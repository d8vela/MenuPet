import Foundation

enum FamilyGuyCharacter: String, CaseIterable {
    case peter
    case lois
    case stewie
    case brian
    case chris
    case meg
    case quagmire
    case cleveland
    case joe
    case adamWest
    case herbert
    case tomTucker

    var displayName: String {
        switch self {
        case .peter: return "Peter Griffin"
        case .lois: return "Lois Griffin"
        case .stewie: return "Stewie Griffin"
        case .brian: return "Brian Griffin"
        case .chris: return "Chris Griffin"
        case .meg: return "Meg Griffin"
        case .quagmire: return "Glenn Quagmire"
        case .cleveland: return "Cleveland Brown"
        case .joe: return "Joe Swanson"
        case .adamWest: return "Mayor Adam West"
        case .herbert: return "Herbert"
        case .tomTucker: return "Tom Tucker"
        }
    }

    var emoji: String {
        switch self {
        case .peter: return "🍺"
        case .lois: return "🎹"
        case .stewie: return "👶"
        case .brian: return "🍸"
        case .chris: return "🧢"
        case .meg: return "👓"
        case .quagmire: return "🌺"
        case .cleveland: return "🛁"
        case .joe: return "♿"
        case .adamWest: return "🎩"
        case .herbert: return "👴"
        case .tomTucker: return "📺"
        }
    }
}
