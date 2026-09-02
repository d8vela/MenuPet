import Foundation

enum KirbyCharacter: String, CaseIterable {
    case kirby
    case kingDedede
    case metaKnight
    case bandanaWaddleDee
    case waddleDee
    case waddleDoo
    case Gordy
    case brontoBurt
    case bonkers
    case kingDededeBoss

    var displayName: String {
        switch self {
        case .kirby: return "Kirby"
        case .kingDedede: return "King Dedede"
        case .metaKnight: return "Meta Knight"
        case .bandanaWaddleDee: return "Bandana Waddle Dee"
        case .waddleDee: return "Waddle Dee"
        case .waddleDoo: return "Waddle Doo"
        case .Gordy: return "Gordo"
        case .brontoBurt: return "Bronto Burt"
        case .bonkers: return "Bonkers"
        case .kingDededeBoss: return "King DDD"
        }
    }

    var emoji: String {
        switch self {
        case .kirby: return "💖"
        case .kingDedede: return "🔨"
        case .metaKnight: return "⚔️"
        case .bandanaWaddleDee: return "🎯"
        case .waddleDee: return "🟡"
        case .waddleDoo: return "👀"
        case .Gordy: return "⚫"
        case .brontoBurt: return "🦅"
        case .bonkers: return "🐒"
        case .kingDededeBoss: return "👑"
        }
    }
}
