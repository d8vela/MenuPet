import Foundation

enum MortalKombatCharacter: String, CaseIterable {
    case scorpion
    case subZero
    case raiden
    case liuKang
    case sonya
    case johnnyCage
    case shangTsung
    case goro
    case kitana
    case jade
    case milena
    case reptile

    var displayName: String {
        switch self {
        case .scorpion: return "Scorpion"
        case .subZero: return "Sub-Zero"
        case .raiden: return "Raiden"
        case .liuKang: return "Liu Kang"
        case .sonya: return "Sonya Blade"
        case .johnnyCage: return "Johnny Cage"
        case .shangTsung: return "Shang Tsung"
        case .goro: return "Goro"
        case .kitana: return "Kitana"
        case .jade: return "Jade"
        case .milena: return "Mileena"
        case .reptile: return "Reptile"
        }
    }

    var emoji: String {
        switch self {
        case .scorpion: return "Get over here"
        case .subZero: return "❄️"
        case .raiden: return "⚡"
        case .liuKang: return "🐉"
        case .sonya: return "💪"
        case .johnnyCage: return " sunglasses"
        case .shangTsung: return "Skull"
        case .goro: return "👹"
        case .kitana: return "🦋"
        case .jade: return "🟢"
        case .milena: return "😷"
        case .reptile: return "🦎"
        }
    }
}
