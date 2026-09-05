import Foundation

enum MarvelCharacter: String, CaseIterable {
    case spiderMan
    case ironMan
    case captainAmerica
    case thor
    case hulk
    case wolverine
    case nickFury
    case loki
    case blackWidow

    var displayName: String {
        switch self {
        case .spiderMan: return "Spider-Man"
        case .ironMan: return "Iron Man"
        case .captainAmerica: return "Captain America"
        case .thor: return "Thor"
        case .hulk: return "Hulk"
        case .wolverine: return "Wolverine"
        case .nickFury: return "Nick Fury"
        case .loki: return "Loki"
        case .blackWidow: return "Black Widow"
        }
    }

    var emoji: String {
        switch self {
        case .spiderMan: return "🕷️"
        case .ironMan: return "🦾"
        case .captainAmerica: return "🛡️"
        case .thor: return "🔨"
        case .hulk: return "💪"
        case .wolverine: return "🦴"
        case .nickFury: return "👁️"
        case .loki: return "🐍"
        case .blackWidow: return "🕸️"
        }
    }
}
