import Foundation

enum MegaManCharacter: String, CaseIterable {
    case megaMan
    case protoMan
    case bass
    case roll
    case rush
    case cutMan
    case gutsMan
    case iceMan
    case bombMan
    case fireMan
    case elecMan
    case metalMan
    case crashMan
    case hardMan
    case tornadoMan
    case stoneMan

    var displayName: String {
        switch self {
        case .megaMan: return "Mega Man"
        case .protoMan: return "Proto Man"
        case .bass: return "Bass"
        case .roll: return "Roll"
        case .rush: return "Rush"
        case .cutMan: return "Cut Man"
        case .gutsMan: return "Guts Man"
        case .iceMan: return "Ice Man"
        case .bombMan: return "Bomb Man"
        case .fireMan: return "Fire Man"
        case .elecMan: return "Elec Man"
        case .metalMan: return "Metal Man"
        case .crashMan: return "Crash Man"
        case .hardMan: return "Hard Man"
        case .tornadoMan: return "Tornado Man"
        case .stoneMan: return "Stone Man"
        }
    }

    var emoji: String {
        switch self {
        case .megaMan: return "🤖"
        case .protoMan: return "🕶️"
        case .bass: return "🎸"
        case .roll: return "🧹"
        case .rush: return "🐕"
        case .cutMan: return "✂️"
        case .gutsMan: return "💪"
        case .iceMan: return "❄️"
        case .bombMan: return "💣"
        case .fireMan: return "🔥"
        case .elecMan: return "⚡"
        case .metalMan: return "⚙️"
        case .crashMan: return "💥"
        case .hardMan: return "🪨"
        case .tornadoMan: return "🌪️"
        case .stoneMan: return "🗿"
        }
    }
}
