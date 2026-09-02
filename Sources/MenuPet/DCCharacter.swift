import Foundation

enum DCCharacter: String, CaseIterable {
    case batman
    case superman
    case wonderWoman
    case flash
    case greenLantern
    case aquaman
    case joker
    case harleyQuinn
    case lexLuthor
    case darkseid

    var displayName: String {
        switch self {
        case .batman: return "Batman"
        case .superman: return "Superman"
        case .wonderWoman: return "Wonder Woman"
        case .flash: return "The Flash"
        case .greenLantern: return "Green Lantern"
        case .aquaman: return "Aquaman"
        case .joker: return "Joker"
        case .harleyQuinn: return "Harley Quinn"
        case .lexLuthor: return "Lex Luthor"
        case .darkseid: return "Darkseid"
        }
    }

    var emoji: String {
        switch self {
        case .batman: return "🦇"
        case .superman: return "S"
        case .wonderWoman: return "W"
        case .flash: return "Lightning"
        case .greenLantern: return "Lantern"
        case .aquaman: return "Trident"
        case .joker: return "🃏"
        case .harleyQuinn: return "Harlequin"
        case .lexLuthor: return "Lex"
        case .darkseid: return "Dark"
        }
    }
}
