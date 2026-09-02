import Foundation

enum NarutoCharacter: String, CaseIterable {
    case naruto
    case sasuke
    case sakura
    case kakashi
    case itachi
    case gaara
    case orochimaru
    case jiraiya
    case tsunade
    case rockLee
    case hinata
    case shikamaru

    var displayName: String {
        switch self {
        case .naruto: return "Naruto"
        case .sasuke: return "Sasuke"
        case .sakura: return "Sakura"
        case .kakashi: return "Kakashi"
        case .itachi: return "Itachi"
        case .gaara: return "Gaara"
        case .orochimaru: return "Orochimaru"
        case .jiraiya: return "Jiraiya"
        case .tsunade: return "Tsunade"
        case .rockLee: return "Rock Lee"
        case .hinata: return "Hinata"
        case .shikamaru: return "Shikamaru"
        }
    }

    var emoji: String {
        switch self {
        case .naruto: return "🍥"
        case .sasuke: return "🔮"
        case .sakura: return "🌸"
        case .kakashi: return "📖"
        case .itachi: return " crow"
        case .gaara: return "⛱️"
        case .orochimaru: return "🐍"
        case .jiraiya: return "🐸"
        case .tsunade: return "🍶"
        case .rockLee: return "💪"
        case .hinata: return "👀"
        case .shikamaru: return "🧠"
        }
    }
}
