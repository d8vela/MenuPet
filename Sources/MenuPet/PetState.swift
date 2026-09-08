import Foundation

class PetState {
    static let shared = PetState()

    var hunger: Double = 100
    var happiness: Double = 100
    var energy: Double = 100
    var hygiene: Double = 100

    var careScore: Double = 50
    var stage: Int = 2
    var totalDaysOwned: Int = 0

    var isDisobedient: Bool = false
    var obedience: Double = 80
    var disobedienceMessage: String = ""

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

    var stageName: String {
        switch stage {
        case 0: return "Neglected"
        case 1: return "Baby"
        case 2: return "Normal"
        case 3: return "Happy"
        case 4: return "Champion"
        default: return "Normal"
        }
    }

    var stageEmoji: String {
        switch stage {
        case 0: return "🥀"
        case 1: return "🥚"
        case 2: return "⭐"
        case 3: return "🌟"
        case 4: return "👑"
        default: return "⭐"
        }
    }

    var brightnessModifier: Double {
        switch stage {
        case 0: return 0.6
        case 1: return 0.8
        case 2: return 1.0
        case 3: return 1.1
        case 4: return 1.2
        default: return 1.0
        }
    }

    var saturationModifier: Double {
        switch stage {
        case 0: return 0.5
        case 1: return 0.8
        case 2: return 1.0
        case 3: return 1.15
        case 4: return 1.3
        default: return 1.0
        }
    }

    var showSparkles: Bool { stage >= 3 }
    var showShadow: Bool { stage <= 1 }

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

    func checkDisobedience() {
        guard !isDisobedient else { return }
        let chance = Int.random(in: 0...100)
        let disobedienceThreshold = max(5, Int(100 - obedience))
        if chance < disobedienceThreshold {
            isDisobedient = true
            let messages = [
                "Refuses to eat!",
                "Made a mess!",
                "Won't stop jumping around!",
                "Knocked something over!",
                "Is ignoring you!",
                "Chewed on something!",
                "Is throwing a tantrum!",
                "Won't settle down!"
            ]
            disobedienceMessage = messages.randomElement() ?? "Is misbehaving!"
        }
    }

    func discipline() -> String {
        guard isDisobedient else {
            return "Pet is behaving well!"
        }
        isDisobedient = false
        obedience = min(100, obedience + 5)
        happiness = max(0, happiness - 25)
        save()
        return "Pet disciplined. Obedience increased."
    }

    func decay() {
        hunger = max(0, hunger - 0.5)
        happiness = max(0, happiness - 0.3)
        energy = max(0, energy - 0.2)
        hygiene = max(0, hygiene - 0.4)

        if hunger < 20 { happiness = max(0, happiness - 0.5) }
        if hygiene < 20 { happiness = max(0, happiness - 0.3) }

        let avg = (hunger + happiness + energy + hygiene) / 4.0
        if avg >= 70 {
            careScore = min(100, careScore + 0.3)
        } else if avg >= 40 {
            careScore = min(100, careScore + 0.1)
        } else if avg >= 20 {
            careScore = max(0, careScore - 0.2)
        } else {
            careScore = max(0, careScore - 0.5)
        }

        let newStage: Int
        if careScore >= 85 { newStage = 4 }
        else if careScore >= 65 { newStage = 3 }
        else if careScore >= 40 { newStage = 2 }
        else if careScore >= 20 { newStage = 1 }
        else { newStage = 0 }

        if newStage != stage {
            stage = newStage
        }

        save()
    }

    func save() {
        let dict: [String: Double] = [
            "hunger": hunger,
            "happiness": happiness,
            "energy": energy,
            "hygiene": hygiene,
            "careScore": careScore,
            "stage": Double(stage),
            "obedience": obedience,
            "isDisobedient": isDisobedient ? 1 : 0
        ]
        UserDefaults.standard.set(dict, forKey: "petState")
        UserDefaults.standard.set(disobedienceMessage, forKey: "disobedienceMessage")
    }

    func load() {
        guard let dict = UserDefaults.standard.dictionary(forKey: "petState") as? [String: Double] else { return }
        hunger = dict["hunger"] ?? 100
        happiness = dict["happiness"] ?? 100
        energy = dict["energy"] ?? 100
        hygiene = dict["hygiene"] ?? 100
        careScore = dict["careScore"] ?? 50
        stage = Int(dict["stage"] ?? 2)
        obedience = dict["obedience"] ?? 80
        isDisobedient = (dict["isDisobedient"] ?? 0) == 1
        disobedienceMessage = UserDefaults.standard.string(forKey: "disobedienceMessage") ?? ""
    }
}
