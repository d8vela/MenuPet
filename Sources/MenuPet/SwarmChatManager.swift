import Foundation

struct SwarmMessage: Identifiable {
    let id = UUID()
    let speaker: SelectableCharacter
    let text: String
    let timestamp: Date
    let isUser: Bool
}

class SwarmChatManager {
    static let shared = SwarmChatManager()

    var history: [SwarmMessage] = []
    var isSwarmChatting = false

    private let maxHistory = 100

    private init() {}

    func startSwarmConversation(
        topic: String,
        completion: @escaping ([SwarmMessage]) -> Void
    ) {
        let pets = MultiPetManager.shared.selectedPets
        guard pets.count >= 2 else {
            completion([])
            return
        }

        isSwarmChatting = true
        history = []

        let systemPrompt = buildSwarmSystemPrompt(pets: pets)
        let userPrompt = buildSwarmUserPrompt(pets: pets, topic: topic)

        let messages: [[String: String]] = [
            ["role": "system", "content": systemPrompt],
            ["role": "user", "content": userPrompt]
        ]

        callSwarmAPI(messages: messages, pets: pets, round: 0, maxRounds: pets.count * 2) { [weak self] results in
            self?.isSwarmChatting = false
            completion(results)
        }
    }

    func sendUserMessage(
        _ text: String,
        completion: @escaping ([SwarmMessage]) -> Void
    ) {
        let pets = MultiPetManager.shared.selectedPets
        guard pets.count >= 2 else {
            completion([])
            return
        }

        isSwarmChatting = true

        history.append(SwarmMessage(
            speaker: .pokemon(.pokeball),
            text: text,
            timestamp: Date(),
            isUser: true
        ))

        let systemPrompt = buildSwarmSystemPrompt(pets: pets)
        var messages: [[String: String]] = [
            ["role": "system", "content": systemPrompt]
        ]
        for msg in history.suffix(20) {
            if msg.isUser {
                messages.append(["role": "user", "content": "[User]: \(msg.text)"])
            } else {
                messages.append(["role": "assistant", "content": "\(msg.speaker.displayName): \(msg.text)"])
            }
        }

        let petsToRespond = Array(pets.shuffled().prefix(3))
        var responded = 0
        var newMessages: [SwarmMessage] = []

        for pet in petsToRespond {
            let petContext = buildPetContext(for: pet)
            var petMessages = messages
            petMessages.append(["role": "user", "content": "\(petContext)\n\nRespond as \(pet.displayName) in the group chat. React to what was said. Keep it under 20 words. Be in character."])

            callSinglePetChat(messages: petMessages) { [weak self] response in
                guard let self = self else { return }
                let msg = SwarmMessage(speaker: pet, text: response, timestamp: Date(), isUser: false)
                self.history.append(msg)
                newMessages.append(msg)
                responded += 1
                if responded >= petsToRespond.count {
                    DispatchQueue.main.async {
                        completion(newMessages)
                    }
                }
            }
        }
    }

    func triggerRandomInteraction(
        completion: @escaping ([SwarmMessage]) -> Void
    ) {
        let pets = MultiPetManager.shared.selectedPets
        guard pets.count >= 2 else {
            completion([])
            return
        }

        let topics = [
            "greet each other",
            "argue about who is the best pet",
            "tell each other jokes",
            "discuss what food they want",
            "talk about their day",
            "brag about their stats",
            "plan an adventure together",
            "debate who is the cutest",
            "share a secret",
            "challenge each other to a game"
        ]
        let topic = topics.randomElement() ?? "greet each other"

        let randomPair = pets.shuffled().prefix(2)
        let pet1 = randomPair[0]
        let pet2 = randomPair[1]

        isSwarmChatting = true

        let systemPrompt = """
        You are two pixel art pets in a macOS menu bar having a conversation. Be funny, dramatic, and in character. Keep each reply under 20 words. No JSON, just respond as the character.
        """

        let messages: [[String: String]] = [
            ["role": "system", "content": systemPrompt],
            ["role": "user", "content": "Have \(pet1.displayName) and \(pet2.displayName) \(topic). Start with \(pet1.displayName) speaking first."]
        ]

        callSwarmPairChat(pet1: pet1, pet2: pet2, messages: messages, round: 0, maxRounds: 4) { [weak self] results in
            self?.isSwarmChatting = false
            completion(results)
        }
    }

    // MARK: - Swarm API Calls

    private func callSwarmAPI(
        messages: [[String: String]],
        pets: [SelectableCharacter],
        round: Int,
        maxRounds: Int,
        accumulated: [SwarmMessage] = [],
        completion: @escaping ([SwarmMessage]) -> Void
    ) {
        guard round < maxRounds && !pets.isEmpty else {
            DispatchQueue.main.async { completion(accumulated) }
            return
        }

        let pet = pets[round % pets.count]
        let petContext = buildPetContext(for: pet)

        var fullMessages = messages
        fullMessages.append(["role": "user", "content": "\(petContext)\n\nNow respond as \(pet.displayName). Be in character. React to the conversation so far. Keep it under 20 words."])

        callSinglePetChat(messages: fullMessages) { [weak self] response in
            guard let self = self else { return }
            let msg = SwarmMessage(speaker: pet, text: response, timestamp: Date(), isUser: false)
            var newAccumulated = accumulated
            newAccumulated.append(msg)

            DispatchQueue.main.async {
                self.history.append(msg)
            }

            var nextMessages = messages
            nextMessages.append(["role": "assistant", "content": "\(pet.displayName): \(response)"])

            self.callSwarmAPI(
                messages: nextMessages,
                pets: pets,
                round: round + 1,
                maxRounds: maxRounds,
                accumulated: newAccumulated,
                completion: completion
            )
        }
    }

    private func callSwarmPairChat(
        pet1: SelectableCharacter,
        pet2: SelectableCharacter,
        messages: [[String: String]],
        round: Int,
        maxRounds: Int,
        accumulated: [SwarmMessage] = [],
        completion: @escaping ([SwarmMessage]) -> Void
    ) {
        guard round < maxRounds else {
            DispatchQueue.main.async { completion(accumulated) }
            return
        }

        let currentPet = round % 2 == 0 ? pet1 : pet2
        let otherPet = round % 2 == 0 ? pet2 : pet1

        var fullMessages = messages
        fullMessages.append(["role": "user", "content": "You are \(currentPet.displayName) responding to \(otherPet.displayName). Stay in character as \(currentPet.displayName). Keep it under 20 words."])

        callSinglePetChat(messages: fullMessages) { [weak self] response in
            guard let self = self else { return }
            let msg = SwarmMessage(speaker: currentPet, text: response, timestamp: Date(), isUser: false)
            var newAccumulated = accumulated
            newAccumulated.append(msg)

            DispatchQueue.main.async {
                self.history.append(msg)
            }

            var nextMessages = messages
            nextMessages.append(["role": "assistant", "content": "\(currentPet.displayName): \(response)"])

            self.callSwarmPairChat(
                pet1: pet1,
                pet2: pet2,
                messages: nextMessages,
                round: round + 1,
                maxRounds: maxRounds,
                accumulated: newAccumulated,
                completion: completion
            )
        }
    }

    // MARK: - Single Pet Chat Call

    private func callSinglePetChat(
        messages: [[String: String]],
        completion: @escaping (String) -> Void
    ) {
        let llm = LLMService.shared
        guard !llm.apiKey.isEmpty, !llm.endpoint.isEmpty else {
            completion("*looks around confused*")
            return
        }

        guard let url = URL(string: llm.endpoint) else {
            completion("*stares blankly*")
            return
        }

        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.timeoutInterval = 30

        switch llm.provider {
        case .anthropic:
            request.setValue(llm.apiKey, forHTTPHeaderField: "x-api-key")
            request.setValue("2023-06-01", forHTTPHeaderField: "anthropic-version")
            request.setValue("application/json", forHTTPHeaderField: "Content-Type")
            let body: [String: Any] = [
                "model": llm.model,
                "max_tokens": 150,
                "messages": messages
            ]
            request.httpBody = try? JSONSerialization.data(withJSONObject: body)

        case .gemini:
            let urlStr = "\(llm.endpoint)/\(llm.model):generateContent?key=\(llm.apiKey)"
            guard let geminiURL = URL(string: urlStr) else {
                completion("*connection lost*")
                return
            }
            request = URLRequest(url: geminiURL)
            request.httpMethod = "POST"
            request.timeoutInterval = 30
            request.setValue("application/json", forHTTPHeaderField: "Content-Type")
            let contents = messages.filter { $0["role"] != "system" }.map { ["parts": [["text": $0["content"] ?? ""]]] }
            let body: [String: Any] = [
                "contents": contents,
                "generationConfig": ["maxOutputTokens": 150]
            ]
            request.httpBody = try? JSONSerialization.data(withJSONObject: body)

        default:
            request.setValue("Bearer \(llm.apiKey)", forHTTPHeaderField: "Authorization")
            request.setValue("application/json", forHTTPHeaderField: "Content-Type")
            let body: [String: Any] = [
                "model": llm.model,
                "max_tokens": 150,
                "messages": messages
            ]
            request.httpBody = try? JSONSerialization.data(withJSONObject: body)
        }

        URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                DispatchQueue.main.async { completion("*error: \(error.localizedDescription)") }
                return
            }
            guard let data = data else {
                DispatchQueue.main.async { completion("*silence*") }
                return
            }

            let text = self.parseChatResponse(data: data) ?? "*confused pixel noises*"
            DispatchQueue.main.async { completion(text) }
        }.resume()
    }

    // MARK: - Response Parsing

    private func parseChatResponse(data: Data) -> String? {
        guard let json = try? JSONSerialization.jsonObject(with: data) as? [String: Any] else { return nil }

        if let choices = json["choices"] as? [[String: Any]],
           let message = choices.first?["message"] as? [String: Any] {
            if let text = message["content"] as? String, !text.isEmpty {
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

    // MARK: - Prompt Building

    private func buildSwarmSystemPrompt(pets: [SelectableCharacter]) -> String {
        let petNames = pets.map { $0.displayName }.joined(separator: ", ")
        return """
        You are a group of pixel art pets living in a macOS menu bar. The pets are: \(petNames).
        Each pet speaks in turn, staying in character. Be funny, dramatic, and overreact to everything.
        Think meme energy. Each reply should be under 20 words. No JSON, just respond as the character.
        When responding, start your message with just what the character says, no name prefix needed.
        """
    }

    private func buildSwarmUserPrompt(pets: [SelectableCharacter], topic: String) -> String {
        let petDetails = pets.map { pet in
            let state = MultiPetManager.shared.state(for: pet)
            return "\(pet.displayName) (\(pet.category)): mood=\(state.mood), hunger=\(Int(state.hunger))%"
        }.joined(separator: "\n")
        return """
        The pets want to \(topic). Here are their current states:
        \(petDetails)
        
        Start the conversation. Have 2-3 pets respond.
        """
    }

    private func buildPetContext(for character: SelectableCharacter) -> String {
        let state = MultiPetManager.shared.state(for: character)
        return """
        You are \(character.displayName) from \(character.category).
        Current mood: \(state.mood). Hunger: \(Int(state.hunger))%. Happiness: \(Int(state.happiness))%.
        Energy: \(Int(state.energy))%. Cleanliness: \(Int(state.hygiene))%.
        Stage: \(state.stageName). Is disobedient: \(state.isDisobedient).
        Be in character as \(character.displayName). Be dramatic and funny.
        """
    }
}
