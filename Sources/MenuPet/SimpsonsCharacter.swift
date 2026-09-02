import Foundation

enum SimpsonsCharacter: String, CaseIterable {
    case homer
    case marge
    case bart
    case lisa
    case maggie
    case nedFlanders
    case mrBurns
    case smithers
    case milhouse
    case nelson
    case principalSkinner
    case krusty

    var displayName: String {
        switch self {
        case .homer: return "Homer"
        case .marge: return "Marge"
        case .bart: return "Bart"
        case .lisa: return "Lisa"
        case .maggie: return "Maggie"
        case .nedFlanders: return "Ned Flanders"
        case .mrBurns: return "Mr. Burns"
        case .smithers: return "Smithers"
        case .milhouse: return "Milhouse"
        case .nelson: return "Nelson"
        case .principalSkinner: return "Principal Skinner"
        case .krusty: return "Krusty"
        }
    }

    var emoji: String {
        switch self {
        case .homer: return "🍩"
        case .marge: return "💇"
        case .bart: return "🛹"
        case .lisa: return "🎷"
        case .maggie: return "🍼"
        case .nedFlanders: return "👍"
        case .mrBurns: return "💰"
        case .smithers: return "🤓"
        case .milhouse: return "👓"
        case .nelson: return "Ha"
        case .principalSkinner: return "📋"
        case .krusty: return "🤡"
        }
    }
}
