import Foundation

class PetState {
    static let shared = PetState()

    var hunger: Double = 100
    var happiness: Double = 100
    var energy: Double = 100
    var hygiene: Double = 100

    var mood: String {
        let avg = (hunger + happiness + energy + hygiene) / 4.0
        if avg >= 80 { return "Happy" }
        if avg >= 60 { return "Content" }
        if avg >= 40 { return "Okay" }
        if avg >= 20 { return "Sad" }
        return "Miserable"
    }

    var moodEmoji: String {
        let avg = (hunger + happiness + energy + hygiene) / 4.0
        if avg >= 80 { return "😊" }
        if avg >= 60 { return "🙂" }
        if avg >= 40 { return "😐" }
        if avg >= 20 { return "😢" }
        return "😫"
    }

    private init() {
        load()
    }

    func feed() {
        hunger = min(100, hunger + 25)
        happiness = min(100, happiness + 5)
        save()
    }

    func play() {
        happiness = min(100, happiness + 30)
        energy = max(0, energy - 15)
        hunger = max(0, hunger - 10)
        save()
    }

    func clean() {
        hygiene = min(100, hygiene + 40)
        happiness = min(100, happiness + 10)
        save()
    }

    func sleep() {
        energy = min(100, energy + 40)
        hunger = max(0, hunger - 5)
        save()
    }

    func decay() {
        hunger = max(0, hunger - 0.5)
        happiness = max(0, happiness - 0.3)
        energy = max(0, energy - 0.2)
        hygiene = max(0, hygiene - 0.4)

        if hunger < 20 { happiness = max(0, happiness - 0.5) }
        if hygiene < 20 { happiness = max(0, happiness - 0.3) }

        save()
    }

    func save() {
        let dict: [String: Double] = [
            "hunger": hunger,
            "happiness": happiness,
            "energy": energy,
            "hygiene": hygiene
        ]
        UserDefaults.standard.set(dict, forKey: "petState")
    }

    func load() {
        guard let dict = UserDefaults.standard.dictionary(forKey: "petState") as? [String: Double] else { return }
        hunger = dict["hunger"] ?? 100
        happiness = dict["happiness"] ?? 100
        energy = dict["energy"] ?? 100
        hygiene = dict["hygiene"] ?? 100
    }
}
