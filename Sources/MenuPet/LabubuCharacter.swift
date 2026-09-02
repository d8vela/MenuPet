import Foundation

enum LabubuCharacter: String, CaseIterable {
    case labubu
    case labubuPink
    case labubuGray
    case labubuBrown
    case labubuWhite
    case labubuGolden

    var displayName: String {
        switch self {
        case .labubu: return "Labubu"
        case .labubuPink: return "Pink Labubu"
        case .labubuGray: return "Gray Labubu"
        case .labubuBrown: return "Brown Labubu"
        case .labubuWhite: return "White Labubu"
        case .labubuGolden: return "Golden Labubu"
        }
    }

    var emoji: String {
        switch self {
        case .labubu: return "🧸"
        case .labubuPink: return "💗"
        case .labubuGray: return "🐭"
        case .labubuBrown: return "🧸"
        case .labubuWhite: return "🤍"
        case .labubuGolden: return "✨"
        }
    }
}
