import Foundation

enum DragonBallCharacter: String, CaseIterable {
    case goku
    case vegeta
    case gohan
    case piccolo
    case frieza
    case cell
    case majinBuu
    case krillin
    case trunks
    case goten
    case beerus
    case whis

    var displayName: String {
        switch self {
        case .goku: return "Goku"
        case .vegeta: return "Vegeta"
        case .gohan: return "Gohan"
        case .piccolo: return "Piccolo"
        case .frieza: return "Frieza"
        case .cell: return "Cell"
        case .majinBuu: return "Majin Buu"
        case .krillin: return "Krillin"
        case .trunks: return "Trunks"
        case .goten: return "Goten"
        case .beerus: return "Beerus"
        case .whis: return "Whis"
        }
    }

    var emoji: String {
        switch self {
        case .goku: return "🐉"
        case .vegeta: return "💪"
        case .gohan: return "📚"
        case .piccolo: return "🟢"
        case .frieza: return "👑"
        case .cell: return "🦗"
        case .majinBuu: return "🧁"
        case .krillin: return "☀️"
        case .trunks: return "⚔️"
        case .goten: return "🧒"
        case .beerus: return "🐱"
        case .whis: return "😇"
        }
    }
}
