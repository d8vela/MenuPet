import Foundation

enum FuturamaCharacter: String, CaseIterable {
    case fry
    case leela
    case bender
    case amy
    case farnsworth
    case hermes
    case zoidberg
    case cubert
    case ndnd
    case zapp

    var displayName: String {
        switch self {
        case .fry: return "Fry"
        case .leela: return "Leela"
        case .bender: return "Bender"
        case .amy: return "Amy"
        case .farnsworth: return "Professor Farnsworth"
        case .hermes: return "Hermes"
        case .zoidberg: return "Zoidberg"
        case .cubert: return "Cubert"
        case .ndnd: return "Ndnd"
        case .zapp: return "Zapp Brannigan"
        }
    }

    var emoji: String {
        switch self {
        case .fry: return "Pizza"
        case .leela: return "Eye"
        case .bender: return "Beer"
        case .amy: return "Lipstick"
        case .farnsworth: return "Lab"
        case .hermes: return "Bureaucrat"
        case .zoidberg: return "Claw"
        case .cubert: return "Kid"
        case .ndnd: return "Alien"
        case .zapp: return "Uniform"
        }
    }
}
