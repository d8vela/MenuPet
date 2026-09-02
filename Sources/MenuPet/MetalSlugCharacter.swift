import Foundation

enum MetalSlugCharacter: String, CaseIterable {
    case marco
    case tarma
    case eri
    case fio
    case morden
    case camel
    case slugTank
    case zombie
    case mummy
    case ape
    case hermit
    case crab

    var displayName: String {
        switch self {
        case .marco: return "Marco Rossi"
        case .tarma: return "Tarma Roving"
        case .eri: return "Eri Kasamoto"
        case .fio: return "Fio Germi"
        case .morden: return "Morden"
        case .camel: return "Camel"
        case .slugTank: return "Metal Slug"
        case .zombie: return "Zombie"
        case .mummy: return "Mummy"
        case .ape: return "Space Ape"
        case .hermit: return "Hermit"
        case .crab: return "Crab"
        }
    }

    var emoji: String {
        switch self {
        case .marco: return "🔫"
        case .tarma: return "🪖"
        case .eri: return "💣"
        case .fio: return "🎯"
        case .morden: return "🎖️"
        case .camel: return "🐪"
        case .slugTank: return "🫏"
        case .zombie: return "🧟"
        case .mummy: return "🩻"
        case .ape: return "🦍"
        case .hermit: return "🐚"
        case .crab: return "🦀"
        }
    }
}
