import Foundation

enum BatmanCharacter: String, CaseIterable {
    case joker
    case bane
    case riddler
    case penguin
    case harleyQuinn
    case scarecrow
    case killerCroc
    case poisonIvy
    case catwoman
    case twoFace
    case mrFreeze
    case redHood
    case rasAlGhul
    case deathstroke

    var displayName: String {
        switch self {
        case .joker: return "Joker"
        case .bane: return "Bane"
        case .riddler: return "Riddler"
        case .penguin: return "Penguin"
        case .harleyQuinn: return "Harley Quinn"
        case .scarecrow: return "Scarecrow"
        case .killerCroc: return "Killer Croc"
        case .poisonIvy: return "Poison Ivy"
        case .catwoman: return "Catwoman"
        case .twoFace: return "Two-Face"
        case .mrFreeze: return "Mr. Freeze"
        case .redHood: return "Red Hood"
        case .rasAlGhul: return "Ra's al Ghul"
        case .deathstroke: return "Deathstroke"
        }
    }

    var emoji: String {
        switch self {
        case .joker: return "🃏"
        case .bane: return "💪"
        case .riddler: return "❓"
        case .penguin: return "🐧"
        case .harleyQuinn: return "🃏"
        case .scarecrow: return "🎃"
        case .killerCroc: return "🐊"
        case .poisonIvy: return "🌿"
        case .catwoman: return "🐱"
        case .twoFace: return "🪙"
        case .mrFreeze: return "❄️"
        case .redHood: return "🔴"
        case .rasAlGhul: return "⚔️"
        case .deathstroke: return "🎯"
        }
    }
}
