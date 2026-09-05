import Foundation

enum MarioItem: String, CaseIterable {
    // Characters
    case mario
    case luigi
    case peach
    case toad
    case bowser
    case yoshi
    case donkeyKong
    case wario
    case waluigi
    case boo

    // Items
    case superMushroom
    case fireFlower
    case starman
    case coin
    case oneUpMushroom
    case yoshiEgg
    case pipe
    case questionBlock
    case goomba
    case koopaTroopa

    var displayName: String {
        switch self {
        case .mario: return "Mario"
        case .luigi: return "Luigi"
        case .peach: return "Princess Peach"
        case .toad: return "Toad"
        case .bowser: return "Bowser"
        case .yoshi: return "Yoshi"
        case .donkeyKong: return "Donkey Kong"
        case .wario: return "Wario"
        case .waluigi: return "Waluigi"
        case .boo: return "Boo"
        case .superMushroom: return "Super Mushroom"
        case .fireFlower: return "Fire Flower"
        case .starman: return "Starman"
        case .coin: return "Coin"
        case .oneUpMushroom: return "1-Up Mushroom"
        case .yoshiEgg: return "Yoshi Egg"
        case .pipe: return "Pipe"
        case .questionBlock: return "Question Block"
        case .goomba: return "Goomba"
        case .koopaTroopa: return "Koopa Troopa"
        }
    }

    var emoji: String {
        switch self {
        case .mario: return "🍄"
        case .luigi: return "🟢"
        case .peach: return "🍑"
        case .toad: return "🍄"
        case .bowser: return "🐢"
        case .yoshi: return "🦎"
        case .donkeyKong: return "🦍"
        case .wario: return "💜"
        case .waluigi: return "💜"
        case .boo: return "👻"
        case .superMushroom: return "🍄"
        case .fireFlower: return "🔥"
        case .starman: return "⭐"
        case .coin: return "🪙"
        case .oneUpMushroom: return "💚"
        case .yoshiEgg: return "🥚"
        case .pipe: return "🟩"
        case .questionBlock: return "❓"
        case .goomba: return "🍄"
        case .koopaTroopa: return "🐢"
        }
    }

    var isCharacter: Bool {
        switch self {
        case .mario, .luigi, .peach, .toad, .bowser, .yoshi, .donkeyKong, .wario, .waluigi, .boo:
            return true
        default:
            return false
        }
    }
}
