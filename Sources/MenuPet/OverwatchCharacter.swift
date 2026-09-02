import Foundation

enum OverwatchCharacter: String, CaseIterable {
    case tracer
    case genji
    case mercy
    case reinhardt
    case dva
    case winston
    case soldier76
    case reaper
    case widowmaker
    case mccree
    case pharah
    case lucio
    case ana
    case zarya
    case mei
    case symmetra

    var displayName: String {
        switch self {
        case .tracer: return "Tracer"
        case .genji: return "Genji"
        case .mercy: return "Mercy"
        case .reinhardt: return "Reinhardt"
        case .dva: return "D.Va"
        case .winston: return "Winston"
        case .soldier76: return "Soldier: 76"
        case .reaper: return "Reaper"
        case .widowmaker: return "Widowmaker"
        case .mccree: return "Cassidy"
        case .pharah: return "Pharah"
        case .lucio: return "Lúcio"
        case .ana: return "Ana"
        case .zarya: return "Zarya"
        case .mei: return "Mei"
        case .symmetra: return "Symmetra"
        }
    }

    var emoji: String {
        switch self {
        case .tracer: return "⚡"
        case .genji: return "🐉"
        case .mercy: return "👼"
        case .reinhardt: return "🛡️"
        case .dva: return "🎮"
        case .winston: return "🦍"
        case .soldier76: return "🎖️"
        case .reaper: return "💀"
        case .widowmaker: return "🕷️"
        case .mccree: return "🤠"
        case .pharah: return "🚀"
        case .lucio: return "🎵"
        case .ana: return "💉"
        case .zarya: return "💪"
        case .mei: return "❄️"
        case .symmetra: return "💎"
        }
    }
}
