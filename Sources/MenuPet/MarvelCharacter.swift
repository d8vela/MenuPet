import Foundation

enum MarvelCharacter: String, CaseIterable {
    case ironMan
    case captainAmerica
    case thor
    case hulk
    case spiderMan
    case wolverine
    case blackPanther
    case daredevil
    case blackWidow
    case hawkeye
    case vision
    case scarletWitch
    case warMachine
    case spiderWoman
    case cyclops
    case sheHulk
    case juggernaut
    case loki
    case venom

    var displayName: String {
        switch self {
        case .ironMan: return "Iron Man"
        case .captainAmerica: return "Captain America"
        case .thor: return "Thor"
        case .hulk: return "Hulk"
        case .spiderMan: return "Spider-Man"
        case .wolverine: return "Wolverine"
        case .blackPanther: return "Black Panther"
        case .daredevil: return "Daredevil"
        case .blackWidow: return "Black Widow"
        case .hawkeye: return "Hawkeye"
        case .vision: return "Vision"
        case .scarletWitch: return "Scarlet Witch"
        case .warMachine: return "War Machine"
        case .spiderWoman: return "Spider-Woman"
        case .cyclops: return "Cyclops"
        case .sheHulk: return "She-Hulk"
        case .juggernaut: return "Juggernaut"
        case .loki: return "Loki"
        case .venom: return "Venom"
        }
    }

    var emoji: String {
        switch self {
        case .ironMan: return "🦾"
        case .captainAmerica: return "🛡️"
        case .thor: return "🔨"
        case .hulk: return "💪"
        case .spiderMan: return "🕷️"
        case .wolverine: return "🦴"
        case .blackPanther: return "Panther"
        case .daredevil: return "😈"
        case .blackWidow: return "🕸️"
        case .hawkeye: return "🏹"
        case .vision: return "💎"
        case .scarletWitch: return "🔮"
        case .warMachine: return "🤖"
        case .spiderWoman: return "🦂"
        case .cyclops: return "👁️"
        case .sheHulk: return "💚"
        case .juggernaut: return "🔴"
        case .loki: return "🐍"
        case .venom: return "🖤"
        }
    }
}
