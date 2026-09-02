import Foundation

enum StarWarsCharacter: String, CaseIterable {
    case luke
    case vader
    case leia
    case han
    case chewbacca
    case yoda
    case maul
    case bobaFett
    case c3po
    case r2d2
    case obiWan
    case kyloRen
    case stormtrooper

    var displayName: String {
        switch self {
        case .luke: return "Luke Skywalker"
        case .vader: return "Darth Vader"
        case .leia: return "Princess Leia"
        case .han: return "Han Solo"
        case .chewbacca: return "Chewbacca"
        case .yoda: return "Yoda"
        case .maul: return "Darth Maul"
        case .bobaFett: return "Boba Fett"
        case .c3po: return "C-3PO"
        case .r2d2: return "R2-D2"
        case .obiWan: return "Obi-Wan Kenobi"
        case .kyloRen: return "Kylo Ren"
        case .stormtrooper: return "Stormtrooper"
        }
    }

    var emoji: String {
        switch self {
        case .luke: return "Jedi"
        case .vader: return "Sith"
        case .leia: return "Princess"
        case .han: return "Smuggler"
        case .chewbacca: return "Wookiee"
        case .yoda: return "Master"
        case .maul: return "Zabrak"
        case .bobaFett: return "Bounty"
        case .c3po: return "Droid"
        case .r2d2: return "Astromech"
        case .obiWan: return "Ben"
        case .kyloRen: return "Ren"
        case .stormtrooper: return "Empire"
        }
    }
}
