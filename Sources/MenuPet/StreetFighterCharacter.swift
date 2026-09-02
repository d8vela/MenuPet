import Foundation

enum StreetFighterCharacter: String, CaseIterable {
    case ryu
    case ken
    case chunLi
    case guile
    case dhalsim
    case zangief
    case blanka
    case eHonda
    case balrog
    case vega
    case sagat
    case dictator

    var displayName: String {
        switch self {
        case .ryu: return "Ryu"
        case .ken: return "Ken"
        case .chunLi: return "Chun-Li"
        case .guile: return "Guile"
        case .dhalsim: return "Dhalsim"
        case .zangief: return "Zangief"
        case .blanka: return "Blanka"
        case .eHonda: return "E. Honda"
        case .balrog: return "Balrog"
        case .vega: return "Vega"
        case .sagat: return "Sagat"
        case .dictator: return "M. Bison"
        }
    }

    var emoji: String {
        switch self {
        case .ryu: return "🥊"
        case .ken: return "🔥"
        case .chunLi: return "🦵"
        case .guile: return "✈️"
        case .dhalsim: return "🔥"
        case .zangief: return "💪"
        case .blanka: return "⚡"
        case .eHonda: return "🤼"
        case .balrog: return "👊"
        case .vega: return "🗡️"
        case .sagat: return "🦯"
        case .dictator: return "👹"
        }
    }
}
