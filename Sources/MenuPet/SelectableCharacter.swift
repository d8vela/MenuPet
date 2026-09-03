import Foundation

enum SelectableCharacter: Equatable, Hashable {
    case pokemon(PokemonCharacter)
    case marioItem(MarioItem)
    case marioKart(MarioKartCharacter)
    case contra(ContraCharacter)
    case tmnt(TMNTCharacter)
    case streetFighter(StreetFighterCharacter)
    case metalSlug(MetalSlugCharacter)
    case overwatch(OverwatchCharacter)
    case kirby(KirbyCharacter)
    case zelda(ZeldaCharacter)
    case megaMan(MegaManCharacter)
    case marvel(MarvelCharacter)
    case dc(DCCharacter)
    case naruto(NarutoCharacter)
    case simpsons(SimpsonsCharacter)
    case mortalKombat(MortalKombatCharacter)
    case minions(MinionsCharacter)
    case dragonBall(DragonBallCharacter)
    case ghibli(GhibliCharacter)
    case gundam(GundamCharacter)
    case starWars(StarWarsCharacter)
    case labubu(LabubuCharacter)
    case kingOfTheHill(KingOfTheHillCharacter)
    case familyGuy(FamilyGuyCharacter)

    var identifier: String {
        switch self {
        case .pokemon(let p): return "pokemon_\(p.rawValue)"
        case .marioItem(let m): return "marioItem_\(m.rawValue)"
        case .marioKart(let k): return "marioKart_\(k.rawValue)"
        case .contra(let c): return "contra_\(c.rawValue)"
        case .tmnt(let t): return "tmnt_\(t.rawValue)"
        case .streetFighter(let s): return "streetFighter_\(s.rawValue)"
        case .metalSlug(let m): return "metalSlug_\(m.rawValue)"
        case .overwatch(let o): return "overwatch_\(o.rawValue)"
        case .kirby(let k): return "kirby_\(k.rawValue)"
        case .zelda(let z): return "zelda_\(z.rawValue)"
        case .megaMan(let m): return "megaMan_\(m.rawValue)"
        case .marvel(let m): return "marvel_\(m.rawValue)"
        case .dc(let d): return "dc_\(d.rawValue)"
        case .naruto(let n): return "naruto_\(n.rawValue)"
        case .simpsons(let s): return "simpsons_\(s.rawValue)"
        case .mortalKombat(let m): return "mortalKombat_\(m.rawValue)"
        case .minions(let m): return "minions_\(m.rawValue)"
        case .dragonBall(let d): return "dragonBall_\(d.rawValue)"
        case .ghibli(let g): return "ghibli_\(g.rawValue)"
        case .gundam(let g): return "gundam_\(g.rawValue)"
        case .starWars(let s): return "starWars_\(s.rawValue)"
        case .labubu(let l): return "labubu_\(l.rawValue)"
        case .kingOfTheHill(let k): return "kingOfTheHill_\(k.rawValue)"
        case .familyGuy(let f): return "familyGuy_\(f.rawValue)"
        }
    }

    static func from(identifier: String) -> SelectableCharacter? {
        let parts = identifier.split(separator: "_", maxSplits: 1)
        guard parts.count == 2 else { return nil }
        let prefix = String(parts[0])
        let value = String(parts[1])
        switch prefix {
        case "pokemon": return PokemonCharacter(rawValue: value).map { .pokemon($0) }
        case "marioItem": return MarioItem(rawValue: value).map { .marioItem($0) }
        case "marioKart": return MarioKartCharacter(rawValue: value).map { .marioKart($0) }
        case "contra": return ContraCharacter(rawValue: value).map { .contra($0) }
        case "tmnt": return TMNTCharacter(rawValue: value).map { .tmnt($0) }
        case "streetFighter": return StreetFighterCharacter(rawValue: value).map { .streetFighter($0) }
        case "metalSlug": return MetalSlugCharacter(rawValue: value).map { .metalSlug($0) }
        case "overwatch": return OverwatchCharacter(rawValue: value).map { .overwatch($0) }
        case "kirby": return KirbyCharacter(rawValue: value).map { .kirby($0) }
        case "zelda": return ZeldaCharacter(rawValue: value).map { .zelda($0) }
        case "megaMan": return MegaManCharacter(rawValue: value).map { .megaMan($0) }
        case "marvel": return MarvelCharacter(rawValue: value).map { .marvel($0) }
        case "dc": return DCCharacter(rawValue: value).map { .dc($0) }
        case "naruto": return NarutoCharacter(rawValue: value).map { .naruto($0) }
        case "simpsons": return SimpsonsCharacter(rawValue: value).map { .simpsons($0) }
        case "mortalKombat": return MortalKombatCharacter(rawValue: value).map { .mortalKombat($0) }
        case "minions": return MinionsCharacter(rawValue: value).map { .minions($0) }
        case "dragonBall": return DragonBallCharacter(rawValue: value).map { .dragonBall($0) }
        case "ghibli": return GhibliCharacter(rawValue: value).map { .ghibli($0) }
        case "gundam": return GundamCharacter(rawValue: value).map { .gundam($0) }
        case "starWars": return StarWarsCharacter(rawValue: value).map { .starWars($0) }
        case "labubu": return LabubuCharacter(rawValue: value).map { .labubu($0) }
        case "kingOfTheHill": return KingOfTheHillCharacter(rawValue: value).map { .kingOfTheHill($0) }
        case "familyGuy": return FamilyGuyCharacter(rawValue: value).map { .familyGuy($0) }
        default: return nil
        }
    }

    var displayName: String {
        switch self {
        case .pokemon(let p): return p.displayName
        case .marioItem(let m): return m.displayName
        case .marioKart(let k): return k.displayName
        case .contra(let c): return c.displayName
        case .tmnt(let t): return t.displayName
        case .streetFighter(let s): return s.displayName
        case .metalSlug(let m): return m.displayName
        case .overwatch(let o): return o.displayName
        case .kirby(let k): return k.displayName
        case .zelda(let z): return z.displayName
        case .megaMan(let m): return m.displayName
        case .marvel(let m): return m.displayName
        case .dc(let d): return d.displayName
        case .naruto(let n): return n.displayName
        case .simpsons(let s): return s.displayName
        case .mortalKombat(let m): return m.displayName
        case .minions(let m): return m.displayName
        case .dragonBall(let d): return d.displayName
        case .ghibli(let g): return g.displayName
        case .gundam(let g): return g.displayName
        case .starWars(let s): return s.displayName
        case .labubu(let l): return l.displayName
        case .kingOfTheHill(let k): return k.displayName
        case .familyGuy(let f): return f.displayName
        }
    }

    var emoji: String {
        switch self {
        case .pokemon(let p): return p.emoji
        case .marioItem(let m): return m.emoji
        case .marioKart(let k): return k.emoji
        case .contra(let c): return c.emoji
        case .tmnt(let t): return t.emoji
        case .streetFighter(let s): return s.emoji
        case .metalSlug(let m): return m.emoji
        case .overwatch(let o): return o.emoji
        case .kirby(let k): return k.emoji
        case .zelda(let z): return z.emoji
        case .megaMan(let m): return m.emoji
        case .marvel(let m): return m.emoji
        case .dc(let d): return d.emoji
        case .naruto(let n): return n.emoji
        case .simpsons(let s): return s.emoji
        case .mortalKombat(let m): return m.emoji
        case .minions(let m): return m.emoji
        case .dragonBall(let d): return d.emoji
        case .ghibli(let g): return g.emoji
        case .gundam(let g): return g.emoji
        case .starWars(let s): return s.emoji
        case .labubu(let l): return l.emoji
        case .kingOfTheHill(let k): return k.emoji
        case .familyGuy(let f): return f.emoji
        }
    }
}
