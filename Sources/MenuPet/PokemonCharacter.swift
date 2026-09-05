import Foundation

enum PokemonCharacter: String, CaseIterable {
    case pikachu
    case psyduck
    case snorlax
    case charmander
    case bulbasaur
    case squirtle
    case jigglypuff
    case meowth
    case eevee
    case mew
    case gengar
    case dragonite
    case gyarados
    case arcanine
    case alakazam
    case machamp
    case golem
    case onix
    case jolteon
    case flareon
    case vaporeon
    case porygon
    case ditto
    case lapras
    case marill
    case umbreon
    case pokeball
    case greatBall
    case ultraBall
    case masterBall

    var displayName: String {
        return rawValue.capitalized
    }

    var emoji: String {
        switch self {
        case .pikachu: return "⚡"
        case .psyduck: return "🦆"
        case .snorlax: return "😴"
        case .charmander: return "🔥"
        case .bulbasaur: return "🌱"
        case .squirtle: return "💧"
        case .jigglypuff: return "🎵"
        case .meowth: return "🐱"
        case .eevee: return "🦊"
        case .mew: return "✨"
        case .gengar: return "👻"
        case .dragonite: return "🐉"
        case .gyarados: return "🌊"
        case .arcanine: return "🐺"
        case .alakazam: return "🔮"
        case .machamp: return "💪"
        case .golem: return "🪨"
        case .onix: return "🐍"
        case .jolteon: return "⚡"
        case .flareon: return "🔥"
        case .vaporeon: return "💧"
        case .porygon: return "🔷"
        case .ditto: return "🫧"
        case .lapras: return "🧊"
        case .marill: return "🫧"
        case .umbreon: return "🌑"
        case .pokeball: return "🔴"
        case .greatBall: return "🔵"
        case .ultraBall: return "⚫"
        case .masterBall: return "🟣"
        }
    }
}
