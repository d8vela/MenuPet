import Foundation

enum GundamCharacter: String, CaseIterable {
    case rx78
    case zaku
    case freedom
    case justice
    case strike
    case barbatos
    case unicorn
    case sinanju
    case exia
    case WingZero
    case deathscythe
    case heavyArms

    var displayName: String {
        switch self {
        case .rx78: return "RX-78-2"
        case .zaku: return "Zaku II"
        case .freedom: return "Freedom"
        case .justice: return "Justice"
        case .strike: return "Strike"
        case .barbatos: return "Barbatos"
        case .unicorn: return "Unicorn"
        case .sinanju: return "Sinanju"
        case .exia: return "Exia"
        case .WingZero: return "Wing Zero"
        case .deathscythe: return "Deathscythe"
        case .heavyArms: return "HeavyArms"
        }
    }

    var emoji: String {
        switch self {
        case .rx78: return "OG"
        case .zaku: return "Mono"
        case .freedom: return "SEED"
        case .justice: return "Red"
        case .strike: return "Blitz"
        case .barbatos: return "Iron"
        case .unicorn: return "Beam"
        case .sinanju: return "Gold"
        case .exia: return "GN"
        case .WingZero: return "Feather"
        case .deathscythe: return "Scythe"
        case .heavyArms: return "Guns"
        }
    }
}
