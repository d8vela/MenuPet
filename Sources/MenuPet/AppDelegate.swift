import AppKit

class AppDelegate: NSObject, NSApplicationDelegate {
    var statusItem: NSStatusItem!
    var cpuMonitor: CPUMonitor!
    var spriteAnimator: SpriteAnimator!

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
        .spiderMan, .ironMan, .captainAmerica, .thor, .hulk, .wolverine,
        .deadpool, .blackPanther, .doctorStrange
    ]

    let marvelVillains: [MarvelCharacter] = [
        .thanos, .loki, .magneto
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
    }

    func buildMenu() {
        let menu = NSMenu()
        menu.addItem(NSMenuItem(title: "MenuPet", action: nil, keyEquivalent: ""))
        let currentPokemonItem = NSMenuItem(title: "\(spriteAnimator.currentPokemon.emoji) \(spriteAnimator.currentPokemon.displayName)", action: nil, keyEquivalent: "")
        currentPokemonItem.tag = 300
        menu.addItem(currentPokemonItem)
        menu.addItem(NSMenuItem.separator())

        let cpuItem = NSMenuItem(title: "CPU Usage: \(Int(cpuMonitor.currentCPU))%", action: nil, keyEquivalent: "")
        cpuItem.tag = 100
        menu.addItem(cpuItem)

        // Pokémon submenu
        let pokemonSubmenu = NSMenu()
        for pokemon in pokemonList {
            let item = NSMenuItem(title: pokemon.displayName, action: #selector(selectCharacter(_:)), keyEquivalent: "")
            item.target = self
            item.representedObject = SelectableCharacter.pokemon(pokemon)
            if case .pokemon(let p) = spriteAnimator.currentPokemon, p == pokemon {
                item.state = .on
            }
            pokemonSubmenu.addItem(item)
        }
        let pokemonMenuItem = NSMenuItem(title: "Pokémon", action: nil, keyEquivalent: "")
        pokemonMenuItem.submenu = pokemonSubmenu
        if case .pokemon(_) = spriteAnimator.currentPokemon {
            pokemonMenuItem.state = .on
        }
        menu.addItem(pokemonMenuItem)

        // Super Mario Bros submenu
        let marioSubmenu = NSMenu()

        // Characters section
        let marioCharsHeader = NSMenuItem(title: "Characters", action: nil, keyEquivalent: "")
        marioCharsHeader.isEnabled = false
        marioSubmenu.addItem(marioCharsHeader)
        for char in marioCharacters {
            let item = NSMenuItem(title: "  \(char.displayName)", action: #selector(selectCharacter(_:)), keyEquivalent: "")
            item.target = self
            item.representedObject = SelectableCharacter.marioItem(char)
            if case .marioItem(let m) = spriteAnimator.currentPokemon, m == char {
                item.state = .on
            }
            marioSubmenu.addItem(item)
        }

        marioSubmenu.addItem(NSMenuItem.separator())

        // Items section
        let marioItemsHeader = NSMenuItem(title: "Items", action: nil, keyEquivalent: "")
        marioItemsHeader.isEnabled = false
        marioSubmenu.addItem(marioItemsHeader)
        for item in marioItems {
            let menuItem = NSMenuItem(title: "  \(item.displayName)", action: #selector(selectCharacter(_:)), keyEquivalent: "")
            menuItem.target = self
            menuItem.representedObject = SelectableCharacter.marioItem(item)
            if case .marioItem(let m) = spriteAnimator.currentPokemon, m == item {
                menuItem.state = .on
            }
            marioSubmenu.addItem(menuItem)
        }

        let marioMenuItem = NSMenuItem(title: "Super Mario Bros", action: nil, keyEquivalent: "")
        marioMenuItem.submenu = marioSubmenu
        if case .marioItem(_) = spriteAnimator.currentPokemon {
            marioMenuItem.state = .on
        }
        menu.addItem(marioMenuItem)

        // Mario Kart submenu
        let kartSubmenu = NSMenu()
        let kartCharsHeader = NSMenuItem(title: "Racers", action: nil, keyEquivalent: "")
        kartCharsHeader.isEnabled = false
        kartSubmenu.addItem(kartCharsHeader)
        for char in marioKartList {
            let item = NSMenuItem(title: "  \(char.displayName)", action: #selector(selectCharacter(_:)), keyEquivalent: "")
            item.target = self
            item.representedObject = SelectableCharacter.marioKart(char)
            if case .marioKart(let k) = spriteAnimator.currentPokemon, k == char {
                item.state = .on
            }
            kartSubmenu.addItem(item)
        }
        kartSubmenu.addItem(NSMenuItem.separator())
        let kartItemsHeader = NSMenuItem(title: "Items", action: nil, keyEquivalent: "")
        kartItemsHeader.isEnabled = false
        kartSubmenu.addItem(kartItemsHeader)
        for item in marioKartItems {
            let mi = NSMenuItem(title: "  \(item.displayName)", action: #selector(selectCharacter(_:)), keyEquivalent: "")
            mi.target = self
            mi.representedObject = SelectableCharacter.marioKart(item)
            if case .marioKart(let k) = spriteAnimator.currentPokemon, k == item {
                mi.state = .on
            }
            kartSubmenu.addItem(mi)
        }
        let kartMenuItem = NSMenuItem(title: "Mario Kart", action: nil, keyEquivalent: "")
        kartMenuItem.submenu = kartSubmenu
        if case .marioKart(_) = spriteAnimator.currentPokemon {
            kartMenuItem.state = .on
        }
        menu.addItem(kartMenuItem)

        // Contra submenu
        let contraSubmenu = NSMenu()

        // Characters section
        let contraCharsHeader = NSMenuItem(title: "Characters", action: nil, keyEquivalent: "")
        contraCharsHeader.isEnabled = false
        contraSubmenu.addItem(contraCharsHeader)
        for char in contraCharacters {
            let item = NSMenuItem(title: "  \(char.displayName)", action: #selector(selectCharacter(_:)), keyEquivalent: "")
            item.target = self
            item.representedObject = SelectableCharacter.contra(char)
            if case .contra(let c) = spriteAnimator.currentPokemon, c == char {
                item.state = .on
            }
            contraSubmenu.addItem(item)
        }

        contraSubmenu.addItem(NSMenuItem.separator())

        // Weapons section
        let contraWeaponsHeader = NSMenuItem(title: "Weapons", action: nil, keyEquivalent: "")
        contraWeaponsHeader.isEnabled = false
        contraSubmenu.addItem(contraWeaponsHeader)
        for item in contraItems {
            let menuItem = NSMenuItem(title: "  \(item.displayName)", action: #selector(selectCharacter(_:)), keyEquivalent: "")
            menuItem.target = self
            menuItem.representedObject = SelectableCharacter.contra(item)
            if case .contra(let c) = spriteAnimator.currentPokemon, c == item {
                menuItem.state = .on
            }
            contraSubmenu.addItem(menuItem)
        }

        contraSubmenu.addItem(NSMenuItem.separator())

        // Enemies section
        let contraEnemiesHeader = NSMenuItem(title: "Enemies", action: nil, keyEquivalent: "")
        contraEnemiesHeader.isEnabled = false
        contraSubmenu.addItem(contraEnemiesHeader)
        for item in contraEnemies {
            let menuItem = NSMenuItem(title: "  \(item.displayName)", action: #selector(selectCharacter(_:)), keyEquivalent: "")
            menuItem.target = self
            menuItem.representedObject = SelectableCharacter.contra(item)
            if case .contra(let c) = spriteAnimator.currentPokemon, c == item {
                menuItem.state = .on
            }
            contraSubmenu.addItem(menuItem)
        }

        let contraMenuItem = NSMenuItem(title: "Contra", action: nil, keyEquivalent: "")
        contraMenuItem.submenu = contraSubmenu
        if case .contra(_) = spriteAnimator.currentPokemon {
            contraMenuItem.state = .on
        }
        menu.addItem(contraMenuItem)

        // TMNT submenu
        let tmntSubmenu = NSMenu()

        // Heroes section
        let tmntHeroesHeader = NSMenuItem(title: "Heroes", action: nil, keyEquivalent: "")
        tmntHeroesHeader.isEnabled = false
        tmntSubmenu.addItem(tmntHeroesHeader)
        for char in tmntCharacters {
            let item = NSMenuItem(title: "  \(char.displayName)", action: #selector(selectCharacter(_:)), keyEquivalent: "")
            item.target = self
            item.representedObject = SelectableCharacter.tmnt(char)
            if case .tmnt(let t) = spriteAnimator.currentPokemon, t == char {
                item.state = .on
            }
            tmntSubmenu.addItem(item)
        }

        tmntSubmenu.addItem(NSMenuItem.separator())

        // Villains section
        let tmntVillainsHeader = NSMenuItem(title: "Villains", action: nil, keyEquivalent: "")
        tmntVillainsHeader.isEnabled = false
        tmntSubmenu.addItem(tmntVillainsHeader)
        for item in tmntEnemies {
            let menuItem = NSMenuItem(title: "  \(item.displayName)", action: #selector(selectCharacter(_:)), keyEquivalent: "")
            menuItem.target = self
            menuItem.representedObject = SelectableCharacter.tmnt(item)
            if case .tmnt(let t) = spriteAnimator.currentPokemon, t == item {
                menuItem.state = .on
            }
            tmntSubmenu.addItem(menuItem)
        }

        let tmntMenuItem = NSMenuItem(title: "TMNT", action: nil, keyEquivalent: "")
        tmntMenuItem.submenu = tmntSubmenu
        if case .tmnt(_) = spriteAnimator.currentPokemon {
            tmntMenuItem.state = .on
        }
        menu.addItem(tmntMenuItem)

        // Street Fighter submenu
        let sfSubmenu = NSMenu()

        // Fighters section
        let sfFightersHeader = NSMenuItem(title: "Fighters", action: nil, keyEquivalent: "")
        sfFightersHeader.isEnabled = false
        sfSubmenu.addItem(sfFightersHeader)
        for char in streetFighterCharacters {
            let item = NSMenuItem(title: "  \(char.displayName)", action: #selector(selectCharacter(_:)), keyEquivalent: "")
            item.target = self
            item.representedObject = SelectableCharacter.streetFighter(char)
            if case .streetFighter(let s) = spriteAnimator.currentPokemon, s == char {
                item.state = .on
            }
            sfSubmenu.addItem(item)
        }

        sfSubmenu.addItem(NSMenuItem.separator())

        // Bosses section
        let sfBossesHeader = NSMenuItem(title: "Bosses", action: nil, keyEquivalent: "")
        sfBossesHeader.isEnabled = false
        sfSubmenu.addItem(sfBossesHeader)
        for item in streetFighterBosses {
            let menuItem = NSMenuItem(title: "  \(item.displayName)", action: #selector(selectCharacter(_:)), keyEquivalent: "")
            menuItem.target = self
            menuItem.representedObject = SelectableCharacter.streetFighter(item)
            if case .streetFighter(let s) = spriteAnimator.currentPokemon, s == item {
                menuItem.state = .on
            }
            sfSubmenu.addItem(menuItem)
        }

        let sfMenuItem = NSMenuItem(title: "Street Fighter", action: nil, keyEquivalent: "")
        sfMenuItem.submenu = sfSubmenu
        if case .streetFighter(_) = spriteAnimator.currentPokemon {
            sfMenuItem.state = .on
        }
        menu.addItem(sfMenuItem)

        // Metal Slug submenu
        let msSubmenu = NSMenu()

        // Heroes section
        let msHeroesHeader = NSMenuItem(title: "Heroes", action: nil, keyEquivalent: "")
        msHeroesHeader.isEnabled = false
        msSubmenu.addItem(msHeroesHeader)
        for char in metalSlugCharacters {
            let item = NSMenuItem(title: "  \(char.displayName)", action: #selector(selectCharacter(_:)), keyEquivalent: "")
            item.target = self
            item.representedObject = SelectableCharacter.metalSlug(char)
            if case .metalSlug(let m) = spriteAnimator.currentPokemon, m == char {
                item.state = .on
            }
            msSubmenu.addItem(item)
        }

        msSubmenu.addItem(NSMenuItem.separator())

        // Vehicles section
        let msVehiclesHeader = NSMenuItem(title: "Vehicles", action: nil, keyEquivalent: "")
        msVehiclesHeader.isEnabled = false
        msSubmenu.addItem(msVehiclesHeader)
        for item in metalSlugVehicles {
            let menuItem = NSMenuItem(title: "  \(item.displayName)", action: #selector(selectCharacter(_:)), keyEquivalent: "")
            menuItem.target = self
            menuItem.representedObject = SelectableCharacter.metalSlug(item)
            if case .metalSlug(let m) = spriteAnimator.currentPokemon, m == item {
                menuItem.state = .on
            }
            msSubmenu.addItem(menuItem)
        }

        msSubmenu.addItem(NSMenuItem.separator())

        // Enemies section
        let msEnemiesHeader = NSMenuItem(title: "Enemies", action: nil, keyEquivalent: "")
        msEnemiesHeader.isEnabled = false
        msSubmenu.addItem(msEnemiesHeader)
        for item in metalSlugEnemies {
            let menuItem = NSMenuItem(title: "  \(item.displayName)", action: #selector(selectCharacter(_:)), keyEquivalent: "")
            menuItem.target = self
            menuItem.representedObject = SelectableCharacter.metalSlug(item)
            if case .metalSlug(let m) = spriteAnimator.currentPokemon, m == item {
                menuItem.state = .on
            }
            msSubmenu.addItem(menuItem)
        }

        let msMenuItem = NSMenuItem(title: "Metal Slug", action: nil, keyEquivalent: "")
        msMenuItem.submenu = msSubmenu
        if case .metalSlug(_) = spriteAnimator.currentPokemon {
            msMenuItem.state = .on
        }
        menu.addItem(msMenuItem)

        // Overwatch submenu
        let owSubmenu = NSMenu()

        // DPS section
        let owDPSHeader = NSMenuItem(title: "DPS", action: nil, keyEquivalent: "")
        owDPSHeader.isEnabled = false
        owSubmenu.addItem(owDPSHeader)
        for char in overwatchDPS {
            let item = NSMenuItem(title: "  \(char.displayName)", action: #selector(selectCharacter(_:)), keyEquivalent: "")
            item.target = self
            item.representedObject = SelectableCharacter.overwatch(char)
            if case .overwatch(let o) = spriteAnimator.currentPokemon, o == char {
                item.state = .on
            }
            owSubmenu.addItem(item)
        }

        owSubmenu.addItem(NSMenuItem.separator())

        // Tank section
        let owTankHeader = NSMenuItem(title: "Tank", action: nil, keyEquivalent: "")
        owTankHeader.isEnabled = false
        owSubmenu.addItem(owTankHeader)
        for item in overwatchTank {
            let menuItem = NSMenuItem(title: "  \(item.displayName)", action: #selector(selectCharacter(_:)), keyEquivalent: "")
            menuItem.target = self
            menuItem.representedObject = SelectableCharacter.overwatch(item)
            if case .overwatch(let o) = spriteAnimator.currentPokemon, o == item {
                menuItem.state = .on
            }
            owSubmenu.addItem(menuItem)
        }

        owSubmenu.addItem(NSMenuItem.separator())

        // Support section
        let owSupportHeader = NSMenuItem(title: "Support", action: nil, keyEquivalent: "")
        owSupportHeader.isEnabled = false
        owSubmenu.addItem(owSupportHeader)
        for item in overwatchSupport {
            let menuItem = NSMenuItem(title: "  \(item.displayName)", action: #selector(selectCharacter(_:)), keyEquivalent: "")
            menuItem.target = self
            menuItem.representedObject = SelectableCharacter.overwatch(item)
            if case .overwatch(let o) = spriteAnimator.currentPokemon, o == item {
                menuItem.state = .on
            }
            owSubmenu.addItem(menuItem)
        }

        let owMenuItem = NSMenuItem(title: "Overwatch", action: nil, keyEquivalent: "")
        owMenuItem.submenu = owSubmenu
        if case .overwatch(_) = spriteAnimator.currentPokemon {
            owMenuItem.state = .on
        }
        menu.addItem(owMenuItem)

        // Kirby submenu
        let kirbySubmenu = NSMenu()

        // Heroes section
        let kirbyHeroesHeader = NSMenuItem(title: "Heroes", action: nil, keyEquivalent: "")
        kirbyHeroesHeader.isEnabled = false
        kirbySubmenu.addItem(kirbyHeroesHeader)
        for char in kirbyCharacters {
            let item = NSMenuItem(title: "  \(char.displayName)", action: #selector(selectCharacter(_:)), keyEquivalent: "")
            item.target = self
            item.representedObject = SelectableCharacter.kirby(char)
            if case .kirby(let k) = spriteAnimator.currentPokemon, k == char {
                item.state = .on
            }
            kirbySubmenu.addItem(item)
        }

        kirbySubmenu.addItem(NSMenuItem.separator())

        // Enemies section
        let kirbyEnemiesHeader = NSMenuItem(title: "Enemies", action: nil, keyEquivalent: "")
        kirbyEnemiesHeader.isEnabled = false
        kirbySubmenu.addItem(kirbyEnemiesHeader)
        for item in kirbyEnemies {
            let menuItem = NSMenuItem(title: "  \(item.displayName)", action: #selector(selectCharacter(_:)), keyEquivalent: "")
            menuItem.target = self
            menuItem.representedObject = SelectableCharacter.kirby(item)
            if case .kirby(let k) = spriteAnimator.currentPokemon, k == item {
                menuItem.state = .on
            }
            kirbySubmenu.addItem(menuItem)
        }

        let kirbyMenuItem = NSMenuItem(title: "Kirby", action: nil, keyEquivalent: "")
        kirbyMenuItem.submenu = kirbySubmenu
        if case .kirby(_) = spriteAnimator.currentPokemon {
            kirbyMenuItem.state = .on
        }
        menu.addItem(kirbyMenuItem)

        // Legend of Zelda submenu
        let zeldaSubmenu = NSMenu()

        // Heroes section
        let zeldaHeroesHeader = NSMenuItem(title: "Heroes", action: nil, keyEquivalent: "")
        zeldaHeroesHeader.isEnabled = false
        zeldaSubmenu.addItem(zeldaHeroesHeader)
        for char in zeldaHeroes {
            let item = NSMenuItem(title: "  \(char.displayName)", action: #selector(selectCharacter(_:)), keyEquivalent: "")
            item.target = self
            item.representedObject = SelectableCharacter.zelda(char)
            if case .zelda(let z) = spriteAnimator.currentPokemon, z == char {
                item.state = .on
            }
            zeldaSubmenu.addItem(item)
        }

        zeldaSubmenu.addItem(NSMenuItem.separator())

        // Enemies section
        let zeldaEnemiesHeader = NSMenuItem(title: "Enemies", action: nil, keyEquivalent: "")
        zeldaEnemiesHeader.isEnabled = false
        zeldaSubmenu.addItem(zeldaEnemiesHeader)
        for item in zeldaEnemies {
            let menuItem = NSMenuItem(title: "  \(item.displayName)", action: #selector(selectCharacter(_:)), keyEquivalent: "")
            menuItem.target = self
            menuItem.representedObject = SelectableCharacter.zelda(item)
            if case .zelda(let z) = spriteAnimator.currentPokemon, z == item {
                menuItem.state = .on
            }
            zeldaSubmenu.addItem(menuItem)
        }

        let zeldaMenuItem = NSMenuItem(title: "Legend of Zelda", action: nil, keyEquivalent: "")
        zeldaMenuItem.submenu = zeldaSubmenu
        if case .zelda(_) = spriteAnimator.currentPokemon {
            zeldaMenuItem.state = .on
        }
        menu.addItem(zeldaMenuItem)

        // Mega Man submenu
        let mmSubmenu = NSMenu()
        let mmHeroesHeader = NSMenuItem(title: "Characters", action: nil, keyEquivalent: "")
        mmHeroesHeader.isEnabled = false
        mmSubmenu.addItem(mmHeroesHeader)
        for char in megaManCharacters {
            let item = NSMenuItem(title: "  \(char.displayName)", action: #selector(selectCharacter(_:)), keyEquivalent: "")
            item.target = self
            item.representedObject = SelectableCharacter.megaMan(char)
            if case .megaMan(let m) = spriteAnimator.currentPokemon, m == char {
                item.state = .on
            }
            mmSubmenu.addItem(item)
        }
        mmSubmenu.addItem(NSMenuItem.separator())
        let mmBossHeader = NSMenuItem(title: "Bosses", action: nil, keyEquivalent: "")
        mmBossHeader.isEnabled = false
        mmSubmenu.addItem(mmBossHeader)
        for boss in megaManBosses {
            let item = NSMenuItem(title: "  \(boss.displayName)", action: #selector(selectCharacter(_:)), keyEquivalent: "")
            item.target = self
            item.representedObject = SelectableCharacter.megaMan(boss)
            if case .megaMan(let m) = spriteAnimator.currentPokemon, m == boss {
                item.state = .on
            }
            mmSubmenu.addItem(item)
        }
        let mmMenuItem = NSMenuItem(title: "Mega Man", action: nil, keyEquivalent: "")
        mmMenuItem.submenu = mmSubmenu
        if case .megaMan(_) = spriteAnimator.currentPokemon {
            mmMenuItem.state = .on
        }
        menu.addItem(mmMenuItem)

        // Marvel submenu
        let mvSubmenu = NSMenu()
        let mvHeroesHeader = NSMenuItem(title: "Heroes", action: nil, keyEquivalent: "")
        mvHeroesHeader.isEnabled = false
        mvSubmenu.addItem(mvHeroesHeader)
        for char in marvelCharacters {
            let item = NSMenuItem(title: "  \(char.displayName)", action: #selector(selectCharacter(_:)), keyEquivalent: "")
            item.target = self
            item.representedObject = SelectableCharacter.marvel(char)
            if case .marvel(let m) = spriteAnimator.currentPokemon, m == char {
                item.state = .on
            }
            mvSubmenu.addItem(item)
        }
        mvSubmenu.addItem(NSMenuItem.separator())
        let mvVillainsHeader = NSMenuItem(title: "Villains", action: nil, keyEquivalent: "")
        mvVillainsHeader.isEnabled = false
        mvSubmenu.addItem(mvVillainsHeader)
        for villain in marvelVillains {
            let item = NSMenuItem(title: "  \(villain.displayName)", action: #selector(selectCharacter(_:)), keyEquivalent: "")
            item.target = self
            item.representedObject = SelectableCharacter.marvel(villain)
            if case .marvel(let m) = spriteAnimator.currentPokemon, m == villain {
                item.state = .on
            }
            mvSubmenu.addItem(item)
        }
        let mvMenuItem = NSMenuItem(title: "Marvel", action: nil, keyEquivalent: "")
        mvMenuItem.submenu = mvSubmenu
        menu.addItem(mvMenuItem)

        // DC submenu
        let dcSubmenu = NSMenu()
        let dcHeroesHeader = NSMenuItem(title: "Heroes", action: nil, keyEquivalent: "")
        dcHeroesHeader.isEnabled = false
        dcSubmenu.addItem(dcHeroesHeader)
        for char in dcCharacters {
            let item = NSMenuItem(title: "  \(char.displayName)", action: #selector(selectCharacter(_:)), keyEquivalent: "")
            item.target = self
            item.representedObject = SelectableCharacter.dc(char)
            if case .dc(let d) = spriteAnimator.currentPokemon, d == char {
                item.state = .on
            }
            dcSubmenu.addItem(item)
        }
        dcSubmenu.addItem(NSMenuItem.separator())
        let dcVillainsHeader = NSMenuItem(title: "Villains", action: nil, keyEquivalent: "")
        dcVillainsHeader.isEnabled = false
        dcSubmenu.addItem(dcVillainsHeader)
        for villain in dcVillains {
            let item = NSMenuItem(title: "  \(villain.displayName)", action: #selector(selectCharacter(_:)), keyEquivalent: "")
            item.target = self
            item.representedObject = SelectableCharacter.dc(villain)
            if case .dc(let d) = spriteAnimator.currentPokemon, d == villain {
                item.state = .on
            }
            dcSubmenu.addItem(item)
        }
        let dcMenuItem = NSMenuItem(title: "DC Comics", action: nil, keyEquivalent: "")
        dcMenuItem.submenu = dcSubmenu
        if case .dc(_) = spriteAnimator.currentPokemon {
            dcMenuItem.state = .on
        }
        menu.addItem(dcMenuItem)

        // Naruto submenu
        let narutoSubmenu = NSMenu()
        let narutoHeroesHeader = NSMenuItem(title: "Heroes", action: nil, keyEquivalent: "")
        narutoHeroesHeader.isEnabled = false
        narutoSubmenu.addItem(narutoHeroesHeader)
        for char in narutoCharacters {
            let item = NSMenuItem(title: "  \(char.displayName)", action: #selector(selectCharacter(_:)), keyEquivalent: "")
            item.target = self
            item.representedObject = SelectableCharacter.naruto(char)
            if case .naruto(let n) = spriteAnimator.currentPokemon, n == char {
                item.state = .on
            }
            narutoSubmenu.addItem(item)
        }
        narutoSubmenu.addItem(NSMenuItem.separator())
        let narutoVillainsHeader = NSMenuItem(title: "Others", action: nil, keyEquivalent: "")
        narutoVillainsHeader.isEnabled = false
        narutoSubmenu.addItem(narutoVillainsHeader)
        for villain in narutoVillains {
            let item = NSMenuItem(title: "  \(villain.displayName)", action: #selector(selectCharacter(_:)), keyEquivalent: "")
            item.target = self
            item.representedObject = SelectableCharacter.naruto(villain)
            if case .naruto(let n) = spriteAnimator.currentPokemon, n == villain {
                item.state = .on
            }
            narutoSubmenu.addItem(item)
        }
        let narutoMenuItem = NSMenuItem(title: "Naruto", action: nil, keyEquivalent: "")
        narutoMenuItem.submenu = narutoSubmenu
        if case .naruto(_) = spriteAnimator.currentPokemon {
            narutoMenuItem.state = .on
        }
        menu.addItem(narutoMenuItem)

        // Simpsons submenu
        let simpsonsSubmenu = NSMenu()
        let simpsonsMainHeader = NSMenuItem(title: "Main Family", action: nil, keyEquivalent: "")
        simpsonsMainHeader.isEnabled = false
        simpsonsSubmenu.addItem(simpsonsMainHeader)
        for char in simpsonsCharacters {
            let item = NSMenuItem(title: "  \(char.displayName)", action: #selector(selectCharacter(_:)), keyEquivalent: "")
            item.target = self
            item.representedObject = SelectableCharacter.simpsons(char)
            if case .simpsons(let s) = spriteAnimator.currentPokemon, s == char {
                item.state = .on
            }
            simpsonsSubmenu.addItem(item)
        }
        simpsonsSubmenu.addItem(NSMenuItem.separator())
        let simpsonsOthersHeader = NSMenuItem(title: "Others", action: nil, keyEquivalent: "")
        simpsonsOthersHeader.isEnabled = false
        simpsonsSubmenu.addItem(simpsonsOthersHeader)
        for other in simpsonsOthers {
            let item = NSMenuItem(title: "  \(other.displayName)", action: #selector(selectCharacter(_:)), keyEquivalent: "")
            item.target = self
            item.representedObject = SelectableCharacter.simpsons(other)
            if case .simpsons(let s) = spriteAnimator.currentPokemon, s == other {
                item.state = .on
            }
            simpsonsSubmenu.addItem(item)
        }
        let simpsonsMenuItem = NSMenuItem(title: "The Simpsons", action: nil, keyEquivalent: "")
        simpsonsMenuItem.submenu = simpsonsSubmenu
        if case .simpsons(_) = spriteAnimator.currentPokemon {
            simpsonsMenuItem.state = .on
        }
        menu.addItem(simpsonsMenuItem)

        // Mortal Kombat submenu
        let mkSubmenu = NSMenu()
        let mkHeroesHeader = NSMenuItem(title: "Fighters", action: nil, keyEquivalent: "")
        mkHeroesHeader.isEnabled = false
        mkSubmenu.addItem(mkHeroesHeader)
        for char in mkCharacters {
            let item = NSMenuItem(title: "  \(char.displayName)", action: #selector(selectCharacter(_:)), keyEquivalent: "")
            item.target = self
            item.representedObject = SelectableCharacter.mortalKombat(char)
            if case .mortalKombat(let m) = spriteAnimator.currentPokemon, m == char {
                item.state = .on
            }
            mkSubmenu.addItem(item)
        }
        mkSubmenu.addItem(NSMenuItem.separator())
        let mkVillainsHeader = NSMenuItem(title: "Villains", action: nil, keyEquivalent: "")
        mkVillainsHeader.isEnabled = false
        mkSubmenu.addItem(mkVillainsHeader)
        for villain in mkVillains {
            let item = NSMenuItem(title: "  \(villain.displayName)", action: #selector(selectCharacter(_:)), keyEquivalent: "")
            item.target = self
            item.representedObject = SelectableCharacter.mortalKombat(villain)
            if case .mortalKombat(let m) = spriteAnimator.currentPokemon, m == villain {
                item.state = .on
            }
            mkSubmenu.addItem(item)
        }
        let mkMenuItem = NSMenuItem(title: "Mortal Kombat", action: nil, keyEquivalent: "")
        mkMenuItem.submenu = mkSubmenu
        if case .mortalKombat(_) = spriteAnimator.currentPokemon {
            mkMenuItem.state = .on
        }
        menu.addItem(mkMenuItem)

        // Minions submenu
        let minionsSubmenu = NSMenu()
        for char in minionsList {
            let item = NSMenuItem(title: char.displayName, action: #selector(selectCharacter(_:)), keyEquivalent: "")
            item.target = self
            item.representedObject = SelectableCharacter.minions(char)
            if case .minions(let m) = spriteAnimator.currentPokemon, m == char {
                item.state = .on
            }
            minionsSubmenu.addItem(item)
        }
        let minionsMenuItem = NSMenuItem(title: "Minions", action: nil, keyEquivalent: "")
        minionsMenuItem.submenu = minionsSubmenu
        if case .minions(_) = spriteAnimator.currentPokemon {
            minionsMenuItem.state = .on
        }
        menu.addItem(minionsMenuItem)

        // Dragon Ball submenu
        let dbSubmenu = NSMenu()
        for char in dragonBallCharacters {
            let item = NSMenuItem(title: char.displayName, action: #selector(selectCharacter(_:)), keyEquivalent: "")
            item.target = self
            item.representedObject = SelectableCharacter.dragonBall(char)
            if case .dragonBall(let d) = spriteAnimator.currentPokemon, d == char {
                item.state = .on
            }
            dbSubmenu.addItem(item)
        }
        let dbMenuItem = NSMenuItem(title: "Dragon Ball", action: nil, keyEquivalent: "")
        dbMenuItem.submenu = dbSubmenu
        if case .dragonBall(_) = spriteAnimator.currentPokemon {
            dbMenuItem.state = .on
        }
        menu.addItem(dbMenuItem)

        // Ghibli submenu
        let ghSubmenu = NSMenu()
        for char in ghibliCharacters {
            let item = NSMenuItem(title: char.displayName, action: #selector(selectCharacter(_:)), keyEquivalent: "")
            item.target = self
            item.representedObject = SelectableCharacter.ghibli(char)
            if case .ghibli(let g) = spriteAnimator.currentPokemon, g == char {
                item.state = .on
            }
            ghSubmenu.addItem(item)
        }
        let ghMenuItem = NSMenuItem(title: "Studio Ghibli", action: nil, keyEquivalent: "")
        ghMenuItem.submenu = ghSubmenu
        menu.addItem(ghMenuItem)

        // Gundam submenu
        let gdSubmenu = NSMenu()
        for char in gundamCharacters {
            let item = NSMenuItem(title: char.displayName, action: #selector(selectCharacter(_:)), keyEquivalent: "")
            item.target = self
            item.representedObject = SelectableCharacter.gundam(char)
            if case .gundam(let g) = spriteAnimator.currentPokemon, g == char {
                item.state = .on
            }
            gdSubmenu.addItem(item)
        }
        let gdMenuItem = NSMenuItem(title: "Gundam", action: nil, keyEquivalent: "")
        gdMenuItem.submenu = gdSubmenu
        menu.addItem(gdMenuItem)

        // Star Wars submenu
        let swSubmenu = NSMenu()
        for char in starWarsCharacters {
            let item = NSMenuItem(title: char.displayName, action: #selector(selectCharacter(_:)), keyEquivalent: "")
            item.target = self
            item.representedObject = SelectableCharacter.starWars(char)
            if case .starWars(let s) = spriteAnimator.currentPokemon, s == char {
                item.state = .on
            }
            swSubmenu.addItem(item)
        }
        let swMenuItem = NSMenuItem(title: "Star Wars", action: nil, keyEquivalent: "")
        swMenuItem.submenu = swSubmenu
        if case .starWars(_) = spriteAnimator.currentPokemon {
            swMenuItem.state = .on
        }
        menu.addItem(swMenuItem)

        // Labubu submenu
        let labubuSubmenu = NSMenu()
        for char in labubuCharacters {
            let item = NSMenuItem(title: char.displayName, action: #selector(selectCharacter(_:)), keyEquivalent: "")
            item.target = self
            item.representedObject = SelectableCharacter.labubu(char)
            if case .labubu(let l) = spriteAnimator.currentPokemon, l == char {
                item.state = .on
            }
            labubuSubmenu.addItem(item)
        }
        let labubuMenuItem = NSMenuItem(title: "Labubu", action: nil, keyEquivalent: "")
        labubuMenuItem.submenu = labubuSubmenu
        if case .labubu(_) = spriteAnimator.currentPokemon {
            labubuMenuItem.state = .on
        }
        menu.addItem(labubuMenuItem)

        // King of the Hill submenu
        let kothSubmenu = NSMenu()
        let kothFamilyHeader = NSMenuItem(title: "The Hills", action: nil, keyEquivalent: "")
        kothFamilyHeader.isEnabled = false
        kothSubmenu.addItem(kothFamilyHeader)
        for char in kingOfTheHillFamily {
            let item = NSMenuItem(title: "  \(char.displayName)", action: #selector(selectCharacter(_:)), keyEquivalent: "")
            item.target = self
            item.representedObject = SelectableCharacter.kingOfTheHill(char)
            if case .kingOfTheHill(let k) = spriteAnimator.currentPokemon, k == char {
                item.state = .on
            }
            kothSubmenu.addItem(item)
        }
        kothSubmenu.addItem(NSMenuItem.separator())
        let kothFriendsHeader = NSMenuItem(title: "Friends & Neighbors", action: nil, keyEquivalent: "")
        kothFriendsHeader.isEnabled = false
        kothSubmenu.addItem(kothFriendsHeader)
        for char in kingOfTheHillFriends {
            let item = NSMenuItem(title: "  \(char.displayName)", action: #selector(selectCharacter(_:)), keyEquivalent: "")
            item.target = self
            item.representedObject = SelectableCharacter.kingOfTheHill(char)
            if case .kingOfTheHill(let k) = spriteAnimator.currentPokemon, k == char {
                item.state = .on
            }
            kothSubmenu.addItem(item)
        }
        let kothMenuItem = NSMenuItem(title: "King of the Hill", action: nil, keyEquivalent: "")
        kothMenuItem.submenu = kothSubmenu
        if case .kingOfTheHill(_) = spriteAnimator.currentPokemon {
            kothMenuItem.state = .on
        }
        menu.addItem(kothMenuItem)

        // Family Guy submenu
        let fgSubmenu = NSMenu()
        let fgFamilyHeader = NSMenuItem(title: "The Griffins", action: nil, keyEquivalent: "")
        fgFamilyHeader.isEnabled = false
        fgSubmenu.addItem(fgFamilyHeader)
        for char in familyGuyFamily {
            let item = NSMenuItem(title: "  \(char.displayName)", action: #selector(selectCharacter(_:)), keyEquivalent: "")
            item.target = self
            item.representedObject = SelectableCharacter.familyGuy(char)
            if case .familyGuy(let f) = spriteAnimator.currentPokemon, f == char {
                item.state = .on
            }
            fgSubmenu.addItem(item)
        }
        fgSubmenu.addItem(NSMenuItem.separator())
        let fgFriendsHeader = NSMenuItem(title: "Quahog Residents", action: nil, keyEquivalent: "")
        fgFriendsHeader.isEnabled = false
        fgSubmenu.addItem(fgFriendsHeader)
        for char in familyGuyFriends {
            let item = NSMenuItem(title: "  \(char.displayName)", action: #selector(selectCharacter(_:)), keyEquivalent: "")
            item.target = self
            item.representedObject = SelectableCharacter.familyGuy(char)
            if case .familyGuy(let f) = spriteAnimator.currentPokemon, f == char {
                item.state = .on
            }
            fgSubmenu.addItem(item)
        }
        let fgMenuItem = NSMenuItem(title: "Family Guy", action: nil, keyEquivalent: "")
        fgMenuItem.submenu = fgSubmenu
        if case .familyGuy(_) = spriteAnimator.currentPokemon {
            fgMenuItem.state = .on
        }
        menu.addItem(fgMenuItem)

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
                let item = NSMenuItem(title: character.displayName, action: #selector(selectCharacter(_:)), keyEquivalent: "")
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
                item.title = "\(spriteAnimator.currentPokemon.emoji) \(spriteAnimator.currentPokemon.displayName)"
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
    
    private func downloadAndInstall(from url: String) {
        let alert = NSAlert()
        alert.messageText = "Downloading Update"
        alert.informativeText = "Please wait while the update is being downloaded..."
        alert.addButton(withTitle: "Cancel")
        alert.runModal()
        
        UpdateChecker.shared.downloadAndInstallUpdate(from: url)
    }
    
    @objc func quitApp() {
        NSApplication.shared.terminate(nil)
    }
}
