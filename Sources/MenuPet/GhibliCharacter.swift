import Foundation

enum GhibliCharacter: String, CaseIterable {
    case totoro
    case noFace
    case kiki
    case calcifer
    case ponyo
    case satsuki
    case mei
    case howl
    case sophie
    case append
    case jiro
    case chihiro

    var displayName: String {
        switch self {
        case .totoro: return "Totoro"
        case .noFace: return "No-Face"
        case .kiki: return "Kiki"
        case .calcifer: return "Calcifer"
        case .ponyo: return "Ponyo"
        case .satsuki: return "Satsuki"
        case .mei: return "Mei"
        case .howl: return "Howl"
        case .sophie: return "Sophie"
        case .append: return "Append"
        case .jiro: return "Jiro"
        case .chihiro: return "Chihiro"
        }
    }

    var emoji: String {
        switch self {
        case .totoro: return "Forest"
        case .noFace: return "Mask"
        case .kiki: return "Broom"
        case .calcifer: return "Fire"
        case .ponyo: return "Fish"
        case .satsuki: return "Umbrella"
        case .mei: return "Leaf"
        case .howl: return "Bird"
        case .sophie: return "Hat"
        case .append: return "Robot"
        case .jiro: return "Plane"
        case .chihiro: return "River"
        }
    }
}
