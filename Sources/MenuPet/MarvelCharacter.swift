import Foundation

enum MarvelCharacter: String, CaseIterable {
    case spiderMan
    case ironMan
    case captainAmerica
    case thor
    case hulk
    case wolverine
    case deadpool
    case blackPanther
    case doctorStrange
    case thanos
    case loki
    case magneto

    var displayName: String {
        switch self {
        case .spiderMan: return "Spider-Man"
        case .ironMan: return "Iron Man"
        case .captainAmerica: return "Captain America"
        case .thor: return "Thor"
        case .hulk: return "Hulk"
        case .wolverine: return "Wolverine"
        case .deadpool: return "Deadpool"
        case .blackPanther: return "Black Panther"
        case .doctorStrange: return "Doctor Strange"
        case .thanos: return "Thanos"
        case .loki: return "Loki"
        case .magneto: return "Magneto"
        }
    }

    var emoji: String {
        switch self {
        case .spiderMan: return "🕷️"
        case .ironMan: return "🦾"
        case .captainAmerica: return "🛡️"
        case .thor: return "🔨"
        case .hulk: return "💪"
        case .wolverine: return "🦓"
        case .deadpool: return " Mouth"
        case .blackPanther: return "Panther"
        case .doctorStrange: return "🔮"
        case .thanos: return "Infinity"
        case .loki: return "Horned"
        case .magneto: return "Magnet"
        }
    }
}
