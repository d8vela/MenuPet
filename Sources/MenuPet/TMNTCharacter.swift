import Foundation

enum TMNTCharacter: String, CaseIterable {
    case leonardo
    case donatello
    case raphael
    case michelangelo
    case splinter
    case shredder
    case krang
    case bebop
    case rocksteady
    case april
    case CaseyJones

    var displayName: String {
        switch self {
        case .leonardo: return "Leonardo"
        case .donatello: return "Donatello"
        case .raphael: return "Raphael"
        case .michelangelo: return "Michelangelo"
        case .splinter: return "Splinter"
        case .shredder: return "Shredder"
        case .krang: return "Krang"
        case .bebop: return "Bebop"
        case .rocksteady: return "Rocksteady"
        case .april: return "April O'Neil"
        case .CaseyJones: return "Casey Jones"
        }
    }

    var emoji: String {
        switch self {
        case .leonardo: return "⚔️"
        case .donatello: return "🥢"
        case .raphael: return "🔴"
        case .michelangelo: return "🛹"
        case .splinter: return "🐀"
        case .shredder: return "🦾"
        case .krang: return "🧠"
        case .bebop: return "🐗"
        case .rocksteady: return "🦏"
        case .april: return "📺"
        case .CaseyJones: return "🏒"
        }
    }
}
