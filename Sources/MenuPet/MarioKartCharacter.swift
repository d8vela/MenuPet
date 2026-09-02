import Foundation

enum MarioKartCharacter: String, CaseIterable {
    case mario
    case luigi
    case peach
    case toad
    case bowser
    case donkeyKong
    case yoshi
    case wario
    case redShell
    case greenShell
    case bananaPeel
    case bomb
    case bulletBill
    case blueShell
    case star
    case lightning
    case mushroom
    case tripleMushroom
    case goldenMushroom

    var displayName: String {
        switch self {
        case .mario: return "Mario"
        case .luigi: return "Luigi"
        case .peach: return "Peach"
        case .toad: return "Toad"
        case .bowser: return "Bowser"
        case .donkeyKong: return "Donkey Kong"
        case .yoshi: return "Yoshi"
        case .wario: return "Wario"
        case .redShell: return "Red Shell"
        case .greenShell: return "Green Shell"
        case .bananaPeel: return "Banana Peel"
        case .bomb: return "Bob-omb"
        case .bulletBill: return "Bullet Bill"
        case .blueShell: return "Blue Shell"
        case .star: return "Star"
        case .lightning: return "Lightning"
        case .mushroom: return "Mushroom"
        case .tripleMushroom: return "Triple Mushroom"
        case .goldenMushroom: return "Golden Mushroom"
        }
    }

    var emoji: String {
        switch self {
        case .mario: return "🏎️"
        case .luigi: return "🏎️"
        case .peach: return "🏎️"
        case .toad: return "🏎️"
        case .bowser: return "🏎️"
        case .donkeyKong: return "🏎️"
        case .yoshi: return "🏎️"
        case .wario: return "🏎️"
        case .redShell: return "🔴"
        case .greenShell: return "🟢"
        case .bananaPeel: return "🍌"
        case .bomb: return "💣"
        case .bulletBill: return "🔘"
        case .blueShell: return "🔵"
        case .star: return "⭐"
        case .lightning: return "⚡"
        case .mushroom: return "🍄"
        case .tripleMushroom: return "🍄"
        case .goldenMushroom: return "🌟"
        }
    }
}
