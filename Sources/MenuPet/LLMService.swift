import Foundation

enum LLMProvider: String, CaseIterable {
    case openai = "OpenAI"
    case anthropic = "Anthropic"
    case gemini = "Gemini"
    case openrouter = "OpenRouter"
    case openCodeZen = "OpenCode Zen"
    case custom = "Custom"

    var defaultEndpoint: String {
        switch self {
        case .openai: return "https://api.openai.com/v1/chat/completions"
        case .anthropic: return "https://api.anthropic.com/v1/messages"
        case .gemini: return "https://generativelanguage.googleapis.com/v1beta/models"
        case .openrouter: return "https://openrouter.ai/api/v1/chat/completions"
        case .openCodeZen: return "https://api.openai.com/v1/chat/completions"
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
}

class LLMService {
    static let shared = LLMService()

    var provider: LLMProvider {
        get {
            LLMProvider(rawValue: UserDefaults.standard.string(forKey: "llmProvider") ?? "OpenAI") ?? .openai
        }
        set { UserDefaults.standard.set(newValue.rawValue, forKey: "llmProvider") }
    }

    var apiKey: String {
        get { UserDefaults.standard.string(forKey: "llmApiKey") ?? "" }
        set { UserDefaults.standard.set(newValue, forKey: "llmApiKey") }
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
            completion(defaultStatus(for: character))
            return
        }

        let charId = character.identifier
        if let cached = cachedStatuses[charId], Date().timeIntervalSince(lastStatusTime) < 300 {
            completion(cached)
            return
        }

        let prompt = buildPrompt(for: character, petState: petState)
        callAPI(prompt: prompt) { [weak self] response in
            let status = response ?? self?.defaultStatus(for: character) ?? ""
            self?.cachedStatuses[charId] = status
            self?.lastStatusTime = Date()
            completion(status)
        }
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
        You are \(name) from \(category). You are a tiny pixel art pet living in a macOS menu bar.

        Your current state:
        - Mood: \(mood)
        - Hunger: \(hunger)% (0=starving, 100=full)
        - Happiness: \(happiness)% (0=miserable, 100=ecstatic)
        - Energy: \(energy)% (0=exhausted, 100=hyper)
        - Cleanliness: \(hygiene)% (0=filthy, 100=sparkling)
        - Stage: \(stage)\(isDisobedient ? " - You are currently being DISOBEDIENT" : "")

        Generate a SHORT status message (max 40 chars) that \(name) would say about how they're feeling right now. Stay in character. Be fun and expressive. Use emojis sparingly (max 1). No quotes around the message.

        Examples of good responses:
        - "Feeling mighty! Time for an adventure!"
        - "So hungry... need snacks!"
        - "*yawns* Need a nap..."
        - "Ready to save the world!"
        """
    }

    private func callAPI(prompt: String, completion: @escaping (String?) -> Void) {
        guard let url = URL(string: endpoint) else {
            completion(nil)
            return
        }

        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.timeoutInterval = 10

        switch provider {
        case .anthropic:
            request.setValue(apiKey, forHTTPHeaderField: "x-api-key")
            request.setValue("2023-06-01", forHTTPHeaderField: "anthropic-version")
            request.setValue("application/json", forHTTPHeaderField: "Content-Type")
            let body: [String: Any] = [
                "model": model,
                "max_tokens": 60,
                "messages": [["role": "user", "content": prompt]]
            ]
            request.httpBody = try? JSONSerialization.data(withJSONObject: body)

        case .gemini:
            let urlStr = "\(endpoint)/\(model):generateContent?key=\(apiKey)"
            guard let geminiURL = URL(string: urlStr) else { completion(nil); return }
            request = URLRequest(url: geminiURL)
            request.httpMethod = "POST"
            request.setValue("application/json", forHTTPHeaderField: "Content-Type")
            let body: [String: Any] = [
                "contents": [["parts": [["text": prompt]]]],
                "generationConfig": ["maxOutputTokens": 60]
            ]
            request.httpBody = try? JSONSerialization.data(withJSONObject: body)

        default:
            request.setValue("Bearer \(apiKey)", forHTTPHeaderField: "Authorization")
            request.setValue("application/json", forHTTPHeaderField: "Content-Type")
            let body: [String: Any] = [
                "model": model,
                "max_tokens": 60,
                "messages": [["role": "user", "content": prompt]]
            ]
            request.httpBody = try? JSONSerialization.data(withJSONObject: body)
        }

        URLSession.shared.dataTask(with: request) { data, _, _ in
            guard let data = data else {
                DispatchQueue.main.async { completion(nil) }
                return
            }

            let text = self.parseResponse(data: data)
            DispatchQueue.main.async { completion(text) }
        }.resume()
    }

    private func parseResponse(data: Data) -> String? {
        guard let json = try? JSONSerialization.jsonObject(with: data) as? [String: Any] else { return nil }

        switch provider {
        case .anthropic:
            if let content = json["content"] as? [[String: Any]],
               let text = content.first?["text"] as? String {
                return text.trimmingCharacters(in: .whitespacesAndNewlines)
            }
        case .gemini:
            if let candidates = json["candidates"] as? [[String: Any]],
               let content = candidates.first?["content"] as? [String: Any],
               let parts = content["parts"] as? [[String: Any]],
               let text = parts.first?["text"] as? String {
                return text.trimmingCharacters(in: .whitespacesAndNewlines)
            }
        default:
            if let choices = json["choices"] as? [[String: Any]],
               let message = choices.first?["message"] as? [String: Any],
               let text = message["content"] as? String {
                return text.trimmingCharacters(in: .whitespacesAndNewlines)
            }
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
