import AppKit

class AppDelegate: NSObject, NSApplicationDelegate {
    var statusItem: NSStatusItem!
    var cpuMonitor: CPUMonitor!
    var spriteAnimator: SpriteAnimator!
    var updateCheckTimer: Timer?

    let pokemonList: [PokemonCharacter] = [
        .jigglypuff, .pikachu, .psyduck, .snorlax, .charmander, .bulbasaur, .squirtle,
        .meowth, .eevee, .mew, .gengar, .dragonite,
        .gyarados, .arcanine, .alakazam, .machamp, .golem, .onix,
        .jolteon, .flareon, .vaporeon, .porygon, .ditto, .lapras,
        .marill, .umbreon
    ]

    let marioCharacters: [MarioItem] = [
        .mario, .luigi, .peach, .toad, .bowser, .yoshi, .donkeyKong, .wario, .waluigi, .boo
    ]

    let marioItems: [MarioItem] = [
        .superMushroom, .fireFlower, .starman, .coin, .oneUpMushroom,
        .yoshiEgg, .pipe, .questionBlock, .goomba, .koopaTroopa
    ]

    let marioKartList: [MarioKartCharacter] = [
        .mario, .luigi, .peach, .toad, .bowser, .donkeyKong, .yoshi, .wario
    ]

    let marioKartItems: [MarioKartCharacter] = [
        .redShell, .greenShell, .bananaPeel, .bomb, .bulletBill, .blueShell,
        .star, .lightning, .mushroom, .tripleMushroom, .goldenMushroom
    ]

    let contraCharacters: [ContraCharacter] = [
        .bill, .lance
    ]

    let contraItems: [ContraCharacter] = [
        .fireGun, .machineGun, .spreadGun, .laserGun, .barrier, .rapidBullets
    ]

    let contraEnemies: [ContraCharacter] = [
        .alienWall, .neoDic, .turret, .sweat, .probox
    ]

    let tmntCharacters: [TMNTCharacter] = [
        .leonardo, .donatello, .raphael, .michelangelo, .splinter, .april, .CaseyJones
    ]

    let tmntEnemies: [TMNTCharacter] = [
        .shredder, .krang, .bebop, .rocksteady
    ]

    let streetFighterCharacters: [StreetFighterCharacter] = [
        .ryu, .ken, .chunLi, .guile, .dhalsim, .zangief, .blanka, .eHonda
    ]

    let streetFighterBosses: [StreetFighterCharacter] = [
        .balrog, .vega, .sagat, .dictator
    ]

    let metalSlugCharacters: [MetalSlugCharacter] = [
        .marco, .tarma, .eri, .fio
    ]

    let metalSlugEnemies: [MetalSlugCharacter] = [
        .morden, .zombie, .mummy, .ape, .hermit, .crab
    ]

    let metalSlugVehicles: [MetalSlugCharacter] = [
        .camel, .slugTank
    ]

    let overwatchDPS: [OverwatchCharacter] = [
        .tracer, .genji, .soldier76, .reaper, .widowmaker, .mccree, .pharah, .mei
    ]

    let overwatchTank: [OverwatchCharacter] = [
        .reinhardt, .dva, .winston, .zarya
    ]

    let overwatchSupport: [OverwatchCharacter] = [
        .mercy, .lucio, .ana, .symmetra
    ]

    let kirbyCharacters: [KirbyCharacter] = [
        .kirby, .kingDedede, .metaKnight, .bandanaWaddleDee
    ]

    let kirbyEnemies: [KirbyCharacter] = [
        .waddleDee, .waddleDoo, .Gordy, .brontoBurt, .bonkers, .kingDededeBoss
    ]

    let zeldaHeroes: [ZeldaCharacter] = [
        .link, .zelda, .navi, .midna, .impa, .greatFairy
    ]

    let zeldaEnemies: [ZeldaCharacter] = [
        .ganon, .skullKid, .octorok, .moblin, .keese, .darkLink
    ]

    let megaManCharacters: [MegaManCharacter] = [
        .megaMan, .protoMan, .bass, .roll, .rush
    ]

    let megaManBosses: [MegaManCharacter] = [
        .cutMan, .gutsMan, .iceMan, .bombMan, .fireMan,
        .elecMan, .metalMan, .crashMan, .hardMan, .tornadoMan, .stoneMan
    ]

    let marvelCharacters: [MarvelCharacter] = [
        .ironMan, .captainAmerica, .thor, .hulk, .spiderMan, .wolverine,
        .blackPanther, .daredevil, .blackWidow, .hawkeye, .vision, .scarletWitch,
        .warMachine, .spiderWoman, .cyclops, .sheHulk, .juggernaut, .loki, .venom
    ]

    let dcCharacters: [DCCharacter] = [
        .batman, .superman, .wonderWoman, .flash, .greenLantern, .aquaman
    ]

    let dcVillains: [DCCharacter] = [
        .joker, .harleyQuinn, .lexLuthor, .darkseid
    ]

    let narutoCharacters: [NarutoCharacter] = [
        .naruto, .sasuke, .sakura, .kakashi, .hinata, .rockLee, .shikamaru
    ]

    let narutoVillains: [NarutoCharacter] = [
        .itachi, .gaara, .orochimaru, .jiraiya, .tsunade
    ]

    let simpsonsCharacters: [SimpsonsCharacter] = [
        .homer, .marge, .bart, .lisa, .maggie, .nedFlanders,
        .milhouse, .nelson, .krusty
    ]

    let simpsonsOthers: [SimpsonsCharacter] = [
        .mrBurns, .smithers, .principalSkinner
    ]

    let mkCharacters: [MortalKombatCharacter] = [
        .scorpion, .subZero, .raiden, .liuKang, .sonya, .johnnyCage
    ]

    let mkVillains: [MortalKombatCharacter] = [
        .shangTsung, .goro, .kitana, .jade, .milena, .reptile
    ]

    let minionsList: [MinionsCharacter] = [
        .kevin, .stuart, .bob, .dave, .jerry, .phil,
        .tim, .mark, .carl, .jorge, .donny, .eric
    ]

    let dragonBallCharacters: [DragonBallCharacter] = [
        .goku, .vegeta, .gohan, .piccolo, .frieza, .cell,
        .majinBuu, .krillin, .trunks, .goten, .beerus, .whis
    ]

    let ghibliCharacters: [GhibliCharacter] = [
        .totoro, .noFace, .kiki, .calcifer, .ponyo, .satsuki,
        .mei, .howl, .sophie, .append, .jiro, .chihiro
    ]

    let gundamCharacters: [GundamCharacter] = [
        .rx78, .zaku, .freedom, .justice, .strike, .barbatos,
        .unicorn, .sinanju, .exia, .WingZero, .deathscythe, .heavyArms
    ]

    let starWarsCharacters: [StarWarsCharacter] = [
        .luke, .vader, .leia, .han, .chewbacca, .yoda,
        .maul, .bobaFett, .c3po, .r2d2, .obiWan, .kyloRen, .stormtrooper
    ]

    let labubuCharacters: [LabubuCharacter] = [
        .labubu, .labubuPink, .labubuGray, .labubuBrown, .labubuWhite, .labubuGolden
    ]

    let kingOfTheHillFamily: [KingOfTheHillCharacter] = [
        .hank, .peggy, .bobby, .luanne, .cotton, .ladybird
    ]

    let kingOfTheHillFriends: [KingOfTheHillCharacter] = [
        .dale, .bill, .boomhauer, .kahn, .johnRedcorn, .buckStrickland
    ]

    let familyGuyFamily: [FamilyGuyCharacter] = [
        .peter, .lois, .stewie, .brian, .chris, .meg
    ]

    let familyGuyFriends: [FamilyGuyCharacter] = [
        .quagmire, .cleveland, .joe, .adamWest, .herbert, .tomTucker
    ]

    let futuramaCharacters: [FuturamaCharacter] = [
        .fry, .leela, .bender, .amy, .farnsworth, .hermes, .zoidberg, .cubert, .ndnd, .zapp
    ]

    let batmanCharacters: [BatmanCharacter] = [
        .joker, .bane, .riddler, .penguin, .harleyQuinn, .scarecrow, .killerCroc, .poisonIvy,
        .catwoman, .twoFace, .mrFreeze, .redHood, .rasAlGhul, .deathstroke
    ]

    func applicationDidFinishLaunching(_ notification: Notification) {
        NSApp.setActivationPolicy(.accessory)

        statusItem = NSStatusBar.system.statusItem(withLength: NSStatusItem.variableLength)

        cpuMonitor = CPUMonitor()
        spriteAnimator = SpriteAnimator(cpuMonitor: cpuMonitor)
        spriteAnimator.setOnPokemonChanged { [weak self] in
            DispatchQueue.main.async {
                self?.buildMenu()
            }
        }

        if let button = statusItem.button {
            button.image = spriteAnimator.currentFrame
            button.imagePosition = .imageOnly
        }

        cpuMonitor.onCPUUpdate = { [weak self] usage in
            DispatchQueue.main.async {
                self?.spriteAnimator.updateSpeed(cpuUsage: usage)
                self?.statusItem.button?.image = self?.spriteAnimator.currentFrame
                self?.updateMenu()
            }
        }

        buildMenu()
        cpuMonitor.start()

        checkForUpdatesInBackground()
        updateCheckTimer = Timer.scheduledTimer(withTimeInterval: 86400, repeats: true) { [weak self] _ in
            self?.checkForUpdatesInBackground()
        }
    }

    func buildMenu() {
        let menu = NSMenu()
        menu.addItem(NSMenuItem(title: "MenuPet", action: nil, keyEquivalent: ""))
        let currentPokemonItem = NSMenuItem(title: "\(spriteAnimator.currentPokemon.emoji) \(spriteAnimator.currentPokemon.displayName) — \(spriteAnimator.currentPokemon.category)", action: #selector(searchCharacter(_:)), keyEquivalent: "")
        currentPokemonItem.tag = 300
        currentPokemonItem.target = self
        menu.addItem(currentPokemonItem)
        menu.addItem(NSMenuItem.separator())

        let cpuItem = NSMenuItem(title: "CPU Usage: \(Int(cpuMonitor.currentCPU))%", action: nil, keyEquivalent: "")
        cpuItem.tag = 100
        menu.addItem(cpuItem)

        // ===== Grouped Categories =====
        let gamesMenu = NSMenu()
        let animeMenu = NSMenu()
        let moviesTVMenu = NSMenu()

        // Helper to create a category submenu
        func makeCategoryMenu<T>(_ items: [(title: String, characters: [T])], cases: (T) -> SelectableCharacter) -> NSMenu {
            let sub = NSMenu()
            for (title, chars) in items {
                if chars.count > 1 {
                    let header = NSMenuItem(title: title, action: nil, keyEquivalent: "")
                    header.isEnabled = false
                    sub.addItem(header)
                    for char in chars {
                        let item = NSMenuItem(title: "  \(cases(char).displayName)", action: #selector(selectCharacter(_:)), keyEquivalent: "")
                        item.target = self
                        item.representedObject = cases(char)
                        if cases(char) == spriteAnimator.currentPokemon { item.state = .on }
                        sub.addItem(item)
                    }
                } else if let char = chars.first {
                    let item = NSMenuItem(title: cases(char).displayName, action: #selector(selectCharacter(_:)), keyEquivalent: "")
                    item.target = self
                    item.representedObject = cases(char)
                    if cases(char) == spriteAnimator.currentPokemon { item.state = .on }
                    sub.addItem(item)
                }
            }
            return sub
        }

        // ===== Video Games =====
        func addCategoryToMenu(_ menu: NSMenu, title: String, isActive: Bool) {
            let item = NSMenuItem(title: title, action: nil, keyEquivalent: "")
            item.state = isActive ? .on : .off
            menu.addItem(item)
        }

        // Pokémon
        let pokemonSub = NSMenu()
        for p in pokemonList {
            let i = NSMenuItem(title: p.displayName, action: #selector(selectCharacter(_:)), keyEquivalent: "")
            i.target = self; i.representedObject = SelectableCharacter.pokemon(p)
            if case .pokemon(let x) = spriteAnimator.currentPokemon, x == p { i.state = .on }
            pokemonSub.addItem(i)
        }
        let pokemonMI = NSMenuItem(title: "Pokémon", action: nil, keyEquivalent: "")
        pokemonMI.submenu = pokemonSub
        if case .pokemon(_) = spriteAnimator.currentPokemon { pokemonMI.state = .on }
        gamesMenu.addItem(pokemonMI)

        // Super Mario Bros
        let marioSub = NSMenu()
        for c in marioCharacters {
            let i = NSMenuItem(title: c.displayName, action: #selector(selectCharacter(_:)), keyEquivalent: "")
            i.target = self; i.representedObject = SelectableCharacter.marioItem(c)
            if case .marioItem(let x) = spriteAnimator.currentPokemon, x == c { i.state = .on }
            marioSub.addItem(i)
        }
        marioSub.addItem(NSMenuItem.separator())
        for c in marioItems {
            let i = NSMenuItem(title: c.displayName, action: #selector(selectCharacter(_:)), keyEquivalent: "")
            i.target = self; i.representedObject = SelectableCharacter.marioItem(c)
            if case .marioItem(let x) = spriteAnimator.currentPokemon, x == c { i.state = .on }
            marioSub.addItem(i)
        }
        let marioMI = NSMenuItem(title: "Super Mario Bros", action: nil, keyEquivalent: "")
        marioMI.submenu = marioSub
        if case .marioItem(_) = spriteAnimator.currentPokemon { marioMI.state = .on }
        gamesMenu.addItem(marioMI)

        // Mario Kart
        let kartSub = NSMenu()
        for c in marioKartList {
            let i = NSMenuItem(title: c.displayName, action: #selector(selectCharacter(_:)), keyEquivalent: "")
            i.target = self; i.representedObject = SelectableCharacter.marioKart(c)
            if case .marioKart(let x) = spriteAnimator.currentPokemon, x == c { i.state = .on }
            kartSub.addItem(i)
        }
        kartSub.addItem(NSMenuItem.separator())
        for c in marioKartItems {
            let i = NSMenuItem(title: c.displayName, action: #selector(selectCharacter(_:)), keyEquivalent: "")
            i.target = self; i.representedObject = SelectableCharacter.marioKart(c)
            if case .marioKart(let x) = spriteAnimator.currentPokemon, x == c { i.state = .on }
            kartSub.addItem(i)
        }
        let kartMI = NSMenuItem(title: "Mario Kart", action: nil, keyEquivalent: "")
        kartMI.submenu = kartSub
        if case .marioKart(_) = spriteAnimator.currentPokemon { kartMI.state = .on }
        gamesMenu.addItem(kartMI)

        // Kirby
        let kirbySub = NSMenu()
        for c in kirbyCharacters {
            let i = NSMenuItem(title: c.displayName, action: #selector(selectCharacter(_:)), keyEquivalent: "")
            i.target = self; i.representedObject = SelectableCharacter.kirby(c)
            if case .kirby(let x) = spriteAnimator.currentPokemon, x == c { i.state = .on }
            kirbySub.addItem(i)
        }
        kirbySub.addItem(NSMenuItem.separator())
        for c in kirbyEnemies {
            let i = NSMenuItem(title: c.displayName, action: #selector(selectCharacter(_:)), keyEquivalent: "")
            i.target = self; i.representedObject = SelectableCharacter.kirby(c)
            if case .kirby(let x) = spriteAnimator.currentPokemon, x == c { i.state = .on }
            kirbySub.addItem(i)
        }
        let kirbyMI = NSMenuItem(title: "Kirby", action: nil, keyEquivalent: "")
        kirbyMI.submenu = kirbySub
        if case .kirby(_) = spriteAnimator.currentPokemon { kirbyMI.state = .on }
        gamesMenu.addItem(kirbyMI)

        // Legend of Zelda
        let zeldaSub = NSMenu()
        for c in zeldaHeroes {
            let i = NSMenuItem(title: c.displayName, action: #selector(selectCharacter(_:)), keyEquivalent: "")
            i.target = self; i.representedObject = SelectableCharacter.zelda(c)
            if case .zelda(let x) = spriteAnimator.currentPokemon, x == c { i.state = .on }
            zeldaSub.addItem(i)
        }
        zeldaSub.addItem(NSMenuItem.separator())
        for c in zeldaEnemies {
            let i = NSMenuItem(title: c.displayName, action: #selector(selectCharacter(_:)), keyEquivalent: "")
            i.target = self; i.representedObject = SelectableCharacter.zelda(c)
            if case .zelda(let x) = spriteAnimator.currentPokemon, x == c { i.state = .on }
            zeldaSub.addItem(i)
        }
        let zeldaMI = NSMenuItem(title: "Legend of Zelda", action: nil, keyEquivalent: "")
        zeldaMI.submenu = zeldaSub
        if case .zelda(_) = spriteAnimator.currentPokemon { zeldaMI.state = .on }
        gamesMenu.addItem(zeldaMI)

        // Mega Man
        let mmSub = NSMenu()
        for c in megaManCharacters {
            let i = NSMenuItem(title: c.displayName, action: #selector(selectCharacter(_:)), keyEquivalent: "")
            i.target = self; i.representedObject = SelectableCharacter.megaMan(c)
            if case .megaMan(let x) = spriteAnimator.currentPokemon, x == c { i.state = .on }
            mmSub.addItem(i)
        }
        mmSub.addItem(NSMenuItem.separator())
        for c in megaManBosses {
            let i = NSMenuItem(title: c.displayName, action: #selector(selectCharacter(_:)), keyEquivalent: "")
            i.target = self; i.representedObject = SelectableCharacter.megaMan(c)
            if case .megaMan(let x) = spriteAnimator.currentPokemon, x == c { i.state = .on }
            mmSub.addItem(i)
        }
        let mmMI = NSMenuItem(title: "Mega Man", action: nil, keyEquivalent: "")
        mmMI.submenu = mmSub
        if case .megaMan(_) = spriteAnimator.currentPokemon { mmMI.state = .on }
        gamesMenu.addItem(mmMI)

        // Contra
        let contraSub = NSMenu()
        for c in contraCharacters {
            let i = NSMenuItem(title: c.displayName, action: #selector(selectCharacter(_:)), keyEquivalent: "")
            i.target = self; i.representedObject = SelectableCharacter.contra(c)
            if case .contra(let x) = spriteAnimator.currentPokemon, x == c { i.state = .on }
            contraSub.addItem(i)
        }
        contraSub.addItem(NSMenuItem.separator())
        for c in contraItems + contraEnemies {
            let i = NSMenuItem(title: c.displayName, action: #selector(selectCharacter(_:)), keyEquivalent: "")
            i.target = self; i.representedObject = SelectableCharacter.contra(c)
            if case .contra(let x) = spriteAnimator.currentPokemon, x == c { i.state = .on }
            contraSub.addItem(i)
        }
        let contraMI = NSMenuItem(title: "Contra", action: nil, keyEquivalent: "")
        contraMI.submenu = contraSub
        if case .contra(_) = spriteAnimator.currentPokemon { contraMI.state = .on }
        gamesMenu.addItem(contraMI)

        // Metal Slug
        let msSub = NSMenu()
        for c in metalSlugCharacters {
            let i = NSMenuItem(title: c.displayName, action: #selector(selectCharacter(_:)), keyEquivalent: "")
            i.target = self; i.representedObject = SelectableCharacter.metalSlug(c)
            if case .metalSlug(let x) = spriteAnimator.currentPokemon, x == c { i.state = .on }
            msSub.addItem(i)
        }
        msSub.addItem(NSMenuItem.separator())
        for c in metalSlugVehicles + metalSlugEnemies {
            let i = NSMenuItem(title: c.displayName, action: #selector(selectCharacter(_:)), keyEquivalent: "")
            i.target = self; i.representedObject = SelectableCharacter.metalSlug(c)
            if case .metalSlug(let x) = spriteAnimator.currentPokemon, x == c { i.state = .on }
            msSub.addItem(i)
        }
        let msMI = NSMenuItem(title: "Metal Slug", action: nil, keyEquivalent: "")
        msMI.submenu = msSub
        if case .metalSlug(_) = spriteAnimator.currentPokemon { msMI.state = .on }
        gamesMenu.addItem(msMI)

        // Street Fighter
        let sfSub = NSMenu()
        for c in streetFighterCharacters {
            let i = NSMenuItem(title: c.displayName, action: #selector(selectCharacter(_:)), keyEquivalent: "")
            i.target = self; i.representedObject = SelectableCharacter.streetFighter(c)
            if case .streetFighter(let x) = spriteAnimator.currentPokemon, x == c { i.state = .on }
            sfSub.addItem(i)
        }
        sfSub.addItem(NSMenuItem.separator())
        for c in streetFighterBosses {
            let i = NSMenuItem(title: c.displayName, action: #selector(selectCharacter(_:)), keyEquivalent: "")
            i.target = self; i.representedObject = SelectableCharacter.streetFighter(c)
            if case .streetFighter(let x) = spriteAnimator.currentPokemon, x == c { i.state = .on }
            sfSub.addItem(i)
        }
        let sfMI = NSMenuItem(title: "Street Fighter", action: nil, keyEquivalent: "")
        sfMI.submenu = sfSub
        if case .streetFighter(_) = spriteAnimator.currentPokemon { sfMI.state = .on }
        gamesMenu.addItem(sfMI)

        // Mortal Kombat
        let mkSub = NSMenu()
        for c in mkCharacters {
            let i = NSMenuItem(title: c.displayName, action: #selector(selectCharacter(_:)), keyEquivalent: "")
            i.target = self; i.representedObject = SelectableCharacter.mortalKombat(c)
            if case .mortalKombat(let x) = spriteAnimator.currentPokemon, x == c { i.state = .on }
            mkSub.addItem(i)
        }
        mkSub.addItem(NSMenuItem.separator())
        for c in mkVillains {
            let i = NSMenuItem(title: c.displayName, action: #selector(selectCharacter(_:)), keyEquivalent: "")
            i.target = self; i.representedObject = SelectableCharacter.mortalKombat(c)
            if case .mortalKombat(let x) = spriteAnimator.currentPokemon, x == c { i.state = .on }
            mkSub.addItem(i)
        }
        let mkMI = NSMenuItem(title: "Mortal Kombat", action: nil, keyEquivalent: "")
        mkMI.submenu = mkSub
        if case .mortalKombat(_) = spriteAnimator.currentPokemon { mkMI.state = .on }
        gamesMenu.addItem(mkMI)

        // TMNT
        let tmntSub = NSMenu()
        for c in tmntCharacters {
            let i = NSMenuItem(title: c.displayName, action: #selector(selectCharacter(_:)), keyEquivalent: "")
            i.target = self; i.representedObject = SelectableCharacter.tmnt(c)
            if case .tmnt(let x) = spriteAnimator.currentPokemon, x == c { i.state = .on }
            tmntSub.addItem(i)
        }
        tmntSub.addItem(NSMenuItem.separator())
        for c in tmntEnemies {
            let i = NSMenuItem(title: c.displayName, action: #selector(selectCharacter(_:)), keyEquivalent: "")
            i.target = self; i.representedObject = SelectableCharacter.tmnt(c)
            if case .tmnt(let x) = spriteAnimator.currentPokemon, x == c { i.state = .on }
            tmntSub.addItem(i)
        }
        let tmntMI = NSMenuItem(title: "TMNT", action: nil, keyEquivalent: "")
        tmntMI.submenu = tmntSub
        if case .tmnt(_) = spriteAnimator.currentPokemon { tmntMI.state = .on }
        gamesMenu.addItem(tmntMI)

        // Overwatch
        let owSub = NSMenu()
        for c in overwatchDPS + overwatchTank + overwatchSupport {
            let i = NSMenuItem(title: c.displayName, action: #selector(selectCharacter(_:)), keyEquivalent: "")
            i.target = self; i.representedObject = SelectableCharacter.overwatch(c)
            if case .overwatch(let x) = spriteAnimator.currentPokemon, x == c { i.state = .on }
            owSub.addItem(i)
        }
        let owMI = NSMenuItem(title: "Overwatch", action: nil, keyEquivalent: "")
        owMI.submenu = owSub
        if case .overwatch(_) = spriteAnimator.currentPokemon { owMI.state = .on }
        gamesMenu.addItem(owMI)

        let gamesMI = NSMenuItem(title: "🎮 Video Games", action: nil, keyEquivalent: "")
        gamesMI.submenu = gamesMenu
        menu.addItem(gamesMI)

        // ===== Anime & Manga =====
        // Dragon Ball
        let dbSub = NSMenu()
        for c in dragonBallCharacters {
            let i = NSMenuItem(title: c.displayName, action: #selector(selectCharacter(_:)), keyEquivalent: "")
            i.target = self; i.representedObject = SelectableCharacter.dragonBall(c)
            if case .dragonBall(let x) = spriteAnimator.currentPokemon, x == c { i.state = .on }
            dbSub.addItem(i)
        }
        let dbMI = NSMenuItem(title: "Dragon Ball", action: nil, keyEquivalent: "")
        dbMI.submenu = dbSub
        if case .dragonBall(_) = spriteAnimator.currentPokemon { dbMI.state = .on }
        animeMenu.addItem(dbMI)

        // Naruto
        let narutoSub = NSMenu()
        for c in narutoCharacters {
            let i = NSMenuItem(title: c.displayName, action: #selector(selectCharacter(_:)), keyEquivalent: "")
            i.target = self; i.representedObject = SelectableCharacter.naruto(c)
            if case .naruto(let x) = spriteAnimator.currentPokemon, x == c { i.state = .on }
            narutoSub.addItem(i)
        }
        narutoSub.addItem(NSMenuItem.separator())
        for c in narutoVillains {
            let i = NSMenuItem(title: c.displayName, action: #selector(selectCharacter(_:)), keyEquivalent: "")
            i.target = self; i.representedObject = SelectableCharacter.naruto(c)
            if case .naruto(let x) = spriteAnimator.currentPokemon, x == c { i.state = .on }
            narutoSub.addItem(i)
        }
        let narutoMI = NSMenuItem(title: "Naruto", action: nil, keyEquivalent: "")
        narutoMI.submenu = narutoSub
        if case .naruto(_) = spriteAnimator.currentPokemon { narutoMI.state = .on }
        animeMenu.addItem(narutoMI)

        // Gundam
        let gdSub = NSMenu()
        for c in gundamCharacters {
            let i = NSMenuItem(title: c.displayName, action: #selector(selectCharacter(_:)), keyEquivalent: "")
            i.target = self; i.representedObject = SelectableCharacter.gundam(c)
            if case .gundam(let x) = spriteAnimator.currentPokemon, x == c { i.state = .on }
            gdSub.addItem(i)
        }
        let gdMI = NSMenuItem(title: "Gundam", action: nil, keyEquivalent: "")
        gdMI.submenu = gdSub
        if case .gundam(_) = spriteAnimator.currentPokemon { gdMI.state = .on }
        animeMenu.addItem(gdMI)

        // Studio Ghibli
        let ghSub = NSMenu()
        for c in ghibliCharacters {
            let i = NSMenuItem(title: c.displayName, action: #selector(selectCharacter(_:)), keyEquivalent: "")
            i.target = self; i.representedObject = SelectableCharacter.ghibli(c)
            if case .ghibli(let x) = spriteAnimator.currentPokemon, x == c { i.state = .on }
            ghSub.addItem(i)
        }
        let ghMI = NSMenuItem(title: "Studio Ghibli", action: nil, keyEquivalent: "")
        ghMI.submenu = ghSub
        if case .ghibli(_) = spriteAnimator.currentPokemon { ghMI.state = .on }
        animeMenu.addItem(ghMI)

        // Labubu
        let labSub = NSMenu()
        for c in labubuCharacters {
            let i = NSMenuItem(title: c.displayName, action: #selector(selectCharacter(_:)), keyEquivalent: "")
            i.target = self; i.representedObject = SelectableCharacter.labubu(c)
            if case .labubu(let x) = spriteAnimator.currentPokemon, x == c { i.state = .on }
            labSub.addItem(i)
        }
        let labMI = NSMenuItem(title: "Labubu", action: nil, keyEquivalent: "")
        labMI.submenu = labSub
        if case .labubu(_) = spriteAnimator.currentPokemon { labMI.state = .on }
        animeMenu.addItem(labMI)

        let animeMI = NSMenuItem(title: "⛩️ Anime & Manga", action: nil, keyEquivalent: "")
        animeMI.submenu = animeMenu
        menu.addItem(animeMI)

        // ===== Movies & TV =====
        // Marvel
        let mvSub = NSMenu()
        for c in marvelCharacters {
            let i = NSMenuItem(title: c.displayName, action: #selector(selectCharacter(_:)), keyEquivalent: "")
            i.target = self; i.representedObject = SelectableCharacter.marvel(c)
            if case .marvel(let x) = spriteAnimator.currentPokemon, x == c { i.state = .on }
            mvSub.addItem(i)
        }
        let mvMI = NSMenuItem(title: "Marvel", action: nil, keyEquivalent: "")
        mvMI.submenu = mvSub
        if case .marvel(_) = spriteAnimator.currentPokemon { mvMI.state = .on }
        moviesTVMenu.addItem(mvMI)

        // DC Comics
        let dcSub = NSMenu()
        for c in dcCharacters {
            let i = NSMenuItem(title: c.displayName, action: #selector(selectCharacter(_:)), keyEquivalent: "")
            i.target = self; i.representedObject = SelectableCharacter.dc(c)
            if case .dc(let x) = spriteAnimator.currentPokemon, x == c { i.state = .on }
            dcSub.addItem(i)
        }
        dcSub.addItem(NSMenuItem.separator())
        for c in dcVillains {
            let i = NSMenuItem(title: c.displayName, action: #selector(selectCharacter(_:)), keyEquivalent: "")
            i.target = self; i.representedObject = SelectableCharacter.dc(c)
            if case .dc(let x) = spriteAnimator.currentPokemon, x == c { i.state = .on }
            dcSub.addItem(i)
        }
        let dcMI = NSMenuItem(title: "DC Comics", action: nil, keyEquivalent: "")
        dcMI.submenu = dcSub
        if case .dc(_) = spriteAnimator.currentPokemon { dcMI.state = .on }
        moviesTVMenu.addItem(dcMI)

        // Star Wars
        let swSub = NSMenu()
        for c in starWarsCharacters {
            let i = NSMenuItem(title: c.displayName, action: #selector(selectCharacter(_:)), keyEquivalent: "")
            i.target = self; i.representedObject = SelectableCharacter.starWars(c)
            if case .starWars(let x) = spriteAnimator.currentPokemon, x == c { i.state = .on }
            swSub.addItem(i)
        }
        let swMI = NSMenuItem(title: "Star Wars", action: nil, keyEquivalent: "")
        swMI.submenu = swSub
        if case .starWars(_) = spriteAnimator.currentPokemon { swMI.state = .on }
        moviesTVMenu.addItem(swMI)



        // The Simpsons
        let simpSub = NSMenu()
        for c in simpsonsCharacters + simpsonsOthers {
            let i = NSMenuItem(title: c.displayName, action: #selector(selectCharacter(_:)), keyEquivalent: "")
            i.target = self; i.representedObject = SelectableCharacter.simpsons(c)
            if case .simpsons(let x) = spriteAnimator.currentPokemon, x == c { i.state = .on }
            simpSub.addItem(i)
        }
        let simpMI = NSMenuItem(title: "The Simpsons", action: nil, keyEquivalent: "")
        simpMI.submenu = simpSub
        if case .simpsons(_) = spriteAnimator.currentPokemon { simpMI.state = .on }
        moviesTVMenu.addItem(simpMI)

        // King of the Hill
        let kothSub = NSMenu()
        for c in kingOfTheHillFamily + kingOfTheHillFriends {
            let i = NSMenuItem(title: c.displayName, action: #selector(selectCharacter(_:)), keyEquivalent: "")
            i.target = self; i.representedObject = SelectableCharacter.kingOfTheHill(c)
            if case .kingOfTheHill(let x) = spriteAnimator.currentPokemon, x == c { i.state = .on }
            kothSub.addItem(i)
        }
        let kothMI = NSMenuItem(title: "King of the Hill", action: nil, keyEquivalent: "")
        kothMI.submenu = kothSub
        if case .kingOfTheHill(_) = spriteAnimator.currentPokemon { kothMI.state = .on }
        moviesTVMenu.addItem(kothMI)

        // Family Guy
        let fgSub = NSMenu()
        for c in familyGuyFamily + familyGuyFriends {
            let i = NSMenuItem(title: c.displayName, action: #selector(selectCharacter(_:)), keyEquivalent: "")
            i.target = self; i.representedObject = SelectableCharacter.familyGuy(c)
            if case .familyGuy(let x) = spriteAnimator.currentPokemon, x == c { i.state = .on }
            fgSub.addItem(i)
        }
        let fgMI = NSMenuItem(title: "Family Guy", action: nil, keyEquivalent: "")
        fgMI.submenu = fgSub
        if case .familyGuy(_) = spriteAnimator.currentPokemon { fgMI.state = .on }
        moviesTVMenu.addItem(fgMI)

        // Minions
        let minSub = NSMenu()
        for c in minionsList {
            let i = NSMenuItem(title: c.displayName, action: #selector(selectCharacter(_:)), keyEquivalent: "")
            i.target = self; i.representedObject = SelectableCharacter.minions(c)
            if case .minions(let x) = spriteAnimator.currentPokemon, x == c { i.state = .on }
            minSub.addItem(i)
        }
        let minMI = NSMenuItem(title: "Minions", action: nil, keyEquivalent: "")
        minMI.submenu = minSub
        if case .minions(_) = spriteAnimator.currentPokemon { minMI.state = .on }
        moviesTVMenu.addItem(minMI)

        // Futurama
        let futSub = NSMenu()
        for c in futuramaCharacters {
            let i = NSMenuItem(title: c.displayName, action: #selector(selectCharacter(_:)), keyEquivalent: "")
            i.target = self; i.representedObject = SelectableCharacter.futurama(c)
            if case .futurama(let x) = spriteAnimator.currentPokemon, x == c { i.state = .on }
            futSub.addItem(i)
        }
        let futMI = NSMenuItem(title: "Futurama", action: nil, keyEquivalent: "")
        futMI.submenu = futSub
        if case .futurama(_) = spriteAnimator.currentPokemon { futMI.state = .on }
        moviesTVMenu.addItem(futMI)

        // Batman
        let batSub = NSMenu()
        for c in batmanCharacters {
            let i = NSMenuItem(title: c.displayName, action: #selector(selectCharacter(_:)), keyEquivalent: "")
            i.target = self; i.representedObject = SelectableCharacter.batman(c)
            if case .batman(let x) = spriteAnimator.currentPokemon, x == c { i.state = .on }
            batSub.addItem(i)
        }
        let batMI = NSMenuItem(title: "Batman Rogues", action: nil, keyEquivalent: "")
        batMI.submenu = batSub
        if case .batman(_) = spriteAnimator.currentPokemon { batMI.state = .on }
        moviesTVMenu.addItem(batMI)

        let moviesTVMI = NSMenuItem(title: "🎬 Movies & TV", action: nil, keyEquivalent: "")
        moviesTVMI.submenu = moviesTVMenu
        menu.addItem(moviesTVMI)

        menu.addItem(NSMenuItem.separator())

        let speedItem = NSMenuItem(title: "Speed: \(spriteAnimator.speedLabel)", action: nil, keyEquivalent: "")
        speedItem.tag = 200
        menu.addItem(speedItem)

        let rotationItem = NSMenuItem(title: "Random Rotation (every 10 min)", action: #selector(toggleRotation), keyEquivalent: "")
        rotationItem.target = self
        rotationItem.state = spriteAnimator.rotationEnabled ? .on : .off
        menu.addItem(rotationItem)

        let smartRotationItem = NSMenuItem(title: "Smart Rotation (prefer favorites)", action: #selector(toggleSmartRotation), keyEquivalent: "")
        smartRotationItem.target = self
        smartRotationItem.state = spriteAnimator.smartRotationEnabled ? .on : .off
        smartRotationItem.isEnabled = spriteAnimator.rotationEnabled
        menu.addItem(smartRotationItem)

        // History submenu
        let historySubmenu = NSMenu()
        if spriteAnimator.characterHistory.isEmpty {
            let emptyItem = NSMenuItem(title: "No history yet", action: nil, keyEquivalent: "")
            emptyItem.isEnabled = false
            historySubmenu.addItem(emptyItem)
        } else {
            for character in spriteAnimator.characterHistory.prefix(20) {
                let item = NSMenuItem(title: "\(character.displayName) — \(character.category)", action: #selector(selectCharacter(_:)), keyEquivalent: "")
                item.target = self
                item.representedObject = character
                if character == spriteAnimator.currentPokemon {
                    item.state = .on
                }
                historySubmenu.addItem(item)
            }
        }
        let historyMenuItem = NSMenuItem(title: "History", action: nil, keyEquivalent: "")
        historyMenuItem.submenu = historySubmenu
        menu.addItem(historyMenuItem)

        menu.addItem(NSMenuItem.separator())

        let checkUpdateItem = NSMenuItem(title: "Check for Updates...", action: #selector(checkForUpdates), keyEquivalent: "")
        checkUpdateItem.target = self
        menu.addItem(checkUpdateItem)

        let versionItem = NSMenuItem(title: "Version \(UpdateChecker.shared.currentVersion)", action: nil, keyEquivalent: "")
        versionItem.isEnabled = false
        menu.addItem(versionItem)

        menu.addItem(NSMenuItem.separator())
        menu.addItem(NSMenuItem(title: "Quit", action: #selector(quitApp), keyEquivalent: "q"))

        statusItem.menu = menu
    }

    func updateMenu() {
        guard let menu = statusItem.menu else { return }
        for item in menu.items {
            if item.tag == 100 {
                item.title = "CPU Usage: \(Int(cpuMonitor.currentCPU))%"
            } else if item.tag == 200 {
                item.title = "Speed: \(spriteAnimator.speedLabel)"
            } else if item.tag == 300 {
                item.title = "\(spriteAnimator.currentPokemon.emoji) \(spriteAnimator.currentPokemon.displayName) — \(spriteAnimator.currentPokemon.category)"
            }
            // Update checkmarks for category menus
            if let submenu = item.submenu {
                updateCheckmarks(in: submenu)
            }
        }
    }

    private func updateCheckmarks(in menu: NSMenu) {
        for item in menu.items {
            if let submenu = item.submenu {
                updateCheckmarks(in: submenu)
            } else if let character = item.representedObject as? SelectableCharacter {
                item.state = (character == spriteAnimator.currentPokemon) ? .on : .off
            }
        }
    }

    @objc func selectCharacter(_ sender: NSMenuItem) {
        guard let character = sender.representedObject as? SelectableCharacter else { return }
        spriteAnimator.setPokemon(character)
        spriteAnimator.resetRotationTimer()
        buildMenu()
    }

    @objc func toggleRotation() {
        spriteAnimator.toggleRotation()
        buildMenu()
    }

    @objc func toggleSmartRotation() {
        spriteAnimator.toggleSmartRotation()
        buildMenu()
    }

    @objc func searchCharacter(_ sender: NSMenuItem) {
        let characterName = spriteAnimator.currentPokemon.displayName
        let query = characterName.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? characterName
        if let url = URL(string: "https://www.google.com/search?tbm=isch&q=\(query)") {
            NSWorkspace.shared.open(url)
        }
    }

    @objc func checkForUpdates() {
        UpdateChecker.shared.onUpdateAvailable = { [weak self] version, downloadURL in
            DispatchQueue.main.async {
                let alert = NSAlert()
                alert.messageText = "Update Available"
                alert.informativeText = "A new version (v\(version)) is available. Would you like to download and install it?"
                alert.addButton(withTitle: "Install Update")
                alert.addButton(withTitle: "Cancel")
                
                if alert.runModal() == .alertFirstButtonReturn {
                    self?.downloadAndInstall(from: downloadURL)
                }
            }
        }
        
        UpdateChecker.shared.onCheckComplete = { available, message in
            DispatchQueue.main.async {
                if !available {
                    let alert = NSAlert()
                    alert.messageText = "No Updates Available"
                    alert.informativeText = "You're running the latest version (v\(UpdateChecker.shared.currentVersion))."
                    alert.alertStyle = .informational
                    alert.addButton(withTitle: "OK")
                    alert.runModal()
                }
            }
        }
        
        UpdateChecker.shared.checkForUpdates()
    }
    
    private func checkForUpdatesInBackground() {
        UpdateChecker.shared.onUpdateAvailable = { [weak self] version, downloadURL in
            DispatchQueue.main.async {
                let alert = NSAlert()
                alert.messageText = "Update Available"
                alert.informativeText = "A new version (v\(version)) is available. Would you like to download and install it?"
                alert.addButton(withTitle: "Install Update")
                alert.addButton(withTitle: "Cancel")
                
                if alert.runModal() == .alertFirstButtonReturn {
                    self?.downloadAndInstall(from: downloadURL)
                }
            }
        }
        
        UpdateChecker.shared.onCheckComplete = { available, message in
            // Silently ignore - no alert for background checks
        }
        
        UpdateChecker.shared.checkForUpdates()
    }
    
    private func downloadAndInstall(from url: String) {
        let progressWindow = NSWindow(
            contentRect: NSRect(x: 0, y: 0, width: 320, height: 140),
            styleMask: [.titled],
            backing: .buffered,
            defer: false
        )
        progressWindow.title = "Downloading Update"
        progressWindow.isReleasedWhenClosed = false
        progressWindow.center()

        let label = NSTextField(labelWithString: "Downloading update...")
        label.frame = NSRect(x: 20, y: 90, width: 280, height: 20)
        label.font = NSFont.systemFont(ofSize: 13)

        let progress = NSProgressIndicator(frame: NSRect(x: 20, y: 55, width: 280, height: 20))
        progress.style = .bar
        progress.isIndeterminate = false
        progress.minValue = 0
        progress.maxValue = 100
        progress.doubleValue = 0

        let statusLabel = NSTextField(labelWithString: "0%")
        statusLabel.frame = NSRect(x: 20, y: 30, width: 280, height: 18)
        statusLabel.font = NSFont.systemFont(ofSize: 11)
        statusLabel.textColor = .secondaryLabelColor

        progressWindow.contentView?.addSubview(label)
        progressWindow.contentView?.addSubview(progress)
        progressWindow.contentView?.addSubview(statusLabel)
        progressWindow.makeKeyAndOrderFront(nil)

        UpdateChecker.shared.downloadAndInstallUpdate(from: url, progressWindow: progressWindow, progressIndicator: progress, statusLabel: statusLabel)
    }

    @objc func quitApp() {
        NSApplication.shared.terminate(nil)
    }
}
