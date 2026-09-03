import Foundation

enum KingOfTheHillCharacter: String, CaseIterable {
    case hank
    case peggy
    case bobby
    case dale
    case bill
    case boomhauer
    case luanne
    case cotton
    case kahn
    case ladybird
    case johnRedcorn
    case buckStrickland

    var displayName: String {
        switch self {
        case .hank: return "Hank Hill"
        case .peggy: return "Peggy Hill"
        case .bobby: return "Bobby Hill"
        case .dale: return "Dale Gribble"
        case .bill: return "Bill Dauterive"
        case .boomhauer: return "Boomhauer"
        case .luanne: return "Luanne Platter"
        case .cotton: return "Cotton Hill"
        case .kahn: return "Kahn"
        case .ladybird: return "Ladybird"
        case .johnRedcorn: return "John Redcorn"
        case .buckStrickland: return "Buck Strickland"
        }
    }

    var emoji: String {
        switch self {
        case .hank: return "🥩"
        case .peggy: return "👠"
        case .bobby: return "👦"
        case .dale: return "🕶️"
        case .bill: return "🍺"
        case .boomhauer: return "🍻"
        case .luanne: return "💅"
        case .cotton: return "🎖️"
        case .kahn: return "👔"
        case .ladybird: return "🐕"
        case .johnRedcorn: return "🪶"
        case .buckStrickland: return "⛽"
        }
    }
}
