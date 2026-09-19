import Foundation

class MultiPetManager {
    static let shared = MultiPetManager()

    private(set) var selectedPets: [SelectableCharacter] = []
    private var petStates: [String: PetState] = [:]

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
        save()
        onSelectionChanged?()
    }

    func addPet(_ character: SelectableCharacter) {
        guard !selectedPets.contains(character) else { return }
        guard selectedPets.count < maxPets else { return }
        selectedPets.append(character)
        _ = state(for: character)
        save()
        onSelectionChanged?()
    }

    func removePet(_ character: SelectableCharacter) {
        selectedPets.removeAll { $0 == character }
        petStates.removeValue(forKey: character.identifier)
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
    }

    private func load() {
        guard let ids = UserDefaults.standard.stringArray(forKey: "multiPetSelectedPets") else { return }
        selectedPets = ids.compactMap { SelectableCharacter.from(identifier: $0) }
    }
}
