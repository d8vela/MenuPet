import Foundation

enum TransformersCharacter: String, CaseIterable {
    case optimusPrime
    case bumblebee
    case megatron
    case starscream
    case soundwave
    case prowl
    case jazz
    case ironhide
    case ratchet
    case shockwave
    case soundBlaster
    case galvatron
    case cyclonus
    case devestator

    var displayName: String {
        switch self {
        case .optimusPrime: return "Optimus Prime"
        case .bumblebee: return "Bumblebee"
        case .megatron: return "Megatron"
        case .starscream: return "Starscream"
        case .soundwave: return "Soundwave"
        case .prowl: return "Prowl"
        case .jazz: return "Jazz"
        case .ironhide: return "Ironhide"
        case .ratchet: return "Ratchet"
        case .shockwave: return "Shockwave"
        case .soundBlaster: return "Sound Blaster"
        case .galvatron: return "Galvatron"
        case .cyclonus: return "Cyclonus"
        case .devestator: return "Devastator"
        }
    }

    var emoji: String {
        switch self {
        case .optimusPrime: return "Truck"
        case .bumblebee: return "Bee"
        case .megatron: return "Gun"
        case .starscream: return "Plane"
        case .soundwave: return "Cassette"
        case .prowl: return "Police"
        case .jazz: return "Music"
        case .ironhide: return "Van"
        case .ratchet: return "Medic"
        case .shockwave: return "Eye"
        case .soundBlaster: return "Tape"
        case .galvatron: return "Cannon"
        case .cyclonus: return "Jet"
        case .devestator: return "Combine"
        }
    }
}
