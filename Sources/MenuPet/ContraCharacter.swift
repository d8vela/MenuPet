import Foundation

enum ContraCharacter: String, CaseIterable {
    case bill
    case lance
    case alienWall
    case neoDic
    case turret
    case sweat
    case probox
    case fireGun
    case machineGun
    case spreadGun
    case laserGun
    case barrier
    case rapidBullets

    var displayName: String {
        switch self {
        case .bill: return "Bill Rizer"
        case .lance: return "Lance Bean"
        case .alienWall: return "Alien Wall"
        case .neoDic: return "Neo DiC"
        case .turret: return "Turret"
        case .sweat: return "Sweat"
        case .probox: return "Probox"
        case .fireGun: return "Fire Gun"
        case .machineGun: return "Machine Gun"
        case .spreadGun: return "Spread Gun"
        case .laserGun: return "Laser Gun"
        case .barrier: return "Barrier"
        case .rapidBullets: return "Rapid Bullets"
        }
    }

    var emoji: String {
        switch self {
        case .bill: return "🔫"
        case .lance: return "🔫"
        case .alienWall: return "👾"
        case .neoDic: return "👽"
        case .turret: return "🎯"
        case .sweat: return "💀"
        case .probox: return "🤖"
        case .fireGun: return "🔥"
        case .machineGun: return "💥"
        case .spreadGun: return "🌟"
        case .laserGun: return "⚡"
        case .barrier: return "🛡️"
        case .rapidBullets: return "💨"
        }
    }
}
