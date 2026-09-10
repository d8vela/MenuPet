import Foundation

struct CharacterPersonality {
    let hungerRate: Double
    let happinessRate: Double
    let energyRate: Double
    let hygieneRate: Double
    let disobedienceChance: Double
    let feedGain: Double
    let playGain: Double

    static let `default` = CharacterPersonality(
        hungerRate: 1.0, happinessRate: 1.0, energyRate: 1.0, hygieneRate: 1.0,
        disobedienceChance: 1.0, feedGain: 1.0, playGain: 1.0
    )
}

extension SelectableCharacter {
    var personality: CharacterPersonality {
        switch self {

        case .pokemon(let p):
            switch p {
            case .pikachu: return CharacterPersonality(hungerRate: 1.0, happinessRate: 1.3, energyRate: 1.2, hygieneRate: 0.8, disobedienceChance: 0.6, feedGain: 1.0, playGain: 1.3)
            case .charmander: return CharacterPersonality(hungerRate: 0.9, happinessRate: 0.8, energyRate: 1.3, hygieneRate: 1.2, disobedienceChance: 0.7, feedGain: 1.0, playGain: 1.0)
            case .bulbasaur: return CharacterPersonality(hungerRate: 0.7, happinessRate: 0.8, energyRate: 0.7, hygieneRate: 0.6, disobedienceChance: 0.3, feedGain: 1.1, playGain: 0.8)
            case .squirtle: return CharacterPersonality(hungerRate: 0.9, happinessRate: 1.1, energyRate: 1.0, hygieneRate: 0.5, disobedienceChance: 0.8, feedGain: 1.0, playGain: 1.1)
            case .umbreon: return CharacterPersonality(hungerRate: 0.8, happinessRate: 1.4, energyRate: 0.8, hygieneRate: 0.7, disobedienceChance: 0.4, feedGain: 1.0, playGain: 1.4)
            case .psyduck: return CharacterPersonality(hungerRate: 1.0, happinessRate: 0.7, energyRate: 0.6, hygieneRate: 0.8, disobedienceChance: 1.2, feedGain: 1.0, playGain: 0.7)
            case .snorlax: return CharacterPersonality(hungerRate: 2.5, happinessRate: 1.0, energyRate: 0.2, hygieneRate: 1.5, disobedienceChance: 0.5, feedGain: 2.5, playGain: 0.5)
            case .jigglypuff: return CharacterPersonality(hungerRate: 0.8, happinessRate: 1.5, energyRate: 1.0, hygieneRate: 0.6, disobedienceChance: 1.5, feedGain: 0.8, playGain: 1.5)
            case .meowth: return CharacterPersonality(hungerRate: 1.1, happinessRate: 1.2, energyRate: 1.1, hygieneRate: 0.9, disobedienceChance: 1.0, feedGain: 1.1, playGain: 1.2)
            case .eevee: return CharacterPersonality(hungerRate: 0.9, happinessRate: 1.3, energyRate: 1.0, hygieneRate: 0.7, disobedienceChance: 0.4, feedGain: 1.0, playGain: 1.3)
            case .mew: return CharacterPersonality(hungerRate: 0.5, happinessRate: 1.6, energyRate: 1.4, hygieneRate: 0.3, disobedienceChance: 0.2, feedGain: 0.8, playGain: 1.6)
            case .gengar: return CharacterPersonality(hungerRate: 0.8, happinessRate: 0.6, energyRate: 1.3, hygieneRate: 1.0, disobedienceChance: 1.5, feedGain: 0.8, playGain: 0.6)
            case .dragonite: return CharacterPersonality(hungerRate: 1.5, happinessRate: 1.2, energyRate: 1.5, hygieneRate: 1.0, disobedienceChance: 0.3, feedGain: 1.5, playGain: 1.2)
            case .gyarados: return CharacterPersonality(hungerRate: 1.8, happinessRate: 0.4, energyRate: 1.6, hygieneRate: 1.2, disobedienceChance: 2.5, feedGain: 1.8, playGain: 0.4)
            case .arcanine: return CharacterPersonality(hungerRate: 1.2, happinessRate: 1.1, energyRate: 1.4, hygieneRate: 0.8, disobedienceChance: 0.5, feedGain: 1.2, playGain: 1.1)
            case .alakazam: return CharacterPersonality(hungerRate: 0.6, happinessRate: 0.9, energyRate: 1.0, hygieneRate: 0.4, disobedienceChance: 0.3, feedGain: 0.8, playGain: 0.9)
            case .machamp: return CharacterPersonality(hungerRate: 1.8, happinessRate: 0.7, energyRate: 1.6, hygieneRate: 1.3, disobedienceChance: 1.0, feedGain: 1.8, playGain: 0.7)
            case .golem: return CharacterPersonality(hungerRate: 1.4, happinessRate: 0.6, energyRate: 1.2, hygieneRate: 1.5, disobedienceChance: 0.8, feedGain: 1.4, playGain: 0.6)
            case .onix: return CharacterPersonality(hungerRate: 1.0, happinessRate: 0.5, energyRate: 1.1, hygieneRate: 1.2, disobedienceChance: 0.6, feedGain: 1.0, playGain: 0.5)
            case .jolteon: return CharacterPersonality(hungerRate: 0.9, happinessRate: 1.2, energyRate: 1.4, hygieneRate: 0.5, disobedienceChance: 0.4, feedGain: 1.0, playGain: 1.2)
            case .flareon: return CharacterPersonality(hungerRate: 1.1, happinessRate: 0.8, energyRate: 1.3, hygieneRate: 0.9, disobedienceChance: 0.7, feedGain: 1.1, playGain: 0.8)
            case .vaporeon: return CharacterPersonality(hungerRate: 0.8, happinessRate: 1.1, energyRate: 0.9, hygieneRate: 0.3, disobedienceChance: 0.3, feedGain: 1.0, playGain: 1.1)
            case .porygon: return CharacterPersonality(hungerRate: 0.3, happinessRate: 0.6, energyRate: 0.8, hygieneRate: 0.2, disobedienceChance: 0.1, feedGain: 0.5, playGain: 0.6)
            case .ditto: return CharacterPersonality(hungerRate: 0.7, happinessRate: 1.4, energyRate: 0.7, hygieneRate: 0.5, disobedienceChance: 0.8, feedGain: 0.8, playGain: 1.4)
            case .lapras: return CharacterPersonality(hungerRate: 1.2, happinessRate: 1.0, energyRate: 0.8, hygieneRate: 0.4, disobedienceChance: 0.2, feedGain: 1.2, playGain: 1.0)
            case .marill: return CharacterPersonality(hungerRate: 0.9, happinessRate: 1.3, energyRate: 0.9, hygieneRate: 0.5, disobedienceChance: 0.3, feedGain: 1.0, playGain: 1.3)
            case .pokeball: return CharacterPersonality(hungerRate: 0.1, happinessRate: 0.5, energyRate: 0.1, hygieneRate: 0.1, disobedienceChance: 0.0, feedGain: 0.1, playGain: 0.5)
            case .greatBall: return CharacterPersonality(hungerRate: 0.1, happinessRate: 0.6, energyRate: 0.1, hygieneRate: 0.1, disobedienceChance: 0.0, feedGain: 0.1, playGain: 0.6)
            case .ultraBall: return CharacterPersonality(hungerRate: 0.1, happinessRate: 0.7, energyRate: 0.1, hygieneRate: 0.1, disobedienceChance: 0.0, feedGain: 0.1, playGain: 0.7)
            case .masterBall: return CharacterPersonality(hungerRate: 0.1, happinessRate: 0.9, energyRate: 0.1, hygieneRate: 0.1, disobedienceChance: 0.0, feedGain: 0.1, playGain: 0.9)
            }

        case .marioItem(let m):
            switch m {
            case .mario: return CharacterPersonality(hungerRate: 1.0, happinessRate: 0.9, energyRate: 1.1, hygieneRate: 1.0, disobedienceChance: 0.3, feedGain: 1.0, playGain: 1.0)
            case .luigi: return CharacterPersonality(hungerRate: 0.9, happinessRate: 1.1, energyRate: 0.9, hygieneRate: 1.1, disobedienceChance: 0.5, feedGain: 1.0, playGain: 1.0)
            case .peach: return CharacterPersonality(hungerRate: 0.8, happinessRate: 1.3, energyRate: 0.7, hygieneRate: 0.5, disobedienceChance: 0.2, feedGain: 1.0, playGain: 1.5)
            case .toad: return CharacterPersonality(hungerRate: 1.2, happinessRate: 1.5, energyRate: 1.4, hygieneRate: 1.0, disobedienceChance: 0.4, feedGain: 1.2, playGain: 1.3)
            case .yoshi: return CharacterPersonality(hungerRate: 1.4, happinessRate: 1.2, energyRate: 1.1, hygieneRate: 0.9, disobedienceChance: 0.5, feedGain: 1.5, playGain: 1.1)
            case .bowser: return CharacterPersonality(hungerRate: 1.3, happinessRate: 0.7, energyRate: 1.5, hygieneRate: 1.4, disobedienceChance: 2.0, feedGain: 1.3, playGain: 0.6)
            case .boo: return CharacterPersonality(hungerRate: 0.5, happinessRate: 1.0, energyRate: 0.5, hygieneRate: 0.3, disobedienceChance: 1.2, feedGain: 0.8, playGain: 0.8)
            case .donkeyKong: return CharacterPersonality(hungerRate: 1.6, happinessRate: 0.8, energyRate: 1.4, hygieneRate: 1.3, disobedienceChance: 1.5, feedGain: 1.6, playGain: 0.8)
            case .wario: return CharacterPersonality(hungerRate: 1.8, happinessRate: 0.5, energyRate: 1.3, hygieneRate: 1.8, disobedienceChance: 2.5, feedGain: 1.8, playGain: 0.5)
            case .waluigi: return CharacterPersonality(hungerRate: 1.5, happinessRate: 0.4, energyRate: 1.2, hygieneRate: 1.6, disobedienceChance: 2.8, feedGain: 1.5, playGain: 0.4)
            case .superMushroom: return CharacterPersonality(hungerRate: 0.5, happinessRate: 1.5, energyRate: 1.5, hygieneRate: 0.5, disobedienceChance: 0.1, feedGain: 0.8, playGain: 1.5)
            case .fireFlower: return CharacterPersonality(hungerRate: 0.4, happinessRate: 1.2, energyRate: 1.4, hygieneRate: 0.4, disobedienceChance: 0.2, feedGain: 0.6, playGain: 1.2)
            case .starman: return CharacterPersonality(hungerRate: 0.2, happinessRate: 1.8, energyRate: 2.0, hygieneRate: 0.2, disobedienceChance: 0.0, feedGain: 0.3, playGain: 1.8)
            case .coin: return CharacterPersonality(hungerRate: 0.1, happinessRate: 1.0, energyRate: 0.1, hygieneRate: 0.1, disobedienceChance: 0.0, feedGain: 0.1, playGain: 1.0)
            case .oneUpMushroom: return CharacterPersonality(hungerRate: 0.3, happinessRate: 1.6, energyRate: 1.2, hygieneRate: 0.3, disobedienceChance: 0.0, feedGain: 0.5, playGain: 1.6)
            case .yoshiEgg: return CharacterPersonality(hungerRate: 0.4, happinessRate: 1.4, energyRate: 0.8, hygieneRate: 0.3, disobedienceChance: 0.1, feedGain: 0.6, playGain: 1.4)
            case .pipe: return CharacterPersonality(hungerRate: 0.1, happinessRate: 0.3, energyRate: 0.1, hygieneRate: 0.2, disobedienceChance: 0.0, feedGain: 0.1, playGain: 0.3)
            case .questionBlock: return CharacterPersonality(hungerRate: 0.2, happinessRate: 1.2, energyRate: 0.2, hygieneRate: 0.2, disobedienceChance: 0.0, feedGain: 0.3, playGain: 1.2)
            case .goomba: return CharacterPersonality(hungerRate: 1.0, happinessRate: 0.3, energyRate: 0.8, hygieneRate: 0.8, disobedienceChance: 1.5, feedGain: 1.0, playGain: 0.3)
            case .koopaTroopa: return CharacterPersonality(hungerRate: 0.9, happinessRate: 0.6, energyRate: 0.7, hygieneRate: 0.7, disobedienceChance: 0.8, feedGain: 0.9, playGain: 0.6)
            }

        case .marioKart(let mk):
            switch mk {
            case .mario: return CharacterPersonality(hungerRate: 1.0, happinessRate: 1.1, energyRate: 1.2, hygieneRate: 0.9, disobedienceChance: 0.3, feedGain: 1.0, playGain: 1.1)
            case .luigi: return CharacterPersonality(hungerRate: 0.9, happinessRate: 1.2, energyRate: 1.0, hygieneRate: 1.0, disobedienceChance: 0.5, feedGain: 1.0, playGain: 1.2)
            case .peach: return CharacterPersonality(hungerRate: 0.8, happinessRate: 1.4, energyRate: 0.9, hygieneRate: 0.5, disobedienceChance: 0.2, feedGain: 1.0, playGain: 1.4)
            case .bowser: return CharacterPersonality(hungerRate: 1.4, happinessRate: 0.6, energyRate: 1.6, hygieneRate: 1.5, disobedienceChance: 2.0, feedGain: 1.4, playGain: 0.5)
            case .toad: return CharacterPersonality(hungerRate: 1.3, happinessRate: 1.6, energyRate: 1.5, hygieneRate: 1.1, disobedienceChance: 0.4, feedGain: 1.3, playGain: 1.6)
            case .yoshi: return CharacterPersonality(hungerRate: 1.5, happinessRate: 1.3, energyRate: 1.2, hygieneRate: 0.9, disobedienceChance: 0.5, feedGain: 1.5, playGain: 1.3)
            case .donkeyKong: return CharacterPersonality(hungerRate: 1.6, happinessRate: 0.8, energyRate: 1.4, hygieneRate: 1.3, disobedienceChance: 1.5, feedGain: 1.6, playGain: 0.8)
            case .wario: return CharacterPersonality(hungerRate: 1.7, happinessRate: 0.5, energyRate: 1.3, hygieneRate: 1.6, disobedienceChance: 2.2, feedGain: 1.7, playGain: 0.5)
            case .redShell: return CharacterPersonality(hungerRate: 0.2, happinessRate: 0.8, energyRate: 0.3, hygieneRate: 0.2, disobedienceChance: 0.0, feedGain: 0.3, playGain: 0.8)
            case .greenShell: return CharacterPersonality(hungerRate: 0.2, happinessRate: 0.7, energyRate: 0.3, hygieneRate: 0.2, disobedienceChance: 0.0, feedGain: 0.3, playGain: 0.7)
            case .bananaPeel: return CharacterPersonality(hungerRate: 0.1, happinessRate: 1.0, energyRate: 0.2, hygieneRate: 0.1, disobedienceChance: 0.0, feedGain: 0.2, playGain: 1.0)
            case .bomb: return CharacterPersonality(hungerRate: 0.3, happinessRate: 0.6, energyRate: 0.5, hygieneRate: 0.3, disobedienceChance: 0.0, feedGain: 0.3, playGain: 0.6)
            case .bulletBill: return CharacterPersonality(hungerRate: 0.2, happinessRate: 0.5, energyRate: 0.8, hygieneRate: 0.2, disobedienceChance: 0.0, feedGain: 0.3, playGain: 0.5)
            case .blueShell: return CharacterPersonality(hungerRate: 0.2, happinessRate: 0.4, energyRate: 0.6, hygieneRate: 0.2, disobedienceChance: 0.0, feedGain: 0.3, playGain: 0.4)
            case .star: return CharacterPersonality(hungerRate: 0.1, happinessRate: 1.8, energyRate: 2.0, hygieneRate: 0.1, disobedienceChance: 0.0, feedGain: 0.2, playGain: 1.8)
            case .lightning: return CharacterPersonality(hungerRate: 0.2, happinessRate: 0.9, energyRate: 1.5, hygieneRate: 0.2, disobedienceChance: 0.0, feedGain: 0.3, playGain: 0.9)
            case .mushroom: return CharacterPersonality(hungerRate: 0.3, happinessRate: 1.2, energyRate: 1.3, hygieneRate: 0.3, disobedienceChance: 0.0, feedGain: 0.4, playGain: 1.2)
            case .tripleMushroom: return CharacterPersonality(hungerRate: 0.3, happinessRate: 1.5, energyRate: 1.6, hygieneRate: 0.3, disobedienceChance: 0.0, feedGain: 0.4, playGain: 1.5)
            case .goldenMushroom: return CharacterPersonality(hungerRate: 0.3, happinessRate: 1.8, energyRate: 2.0, hygieneRate: 0.3, disobedienceChance: 0.0, feedGain: 0.4, playGain: 1.8)
            }

        case .kirby(let k):
            switch k {
            case .kirby: return CharacterPersonality(hungerRate: 1.8, happinessRate: 1.0, energyRate: 0.6, hygieneRate: 0.7, disobedienceChance: 0.2, feedGain: 1.8, playGain: 1.0)
            case .metaKnight: return CharacterPersonality(hungerRate: 0.9, happinessRate: 0.7, energyRate: 1.3, hygieneRate: 0.5, disobedienceChance: 0.6, feedGain: 1.0, playGain: 0.8)
            case .kingDedede: return CharacterPersonality(hungerRate: 1.6, happinessRate: 0.9, energyRate: 1.0, hygieneRate: 1.3, disobedienceChance: 1.5, feedGain: 1.6, playGain: 0.8)
            case .waddleDee: return CharacterPersonality(hungerRate: 1.0, happinessRate: 1.5, energyRate: 1.2, hygieneRate: 0.8, disobedienceChance: 0.1, feedGain: 1.0, playGain: 1.5)
            case .bandanaWaddleDee: return CharacterPersonality(hungerRate: 1.0, happinessRate: 1.4, energyRate: 1.3, hygieneRate: 0.7, disobedienceChance: 0.2, feedGain: 1.0, playGain: 1.4)
            case .waddleDoo: return CharacterPersonality(hungerRate: 1.1, happinessRate: 1.2, energyRate: 1.1, hygieneRate: 0.7, disobedienceChance: 0.3, feedGain: 1.1, playGain: 1.2)
            case .Gordy: return CharacterPersonality(hungerRate: 0.5, happinessRate: 0.3, energyRate: 0.8, hygieneRate: 0.3, disobedienceChance: 2.0, feedGain: 0.6, playGain: 0.3)
            case .brontoBurt: return CharacterPersonality(hungerRate: 0.8, happinessRate: 0.9, energyRate: 1.4, hygieneRate: 0.5, disobedienceChance: 0.7, feedGain: 0.8, playGain: 0.9)
            case .bonkers: return CharacterPersonality(hungerRate: 1.5, happinessRate: 0.6, energyRate: 1.5, hygieneRate: 1.2, disobedienceChance: 1.8, feedGain: 1.5, playGain: 0.6)
            case .kingDededeBoss: return CharacterPersonality(hungerRate: 1.8, happinessRate: 0.5, energyRate: 1.4, hygieneRate: 1.5, disobedienceChance: 2.5, feedGain: 1.8, playGain: 0.5)
            }

        case .zelda(let z):
            switch z {
            case .link: return CharacterPersonality(hungerRate: 1.0, happinessRate: 0.8, energyRate: 1.3, hygieneRate: 1.0, disobedienceChance: 0.5, feedGain: 1.0, playGain: 0.8)
            case .zelda: return CharacterPersonality(hungerRate: 0.7, happinessRate: 1.2, energyRate: 0.8, hygieneRate: 0.6, disobedienceChance: 0.2, feedGain: 1.0, playGain: 1.3)
            case .ganon: return CharacterPersonality(hungerRate: 1.1, happinessRate: 0.5, energyRate: 1.4, hygieneRate: 1.5, disobedienceChance: 2.5, feedGain: 1.2, playGain: 0.5)
            case .navi: return CharacterPersonality(hungerRate: 0.4, happinessRate: 1.6, energyRate: 1.5, hygieneRate: 0.3, disobedienceChance: 0.3, feedGain: 0.5, playGain: 1.6)
            case .midna: return CharacterPersonality(hungerRate: 0.7, happinessRate: 1.0, energyRate: 1.1, hygieneRate: 0.6, disobedienceChance: 0.8, feedGain: 0.8, playGain: 1.0)
            case .impa: return CharacterPersonality(hungerRate: 0.8, happinessRate: 0.9, energyRate: 1.2, hygieneRate: 0.5, disobedienceChance: 0.4, feedGain: 0.9, playGain: 0.9)
            case .skullKid: return CharacterPersonality(hungerRate: 1.0, happinessRate: 0.6, energyRate: 1.3, hygieneRate: 1.0, disobedienceChance: 2.0, feedGain: 1.0, playGain: 0.6)
            case .greatFairy: return CharacterPersonality(hungerRate: 0.5, happinessRate: 1.5, energyRate: 0.6, hygieneRate: 0.2, disobedienceChance: 0.1, feedGain: 0.8, playGain: 1.5)
            case .octorok: return CharacterPersonality(hungerRate: 1.2, happinessRate: 0.4, energyRate: 0.9, hygieneRate: 1.0, disobedienceChance: 1.5, feedGain: 1.2, playGain: 0.4)
            case .moblin: return CharacterPersonality(hungerRate: 1.4, happinessRate: 0.3, energyRate: 1.3, hygieneRate: 1.5, disobedienceChance: 2.0, feedGain: 1.4, playGain: 0.3)
            case .keese: return CharacterPersonality(hungerRate: 0.6, happinessRate: 0.5, energyRate: 1.5, hygieneRate: 0.8, disobedienceChance: 1.0, feedGain: 0.6, playGain: 0.5)
            case .darkLink: return CharacterPersonality(hungerRate: 1.0, happinessRate: 0.3, energyRate: 1.4, hygieneRate: 0.7, disobedienceChance: 2.0, feedGain: 1.0, playGain: 0.3)
            }

        case .megaMan(let m):
            switch m {
            case .megaMan: return CharacterPersonality(hungerRate: 0.6, happinessRate: 1.0, energyRate: 1.2, hygieneRate: 0.5, disobedienceChance: 0.2, feedGain: 1.0, playGain: 1.0)
            case .roll: return CharacterPersonality(hungerRate: 0.7, happinessRate: 1.3, energyRate: 0.9, hygieneRate: 0.3, disobedienceChance: 0.1, feedGain: 1.0, playGain: 1.4)
            case .protoMan: return CharacterPersonality(hungerRate: 0.8, happinessRate: 0.6, energyRate: 1.4, hygieneRate: 1.2, disobedienceChance: 1.3, feedGain: 0.9, playGain: 0.7)
            case .bass: return CharacterPersonality(hungerRate: 1.0, happinessRate: 0.5, energyRate: 1.5, hygieneRate: 1.3, disobedienceChance: 2.0, feedGain: 1.0, playGain: 0.5)
            case .rush: return CharacterPersonality(hungerRate: 1.2, happinessRate: 1.4, energyRate: 1.3, hygieneRate: 0.8, disobedienceChance: 0.2, feedGain: 1.2, playGain: 1.4)
            case .cutMan: return CharacterPersonality(hungerRate: 0.9, happinessRate: 0.8, energyRate: 1.1, hygieneRate: 0.7, disobedienceChance: 0.8, feedGain: 0.9, playGain: 0.8)
            case .gutsMan: return CharacterPersonality(hungerRate: 1.5, happinessRate: 0.7, energyRate: 1.4, hygieneRate: 1.3, disobedienceChance: 1.0, feedGain: 1.5, playGain: 0.7)
            case .iceMan: return CharacterPersonality(hungerRate: 0.7, happinessRate: 0.9, energyRate: 1.0, hygieneRate: 0.4, disobedienceChance: 0.5, feedGain: 0.8, playGain: 0.9)
            case .bombMan: return CharacterPersonality(hungerRate: 1.1, happinessRate: 0.6, energyRate: 1.3, hygieneRate: 1.2, disobedienceChance: 1.5, feedGain: 1.1, playGain: 0.6)
            case .fireMan: return CharacterPersonality(hungerRate: 1.0, happinessRate: 0.7, energyRate: 1.4, hygieneRate: 1.0, disobedienceChance: 1.2, feedGain: 1.0, playGain: 0.7)
            case .elecMan: return CharacterPersonality(hungerRate: 0.8, happinessRate: 0.8, energyRate: 1.5, hygieneRate: 0.6, disobedienceChance: 0.9, feedGain: 0.9, playGain: 0.8)
            case .metalMan: return CharacterPersonality(hungerRate: 1.2, happinessRate: 0.5, energyRate: 1.2, hygieneRate: 1.0, disobedienceChance: 1.0, feedGain: 1.2, playGain: 0.5)
            case .crashMan: return CharacterPersonality(hungerRate: 0.9, happinessRate: 0.7, energyRate: 1.3, hygieneRate: 0.8, disobedienceChance: 1.1, feedGain: 0.9, playGain: 0.7)
            case .hardMan: return CharacterPersonality(hungerRate: 1.4, happinessRate: 0.4, energyRate: 1.5, hygieneRate: 1.2, disobedienceChance: 1.3, feedGain: 1.4, playGain: 0.4)
            case .tornadoMan: return CharacterPersonality(hungerRate: 0.8, happinessRate: 0.9, energyRate: 1.4, hygieneRate: 0.7, disobedienceChance: 0.8, feedGain: 0.9, playGain: 0.9)
            case .stoneMan: return CharacterPersonality(hungerRate: 1.3, happinessRate: 0.3, energyRate: 1.1, hygieneRate: 1.5, disobedienceChance: 0.6, feedGain: 1.3, playGain: 0.3)
            }

        case .contra(let c):
            switch c {
            case .bill: return CharacterPersonality(hungerRate: 1.2, happinessRate: 0.7, energyRate: 1.5, hygieneRate: 1.4, disobedienceChance: 1.5, feedGain: 1.2, playGain: 0.7)
            case .lance: return CharacterPersonality(hungerRate: 1.1, happinessRate: 0.7, energyRate: 1.4, hygieneRate: 1.3, disobedienceChance: 1.4, feedGain: 1.1, playGain: 0.7)
            case .alienWall: return CharacterPersonality(hungerRate: 0.5, happinessRate: 0.2, energyRate: 0.8, hygieneRate: 1.5, disobedienceChance: 2.0, feedGain: 0.5, playGain: 0.2)
            case .neoDic: return CharacterPersonality(hungerRate: 0.6, happinessRate: 0.3, energyRate: 0.9, hygieneRate: 1.0, disobedienceChance: 1.8, feedGain: 0.6, playGain: 0.3)
            case .turret: return CharacterPersonality(hungerRate: 0.3, happinessRate: 0.1, energyRate: 1.0, hygieneRate: 0.5, disobedienceChance: 0.0, feedGain: 0.3, playGain: 0.1)
            case .sweat: return CharacterPersonality(hungerRate: 0.4, happinessRate: 0.2, energyRate: 0.5, hygieneRate: 0.8, disobedienceChance: 0.5, feedGain: 0.4, playGain: 0.2)
            case .probox: return CharacterPersonality(hungerRate: 0.8, happinessRate: 0.5, energyRate: 1.2, hygieneRate: 0.7, disobedienceChance: 1.0, feedGain: 0.8, playGain: 0.5)
            case .fireGun: return CharacterPersonality(hungerRate: 0.3, happinessRate: 0.8, energyRate: 1.3, hygieneRate: 0.4, disobedienceChance: 0.0, feedGain: 0.4, playGain: 0.8)
            case .machineGun: return CharacterPersonality(hungerRate: 0.3, happinessRate: 0.7, energyRate: 1.4, hygieneRate: 0.5, disobedienceChance: 0.0, feedGain: 0.4, playGain: 0.7)
            case .spreadGun: return CharacterPersonality(hungerRate: 0.3, happinessRate: 0.9, energyRate: 1.5, hygieneRate: 0.4, disobedienceChance: 0.0, feedGain: 0.4, playGain: 0.9)
            case .laserGun: return CharacterPersonality(hungerRate: 0.3, happinessRate: 0.6, energyRate: 1.3, hygieneRate: 0.3, disobedienceChance: 0.0, feedGain: 0.4, playGain: 0.6)
            case .barrier: return CharacterPersonality(hungerRate: 0.2, happinessRate: 0.5, energyRate: 0.5, hygieneRate: 0.2, disobedienceChance: 0.0, feedGain: 0.3, playGain: 0.5)
            case .rapidBullets: return CharacterPersonality(hungerRate: 0.3, happinessRate: 0.6, energyRate: 1.4, hygieneRate: 0.4, disobedienceChance: 0.0, feedGain: 0.4, playGain: 0.6)
            }

        case .streetFighter(let sf):
            switch sf {
            case .ryu: return CharacterPersonality(hungerRate: 1.3, happinessRate: 0.6, energyRate: 1.5, hygieneRate: 1.0, disobedienceChance: 0.8, feedGain: 1.3, playGain: 0.6)
            case .ken: return CharacterPersonality(hungerRate: 1.2, happinessRate: 0.9, energyRate: 1.4, hygieneRate: 1.1, disobedienceChance: 1.0, feedGain: 1.2, playGain: 0.9)
            case .chunLi: return CharacterPersonality(hungerRate: 0.9, happinessRate: 1.1, energyRate: 1.3, hygieneRate: 0.6, disobedienceChance: 0.5, feedGain: 1.0, playGain: 1.2)
            case .guile: return CharacterPersonality(hungerRate: 1.0, happinessRate: 0.7, energyRate: 1.2, hygieneRate: 0.8, disobedienceChance: 0.7, feedGain: 1.0, playGain: 0.7)
            case .dhalsim: return CharacterPersonality(hungerRate: 0.6, happinessRate: 1.2, energyRate: 0.8, hygieneRate: 0.5, disobedienceChance: 0.2, feedGain: 0.8, playGain: 1.3)
            case .balrog: return CharacterPersonality(hungerRate: 1.5, happinessRate: 0.5, energyRate: 1.6, hygieneRate: 1.5, disobedienceChance: 2.2, feedGain: 1.5, playGain: 0.5)
            case .zangief: return CharacterPersonality(hungerRate: 1.8, happinessRate: 0.6, energyRate: 1.5, hygieneRate: 1.6, disobedienceChance: 1.5, feedGain: 1.8, playGain: 0.6)
            case .blanka: return CharacterPersonality(hungerRate: 1.0, happinessRate: 1.0, energyRate: 1.3, hygieneRate: 1.2, disobedienceChance: 1.8, feedGain: 1.0, playGain: 1.0)
            case .eHonda: return CharacterPersonality(hungerRate: 1.4, happinessRate: 0.8, energyRate: 1.3, hygieneRate: 1.0, disobedienceChance: 0.6, feedGain: 1.4, playGain: 0.8)
            case .vega: return CharacterPersonality(hungerRate: 0.8, happinessRate: 0.7, energyRate: 1.4, hygieneRate: 0.5, disobedienceChance: 1.2, feedGain: 0.9, playGain: 0.7)
            case .sagat: return CharacterPersonality(hungerRate: 1.3, happinessRate: 0.4, energyRate: 1.5, hygieneRate: 1.2, disobedienceChance: 1.8, feedGain: 1.3, playGain: 0.4)
            case .dictator: return CharacterPersonality(hungerRate: 1.0, happinessRate: 0.2, energyRate: 1.6, hygieneRate: 0.8, disobedienceChance: 3.0, feedGain: 1.0, playGain: 0.2)
            }

        case .metalSlug(let ms):
            switch ms {
            case .marco: return CharacterPersonality(hungerRate: 1.1, happinessRate: 0.8, energyRate: 1.3, hygieneRate: 1.2, disobedienceChance: 0.9, feedGain: 1.1, playGain: 0.8)
            case .tarma: return CharacterPersonality(hungerRate: 1.2, happinessRate: 0.7, energyRate: 1.4, hygieneRate: 1.3, disobedienceChance: 1.0, feedGain: 1.2, playGain: 0.7)
            case .eri: return CharacterPersonality(hungerRate: 0.9, happinessRate: 1.2, energyRate: 1.1, hygieneRate: 0.8, disobedienceChance: 0.6, feedGain: 1.0, playGain: 1.2)
            case .fio: return CharacterPersonality(hungerRate: 0.8, happinessRate: 1.3, energyRate: 1.0, hygieneRate: 0.7, disobedienceChance: 0.4, feedGain: 1.0, playGain: 1.3)
            case .morden: return CharacterPersonality(hungerRate: 1.0, happinessRate: 0.2, energyRate: 1.3, hygieneRate: 1.0, disobedienceChance: 2.5, feedGain: 1.0, playGain: 0.2)
            case .camel: return CharacterPersonality(hungerRate: 1.5, happinessRate: 0.6, energyRate: 1.0, hygieneRate: 1.2, disobedienceChance: 0.3, feedGain: 1.5, playGain: 0.6)
            case .slugTank: return CharacterPersonality(hungerRate: 0.5, happinessRate: 0.4, energyRate: 1.5, hygieneRate: 0.8, disobedienceChance: 0.0, feedGain: 0.6, playGain: 0.4)
            case .zombie: return CharacterPersonality(hungerRate: 1.2, happinessRate: 0.1, energyRate: 0.8, hygieneRate: 2.0, disobedienceChance: 2.0, feedGain: 1.2, playGain: 0.1)
            case .mummy: return CharacterPersonality(hungerRate: 0.8, happinessRate: 0.2, energyRate: 0.7, hygieneRate: 1.8, disobedienceChance: 1.5, feedGain: 0.8, playGain: 0.2)
            case .ape: return CharacterPersonality(hungerRate: 1.5, happinessRate: 0.5, energyRate: 1.4, hygieneRate: 1.3, disobedienceChance: 1.8, feedGain: 1.5, playGain: 0.5)
            case .hermit: return CharacterPersonality(hungerRate: 0.6, happinessRate: 0.6, energyRate: 0.7, hygieneRate: 0.8, disobedienceChance: 0.5, feedGain: 0.7, playGain: 0.6)
            case .crab: return CharacterPersonality(hungerRate: 0.7, happinessRate: 0.5, energyRate: 0.9, hygieneRate: 0.9, disobedienceChance: 1.0, feedGain: 0.8, playGain: 0.5)
            }

        case .overwatch(let ow):
            switch ow {
            case .tracer: return CharacterPersonality(hungerRate: 1.1, happinessRate: 1.5, energyRate: 1.6, hygieneRate: 1.0, disobedienceChance: 0.4, feedGain: 1.0, playGain: 1.5)
            case .genji: return CharacterPersonality(hungerRate: 0.8, happinessRate: 0.9, energyRate: 1.3, hygieneRate: 0.6, disobedienceChance: 0.5, feedGain: 1.0, playGain: 0.9)
            case .mercy: return CharacterPersonality(hungerRate: 0.7, happinessRate: 1.3, energyRate: 0.8, hygieneRate: 0.4, disobedienceChance: 0.1, feedGain: 1.0, playGain: 1.4)
            case .reinhardt: return CharacterPersonality(hungerRate: 1.4, happinessRate: 1.0, energyRate: 1.5, hygieneRate: 1.3, disobedienceChance: 0.3, feedGain: 1.4, playGain: 1.0)
            case .dva: return CharacterPersonality(hungerRate: 1.3, happinessRate: 1.4, energyRate: 1.2, hygieneRate: 1.1, disobedienceChance: 0.8, feedGain: 1.3, playGain: 1.4)
            case .widowmaker: return CharacterPersonality(hungerRate: 0.6, happinessRate: 0.3, energyRate: 0.9, hygieneRate: 0.5, disobedienceChance: 1.5, feedGain: 0.8, playGain: 0.4)
            case .winston: return CharacterPersonality(hungerRate: 1.5, happinessRate: 1.0, energyRate: 1.4, hygieneRate: 1.2, disobedienceChance: 0.5, feedGain: 1.5, playGain: 1.0)
            case .soldier76: return CharacterPersonality(hungerRate: 1.0, happinessRate: 0.6, energyRate: 1.2, hygieneRate: 0.8, disobedienceChance: 0.3, feedGain: 1.0, playGain: 0.6)
            case .reaper: return CharacterPersonality(hungerRate: 0.8, happinessRate: 0.2, energyRate: 1.4, hygieneRate: 0.9, disobedienceChance: 2.0, feedGain: 0.8, playGain: 0.2)
            case .mccree: return CharacterPersonality(hungerRate: 1.1, happinessRate: 0.8, energyRate: 1.1, hygieneRate: 0.9, disobedienceChance: 0.7, feedGain: 1.1, playGain: 0.8)
            case .pharah: return CharacterPersonality(hungerRate: 0.9, happinessRate: 1.0, energyRate: 1.3, hygieneRate: 0.7, disobedienceChance: 0.4, feedGain: 1.0, playGain: 1.0)
            case .lucio: return CharacterPersonality(hungerRate: 0.8, happinessRate: 1.6, energyRate: 1.4, hygieneRate: 0.6, disobedienceChance: 0.3, feedGain: 0.9, playGain: 1.6)
            case .ana: return CharacterPersonality(hungerRate: 0.7, happinessRate: 0.9, energyRate: 1.0, hygieneRate: 0.5, disobedienceChance: 0.2, feedGain: 0.8, playGain: 0.9)
            case .zarya: return CharacterPersonality(hungerRate: 1.3, happinessRate: 0.7, energyRate: 1.4, hygieneRate: 1.0, disobedienceChance: 0.6, feedGain: 1.3, playGain: 0.7)
            case .mei: return CharacterPersonality(hungerRate: 0.9, happinessRate: 1.2, energyRate: 0.9, hygieneRate: 0.5, disobedienceChance: 0.3, feedGain: 1.0, playGain: 1.2)
            case .symmetra: return CharacterPersonality(hungerRate: 0.7, happinessRate: 0.8, energyRate: 0.9, hygieneRate: 0.4, disobedienceChance: 0.5, feedGain: 0.8, playGain: 0.8)
            }

        case .dragonBall(let db):
            switch db {
            case .goku: return CharacterPersonality(hungerRate: 2.0, happinessRate: 1.2, energyRate: 1.8, hygieneRate: 1.5, disobedienceChance: 0.8, feedGain: 2.0, playGain: 1.2)
            case .vegeta: return CharacterPersonality(hungerRate: 1.5, happinessRate: 0.5, energyRate: 1.6, hygieneRate: 1.2, disobedienceChance: 2.5, feedGain: 1.5, playGain: 0.4)
            case .gohan: return CharacterPersonality(hungerRate: 1.0, happinessRate: 1.1, energyRate: 1.0, hygieneRate: 0.7, disobedienceChance: 0.3, feedGain: 1.0, playGain: 1.1)
            case .piccolo: return CharacterPersonality(hungerRate: 0.3, happinessRate: 0.6, energyRate: 1.2, hygieneRate: 0.8, disobedienceChance: 1.0, feedGain: 0.5, playGain: 0.6)
            case .krillin: return CharacterPersonality(hungerRate: 1.1, happinessRate: 1.2, energyRate: 1.0, hygieneRate: 0.9, disobedienceChance: 0.5, feedGain: 1.1, playGain: 1.2)
            case .frieza: return CharacterPersonality(hungerRate: 0.8, happinessRate: 0.3, energyRate: 1.3, hygieneRate: 0.6, disobedienceChance: 2.8, feedGain: 0.8, playGain: 0.3)
            case .beerus: return CharacterPersonality(hungerRate: 2.5, happinessRate: 0.8, energyRate: 1.0, hygieneRate: 0.9, disobedienceChance: 2.0, feedGain: 2.5, playGain: 0.7)
            case .cell: return CharacterPersonality(hungerRate: 0.9, happinessRate: 0.3, energyRate: 1.4, hygieneRate: 0.7, disobedienceChance: 2.5, feedGain: 0.9, playGain: 0.3)
            case .majinBuu: return CharacterPersonality(hungerRate: 2.2, happinessRate: 0.9, energyRate: 1.3, hygieneRate: 1.5, disobedienceChance: 2.0, feedGain: 2.2, playGain: 0.9)
            case .trunks: return CharacterPersonality(hungerRate: 1.0, happinessRate: 0.9, energyRate: 1.2, hygieneRate: 0.6, disobedienceChance: 0.5, feedGain: 1.0, playGain: 0.9)
            case .goten: return CharacterPersonality(hungerRate: 1.2, happinessRate: 1.4, energyRate: 1.1, hygieneRate: 0.8, disobedienceChance: 0.6, feedGain: 1.2, playGain: 1.4)
            case .whis: return CharacterPersonality(hungerRate: 0.5, happinessRate: 1.0, energyRate: 0.8, hygieneRate: 0.2, disobedienceChance: 0.1, feedGain: 0.6, playGain: 1.0)
            }

        case .naruto(let n):
            switch n {
            case .naruto: return CharacterPersonality(hungerRate: 1.8, happinessRate: 1.5, energyRate: 1.7, hygieneRate: 1.4, disobedienceChance: 1.5, feedGain: 1.8, playGain: 1.5)
            case .sasuke: return CharacterPersonality(hungerRate: 0.8, happinessRate: 0.4, energyRate: 1.3, hygieneRate: 0.7, disobedienceChance: 2.0, feedGain: 0.8, playGain: 0.4)
            case .sakura: return CharacterPersonality(hungerRate: 0.9, happinessRate: 1.1, energyRate: 1.1, hygieneRate: 0.5, disobedienceChance: 0.7, feedGain: 1.0, playGain: 1.1)
            case .kakashi: return CharacterPersonality(hungerRate: 1.0, happinessRate: 0.8, energyRate: 1.0, hygieneRate: 0.6, disobedienceChance: 1.2, feedGain: 1.0, playGain: 0.8)
            case .hinata: return CharacterPersonality(hungerRate: 0.7, happinessRate: 1.3, energyRate: 0.8, hygieneRate: 0.4, disobedienceChance: 0.2, feedGain: 1.0, playGain: 1.4)
            case .shikamaru: return CharacterPersonality(hungerRate: 1.0, happinessRate: 0.7, energyRate: 0.5, hygieneRate: 0.9, disobedienceChance: 0.6, feedGain: 1.0, playGain: 0.7)
            case .gaara: return CharacterPersonality(hungerRate: 0.6, happinessRate: 0.4, energyRate: 1.0, hygieneRate: 1.2, disobedienceChance: 1.8, feedGain: 0.8, playGain: 0.4)
            case .itachi: return CharacterPersonality(hungerRate: 0.7, happinessRate: 0.3, energyRate: 1.3, hygieneRate: 0.6, disobedienceChance: 1.5, feedGain: 0.8, playGain: 0.3)
            case .orochimaru: return CharacterPersonality(hungerRate: 0.8, happinessRate: 0.2, energyRate: 1.4, hygieneRate: 1.0, disobedienceChance: 2.5, feedGain: 0.8, playGain: 0.2)
            case .jiraiya: return CharacterPersonality(hungerRate: 1.5, happinessRate: 1.2, energyRate: 1.1, hygieneRate: 1.3, disobedienceChance: 1.0, feedGain: 1.5, playGain: 1.2)
            case .tsunade: return CharacterPersonality(hungerRate: 1.3, happinessRate: 0.8, energyRate: 1.2, hygieneRate: 0.7, disobedienceChance: 1.8, feedGain: 1.3, playGain: 0.8)
            case .rockLee: return CharacterPersonality(hungerRate: 1.4, happinessRate: 1.3, energyRate: 1.6, hygieneRate: 0.8, disobedienceChance: 0.3, feedGain: 1.4, playGain: 1.3)
            }

        case .gundam(let g):
            switch g {
            case .rx78: return CharacterPersonality(hungerRate: 0.5, happinessRate: 0.6, energyRate: 1.2, hygieneRate: 0.3, disobedienceChance: 0.4, feedGain: 0.8, playGain: 0.6)
            case .zaku: return CharacterPersonality(hungerRate: 0.6, happinessRate: 0.5, energyRate: 1.1, hygieneRate: 0.4, disobedienceChance: 0.8, feedGain: 0.8, playGain: 0.5)
            case .freedom: return CharacterPersonality(hungerRate: 0.4, happinessRate: 0.8, energyRate: 1.4, hygieneRate: 0.2, disobedienceChance: 0.3, feedGain: 0.7, playGain: 0.8)
            case .WingZero: return CharacterPersonality(hungerRate: 0.5, happinessRate: 0.7, energyRate: 1.3, hygieneRate: 0.3, disobedienceChance: 0.5, feedGain: 0.8, playGain: 0.7)
            case .justice: return CharacterPersonality(hungerRate: 0.5, happinessRate: 0.6, energyRate: 1.3, hygieneRate: 0.3, disobedienceChance: 0.5, feedGain: 0.8, playGain: 0.6)
            case .strike: return CharacterPersonality(hungerRate: 0.5, happinessRate: 0.7, energyRate: 1.2, hygieneRate: 0.3, disobedienceChance: 0.4, feedGain: 0.8, playGain: 0.7)
            case .barbatos: return CharacterPersonality(hungerRate: 0.6, happinessRate: 0.5, energyRate: 1.5, hygieneRate: 0.5, disobedienceChance: 1.0, feedGain: 0.8, playGain: 0.5)
            case .unicorn: return CharacterPersonality(hungerRate: 0.4, happinessRate: 0.9, energyRate: 1.5, hygieneRate: 0.2, disobedienceChance: 0.3, feedGain: 0.7, playGain: 0.9)
            case .sinanju: return CharacterPersonality(hungerRate: 0.4, happinessRate: 0.6, energyRate: 1.4, hygieneRate: 0.2, disobedienceChance: 0.6, feedGain: 0.7, playGain: 0.6)
            case .exia: return CharacterPersonality(hungerRate: 0.5, happinessRate: 0.7, energyRate: 1.3, hygieneRate: 0.3, disobedienceChance: 0.4, feedGain: 0.8, playGain: 0.7)
            case .deathscythe: return CharacterPersonality(hungerRate: 0.4, happinessRate: 0.5, energyRate: 1.3, hygieneRate: 0.3, disobedienceChance: 0.7, feedGain: 0.7, playGain: 0.5)
            case .heavyArms: return CharacterPersonality(hungerRate: 0.5, happinessRate: 0.6, energyRate: 1.3, hygieneRate: 0.4, disobedienceChance: 0.5, feedGain: 0.8, playGain: 0.6)
            }

        case .marvel(let mv):
            switch mv {
            case .spiderMan: return CharacterPersonality(hungerRate: 1.2, happinessRate: 1.5, energyRate: 1.5, hygieneRate: 1.2, disobedienceChance: 0.5, feedGain: 1.2, playGain: 1.5)
            case .wolverine: return CharacterPersonality(hungerRate: 1.3, happinessRate: 0.6, energyRate: 1.5, hygieneRate: 1.4, disobedienceChance: 2.5, feedGain: 1.3, playGain: 0.5)
            case .thor: return CharacterPersonality(hungerRate: 1.6, happinessRate: 1.0, energyRate: 1.4, hygieneRate: 1.0, disobedienceChance: 1.2, feedGain: 1.6, playGain: 1.0)
            case .hulk: return CharacterPersonality(hungerRate: 2.0, happinessRate: 0.4, energyRate: 1.8, hygieneRate: 1.8, disobedienceChance: 3.0, feedGain: 2.0, playGain: 0.3)
            case .ironMan: return CharacterPersonality(hungerRate: 0.8, happinessRate: 1.0, energyRate: 1.0, hygieneRate: 0.5, disobedienceChance: 0.8, feedGain: 0.8, playGain: 1.0)
            case .captainAmerica: return CharacterPersonality(hungerRate: 1.0, happinessRate: 0.9, energyRate: 1.2, hygieneRate: 0.4, disobedienceChance: 0.2, feedGain: 1.0, playGain: 0.9)
            case .blackWidow: return CharacterPersonality(hungerRate: 0.8, happinessRate: 0.7, energyRate: 1.3, hygieneRate: 0.5, disobedienceChance: 0.6, feedGain: 0.9, playGain: 0.7)
            case .venom: return CharacterPersonality(hungerRate: 1.8, happinessRate: 0.5, energyRate: 1.6, hygieneRate: 1.7, disobedienceChance: 2.8, feedGain: 1.8, playGain: 0.4)
            case .blackPanther: return CharacterPersonality(hungerRate: 0.9, happinessRate: 0.8, energyRate: 1.3, hygieneRate: 0.4, disobedienceChance: 0.4, feedGain: 1.0, playGain: 0.8)
            case .daredevil: return CharacterPersonality(hungerRate: 1.0, happinessRate: 0.6, energyRate: 1.4, hygieneRate: 0.7, disobedienceChance: 0.8, feedGain: 1.0, playGain: 0.6)
            case .hawkeye: return CharacterPersonality(hungerRate: 0.9, happinessRate: 0.9, energyRate: 1.1, hygieneRate: 0.6, disobedienceChance: 0.4, feedGain: 1.0, playGain: 0.9)
            case .vision: return CharacterPersonality(hungerRate: 0.4, happinessRate: 0.7, energyRate: 1.0, hygieneRate: 0.2, disobedienceChance: 0.2, feedGain: 0.6, playGain: 0.7)
            case .scarletWitch: return CharacterPersonality(hungerRate: 0.8, happinessRate: 0.8, energyRate: 1.4, hygieneRate: 0.6, disobedienceChance: 1.0, feedGain: 0.9, playGain: 0.8)
            case .warMachine: return CharacterPersonality(hungerRate: 0.9, happinessRate: 0.8, energyRate: 1.2, hygieneRate: 0.5, disobedienceChance: 0.5, feedGain: 1.0, playGain: 0.8)
            case .spiderWoman: return CharacterPersonality(hungerRate: 1.0, happinessRate: 1.2, energyRate: 1.3, hygieneRate: 0.8, disobedienceChance: 0.6, feedGain: 1.0, playGain: 1.2)
            case .cyclops: return CharacterPersonality(hungerRate: 0.9, happinessRate: 0.7, energyRate: 1.1, hygieneRate: 0.5, disobedienceChance: 0.5, feedGain: 1.0, playGain: 0.7)
            case .sheHulk: return CharacterPersonality(hungerRate: 1.4, happinessRate: 0.8, energyRate: 1.5, hygieneRate: 1.0, disobedienceChance: 1.2, feedGain: 1.4, playGain: 0.8)
            case .juggernaut: return CharacterPersonality(hungerRate: 1.8, happinessRate: 0.3, energyRate: 1.7, hygieneRate: 1.8, disobedienceChance: 2.5, feedGain: 1.8, playGain: 0.3)
            case .loki: return CharacterPersonality(hungerRate: 0.9, happinessRate: 0.5, energyRate: 1.2, hygieneRate: 0.6, disobedienceChance: 2.8, feedGain: 0.9, playGain: 0.5)
            }

        case .dc(let dc):
            switch dc {
            case .batman: return CharacterPersonality(hungerRate: 0.7, happinessRate: 0.4, energyRate: 1.5, hygieneRate: 0.5, disobedienceChance: 1.2, feedGain: 0.8, playGain: 0.4)
            case .superman: return CharacterPersonality(hungerRate: 1.0, happinessRate: 1.1, energyRate: 1.2, hygieneRate: 0.3, disobedienceChance: 0.2, feedGain: 1.0, playGain: 1.1)
            case .wonderWoman: return CharacterPersonality(hungerRate: 0.9, happinessRate: 1.0, energyRate: 1.3, hygieneRate: 0.4, disobedienceChance: 0.5, feedGain: 1.0, playGain: 1.0)
            case .joker: return CharacterPersonality(hungerRate: 1.0, happinessRate: 0.3, energyRate: 1.8, hygieneRate: 2.0, disobedienceChance: 3.5, feedGain: 0.8, playGain: 0.3)
            case .harleyQuinn: return CharacterPersonality(hungerRate: 1.2, happinessRate: 1.6, energyRate: 1.7, hygieneRate: 1.5, disobedienceChance: 2.5, feedGain: 1.2, playGain: 1.6)
            case .flash: return CharacterPersonality(hungerRate: 2.0, happinessRate: 1.4, energyRate: 2.0, hygieneRate: 1.2, disobedienceChance: 0.7, feedGain: 2.0, playGain: 1.4)
            case .greenLantern: return CharacterPersonality(hungerRate: 0.9, happinessRate: 1.0, energyRate: 1.3, hygieneRate: 0.6, disobedienceChance: 0.5, feedGain: 1.0, playGain: 1.0)
            case .aquaman: return CharacterPersonality(hungerRate: 1.3, happinessRate: 0.9, energyRate: 1.2, hygieneRate: 0.7, disobedienceChance: 0.8, feedGain: 1.3, playGain: 0.9)
            case .lexLuthor: return CharacterPersonality(hungerRate: 0.6, happinessRate: 0.2, energyRate: 1.1, hygieneRate: 0.3, disobedienceChance: 2.0, feedGain: 0.7, playGain: 0.2)
            case .darkseid: return CharacterPersonality(hungerRate: 1.2, happinessRate: 0.1, energyRate: 1.8, hygieneRate: 1.0, disobedienceChance: 3.5, feedGain: 1.2, playGain: 0.1)
            }

        case .starWars(let sw):
            switch sw {
            case .grogu: return CharacterPersonality(hungerRate: 1.8, happinessRate: 1.5, energyRate: 0.8, hygieneRate: 0.6, disobedienceChance: 0.8, feedGain: 1.8, playGain: 1.5)
            case .yoda: return CharacterPersonality(hungerRate: 0.6, happinessRate: 0.9, energyRate: 0.7, hygieneRate: 0.5, disobedienceChance: 0.3, feedGain: 0.8, playGain: 0.9)
            case .vader: return CharacterPersonality(hungerRate: 0.5, happinessRate: 0.2, energyRate: 1.3, hygieneRate: 0.8, disobedienceChance: 2.5, feedGain: 0.6, playGain: 0.2)
            case .mandalorian: return CharacterPersonality(hungerRate: 1.0, happinessRate: 0.7, energyRate: 1.3, hygieneRate: 0.8, disobedienceChance: 0.6, feedGain: 1.0, playGain: 0.7)
            case .r2d2: return CharacterPersonality(hungerRate: 0.3, happinessRate: 1.4, energyRate: 1.2, hygieneRate: 0.4, disobedienceChance: 0.8, feedGain: 0.5, playGain: 1.4)
            case .c3po: return CharacterPersonality(hungerRate: 0.2, happinessRate: 0.6, energyRate: 0.5, hygieneRate: 0.3, disobedienceChance: 0.3, feedGain: 0.3, playGain: 0.6)
            case .luke: return CharacterPersonality(hungerRate: 1.0, happinessRate: 1.1, energyRate: 1.2, hygieneRate: 0.7, disobedienceChance: 0.4, feedGain: 1.0, playGain: 1.1)
            case .leia: return CharacterPersonality(hungerRate: 0.8, happinessRate: 1.0, energyRate: 1.0, hygieneRate: 0.5, disobedienceChance: 0.3, feedGain: 0.9, playGain: 1.0)
            case .han: return CharacterPersonality(hungerRate: 1.2, happinessRate: 0.9, energyRate: 1.1, hygieneRate: 1.0, disobedienceChance: 1.5, feedGain: 1.2, playGain: 0.9)
            case .chewbacca: return CharacterPersonality(hungerRate: 1.5, happinessRate: 0.8, energyRate: 1.3, hygieneRate: 1.5, disobedienceChance: 0.8, feedGain: 1.5, playGain: 0.8)
            case .maul: return CharacterPersonality(hungerRate: 0.8, happinessRate: 0.2, energyRate: 1.5, hygieneRate: 0.9, disobedienceChance: 2.8, feedGain: 0.8, playGain: 0.2)
            case .bobaFett: return CharacterPersonality(hungerRate: 0.9, happinessRate: 0.4, energyRate: 1.2, hygieneRate: 0.7, disobedienceChance: 1.5, feedGain: 0.9, playGain: 0.4)
            case .obiWan: return CharacterPersonality(hungerRate: 0.7, happinessRate: 1.0, energyRate: 1.0, hygieneRate: 0.5, disobedienceChance: 0.2, feedGain: 0.8, playGain: 1.0)
            case .kyloRen: return CharacterPersonality(hungerRate: 1.0, happinessRate: 0.2, energyRate: 1.4, hygieneRate: 0.8, disobedienceChance: 2.5, feedGain: 1.0, playGain: 0.2)
            case .stormtrooper: return CharacterPersonality(hungerRate: 1.0, happinessRate: 0.5, energyRate: 1.0, hygieneRate: 0.6, disobedienceChance: 0.5, feedGain: 1.0, playGain: 0.5)
            }

        case .simpsons(let s):
            switch s {
            case .homer: return CharacterPersonality(hungerRate: 2.5, happinessRate: 0.8, energyRate: 0.5, hygieneRate: 1.8, disobedienceChance: 1.5, feedGain: 2.5, playGain: 0.8)
            case .bart: return CharacterPersonality(hungerRate: 1.3, happinessRate: 1.5, energyRate: 1.8, hygieneRate: 1.5, disobedienceChance: 3.0, feedGain: 1.3, playGain: 1.5)
            case .marge: return CharacterPersonality(hungerRate: 0.8, happinessRate: 0.9, energyRate: 0.8, hygieneRate: 0.3, disobedienceChance: 0.2, feedGain: 1.0, playGain: 0.9)
            case .lisa: return CharacterPersonality(hungerRate: 0.7, happinessRate: 1.1, energyRate: 0.9, hygieneRate: 0.4, disobedienceChance: 0.3, feedGain: 0.8, playGain: 1.1)
            case .maggie: return CharacterPersonality(hungerRate: 1.5, happinessRate: 1.3, energyRate: 0.7, hygieneRate: 0.6, disobedienceChance: 0.4, feedGain: 1.5, playGain: 1.3)
            case .nedFlanders: return CharacterPersonality(hungerRate: 0.6, happinessRate: 1.2, energyRate: 0.7, hygieneRate: 0.3, disobedienceChance: 0.1, feedGain: 0.8, playGain: 1.2)
            case .mrBurns: return CharacterPersonality(hungerRate: 0.5, happinessRate: 0.1, energyRate: 0.6, hygieneRate: 0.4, disobedienceChance: 2.0, feedGain: 0.6, playGain: 0.1)
            case .smithers: return CharacterPersonality(hungerRate: 0.7, happinessRate: 0.6, energyRate: 0.8, hygieneRate: 0.4, disobedienceChance: 0.3, feedGain: 0.8, playGain: 0.6)
            case .milhouse: return CharacterPersonality(hungerRate: 0.9, happinessRate: 1.2, energyRate: 0.7, hygieneRate: 0.5, disobedienceChance: 0.5, feedGain: 1.0, playGain: 1.2)
            case .nelson: return CharacterPersonality(hungerRate: 1.2, happinessRate: 0.6, energyRate: 1.4, hygieneRate: 1.2, disobedienceChance: 2.5, feedGain: 1.2, playGain: 0.6)
            case .principalSkinner: return CharacterPersonality(hungerRate: 0.7, happinessRate: 0.5, energyRate: 0.8, hygieneRate: 0.4, disobedienceChance: 0.3, feedGain: 0.8, playGain: 0.5)
            case .krusty: return CharacterPersonality(hungerRate: 1.8, happinessRate: 1.0, energyRate: 1.2, hygieneRate: 1.5, disobedienceChance: 1.5, feedGain: 1.8, playGain: 1.0)
            }

        case .mortalKombat(let mk):
            switch mk {
            case .scorpion: return CharacterPersonality(hungerRate: 1.3, happinessRate: 0.4, energyRate: 1.5, hygieneRate: 1.5, disobedienceChance: 2.2, feedGain: 1.3, playGain: 0.4)
            case .subZero: return CharacterPersonality(hungerRate: 0.7, happinessRate: 0.5, energyRate: 1.2, hygieneRate: 0.8, disobedienceChance: 1.0, feedGain: 0.8, playGain: 0.5)
            case .liuKang: return CharacterPersonality(hungerRate: 1.1, happinessRate: 1.0, energyRate: 1.4, hygieneRate: 0.7, disobedienceChance: 0.5, feedGain: 1.1, playGain: 1.0)
            case .raiden: return CharacterPersonality(hungerRate: 0.5, happinessRate: 0.8, energyRate: 1.3, hygieneRate: 0.4, disobedienceChance: 0.4, feedGain: 0.7, playGain: 0.8)
            case .kitana: return CharacterPersonality(hungerRate: 0.8, happinessRate: 1.0, energyRate: 1.2, hygieneRate: 0.5, disobedienceChance: 0.6, feedGain: 0.9, playGain: 1.0)
            case .shangTsung: return CharacterPersonality(hungerRate: 0.9, happinessRate: 0.5, energyRate: 1.4, hygieneRate: 1.2, disobedienceChance: 2.5, feedGain: 0.9, playGain: 0.5)
            case .sonya: return CharacterPersonality(hungerRate: 1.0, happinessRate: 0.9, energyRate: 1.2, hygieneRate: 0.6, disobedienceChance: 0.6, feedGain: 1.0, playGain: 0.9)
            case .johnnyCage: return CharacterPersonality(hungerRate: 1.2, happinessRate: 1.0, energyRate: 1.3, hygieneRate: 0.8, disobedienceChance: 1.5, feedGain: 1.2, playGain: 1.0)
            case .goro: return CharacterPersonality(hungerRate: 1.6, happinessRate: 0.3, energyRate: 1.6, hygieneRate: 1.5, disobedienceChance: 2.5, feedGain: 1.6, playGain: 0.3)
            case .jade: return CharacterPersonality(hungerRate: 0.9, happinessRate: 0.9, energyRate: 1.3, hygieneRate: 0.6, disobedienceChance: 0.7, feedGain: 1.0, playGain: 0.9)
            case .milena: return CharacterPersonality(hungerRate: 1.1, happinessRate: 0.4, energyRate: 1.4, hygieneRate: 1.0, disobedienceChance: 2.5, feedGain: 1.1, playGain: 0.4)
            case .reptile: return CharacterPersonality(hungerRate: 1.0, happinessRate: 0.5, energyRate: 1.2, hygieneRate: 1.2, disobedienceChance: 1.8, feedGain: 1.0, playGain: 0.5)
            }

        case .tmnt(let t):
            switch t {
            case .leonardo: return CharacterPersonality(hungerRate: 1.1, happinessRate: 1.0, energyRate: 1.3, hygieneRate: 0.8, disobedienceChance: 0.4, feedGain: 1.1, playGain: 1.0)
            case .raphael: return CharacterPersonality(hungerRate: 1.3, happinessRate: 0.7, energyRate: 1.5, hygieneRate: 1.3, disobedienceChance: 2.2, feedGain: 1.3, playGain: 0.6)
            case .donatello: return CharacterPersonality(hungerRate: 0.9, happinessRate: 1.1, energyRate: 1.0, hygieneRate: 0.6, disobedienceChance: 0.3, feedGain: 1.0, playGain: 1.1)
            case .michelangelo: return CharacterPersonality(hungerRate: 1.8, happinessRate: 1.8, energyRate: 1.6, hygieneRate: 1.5, disobedienceChance: 1.0, feedGain: 1.8, playGain: 1.8)
            case .splinter: return CharacterPersonality(hungerRate: 0.6, happinessRate: 0.8, energyRate: 0.6, hygieneRate: 0.4, disobedienceChance: 0.1, feedGain: 0.8, playGain: 0.8)
            case .shredder: return CharacterPersonality(hungerRate: 1.0, happinessRate: 0.2, energyRate: 1.4, hygieneRate: 0.8, disobedienceChance: 2.5, feedGain: 1.0, playGain: 0.2)
            case .krang: return CharacterPersonality(hungerRate: 0.8, happinessRate: 0.3, energyRate: 1.1, hygieneRate: 0.6, disobedienceChance: 2.0, feedGain: 0.8, playGain: 0.3)
            case .bebop: return CharacterPersonality(hungerRate: 1.4, happinessRate: 0.6, energyRate: 1.3, hygieneRate: 1.2, disobedienceChance: 1.8, feedGain: 1.4, playGain: 0.6)
            case .rocksteady: return CharacterPersonality(hungerRate: 1.5, happinessRate: 0.5, energyRate: 1.4, hygieneRate: 1.3, disobedienceChance: 1.8, feedGain: 1.5, playGain: 0.5)
            case .april: return CharacterPersonality(hungerRate: 0.8, happinessRate: 1.2, energyRate: 0.9, hygieneRate: 0.5, disobedienceChance: 0.3, feedGain: 0.9, playGain: 1.2)
            case .CaseyJones: return CharacterPersonality(hungerRate: 1.2, happinessRate: 0.9, energyRate: 1.4, hygieneRate: 1.0, disobedienceChance: 1.5, feedGain: 1.2, playGain: 0.9)
            }

        case .minions(let m):
            switch m {
            case .kevin: return CharacterPersonality(hungerRate: 1.5, happinessRate: 1.6, energyRate: 1.7, hygieneRate: 1.3, disobedienceChance: 1.5, feedGain: 1.5, playGain: 1.6)
            case .stuart: return CharacterPersonality(hungerRate: 1.3, happinessRate: 1.4, energyRate: 1.2, hygieneRate: 1.2, disobedienceChance: 1.2, feedGain: 1.3, playGain: 1.4)
            case .bob: return CharacterPersonality(hungerRate: 1.8, happinessRate: 1.8, energyRate: 1.0, hygieneRate: 1.0, disobedienceChance: 0.5, feedGain: 1.8, playGain: 1.8)
            case .dave: return CharacterPersonality(hungerRate: 1.4, happinessRate: 1.5, energyRate: 1.3, hygieneRate: 1.1, disobedienceChance: 1.0, feedGain: 1.4, playGain: 1.5)
            case .jerry: return CharacterPersonality(hungerRate: 1.3, happinessRate: 1.3, energyRate: 1.2, hygieneRate: 1.0, disobedienceChance: 0.9, feedGain: 1.3, playGain: 1.3)
            case .phil: return CharacterPersonality(hungerRate: 1.2, happinessRate: 1.4, energyRate: 1.1, hygieneRate: 0.9, disobedienceChance: 0.8, feedGain: 1.2, playGain: 1.4)
            case .tim: return CharacterPersonality(hungerRate: 1.1, happinessRate: 1.3, energyRate: 1.0, hygieneRate: 0.8, disobedienceChance: 0.7, feedGain: 1.1, playGain: 1.3)
            case .mark: return CharacterPersonality(hungerRate: 1.2, happinessRate: 1.4, energyRate: 1.2, hygieneRate: 1.0, disobedienceChance: 0.9, feedGain: 1.2, playGain: 1.4)
            case .carl: return CharacterPersonality(hungerRate: 1.4, happinessRate: 1.5, energyRate: 1.3, hygieneRate: 1.2, disobedienceChance: 1.1, feedGain: 1.4, playGain: 1.5)
            case .jorge: return CharacterPersonality(hungerRate: 1.3, happinessRate: 1.4, energyRate: 1.2, hygieneRate: 1.1, disobedienceChance: 1.0, feedGain: 1.3, playGain: 1.4)
            case .donny: return CharacterPersonality(hungerRate: 1.5, happinessRate: 1.6, energyRate: 1.4, hygieneRate: 1.3, disobedienceChance: 1.3, feedGain: 1.5, playGain: 1.6)
            case .eric: return CharacterPersonality(hungerRate: 1.2, happinessRate: 1.3, energyRate: 1.1, hygieneRate: 1.0, disobedienceChance: 0.8, feedGain: 1.2, playGain: 1.3)
            }

        case .ghibli(let g):
            switch g {
            case .totoro: return CharacterPersonality(hungerRate: 1.5, happinessRate: 1.2, energyRate: 0.5, hygieneRate: 0.6, disobedienceChance: 0.2, feedGain: 1.5, playGain: 1.2)
            case .ponyo: return CharacterPersonality(hungerRate: 1.8, happinessRate: 1.6, energyRate: 1.5, hygieneRate: 0.8, disobedienceChance: 0.8, feedGain: 1.8, playGain: 1.6)
            case .calcifer: return CharacterPersonality(hungerRate: 2.0, happinessRate: 0.8, energyRate: 1.8, hygieneRate: 1.5, disobedienceChance: 1.5, feedGain: 2.0, playGain: 0.8)
            case .noFace: return CharacterPersonality(hungerRate: 2.5, happinessRate: 0.3, energyRate: 1.0, hygieneRate: 1.5, disobedienceChance: 2.0, feedGain: 2.5, playGain: 0.3)
            case .kiki: return CharacterPersonality(hungerRate: 0.9, happinessRate: 1.3, energyRate: 1.1, hygieneRate: 0.5, disobedienceChance: 0.3, feedGain: 1.0, playGain: 1.3)
            case .satsuki: return CharacterPersonality(hungerRate: 0.8, happinessRate: 1.2, energyRate: 0.9, hygieneRate: 0.4, disobedienceChance: 0.2, feedGain: 0.9, playGain: 1.2)
            case .mei: return CharacterPersonality(hungerRate: 1.0, happinessRate: 1.5, energyRate: 1.2, hygieneRate: 0.7, disobedienceChance: 0.5, feedGain: 1.0, playGain: 1.5)
            case .howl: return CharacterPersonality(hungerRate: 0.8, happinessRate: 1.0, energyRate: 1.1, hygieneRate: 0.5, disobedienceChance: 0.8, feedGain: 0.9, playGain: 1.0)
            case .sophie: return CharacterPersonality(hungerRate: 0.7, happinessRate: 1.1, energyRate: 0.8, hygieneRate: 0.3, disobedienceChance: 0.2, feedGain: 0.8, playGain: 1.1)
            case .append: return CharacterPersonality(hungerRate: 0.3, happinessRate: 0.8, energyRate: 0.6, hygieneRate: 0.2, disobedienceChance: 0.1, feedGain: 0.4, playGain: 0.8)
            case .jiro: return CharacterPersonality(hungerRate: 0.8, happinessRate: 0.9, energyRate: 1.0, hygieneRate: 0.5, disobedienceChance: 0.4, feedGain: 0.9, playGain: 0.9)
            case .chihiro: return CharacterPersonality(hungerRate: 0.9, happinessRate: 1.2, energyRate: 1.0, hygieneRate: 0.5, disobedienceChance: 0.3, feedGain: 1.0, playGain: 1.2)
            }

        case .kingOfTheHill(let k):
            switch k {
            case .hank: return CharacterPersonality(hungerRate: 1.3, happinessRate: 0.7, energyRate: 0.8, hygieneRate: 0.7, disobedienceChance: 0.5, feedGain: 1.3, playGain: 0.7)
            case .boomhauer: return CharacterPersonality(hungerRate: 1.0, happinessRate: 0.9, energyRate: 0.8, hygieneRate: 1.0, disobedienceChance: 0.4, feedGain: 1.0, playGain: 0.9)
            case .dale: return CharacterPersonality(hungerRate: 1.1, happinessRate: 0.6, energyRate: 1.4, hygieneRate: 1.8, disobedienceChance: 2.0, feedGain: 1.1, playGain: 0.6)
            case .bill: return CharacterPersonality(hungerRate: 1.4, happinessRate: 0.4, energyRate: 0.5, hygieneRate: 1.5, disobedienceChance: 0.3, feedGain: 1.4, playGain: 0.5)
            case .peggy: return CharacterPersonality(hungerRate: 1.0, happinessRate: 0.8, energyRate: 0.9, hygieneRate: 0.5, disobedienceChance: 0.6, feedGain: 1.0, playGain: 0.8)
            case .bobby: return CharacterPersonality(hungerRate: 1.5, happinessRate: 1.4, energyRate: 1.1, hygieneRate: 1.2, disobedienceChance: 0.8, feedGain: 1.5, playGain: 1.4)
            case .luanne: return CharacterPersonality(hungerRate: 0.9, happinessRate: 1.2, energyRate: 1.0, hygieneRate: 0.6, disobedienceChance: 0.4, feedGain: 1.0, playGain: 1.2)
            case .cotton: return CharacterPersonality(hungerRate: 1.2, happinessRate: 0.3, energyRate: 0.9, hygieneRate: 1.0, disobedienceChance: 1.5, feedGain: 1.2, playGain: 0.3)
            case .kahn: return CharacterPersonality(hungerRate: 1.1, happinessRate: 0.5, energyRate: 1.2, hygieneRate: 0.8, disobedienceChance: 1.0, feedGain: 1.1, playGain: 0.5)
            case .ladybird: return CharacterPersonality(hungerRate: 1.0, happinessRate: 1.1, energyRate: 0.7, hygieneRate: 0.6, disobedienceChance: 0.2, feedGain: 1.0, playGain: 1.1)
            case .johnRedcorn: return CharacterPersonality(hungerRate: 0.9, happinessRate: 0.9, energyRate: 1.0, hygieneRate: 0.7, disobedienceChance: 0.7, feedGain: 0.9, playGain: 0.9)
            case .buckStrickland: return CharacterPersonality(hungerRate: 1.3, happinessRate: 0.6, energyRate: 1.0, hygieneRate: 1.0, disobedienceChance: 1.2, feedGain: 1.3, playGain: 0.6)
            }

        case .familyGuy(let f):
            switch f {
            case .peter: return CharacterPersonality(hungerRate: 2.0, happinessRate: 0.7, energyRate: 0.8, hygieneRate: 1.8, disobedienceChance: 2.5, feedGain: 2.0, playGain: 0.7)
            case .stewie: return CharacterPersonality(hungerRate: 0.8, happinessRate: 0.5, energyRate: 1.5, hygieneRate: 0.6, disobedienceChance: 2.0, feedGain: 0.8, playGain: 0.5)
            case .brian: return CharacterPersonality(hungerRate: 1.2, happinessRate: 1.0, energyRate: 0.8, hygieneRate: 0.7, disobedienceChance: 1.0, feedGain: 1.2, playGain: 1.0)
            case .chris: return CharacterPersonality(hungerRate: 1.6, happinessRate: 1.2, energyRate: 1.0, hygieneRate: 1.3, disobedienceChance: 0.8, feedGain: 1.6, playGain: 1.2)
            case .meg: return CharacterPersonality(hungerRate: 0.9, happinessRate: 0.5, energyRate: 0.9, hygieneRate: 0.8, disobedienceChance: 0.3, feedGain: 1.0, playGain: 0.6)
            case .lois: return CharacterPersonality(hungerRate: 0.8, happinessRate: 0.9, energyRate: 0.9, hygieneRate: 0.4, disobedienceChance: 0.4, feedGain: 1.0, playGain: 0.9)
            case .quagmire: return CharacterPersonality(hungerRate: 1.3, happinessRate: 1.2, energyRate: 1.4, hygieneRate: 1.2, disobedienceChance: 1.8, feedGain: 1.3, playGain: 1.2)
            case .cleveland: return CharacterPersonality(hungerRate: 1.4, happinessRate: 0.9, energyRate: 0.7, hygieneRate: 1.0, disobedienceChance: 0.6, feedGain: 1.4, playGain: 0.9)
            case .joe: return CharacterPersonality(hungerRate: 1.0, happinessRate: 0.8, energyRate: 1.0, hygieneRate: 0.6, disobedienceChance: 0.5, feedGain: 1.0, playGain: 0.8)
            case .adamWest: return CharacterPersonality(hungerRate: 0.7, happinessRate: 0.6, energyRate: 0.7, hygieneRate: 0.5, disobedienceChance: 0.4, feedGain: 0.8, playGain: 0.6)
            case .herbert: return CharacterPersonality(hungerRate: 0.6, happinessRate: 0.8, energyRate: 0.4, hygieneRate: 0.8, disobedienceChance: 0.3, feedGain: 0.7, playGain: 0.8)
            case .tomTucker: return CharacterPersonality(hungerRate: 0.8, happinessRate: 0.6, energyRate: 0.8, hygieneRate: 0.5, disobedienceChance: 0.4, feedGain: 0.9, playGain: 0.6)
            }

        case .futurama(let f):
            switch f {
            case .fry: return CharacterPersonality(hungerRate: 1.8, happinessRate: 1.3, energyRate: 0.8, hygieneRate: 1.5, disobedienceChance: 1.2, feedGain: 1.8, playGain: 1.3)
            case .bender: return CharacterPersonality(hungerRate: 1.5, happinessRate: 0.6, energyRate: 1.4, hygieneRate: 1.8, disobedienceChance: 3.0, feedGain: 1.5, playGain: 0.5)
            case .leela: return CharacterPersonality(hungerRate: 0.9, happinessRate: 0.8, energyRate: 1.3, hygieneRate: 0.6, disobedienceChance: 0.8, feedGain: 1.0, playGain: 0.8)
            case .zoidberg: return CharacterPersonality(hungerRate: 2.5, happinessRate: 0.5, energyRate: 0.6, hygieneRate: 2.0, disobedienceChance: 0.5, feedGain: 2.5, playGain: 0.5)
            case .amy: return CharacterPersonality(hungerRate: 1.0, happinessRate: 1.2, energyRate: 0.9, hygieneRate: 0.4, disobedienceChance: 0.7, feedGain: 1.0, playGain: 1.2)
            case .farnsworth: return CharacterPersonality(hungerRate: 0.7, happinessRate: 0.8, energyRate: 0.5, hygieneRate: 1.2, disobedienceChance: 0.6, feedGain: 0.8, playGain: 0.8)
            case .hermes: return CharacterPersonality(hungerRate: 0.8, happinessRate: 0.7, energyRate: 0.7, hygieneRate: 0.5, disobedienceChance: 0.3, feedGain: 0.9, playGain: 0.7)
            case .cubert: return CharacterPersonality(hungerRate: 1.0, happinessRate: 1.1, energyRate: 1.0, hygieneRate: 0.7, disobedienceChance: 1.0, feedGain: 1.0, playGain: 1.1)
            case .ndnd: return CharacterPersonality(hungerRate: 0.9, happinessRate: 0.6, energyRate: 1.0, hygieneRate: 0.7, disobedienceChance: 1.2, feedGain: 0.9, playGain: 0.6)
            case .zapp: return CharacterPersonality(hungerRate: 1.2, happinessRate: 0.4, energyRate: 1.1, hygieneRate: 0.8, disobedienceChance: 2.0, feedGain: 1.2, playGain: 0.4)
            }

        case .batman(let b):
            switch b {
            case .joker: return CharacterPersonality(hungerRate: 1.0, happinessRate: 0.3, energyRate: 1.8, hygieneRate: 2.0, disobedienceChance: 3.5, feedGain: 0.8, playGain: 0.3)
            case .catwoman: return CharacterPersonality(hungerRate: 0.8, happinessRate: 1.2, energyRate: 1.3, hygieneRate: 0.5, disobedienceChance: 2.0, feedGain: 0.9, playGain: 1.2)
            case .penguin: return CharacterPersonality(hungerRate: 1.5, happinessRate: 0.6, energyRate: 0.8, hygieneRate: 1.0, disobedienceChance: 1.8, feedGain: 1.5, playGain: 0.6)
            case .riddler: return CharacterPersonality(hungerRate: 0.7, happinessRate: 1.0, energyRate: 1.5, hygieneRate: 0.8, disobedienceChance: 1.5, feedGain: 0.8, playGain: 1.0)
            case .poisonIvy: return CharacterPersonality(hungerRate: 0.6, happinessRate: 1.1, energyRate: 0.9, hygieneRate: 0.3, disobedienceChance: 1.2, feedGain: 0.7, playGain: 1.1)
            case .mrFreeze: return CharacterPersonality(hungerRate: 0.5, happinessRate: 0.4, energyRate: 1.0, hygieneRate: 0.4, disobedienceChance: 1.0, feedGain: 0.6, playGain: 0.4)
            case .bane: return CharacterPersonality(hungerRate: 1.8, happinessRate: 0.3, energyRate: 1.8, hygieneRate: 1.5, disobedienceChance: 2.8, feedGain: 1.8, playGain: 0.3)
            case .scarecrow: return CharacterPersonality(hungerRate: 0.6, happinessRate: 0.4, energyRate: 1.2, hygieneRate: 1.8, disobedienceChance: 1.8, feedGain: 0.7, playGain: 0.4)
            case .harleyQuinn: return CharacterPersonality(hungerRate: 1.2, happinessRate: 1.6, energyRate: 1.7, hygieneRate: 1.5, disobedienceChance: 2.5, feedGain: 1.2, playGain: 1.6)
            case .twoFace: return CharacterPersonality(hungerRate: 1.0, happinessRate: 0.5, energyRate: 1.3, hygieneRate: 1.2, disobedienceChance: 2.2, feedGain: 1.0, playGain: 0.5)
            case .killerCroc: return CharacterPersonality(hungerRate: 1.6, happinessRate: 0.3, energyRate: 1.5, hygieneRate: 1.8, disobedienceChance: 2.5, feedGain: 1.6, playGain: 0.3)
            case .redHood: return CharacterPersonality(hungerRate: 1.1, happinessRate: 0.4, energyRate: 1.4, hygieneRate: 0.9, disobedienceChance: 2.0, feedGain: 1.1, playGain: 0.4)
            case .rasAlGhul: return CharacterPersonality(hungerRate: 0.8, happinessRate: 0.2, energyRate: 1.3, hygieneRate: 0.6, disobedienceChance: 2.5, feedGain: 0.8, playGain: 0.2)
            case .deathstroke: return CharacterPersonality(hungerRate: 0.9, happinessRate: 0.3, energyRate: 1.5, hygieneRate: 0.7, disobedienceChance: 2.0, feedGain: 0.9, playGain: 0.3)
            }

        case .transformers(let t):
            switch t {
            case .optimusPrime: return CharacterPersonality(hungerRate: 0.8, happinessRate: 0.9, energyRate: 1.0, hygieneRate: 0.3, disobedienceChance: 0.1, feedGain: 1.0, playGain: 0.9)
            case .bumblebee: return CharacterPersonality(hungerRate: 1.0, happinessRate: 1.5, energyRate: 1.4, hygieneRate: 0.8, disobedienceChance: 0.3, feedGain: 1.0, playGain: 1.5)
            case .megatron: return CharacterPersonality(hungerRate: 1.2, happinessRate: 0.3, energyRate: 1.6, hygieneRate: 1.5, disobedienceChance: 3.0, feedGain: 1.2, playGain: 0.3)
            case .starscream: return CharacterPersonality(hungerRate: 0.9, happinessRate: 0.5, energyRate: 1.3, hygieneRate: 1.2, disobedienceChance: 2.8, feedGain: 0.9, playGain: 0.4)
            case .soundwave: return CharacterPersonality(hungerRate: 0.5, happinessRate: 0.4, energyRate: 0.8, hygieneRate: 0.3, disobedienceChance: 0.5, feedGain: 0.7, playGain: 0.4)
            case .prowl: return CharacterPersonality(hungerRate: 0.7, happinessRate: 0.8, energyRate: 1.0, hygieneRate: 0.4, disobedienceChance: 0.3, feedGain: 0.9, playGain: 0.8)
            case .jazz: return CharacterPersonality(hungerRate: 1.0, happinessRate: 1.4, energyRate: 1.3, hygieneRate: 0.7, disobedienceChance: 0.5, feedGain: 1.0, playGain: 1.4)
            case .ironhide: return CharacterPersonality(hungerRate: 1.1, happinessRate: 0.7, energyRate: 1.4, hygieneRate: 1.2, disobedienceChance: 1.0, feedGain: 1.1, playGain: 0.7)
            case .ratchet: return CharacterPersonality(hungerRate: 0.6, happinessRate: 1.0, energyRate: 0.8, hygieneRate: 0.3, disobedienceChance: 0.3, feedGain: 0.8, playGain: 1.0)
            case .shockwave: return CharacterPersonality(hungerRate: 0.4, happinessRate: 0.2, energyRate: 1.0, hygieneRate: 0.5, disobedienceChance: 1.5, feedGain: 0.5, playGain: 0.2)
            case .soundBlaster: return CharacterPersonality(hungerRate: 0.5, happinessRate: 0.4, energyRate: 0.9, hygieneRate: 0.4, disobedienceChance: 0.8, feedGain: 0.6, playGain: 0.4)
            case .galvatron: return CharacterPersonality(hungerRate: 1.1, happinessRate: 0.3, energyRate: 1.5, hygieneRate: 1.3, disobedienceChance: 2.8, feedGain: 1.1, playGain: 0.3)
            case .cyclonus: return CharacterPersonality(hungerRate: 0.8, happinessRate: 0.4, energyRate: 1.3, hygieneRate: 0.9, disobedienceChance: 1.8, feedGain: 0.9, playGain: 0.4)
            case .devestator: return CharacterPersonality(hungerRate: 2.0, happinessRate: 0.5, energyRate: 1.8, hygieneRate: 2.0, disobedienceChance: 2.5, feedGain: 2.0, playGain: 0.4)
            }

        case .labubu(let l):
            switch l {
            case .labubu: return CharacterPersonality(hungerRate: 1.2, happinessRate: 1.5, energyRate: 1.3, hygieneRate: 0.8, disobedienceChance: 0.8, feedGain: 1.2, playGain: 1.5)
            case .labubuPink: return CharacterPersonality(hungerRate: 1.1, happinessRate: 1.6, energyRate: 1.2, hygieneRate: 0.7, disobedienceChance: 0.7, feedGain: 1.1, playGain: 1.6)
            case .labubuGray: return CharacterPersonality(hungerRate: 1.3, happinessRate: 1.4, energyRate: 1.4, hygieneRate: 0.9, disobedienceChance: 0.9, feedGain: 1.3, playGain: 1.4)
            case .labubuBrown: return CharacterPersonality(hungerRate: 1.2, happinessRate: 1.3, energyRate: 1.1, hygieneRate: 1.0, disobedienceChance: 0.6, feedGain: 1.2, playGain: 1.3)
            case .labubuWhite: return CharacterPersonality(hungerRate: 1.0, happinessRate: 1.7, energyRate: 1.2, hygieneRate: 0.6, disobedienceChance: 0.7, feedGain: 1.0, playGain: 1.7)
            case .labubuGolden: return CharacterPersonality(hungerRate: 0.8, happinessRate: 1.8, energyRate: 1.5, hygieneRate: 0.4, disobedienceChance: 0.5, feedGain: 0.9, playGain: 1.8)
            }
        }
    }
}
