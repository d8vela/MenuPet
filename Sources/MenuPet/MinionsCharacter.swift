import Foundation

enum MinionsCharacter: String, CaseIterable {
    case kevin
    case stuart
    case bob
    case dave
    case jerry
    case phil
    case tim
    case mark
    case carl
    case jorge
    case donny
    case eric

    var displayName: String {
        switch self {
        case .kevin: return "Kevin"
        case .stuart: return "Stuart"
        case .bob: return "Bob"
        case .dave: return "Dave"
        case .jerry: return "Jerry"
        case .phil: return "Phil"
        case .tim: return "Tim"
        case .mark: return "Mark"
        case .carl: return "Carl"
        case .jorge: return "Jorge"
        case .donny: return "Donny"
        case .eric: return "Eric"
        }
    }

    var emoji: String {
        switch self {
        case .kevin: return "Banana"
        case .stuart: return "Eye"
        case .bob: return "Teddy"
        case .dave: return "Minion"
        case .jerry: return "Minion"
        case .phil: return "Minion"
        case .tim: return "Minion"
        case .mark: return "Minion"
        case .carl: return "Minion"
        case .jorge: return "Minion"
        case .donny: return "Minion"
        case .eric: return "Minion"
        }
    }
}
