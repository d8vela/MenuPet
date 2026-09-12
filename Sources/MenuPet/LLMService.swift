import Foundation

enum LLMProvider: String, CaseIterable {
    case openai = "OpenAI GPT"
    case anthropic = "Anthropic Claude"
    case gemini = "Google Gemini"
    case openrouter = "OpenRouter"
    case openCodeZen = "OpenCode Zen"
    case custom = "Custom"

    var defaultEndpoint: String {
        switch self {
        case .openai: return "https://api.openai.com/v1/chat/completions"
        case .anthropic: return "https://api.anthropic.com/v1/messages"
        case .gemini: return "https://generativelanguage.googleapis.com/v1beta/models"
        case .openrouter: return "https://openrouter.ai/api/v1/chat/completions"
        case .openCodeZen: return "https://opencode.ai/zen/v1/chat/completions"
        case .custom: return ""
        }
    }

    var defaultModel: String {
        switch self {
        case .openai: return "gpt-4o-mini"
        case .anthropic: return "claude-3-haiku-20240307"
        case .gemini: return "gemini-2.0-flash"
        case .openrouter: return "openai/gpt-4o-mini"
        case .openCodeZen: return "gpt-4o-mini"
        case .custom: return ""
        }
    }

    var knownModels: [String] {
        switch self {
        case .openai: return ["gpt-4o-mini", "gpt-4o", "gpt-4-turbo", "gpt-3.5-turbo", "o1-mini", "o1-preview"]
        case .anthropic: return ["claude-3-haiku-20240307", "claude-3-sonnet-20240229", "claude-3-opus-20240229", "claude-3-5-sonnet-20241022"]
        case .gemini: return ["gemini-2.0-flash", "gemini-1.5-flash", "gemini-1.5-pro"]
        case .openrouter: return ["openai/gpt-4o-mini", "openai/gpt-4o", "anthropic/claude-3-haiku", "anthropic/claude-3-sonnet", "xiaomi/mimo-v2.5", "google/gemini-2.0-flash"]
        case .openCodeZen: return ["gpt-4o-mini", "gpt-4o"]
        case .custom: return []
        }
    }
}

class LLMService {
    static let shared = LLMService()

    var provider: LLMProvider {
        get {
            LLMProvider(rawValue: UserDefaults.standard.string(forKey: "llmProvider") ?? "OpenAI GPT") ?? .openai
        }
        set { UserDefaults.standard.set(newValue.rawValue, forKey: "llmProvider") }
    }

    var apiKey: String {
        get {
            let providerKey = UserDefaults.standard.string(forKey: "llmApiKey_\(provider.rawValue)") ?? ""
            if !providerKey.isEmpty { return providerKey }
            return UserDefaults.standard.string(forKey: "llmApiKey") ?? ""
        }
        set { UserDefaults.standard.set(newValue, forKey: "llmApiKey_\(provider.rawValue)") }
    }

    func setApiKey(_ key: String, for provider: LLMProvider) {
        UserDefaults.standard.set(key, forKey: "llmApiKey_\(provider.rawValue)")
    }

    func getApiKey(for provider: LLMProvider) -> String {
        return UserDefaults.standard.string(forKey: "llmApiKey_\(provider.rawValue)") ?? ""
    }

    var endpoint: String {
        get {
            let saved = UserDefaults.standard.string(forKey: "llmEndpoint") ?? ""
            if saved.isEmpty { return provider.defaultEndpoint }
            return saved
        }
        set { UserDefaults.standard.set(newValue, forKey: "llmEndpoint") }
    }

    var model: String {
        get {
            let saved = UserDefaults.standard.string(forKey: "llmModel") ?? ""
            if saved.isEmpty { return provider.defaultModel }
            return saved
        }
        set { UserDefaults.standard.set(newValue, forKey: "llmModel") }
    }

    var statusEnabled: Bool {
        get { UserDefaults.standard.bool(forKey: "llmStatusEnabled") }
        set { UserDefaults.standard.set(newValue, forKey: "llmStatusEnabled") }
    }

    private var lastStatusTime: Date = .distantPast
    private var cachedStatuses: [String: String] = [:]

    func generateStatus(for character: SelectableCharacter, petState: PetState, completion: @escaping (String) -> Void) {
        guard !apiKey.isEmpty else {
            completion("⚠️ No API key set")
            return
        }

        let charId = character.identifier
        if let cached = cachedStatuses[charId], Date().timeIntervalSince(lastStatusTime) < 900 {
            completion(cached)
            return
        }

        let prompt = buildPrompt(for: character, petState: petState)
        callAPI(prompt: prompt) { [weak self] result in
            switch result {
            case .success(let status):
                self?.cachedStatuses[charId] = status
                self?.lastStatusTime = Date()
                completion(status)
            case .failure(let error):
                completion("⚠️ \(error.localizedDescription)")
            }
        }
    }

    func getCachedStatus(for character: SelectableCharacter) -> String? {
        let charId = character.identifier
        if let cached = cachedStatuses[charId], Date().timeIntervalSince(lastStatusTime) < 900 {
            return cached
        }
        return nil
    }

    func invalidateCache() {
        cachedStatuses.removeAll()
        lastStatusTime = .distantPast
    }

    private func buildPrompt(for character: SelectableCharacter, petState: PetState) -> String {
        let name = character.displayName
        let category = character.category
        let mood = petState.mood
        let hunger = Int(petState.hunger)
        let happiness = Int(petState.happiness)
        let energy = Int(petState.energy)
        let hygiene = Int(petState.hygiene)
        let stage = petState.stageName
        let isDisobedient = petState.isDisobedient

        return """
        You are \(name) from \(category). Mood=\(mood). Fullness=\(Int(hunger))%, Happiness=\(Int(happiness))%, Energy=\(Int(energy))%, Clean=\(Int(hygiene))%.
        100% = full, 0% = starving. Only mention hunger if below 30%.
        \(petState.lastAction.map { action in
            switch action {
            case "feed": return "You were just fed. Overreact dramatically."
            case "play": return "You were just played with. Be dramatic about it."
            case "clean": return "You were just cleaned. React like it was a spa day."
            case "sleep": return "You were just put to sleep. Act like you were knocked out."
            case "discipline": return "You were just disciplined. Be dramatic and defiant."
            case "disobedience": return "You just disobeyed your owner. Be rebellious and proud of it. React based on your current mood and stats."
            default: return "Your owner just did this to you: \(action). React to it dramatically."
            }
        } ?? "Give a funny, dramatic status update.")
        Reply as \(name) in first person. Maximum 8 words. Output valid JSON only.
        """
    }

    private func callAPI(prompt: String, completion: @escaping (Result<String, Error>) -> Void) {
        guard !endpoint.isEmpty else {
            completion(.failure(NSError(domain: "LLM", code: 0, userInfo: [NSLocalizedDescriptionKey: "No endpoint configured"])))
            return
        }
        guard let url = URL(string: endpoint) else {
            completion(.failure(NSError(domain: "LLM", code: 0, userInfo: [NSLocalizedDescriptionKey: "Invalid endpoint URL"])))
            return
        }

        var request = URLRequest(url: url)
        request.httpMethod = "POST"
            request.timeoutInterval = 30

        switch provider {
        case .anthropic:
            request.setValue(apiKey, forHTTPHeaderField: "x-api-key")
            request.setValue("2023-06-01", forHTTPHeaderField: "anthropic-version")
            request.setValue("application/json", forHTTPHeaderField: "Content-Type")
            let body: [String: Any] = [
                "model": model,
                "max_tokens": 500,
                "messages": [["role": "user", "content": prompt]]
            ]
            request.httpBody = try? JSONSerialization.data(withJSONObject: body)

        case .gemini:
            let urlStr = "\(endpoint)/\(model):generateContent?key=\(apiKey)"
            guard let geminiURL = URL(string: urlStr) else {
                completion(.failure(NSError(domain: "LLM", code: 0, userInfo: [NSLocalizedDescriptionKey: "Invalid Gemini URL"])))
                return
            }
            request = URLRequest(url: geminiURL)
            request.httpMethod = "POST"
        request.timeoutInterval = 30
            request.setValue("application/json", forHTTPHeaderField: "Content-Type")
            let body: [String: Any] = [
                "contents": [["parts": [["text": prompt]]]],
                "generationConfig": ["maxOutputTokens": 500]
            ]
            request.httpBody = try? JSONSerialization.data(withJSONObject: body)

        default:
            request.setValue("Bearer \(apiKey)", forHTTPHeaderField: "Authorization")
            request.setValue("application/json", forHTTPHeaderField: "Content-Type")
            var body: [String: Any] = [
                "model": model,
                "max_tokens": 150,
                "messages": [
                    ["role": "system", "content": "You are a dramatic, funny tiny pixel pet living in a macOS menu bar. You overreact to everything. Be witty, sarcastic, and dramatic. Think meme energy. Reply with ONLY a JSON object with key s containing a short status. No other text."],
                    ["role": "user", "content": prompt]
                ],
                "response_format": ["type": "json_object"],
                "reasoning": ["effort": "none"] as [String: String]
            ]
            request.httpBody = try? JSONSerialization.data(withJSONObject: body)
        }

        URLSession.shared.dataTask(with: request) { [weak self] data, response, error in
            if let error = error {
                DispatchQueue.main.async { completion(.failure(error)) }
                return
            }
            guard let httpResponse = response as? HTTPURLResponse else {
                DispatchQueue.main.async { completion(.failure(NSError(domain: "LLM", code: 0, userInfo: [NSLocalizedDescriptionKey: "No response from server"]))) }
                return
            }
            guard (200...299).contains(httpResponse.statusCode) else {
                let msg = data.flatMap { String(data: $0, encoding: .utf8) } ?? "HTTP \(httpResponse.statusCode)"
                DispatchQueue.main.async { completion(.failure(NSError(domain: "LLM", code: httpResponse.statusCode, userInfo: [NSLocalizedDescriptionKey: "API error (\(httpResponse.statusCode)): \(msg)"]))) }
                return
            }
            guard let data = data else {
                DispatchQueue.main.async { completion(.failure(NSError(domain: "LLM", code: 0, userInfo: [NSLocalizedDescriptionKey: "Empty response"]))) }
                return
            }
            if let text = self?.parseResponse(data: data) {
                DispatchQueue.main.async { completion(.success(text)) }
            } else {
                let raw = String(data: data, encoding: .utf8) ?? "unknown"
                print("LLM RAW RESPONSE: \(raw)")
                DispatchQueue.main.async { completion(.failure(NSError(domain: "LLM", code: 0, userInfo: [NSLocalizedDescriptionKey: "Parse error: \(raw.prefix(500))"]))) }
            }
        }.resume()
    }

    private func parseResponse(data: Data) -> String? {
        guard let json = try? JSONSerialization.jsonObject(with: data) as? [String: Any] else {
            print("LLM PARSE: Not valid JSON")
            return nil
        }
        print("LLM PARSE: Keys = \(Array(json.keys))")

        // Try OpenAI-compatible format (OpenRouter, OpenAI, OpenCode Zen, custom)
        if let choices = json["choices"] as? [[String: Any]] {
            print("LLM PARSE: choices count = \(choices.count)")
            if let message = choices.first?["message"] as? [String: Any] {
                print("LLM PARSE: message keys = \(Array(message.keys))")
                if let content = message["content"] {
                    print("LLM PARSE: content type = \(type(of: content)), value = \(String(describing: content).prefix(200))")
                }
                if let reasoning = message["reasoning"] {
                    print("LLM PARSE: reasoning type = \(type(of: reasoning)), value = \(String(describing: reasoning).prefix(200))")
                }
                // If reasoning field exists, content is clean output
                if let reasoning = message["reasoning"] as? String, !reasoning.isEmpty,
                   let text = message["content"] as? String, !text.isEmpty {
                    return self.extractMessage(from: text)
                }
                // Standard: message.content
                if let text = message["content"] as? String, !text.isEmpty {
                    return self.extractMessage(from: text)
                }
                // Reasoning models: message.reasoning_content
                if let text = message["reasoning_content"] as? String, !text.isEmpty {
                    return self.extractMessage(from: text)
                }
                // Some reasoning models: message.reasoning (fallback)
                if let text = message["reasoning"] as? String, !text.isEmpty {
                    return self.extractMessage(from: text)
                }
                // Some models: content is array of parts
                if let contentArr = message["content"] as? [[String: Any]],
                   let text = contentArr.first?["text"] as? String {
                    return self.extractMessage(from: text)
                }
            }
            // Non-chat format: choices[0].text
            if let text = choices.first?["text"] as? String, !text.isEmpty {
                return text.trimmingCharacters(in: .whitespacesAndNewlines)
            }
        }

        // Anthropic format
        if let content = json["content"] as? [[String: Any]],
           let text = content.first?["text"] as? String {
            return text.trimmingCharacters(in: .whitespacesAndNewlines)
        }

        // Gemini format
        if let candidates = json["candidates"] as? [[String: Any]],
           let content = candidates.first?["content"] as? [String: Any],
           let parts = content["parts"] as? [[String: Any]],
           let text = parts.first?["text"] as? String {
            return text.trimmingCharacters(in: .whitespacesAndNewlines)
        }

        // Direct content field
        if let text = json["content"] as? String {
            return text.trimmingCharacters(in: .whitespacesAndNewlines)
        }

        // Some APIs nest in data
        if let dataObj = json["data"] as? [String: Any] {
            if let choices = dataObj["choices"] as? [[String: Any]],
               let message = choices.first?["message"] as? [String: Any],
               let text = message["content"] as? String {
                return text.trimmingCharacters(in: .whitespacesAndNewlines)
            }
        }

        return nil
    }

    private func extractMessage(from text: String) -> String {
        // Try direct JSON parse first (clean response)
        if let data = text.data(using: .utf8),
           let json = try? JSONSerialization.jsonObject(with: data) as? [String: Any] {
            for key in ["s", "status", "message"] {
                if let msg = json[key] as? String { return msg.trimmingCharacters(in: .whitespacesAndNewlines) }
            }
        }

        var cleaned = text
        let thinkEnd1 = cleaned.range(of: "<" + "/think>")
        let thinkEnd2 = cleaned.range(of: "<" + "/reasoning>")
        if let range = thinkEnd1 ?? thinkEnd2 {
            cleaned = String(cleaned[range.upperBound...])
        }
        if let data = cleaned.data(using: .utf8),
           let json = try? JSONSerialization.jsonObject(with: data) as? [String: Any] {
            for key in ["s", "status", "message"] {
                if let msg = json[key] as? String { return msg.trimmingCharacters(in: .whitespacesAndNewlines) }
            }
        }
        let pattern = #"\{[^}]*"(s|status|message)"\s*:\s*"((?:[^"\\]|\\.)*)""#
        if let regex = try? NSRegularExpression(pattern: pattern, options: []),
           let match = regex.firstMatch(in: cleaned, range: NSRange(cleaned.startIndex..., in: cleaned)),
           let range = Range(match.range(at: 2), in: cleaned) {
            var result = String(cleaned[range])
            result = result.replacingOccurrences(of: "\\\"", with: "\"")
            result = result.replacingOccurrences(of: "\\n", with: " ")
            return result.trimmingCharacters(in: .whitespacesAndNewlines)
        }
        let fallback = cleaned.trimmingCharacters(in: .whitespacesAndNewlines)
        return String(fallback.prefix(50))
    }

    func chat(character: SelectableCharacter, messages: [[String: String]], completion: @escaping (Result<String, Error>) -> Void) {
        guard !apiKey.isEmpty else {
            completion(.failure(NSError(domain: "LLM", code: 0, userInfo: [NSLocalizedDescriptionKey: "No API key set"])))
            return
        }
        let name = character.displayName
        let category = character.category
        var fullMessages: [[String: String]] = [
            ["role": "system", "content": "You are \(name) from \(category), a tiny pixel art pet living in a macOS menu bar. You are dramatic, funny, and overreact to everything. Think meme energy. Keep replies under 30 words. Be in character as \(name)."]
        ]
        fullMessages.append(contentsOf: messages)

        guard let url = URL(string: endpoint) else {
            completion(.failure(NSError(domain: "LLM", code: 0, userInfo: [NSLocalizedDescriptionKey: "Invalid endpoint URL"])))
            return
        }

        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.timeoutInterval = 30

        switch provider {
        case .anthropic:
            request.setValue(apiKey, forHTTPHeaderField: "x-api-key")
            request.setValue("2023-06-01", forHTTPHeaderField: "anthropic-version")
            request.setValue("application/json", forHTTPHeaderField: "Content-Type")
            let body: [String: Any] = [
                "model": model,
                "max_tokens": 500,
                "messages": fullMessages.map { ["role": $0["role"] ?? "user", "content": $0["content"] ?? ""] }
            ]
            request.httpBody = try? JSONSerialization.data(withJSONObject: body)

        case .gemini:
            let urlStr = "\(endpoint)/\(model):generateContent?key=\(apiKey)"
            guard let geminiURL = URL(string: urlStr) else {
                completion(.failure(NSError(domain: "LLM", code: 0, userInfo: [NSLocalizedDescriptionKey: "Invalid Gemini URL"])))
                return
            }
            request = URLRequest(url: geminiURL)
            request.httpMethod = "POST"
            request.timeoutInterval = 30
            let contents = fullMessages.filter { $0["role"] != "system" }.map { ["parts": [["text": $0["content"] ?? ""]]] }
            let body: [String: Any] = [
                "contents": contents,
                "generationConfig": ["maxOutputTokens": 500]
            ]
            request.httpBody = try? JSONSerialization.data(withJSONObject: body)

        default:
            request.setValue("Bearer \(apiKey)", forHTTPHeaderField: "Authorization")
            request.setValue("application/json", forHTTPHeaderField: "Content-Type")
            let body: [String: Any] = [
                "model": model,
                "max_tokens": 500,
                "messages": fullMessages
            ]
            request.httpBody = try? JSONSerialization.data(withJSONObject: body)
        }

        URLSession.shared.dataTask(with: request) { [weak self] data, response, error in
            if let error = error {
                DispatchQueue.main.async { completion(.failure(error)) }
                return
            }
            guard let httpResponse = response as? HTTPURLResponse else {
                DispatchQueue.main.async { completion(.failure(NSError(domain: "LLM", code: 0, userInfo: [NSLocalizedDescriptionKey: "No response"]))) }
                return
            }
            guard (200...299).contains(httpResponse.statusCode) else {
                let msg = data.flatMap { String(data: $0, encoding: .utf8) } ?? "HTTP \(httpResponse.statusCode)"
                DispatchQueue.main.async { completion(.failure(NSError(domain: "LLM", code: httpResponse.statusCode, userInfo: [NSLocalizedDescriptionKey: msg]))) }
                return
            }
            guard let data = data else {
                DispatchQueue.main.async { completion(.failure(NSError(domain: "LLM", code: 0, userInfo: [NSLocalizedDescriptionKey: "Empty response"]))) }
                return
            }
            if let text = self?.parseChatResponse(data: data) {
                DispatchQueue.main.async { completion(.success(text)) }
            } else {
                let raw = String(data: data, encoding: .utf8) ?? "unknown"
                DispatchQueue.main.async { completion(.failure(NSError(domain: "LLM", code: 0, userInfo: [NSLocalizedDescriptionKey: "Parse error: \(raw.prefix(200))"]))) }
            }
        }.resume()
    }

    private func parseChatResponse(data: Data) -> String? {
        guard let json = try? JSONSerialization.jsonObject(with: data) as? [String: Any] else { return nil }
        if let choices = json["choices"] as? [[String: Any]],
           let message = choices.first?["message"] as? [String: Any] {
            if let text = message["content"] as? String, !text.isEmpty {
                return text.trimmingCharacters(in: .whitespacesAndNewlines)
            }
            if let text = message["reasoning"] as? String, !text.isEmpty {
                return text.trimmingCharacters(in: .whitespacesAndNewlines)
            }
        }
        if let content = json["content"] as? [[String: Any]],
           let text = content.first?["text"] as? String {
            return text.trimmingCharacters(in: .whitespacesAndNewlines)
        }
        if let candidates = json["candidates"] as? [[String: Any]],
           let content = candidates.first?["content"] as? [String: Any],
           let parts = content["parts"] as? [[String: Any]],
           let text = parts.first?["text"] as? String {
            return text.trimmingCharacters(in: .whitespacesAndNewlines)
        }
        return nil
    }

    private func defaultStatus(for character: SelectableCharacter) -> String {
        switch character {
        case .pokemon(let p):
            switch p {
            case .pikachu: return "Pika pika!"
            case .charmander: return "Feeling warm!"
            case .bulbasaur: return "Growing strong!"
            case .squirtle: return "Ready to splash!"
            case .umbreon: return "Moonlight vibes..."
            default: return "Ready for adventure!"
            }
        case .kirby(let k):
            switch k {
            case .kirby: return "Hungry for food!"
            default: return "Ready to fight!"
            }
        case .marioItem(let m):
            switch m {
            case .mario: return "Let's-a go!"
            case .luigi: return "I'm-a scared..."
            case .bowser: return "Grrr!"
            default: return "Here we go!"
            }
        case .dragonBall(let d):
            switch d {
            case .goku: return "I'm hungry!"
            case .vegeta: return "Over 9000!"
            default: return "Powering up!"
            }
        case .transformers(let t):
            switch t {
            case .optimusPrime: return "Roll out!"
            case .bumblebee: return "Bzzzt!"
            case .megatron: return "Decepticons!"
            default: return "Transforming!"
            }
        default:
            return "Hello there!"
        }
    }
}
