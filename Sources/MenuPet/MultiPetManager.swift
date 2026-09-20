import Foundation

class MultiPetManager {
    static let shared = MultiPetManager()

    struct PetRotationSettings {
        var enabled: Bool
        var interval: TimeInterval
        var smartRotation: Bool
        var categoryOnly: Bool

        static let `default` = PetRotationSettings(enabled: false, interval: 300, smartRotation: false, categoryOnly: false)
    }

    private(set) var selectedPets: [SelectableCharacter] = []
    private var petStates: [String: PetState] = [:]
    var petRotationSettings: [String: PetRotationSettings] = [:]
    var petHistory: [String: [SelectableCharacter]] = [:]
    let maxHistoryPerPet = 20
    var selectionHistory: [[String]] = []
    let maxSelectionHistory = 20

    let maxPets = 8

    var isMultiPetMode: Bool { selectedPets.count > 1 }

    var primaryPet: SelectableCharacter? { selectedPets.first }

    var petCount: Int { selectedPets.count }

    var onSelectionChanged: (() -> Void)?

    private init() {
        load()
    }

    func state(for character: SelectableCharacter) -> PetState {
        let id = character.identifier
        if let existing = petStates[id] {
            return existing
        }
        let state = PetState()
        petStates[id] = state
        return state
    }

    func rotationSettings(for character: SelectableCharacter) -> PetRotationSettings {
        return petRotationSettings[character.identifier] ?? .default
    }

    func setRotation(_ settings: PetRotationSettings, for character: SelectableCharacter) {
        petRotationSettings[character.identifier] = settings
        save()
    }

    func addToHistory(_ character: SelectableCharacter, pet: SelectableCharacter) {
        let id = pet.identifier
        if petHistory[id] == nil { petHistory[id] = [] }
        petHistory[id]?.removeAll { $0 == character }
        petHistory[id]?.insert(character, at: 0)
        if (petHistory[id]?.count ?? 0) > maxHistoryPerPet {
            petHistory[id] = Array(petHistory[id]!.prefix(maxHistoryPerPet))
        }
        save()
    }

    func history(for character: SelectableCharacter) -> [SelectableCharacter] {
        return petHistory[character.identifier] ?? []
    }

    func isSelected(_ character: SelectableCharacter) -> Bool {
        selectedPets.contains(character)
    }

    func togglePet(_ character: SelectableCharacter) {
        if let index = selectedPets.firstIndex(of: character) {
            selectedPets.remove(at: index)
            petStates.removeValue(forKey: character.identifier)
        } else {
            guard selectedPets.count < maxPets else { return }
            selectedPets.append(character)
            _ = state(for: character)
        }
        recordSelection()
        save()
        onSelectionChanged?()
    }

    func addPet(_ character: SelectableCharacter) {
        guard !selectedPets.contains(character) else { return }
        guard selectedPets.count < maxPets else { return }
        selectedPets.append(character)
        _ = state(for: character)
        recordSelection()
        save()
        onSelectionChanged?()
    }

    func removePet(_ character: SelectableCharacter) {
        selectedPets.removeAll { $0 == character }
        petStates.removeValue(forKey: character.identifier)
        petOrders.removeValue(forKey: character.identifier)
        save()
        onSelectionChanged?()
    }

    func swapCharacter(from old: SelectableCharacter, to new: SelectableCharacter) {
        guard !selectedPets.contains(new) else { return }
        if let index = selectedPets.firstIndex(of: old) {
            let oldState = petStates[old.identifier]
            selectedPets[index] = new
            petStates.removeValue(forKey: old.identifier)
            if let state = oldState {
                petStates[new.identifier] = state
            }
            if let order = petOrders.removeValue(forKey: old.identifier) {
                petOrders[new.identifier] = order
            }
            save()
            onSelectionChanged?()
        }
    }

    var petOrders: [String: Int] = [:]

    func setOrder(_ order: Int, for character: SelectableCharacter) {
        petOrders[character.identifier] = order
        selectedPets.sort { a, b in
            let orderA = petOrders[a.identifier] ?? Int.max
            let orderB = petOrders[b.identifier] ?? Int.max
            if orderA != orderB { return orderA < orderB }
            return false
        }
        recordSelection()
        save()
        onSelectionChanged?()
    }

    func setPrimary(_ character: SelectableCharacter) {
        guard selectedPets.contains(character) else { return }
        selectedPets.removeAll { $0 == character }
        selectedPets.insert(character, at: 0)
        save()
        onSelectionChanged?()
    }

    func clearAll() {
        selectedPets.removeAll()
        petStates.removeAll()
        recordSelection()
        save()
        onSelectionChanged?()
    }

    func recordSelection() {
        guard selectedPets.count > 1 else { return }
        let ids = selectedPets.map { $0.identifier }
        selectionHistory.removeAll { $0 == ids }
        selectionHistory.insert(ids, at: 0)
        if selectionHistory.count > maxSelectionHistory {
            selectionHistory = Array(selectionHistory.prefix(maxSelectionHistory))
        }
    }

    func restoreSelection(_ identifiers: [String]) {
        guard let characters = [String](identifiers).compactMap({ SelectableCharacter.from(identifier: $0) }) as [SelectableCharacter]? else { return }
        guard !characters.isEmpty else { return }
        selectedPets = characters
        for pet in selectedPets {
            _ = state(for: pet)
        }
        save()
        onSelectionChanged?()
    }

    func feedAll() -> [SelectableCharacter] {
        let affected = selectedPets.filter { state(for: $0).hunger < 40 }
        for pet in affected {
            state(for: pet).feed(personality: pet.personality)
        }
        return affected
    }
 
    func playAll() -> [SelectableCharacter] {
        let affected = selectedPets.filter { state(for: $0).happiness < 40 }
        for pet in affected {
            state(for: pet).play(personality: pet.personality)
        }
        return affected
    }
 
    func cleanAll() -> [SelectableCharacter] {
        let affected = selectedPets.filter { state(for: $0).hygiene < 40 }
        for pet in affected {
            state(for: pet).clean()
        }
        return affected
    }
 
    func sleepAll() -> [SelectableCharacter] {
        let affected = selectedPets.filter { state(for: $0).energy < 40 }
        for pet in affected {
            state(for: pet).sleep()
        }
        return affected
    }

    func decayAll() {
        for pet in selectedPets {
            let s = state(for: pet)
            let wasNotDisobedient = !s.isDisobedient
            s.decay(personality: pet.personality)
            s.checkDisobedience(personality: pet.personality)
            if wasNotDisobedient && s.isDisobedient && LLMService.shared.statusEnabled {
                s.lastAction = "disobedience"
                LLMService.shared.invalidateCache(for: pet)
            }
        }
    }

    func disciplineAll() -> ([SelectableCharacter], String) {
        var results: [String] = []
        var affected: [SelectableCharacter] = []
        for pet in selectedPets {
            let s = state(for: pet)
            if s.isDisobedient {
                let result = s.discipline()
                results.append("\(pet.displayName): \(result)")
                affected.append(pet)
            }
        }
        return (affected, results.joined(separator: "\n"))
    }

    func worstNeedIcons() -> [String] {
        var icons: [String] = []
        for pet in selectedPets {
            let s = state(for: pet)
            var worstStat = 100.0
            var icon = ""
            if s.hunger < worstStat && s.hunger < 30 { worstStat = s.hunger; icon = "🍕" }
            if s.happiness < worstStat && s.happiness < 30 { worstStat = s.happiness; icon = "😢" }
            if s.energy < worstStat && s.energy < 30 { worstStat = s.energy; icon = "😴" }
            if s.hygiene < worstStat && s.hygiene < 30 { worstStat = s.hygiene; icon = "🧼" }
            if !icon.isEmpty { icons.append(icon) }
        }
        return icons
    }

    private func save() {
        let ids = selectedPets.map { $0.identifier }
        UserDefaults.standard.set(ids, forKey: "multiPetSelectedPets")
        UserDefaults.standard.set(petOrders, forKey: "multiPetOrders")

        var rotationData: [String: [String: Any]] = [:]
        for (id, settings) in petRotationSettings {
            rotationData[id] = [
                "enabled": settings.enabled,
                "interval": settings.interval,
                "smartRotation": settings.smartRotation,
                "categoryOnly": settings.categoryOnly
            ]
        }
        UserDefaults.standard.set(rotationData, forKey: "petRotationSettings")

        var historyData: [String: [String]] = [:]
        for (id, chars) in petHistory {
            historyData[id] = chars.map { $0.identifier }
        }
        UserDefaults.standard.set(historyData, forKey: "petHistory")
        UserDefaults.standard.set(selectionHistory, forKey: "petSelectionHistory")
    }

    private func load() {
        guard let ids = UserDefaults.standard.stringArray(forKey: "multiPetSelectedPets") else { return }
        selectedPets = ids.compactMap { SelectableCharacter.from(identifier: $0) }
        if let orders = UserDefaults.standard.dictionary(forKey: "multiPetOrders") as? [String: Int] {
            petOrders = orders
        }

        if let rotationData = UserDefaults.standard.dictionary(forKey: "petRotationSettings") as? [String: [String: Any]] {
            for (id, data) in rotationData {
                let enabled = data["enabled"] as? Bool ?? false
                let interval = data["interval"] as? TimeInterval ?? 300
                let smart = data["smartRotation"] as? Bool ?? false
                let catOnly = data["categoryOnly"] as? Bool ?? false
                petRotationSettings[id] = PetRotationSettings(enabled: enabled, interval: interval, smartRotation: smart, categoryOnly: catOnly)
            }
        }

        if let historyData = UserDefaults.standard.dictionary(forKey: "petHistory") as? [String: [String]] {
            for (id, identifiers) in historyData {
                petHistory[id] = identifiers.compactMap { SelectableCharacter.from(identifier: $0) }
            }
        }

        if let savedSelectionHistory = UserDefaults.standard.array(forKey: "petSelectionHistory") as? [[String]] {
            selectionHistory = savedSelectionHistory
        }
    }
}
