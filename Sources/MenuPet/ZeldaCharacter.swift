import Foundation

enum ZeldaCharacter: String, CaseIterable {
    case link
    case zelda
    case ganon
    case navi
    case midna
    case impa
    case skullKid
    case greatFairy
    case octorok
    case moblin
    case keese
    case darkLink

    var displayName: String {
        switch self {
        case .link: return "Link"
        case .zelda: return "Zelda"
        case .ganon: return "Ganon"
        case .navi: return "Navi"
        case .midna: return "Midna"
        case .impa: return "Impa"
        case .skullKid: return "Skull Kid"
        case .greatFairy: return "Great Fairy"
        case .octorok: return "Octorok"
        case .moblin: return "Moblin"
        case .keese: return "Keese"
        case .darkLink: return "Dark Link"
        }
    }

    var emoji: String {
        switch self {
        case .link: return "🗡️"
        case .zelda: return "👑"
        case .ganon: return "🐗"
        case .navi: return "🧚"
        case .midna: return "🦊"
        case .impa: return "⚔️"
        case .skullKid: return "🎭"
        case .greatFairy: return "🌸"
        case .octorok: return "🐙"
        case .moblin: return "👹"
        case .keese: return "🦇"
        case .darkLink: return "🖤"
        }
    }
}
