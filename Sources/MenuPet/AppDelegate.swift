import AppKit
import ServiceManagement

class ChatTextView: NSTextView {
    override var acceptsFirstResponder: Bool { true }
    override func mouseDown(with event: NSEvent) {
        super.mouseDown(with: event)
        window?.makeFirstResponder(self)
    }
    override func performKeyEquivalent(with event: NSEvent) -> Bool {
        let flags = event.modifierFlags.intersection(.deviceIndependentFlagsMask)
        if flags == .command, let chars = event.charactersIgnoringModifiers {
            switch chars {
            case "c": copy(nil); return true
            case "v": paste(nil); return true
            case "a": selectAll(nil); return true
            case "x": cut(nil); return true
            default: break
            }
        }
        return super.performKeyEquivalent(with: event)
    }
}

class ChatInputField: NSTextField {
    override func keyDown(with event: NSEvent) {
        let flags = event.modifierFlags.intersection(.deviceIndependentFlagsMask)
        if flags == .command, let chars = event.charactersIgnoringModifiers {
            switch chars {
            case "v":
                if let string = NSPasteboard.general.string(forType: .string) {
                    if let editor = currentEditor() as? NSTextView {
                        editor.insertText(string, replacementRange: editor.selectedRange)
                    }
                    return
                }
            case "c":
                super.keyDown(with: event)
                return
            case "a":
                super.keyDown(with: event)
                return
            case "x":
                super.keyDown(with: event)
                return
            default: break
            }
        }
        super.keyDown(with: event)
    }
}

class AppDelegate: NSObject, NSApplicationDelegate {
    var statusItem: NSStatusItem!
    var cpuMonitor: CPUMonitor!
    var spriteAnimator: SpriteAnimator!
    var updateCheckTimer: Timer?
    var petDecayTimer: Timer?
    var swarmChatWindow: NSPanel?
    var swarmChatTextView: NSScrollView?
    var swarmChatInputField: NSTextField?
    var petSubmenus: [SelectableCharacter: NSMenu] = [:]

    let pokemonList: [PokemonCharacter] = [
        .jigglypuff, .pikachu, .psyduck, .snorlax, .charmander, .bulbasaur, .squirtle,
        .meowth, .eevee, .mew, .gengar, .dragonite,
        .gyarados, .arcanine, .alakazam, .machamp, .golem, .onix,
        .jolteon, .flareon, .vaporeon, .porygon, .ditto, .lapras,
        .marill, .umbreon, .pokeball, .greatBall, .ultraBall, .masterBall
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
        .maul, .bobaFett, .c3po, .r2d2, .obiWan, .kyloRen, .stormtrooper, .grogu, .mandalorian
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

    let transformersCharacters: [TransformersCharacter] = [
        .optimusPrime, .bumblebee, .megatron, .starscream, .soundwave, .prowl, .jazz, .ironhide,
        .ratchet, .shockwave, .soundBlaster, .galvatron, .cyclonus, .devestator
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
        spriteAnimator.onFrameAdvanced = { [weak self] in
            self?.statusItem.button?.image = self?.spriteAnimator.currentFrame
        }
        spriteAnimator.onTransformStateChanged = { [weak self] in
            DispatchQueue.main.async { self?.buildMenu() }
        }

        MultiPetManager.shared.onSelectionChanged = { [weak self] in
            DispatchQueue.main.async { self?.buildMenu() }
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
                self?.updateStatusBarTitle()
            }
        }

        buildMenu()
        cpuMonitor.start()
        if PetServer.shared.isEnabled {
            PetServer.shared.start()
        }

        checkForUpdatesInBackground()
        updateCheckTimer = Timer.scheduledTimer(withTimeInterval: 86400, repeats: true) { [weak self] _ in
            self?.checkForUpdatesInBackground()
        }

        petDecayTimer = Timer.scheduledTimer(withTimeInterval: 60, repeats: true) { [weak self] _ in
            let manager = MultiPetManager.shared
            if manager.isMultiPetMode {
                manager.decayAll()
            } else {
                let personality = self?.spriteAnimator.currentPokemon.personality ?? .default
                PetState.shared.decay(personality: personality)
                let wasNotDisobedient = !PetState.shared.isDisobedient
                PetState.shared.checkDisobedience(personality: personality)
                if wasNotDisobedient && PetState.shared.isDisobedient && LLMService.shared.statusEnabled {
                    PetState.shared.lastAction = "disobedience"
                    LLMService.shared.invalidateCache()
                }
            }
            self?.buildMenu()
        }
    }

    func buildMenu() {
        let menu = NSMenu()
        let manager = MultiPetManager.shared

        menu.addItem(NSMenuItem(title: "MenuPet", action: nil, keyEquivalent: ""))

        if manager.isMultiPetMode {
            let headerItem = NSMenuItem(title: "🐾 Multi-Pet Mode (\(manager.petCount) pets)", action: nil, keyEquivalent: "")
            headerItem.isEnabled = false
            menu.addItem(headerItem)
        } else {
            let currentPokemonItem = NSMenuItem(title: "\(spriteAnimator.currentPokemon.emoji) \(spriteAnimator.currentPokemon.displayName) — \(spriteAnimator.currentPokemon.category)", action: #selector(searchCharacter(_:)), keyEquivalent: "")
            currentPokemonItem.tag = 300
            currentPokemonItem.target = self
            menu.addItem(currentPokemonItem)
        }

        let petSelectionSub = NSMenu()
        let selectAllItem = NSMenuItem(title: "Select All Pets", action: #selector(selectAllPets), keyEquivalent: "")
        selectAllItem.target = self
        petSelectionSub.addItem(selectAllItem)
        let clearAllItem = NSMenuItem(title: "Clear All Pets", action: #selector(clearAllPets), keyEquivalent: "")
        clearAllItem.target = self
        petSelectionSub.addItem(clearAllItem)
        petSelectionSub.addItem(NSMenuItem.separator())

        func addCharToSelectMenu(_ character: SelectableCharacter, to sub: NSMenu) {
            let item = NSMenuItem(title: "\(character.emoji) \(character.displayName)", action: #selector(togglePetSelection(_:)), keyEquivalent: "")
            item.target = self
            item.representedObject = character
            item.state = manager.isSelected(character) ? .on : .off
            if manager.isSelected(character) && manager.primaryPet == character {
                item.title = "\(character.emoji) \(character.displayName) ★"
            }
            sub.addItem(item)
        }

        func addCharToSelectSubmenu(_ character: SelectableCharacter, to sub: NSMenu) {
            let item = NSMenuItem(title: "\(character.emoji) \(character.displayName)", action: #selector(togglePetSelection(_:)), keyEquivalent: "")
            item.target = self
            item.representedObject = character
            item.state = manager.isSelected(character) ? .on : .off
            if manager.isSelected(character) && manager.primaryPet == character {
                item.title = "\(character.emoji) \(character.displayName) ★"
            }
            sub.addItem(item)
        }

        let mpGamesMenu = NSMenu()
        let mpAnimeMenu = NSMenu()
        let mpMoviesTVMenu = NSMenu()

        // Pokémon
        let mpPokemonSub = NSMenu()
        for c in PokemonCharacter.allCases.map({ SelectableCharacter.pokemon($0) }) { addCharToSelectSubmenu(c, to: mpPokemonSub) }
        let mpPokemonMI = NSMenuItem(title: "Pokémon", action: nil, keyEquivalent: "")
        mpPokemonMI.submenu = mpPokemonSub
        mpGamesMenu.addItem(mpPokemonMI)

        // Super Mario Bros
        let mpMarioSub = NSMenu()
        for c in marioCharacters.map({ SelectableCharacter.marioItem($0) }) { addCharToSelectSubmenu(c, to: mpMarioSub) }
        mpMarioSub.addItem(NSMenuItem.separator())
        for c in marioItems.map({ SelectableCharacter.marioItem($0) }) { addCharToSelectSubmenu(c, to: mpMarioSub) }
        let mpMarioMI = NSMenuItem(title: "Super Mario Bros", action: nil, keyEquivalent: "")
        mpMarioMI.submenu = mpMarioSub
        mpGamesMenu.addItem(mpMarioMI)

        // Mario Kart
        let mpKartSub = NSMenu()
        for c in marioKartList.map({ SelectableCharacter.marioKart($0) }) { addCharToSelectSubmenu(c, to: mpKartSub) }
        mpKartSub.addItem(NSMenuItem.separator())
        for c in marioKartItems.map({ SelectableCharacter.marioKart($0) }) { addCharToSelectSubmenu(c, to: mpKartSub) }
        let mpKartMI = NSMenuItem(title: "Mario Kart", action: nil, keyEquivalent: "")
        mpKartMI.submenu = mpKartSub
        mpGamesMenu.addItem(mpKartMI)

        // Kirby
        let mpKirbySub = NSMenu()
        for c in kirbyCharacters.map({ SelectableCharacter.kirby($0) }) { addCharToSelectSubmenu(c, to: mpKirbySub) }
        mpKirbySub.addItem(NSMenuItem.separator())
        for c in kirbyEnemies.map({ SelectableCharacter.kirby($0) }) { addCharToSelectSubmenu(c, to: mpKirbySub) }
        let mpKirbyMI = NSMenuItem(title: "Kirby", action: nil, keyEquivalent: "")
        mpKirbyMI.submenu = mpKirbySub
        mpGamesMenu.addItem(mpKirbyMI)

        // Legend of Zelda
        let mpZeldaSub = NSMenu()
        for c in zeldaHeroes.map({ SelectableCharacter.zelda($0) }) { addCharToSelectSubmenu(c, to: mpZeldaSub) }
        mpZeldaSub.addItem(NSMenuItem.separator())
        for c in zeldaEnemies.map({ SelectableCharacter.zelda($0) }) { addCharToSelectSubmenu(c, to: mpZeldaSub) }
        let mpZeldaMI = NSMenuItem(title: "Legend of Zelda", action: nil, keyEquivalent: "")
        mpZeldaMI.submenu = mpZeldaSub
        mpGamesMenu.addItem(mpZeldaMI)

        // Mega Man
        let mpMMSub = NSMenu()
        for c in megaManCharacters.map({ SelectableCharacter.megaMan($0) }) { addCharToSelectSubmenu(c, to: mpMMSub) }
        mpMMSub.addItem(NSMenuItem.separator())
        for c in megaManBosses.map({ SelectableCharacter.megaMan($0) }) { addCharToSelectSubmenu(c, to: mpMMSub) }
        let mpMMMI = NSMenuItem(title: "Mega Man", action: nil, keyEquivalent: "")
        mpMMMI.submenu = mpMMSub
        mpGamesMenu.addItem(mpMMMI)

        // Contra
        let mpContraSub = NSMenu()
        for c in contraCharacters.map({ SelectableCharacter.contra($0) }) { addCharToSelectSubmenu(c, to: mpContraSub) }
        mpContraSub.addItem(NSMenuItem.separator())
        for c in (contraItems + contraEnemies).map({ SelectableCharacter.contra($0) }) { addCharToSelectSubmenu(c, to: mpContraSub) }
        let mpContraMI = NSMenuItem(title: "Contra", action: nil, keyEquivalent: "")
        mpContraMI.submenu = mpContraSub
        mpGamesMenu.addItem(mpContraMI)

        // Metal Slug
        let mpMSSub = NSMenu()
        for c in metalSlugCharacters.map({ SelectableCharacter.metalSlug($0) }) { addCharToSelectSubmenu(c, to: mpMSSub) }
        mpMSSub.addItem(NSMenuItem.separator())
        for c in (metalSlugVehicles + metalSlugEnemies).map({ SelectableCharacter.metalSlug($0) }) { addCharToSelectSubmenu(c, to: mpMSSub) }
        let mpMSMI = NSMenuItem(title: "Metal Slug", action: nil, keyEquivalent: "")
        mpMSMI.submenu = mpMSSub
        mpGamesMenu.addItem(mpMSMI)

        // Street Fighter
        let mpSFSub = NSMenu()
        for c in streetFighterCharacters.map({ SelectableCharacter.streetFighter($0) }) { addCharToSelectSubmenu(c, to: mpSFSub) }
        mpSFSub.addItem(NSMenuItem.separator())
        for c in streetFighterBosses.map({ SelectableCharacter.streetFighter($0) }) { addCharToSelectSubmenu(c, to: mpSFSub) }
        let mpSFMI = NSMenuItem(title: "Street Fighter", action: nil, keyEquivalent: "")
        mpSFMI.submenu = mpSFSub
        mpGamesMenu.addItem(mpSFMI)

        // Mortal Kombat
        let mpMKSub = NSMenu()
        for c in MortalKombatCharacter.allCases.map({ SelectableCharacter.mortalKombat($0) }) { addCharToSelectSubmenu(c, to: mpMKSub) }
        let mpMKMI = NSMenuItem(title: "Mortal Kombat", action: nil, keyEquivalent: "")
        mpMKMI.submenu = mpMKSub
        mpGamesMenu.addItem(mpMKMI)

        // TMNT
        let mpTMNTSub = NSMenu()
        for c in TMNTCharacter.allCases.map({ SelectableCharacter.tmnt($0) }) { addCharToSelectSubmenu(c, to: mpTMNTSub) }
        let mpTMNTMI = NSMenuItem(title: "TMNT", action: nil, keyEquivalent: "")
        mpTMNTMI.submenu = mpTMNTSub
        mpGamesMenu.addItem(mpTMNTMI)

        // Overwatch
        let mpOWSub = NSMenu()
        for c in OverwatchCharacter.allCases.map({ SelectableCharacter.overwatch($0) }) { addCharToSelectSubmenu(c, to: mpOWSub) }
        let mpOWMI = NSMenuItem(title: "Overwatch", action: nil, keyEquivalent: "")
        mpOWMI.submenu = mpOWSub
        mpGamesMenu.addItem(mpOWMI)

        let mpGamesMI = NSMenuItem(title: "🎮 Video Games", action: nil, keyEquivalent: "")
        mpGamesMI.submenu = mpGamesMenu
        petSelectionSub.addItem(mpGamesMI)

        // Dragon Ball
        let mpDBSub = NSMenu()
        for c in dragonBallCharacters.map({ SelectableCharacter.dragonBall($0) }) { addCharToSelectSubmenu(c, to: mpDBSub) }
        let mpDBMI = NSMenuItem(title: "Dragon Ball", action: nil, keyEquivalent: "")
        mpDBMI.submenu = mpDBSub
        mpAnimeMenu.addItem(mpDBMI)

        // Naruto
        let mpNarutoSub = NSMenu()
        for c in NarutoCharacter.allCases.map({ SelectableCharacter.naruto($0) }) { addCharToSelectSubmenu(c, to: mpNarutoSub) }
        let mpNarutoMI = NSMenuItem(title: "Naruto", action: nil, keyEquivalent: "")
        mpNarutoMI.submenu = mpNarutoSub
        mpAnimeMenu.addItem(mpNarutoMI)

        // Gundam
        let mpGDSub = NSMenu()
        for c in GundamCharacter.allCases.map({ SelectableCharacter.gundam($0) }) { addCharToSelectSubmenu(c, to: mpGDSub) }
        let mpGDMI = NSMenuItem(title: "Gundam", action: nil, keyEquivalent: "")
        mpGDMI.submenu = mpGDSub
        mpAnimeMenu.addItem(mpGDMI)

        // Ghibli
        let mpGHSub = NSMenu()
        for c in GhibliCharacter.allCases.map({ SelectableCharacter.ghibli($0) }) { addCharToSelectSubmenu(c, to: mpGHSub) }
        let mpGHMI = NSMenuItem(title: "Studio Ghibli", action: nil, keyEquivalent: "")
        mpGHMI.submenu = mpGHSub
        mpAnimeMenu.addItem(mpGHMI)

        // Labubu
        let mpLabSub = NSMenu()
        for c in LabubuCharacter.allCases.map({ SelectableCharacter.labubu($0) }) { addCharToSelectSubmenu(c, to: mpLabSub) }
        let mpLabMI = NSMenuItem(title: "Labubu", action: nil, keyEquivalent: "")
        mpLabMI.submenu = mpLabSub
        mpAnimeMenu.addItem(mpLabMI)

        let mpAnimeMI = NSMenuItem(title: "⛩️ Anime & Manga", action: nil, keyEquivalent: "")
        mpAnimeMI.submenu = mpAnimeMenu
        petSelectionSub.addItem(mpAnimeMI)

        // Marvel
        let mpMarvelSub = NSMenu()
        for c in MarvelCharacter.allCases.map({ SelectableCharacter.marvel($0) }) { addCharToSelectSubmenu(c, to: mpMarvelSub) }
        let mpMarvelMI = NSMenuItem(title: "Marvel", action: nil, keyEquivalent: "")
        mpMarvelMI.submenu = mpMarvelSub
        mpMoviesTVMenu.addItem(mpMarvelMI)

        // DC
        let mpDCSub = NSMenu()
        for c in DCCharacter.allCases.map({ SelectableCharacter.dc($0) }) { addCharToSelectSubmenu(c, to: mpDCSub) }
        let mpDCMI = NSMenuItem(title: "DC", action: nil, keyEquivalent: "")
        mpDCMI.submenu = mpDCSub
        mpMoviesTVMenu.addItem(mpDCMI)

        // Star Wars
        let mpSWSub = NSMenu()
        for c in StarWarsCharacter.allCases.map({ SelectableCharacter.starWars($0) }) { addCharToSelectSubmenu(c, to: mpSWSub) }
        let mpSWMI = NSMenuItem(title: "Star Wars", action: nil, keyEquivalent: "")
        mpSWMI.submenu = mpSWSub
        mpMoviesTVMenu.addItem(mpSWMI)

        // Simpsons
        let mpSimpSub = NSMenu()
        for c in SimpsonsCharacter.allCases.map({ SelectableCharacter.simpsons($0) }) { addCharToSelectSubmenu(c, to: mpSimpSub) }
        let mpSimpMI = NSMenuItem(title: "The Simpsons", action: nil, keyEquivalent: "")
        mpSimpMI.submenu = mpSimpSub
        mpMoviesTVMenu.addItem(mpSimpMI)

        // King of the Hill
        let mpKOTHSub = NSMenu()
        for c in KingOfTheHillCharacter.allCases.map({ SelectableCharacter.kingOfTheHill($0) }) { addCharToSelectSubmenu(c, to: mpKOTHSub) }
        let mpKOTHMI = NSMenuItem(title: "King of the Hill", action: nil, keyEquivalent: "")
        mpKOTHMI.submenu = mpKOTHSub
        mpMoviesTVMenu.addItem(mpKOTHMI)

        // Family Guy
        let mpFGSub = NSMenu()
        for c in FamilyGuyCharacter.allCases.map({ SelectableCharacter.familyGuy($0) }) { addCharToSelectSubmenu(c, to: mpFGSub) }
        let mpFGMI = NSMenuItem(title: "Family Guy", action: nil, keyEquivalent: "")
        mpFGMI.submenu = mpFGSub
        mpMoviesTVMenu.addItem(mpFGMI)

        // Minions
        let mpMinSub = NSMenu()
        for c in MinionsCharacter.allCases.map({ SelectableCharacter.minions($0) }) { addCharToSelectSubmenu(c, to: mpMinSub) }
        let mpMinMI = NSMenuItem(title: "Minions", action: nil, keyEquivalent: "")
        mpMinMI.submenu = mpMinSub
        mpMoviesTVMenu.addItem(mpMinMI)

        // Futurama
        let mpFutSub = NSMenu()
        for c in FuturamaCharacter.allCases.map({ SelectableCharacter.futurama($0) }) { addCharToSelectSubmenu(c, to: mpFutSub) }
        let mpFutMI = NSMenuItem(title: "Futurama", action: nil, keyEquivalent: "")
        mpFutMI.submenu = mpFutSub
        mpMoviesTVMenu.addItem(mpFutMI)

        // Batman
        let mpBatSub = NSMenu()
        for c in BatmanCharacter.allCases.map({ SelectableCharacter.batman($0) }) { addCharToSelectSubmenu(c, to: mpBatSub) }
        let mpBatMI = NSMenuItem(title: "Batman", action: nil, keyEquivalent: "")
        mpBatMI.submenu = mpBatSub
        mpMoviesTVMenu.addItem(mpBatMI)

        // Transformers
        let mpTFSub = NSMenu()
        for c in TransformersCharacter.allCases.map({ SelectableCharacter.transformers($0) }) { addCharToSelectSubmenu(c, to: mpTFSub) }
        let mpTFMI = NSMenuItem(title: "Transformers", action: nil, keyEquivalent: "")
        mpTFMI.submenu = mpTFSub
        mpMoviesTVMenu.addItem(mpTFMI)

        let mpMoviesTVMI = NSMenuItem(title: "🎬 Movies & TV", action: nil, keyEquivalent: "")
        mpMoviesTVMI.submenu = mpMoviesTVMenu
        petSelectionSub.addItem(mpMoviesTVMI)

        let petSelectionMenuItem = NSMenuItem(title: "🐾 Multi-Pet Selection", action: nil, keyEquivalent: "")
        petSelectionMenuItem.submenu = petSelectionSub
        markHeaders(petSelectionSub)

        menu.addItem(NSMenuItem.separator())

        if LLMService.shared.statusEnabled && !LLMService.shared.apiKey.isEmpty {
            if manager.isMultiPetMode {
                for pet in manager.selectedPets {
                    let cached = LLMService.shared.getCachedStatus(for: pet)
                    let statusItem = NSMenuItem(title: "  \(pet.emoji) \(cached ?? "Loading...")", action: nil, keyEquivalent: "")
                    statusItem.tag = 310
                    statusItem.isEnabled = false
                    menu.addItem(statusItem)
                    if cached == nil {
                        let char = pet
                        let petState = manager.state(for: char)
                        DispatchQueue.global(qos: .userInitiated).async {
                            LLMService.shared.generateStatus(for: char, petState: petState) { status in
                                if let menu = self.statusItem.menu {
                                    for item in menu.items where item.tag == 310 {
                                        if item.title.contains(pet.displayName) {
                                            item.title = "  \(pet.emoji) \(status)"
                                        }
                                    }
                                }
                            }
                        }
                    }
                }
            } else {
                let cached = LLMService.shared.getCachedStatus(for: spriteAnimator.currentPokemon)
                let statusItem = NSMenuItem(title: "  💬 \(cached ?? "Loading status...")", action: nil, keyEquivalent: "")
                statusItem.tag = 310
                statusItem.isEnabled = false
                menu.addItem(statusItem)
                if cached == nil {
                    let char = spriteAnimator.currentPokemon
                    let pet = PetState.shared
                    DispatchQueue.global(qos: .userInitiated).async {
                        LLMService.shared.generateStatus(for: char, petState: pet) { status in
                            self.spriteAnimator.llmStatus = status
                            if let menu = self.statusItem.menu {
                                for item in menu.items where item.tag == 310 {
                                    item.title = "  💬 \(status)"
                                }
                            }
                        }
                    }
                }
            }
        }

        if case .transformers(_) = spriteAnimator.currentPokemon {
            let transformSub = NSMenu()
            let toggleItem = NSMenuItem(title: spriteAnimator.isCurrentlyInVehicleMode ? "🤖 Transform to Robot" : "🚗 Transform to Vehicle", action: #selector(toggleTransformMode), keyEquivalent: "")
            toggleItem.target = self
            transformSub.addItem(toggleItem)
            transformSub.addItem(NSMenuItem.separator())
            let intervalSub = NSMenu()
            let presets: [(String, TimeInterval)] = [
                ("10 sec (test)", 10),
                ("30 sec", 30),
                ("1 min", 60),
                ("2 min", 120),
                ("5 min", 300),
                ("10 min", 600),
            ]
            for (label, interval) in presets {
                let item = NSMenuItem(title: label, action: #selector(setTransformInterval(_:)), keyEquivalent: "")
                item.target = self
                item.tag = Int(interval)
                item.state = spriteAnimator.transformInterval == interval ? .on : .off
                intervalSub.addItem(item)
            }
            let customItem = NSMenuItem(title: "Custom...", action: #selector(setCustomTransformInterval), keyEquivalent: "")
            customItem.target = self
            intervalSub.addItem(customItem)
            let intervalMenuItem = NSMenuItem(title: "Transform Interval", action: nil, keyEquivalent: "")
            intervalMenuItem.submenu = intervalSub
            transformSub.addItem(intervalMenuItem)
            let transformMenuItem = NSMenuItem(title: "Transform Mode", action: nil, keyEquivalent: "")
            transformMenuItem.submenu = transformSub
            menu.addItem(transformMenuItem)
        }

        menu.addItem(NSMenuItem.separator())

        let cpuItem = NSMenuItem(title: "CPU Usage: \(Int(cpuMonitor.currentCPU))%", action: nil, keyEquivalent: "")
        cpuItem.tag = 100
        menu.addItem(cpuItem)

        if manager.isMultiPetMode {
            let summary = multiPetSummaryText()
            let summaryItem = NSMenuItem(title: "\(summary)", action: nil, keyEquivalent: "")
            summaryItem.tag = 200
            summaryItem.isEnabled = false
            menu.addItem(summaryItem)

            let statusSub = NSMenu()
            petSubmenus.removeAll()
            for pet in manager.selectedPets {
                let petActionsSub = buildPetSubmenu(for: pet)
                petSubmenus[pet] = petActionsSub
                let petMenuItem = NSMenuItem(title: "\(pet.emoji) \(pet.displayName)", action: nil, keyEquivalent: "")
                petMenuItem.submenu = petActionsSub
                statusSub.addItem(petMenuItem)
            }
            let statusMenuItem = NSMenuItem(title: "📋 Pet Status", action: nil, keyEquivalent: "")
            statusMenuItem.submenu = statusSub
            menu.addItem(statusMenuItem)
        } else {
            let petStatus = NSMenuItem(title: "Pet: \(PetState.shared.moodEmoji) \(PetState.shared.mood) \(PetState.shared.stageEmoji)", action: nil, keyEquivalent: "")
            petStatus.tag = 200
            menu.addItem(petStatus)

            let stageItem = NSMenuItem(title: "  \(PetState.shared.stageEmoji) Stage: \(PetState.shared.stageName) (\(Int(PetState.shared.careScore))%)", action: nil, keyEquivalent: "")
            stageItem.tag = 205
            stageItem.isEnabled = false
            menu.addItem(stageItem)

            let hungerItem = NSMenuItem(title: "  🍕 Hunger: \(Int(PetState.shared.hunger))%", action: nil, keyEquivalent: "")
            hungerItem.tag = 201
            hungerItem.isEnabled = false
            menu.addItem(hungerItem)

            let happyItem = NSMenuItem(title: "  😊 Happy: \(Int(PetState.shared.happiness))%", action: nil, keyEquivalent: "")
            happyItem.tag = 202
            happyItem.isEnabled = false
            menu.addItem(happyItem)

            let hygieneItem = NSMenuItem(title: "  🧼 Clean: \(Int(PetState.shared.hygiene))%", action: nil, keyEquivalent: "")
            hygieneItem.tag = 204
            hygieneItem.isEnabled = false
            menu.addItem(hygieneItem)

            let energyItem = NSMenuItem(title: "  ⚡ Energy: \(Int(PetState.shared.energy))%", action: nil, keyEquivalent: "")
            energyItem.tag = 203
            energyItem.isEnabled = false
            menu.addItem(energyItem)
        }

        menu.addItem(NSMenuItem.separator())

        if manager.isMultiPetMode {
            let feedCount = countActionsFor("feed")
            if feedCount > 0 {
                let feedItem = NSMenuItem(title: "🍕 Feed All (\(feedCount))", action: #selector(feedPet), keyEquivalent: "")
                feedItem.target = self
                menu.addItem(feedItem)
            }
            let playCount = countActionsFor("play")
            if playCount > 0 {
                let playItem = NSMenuItem(title: "🎾 Play All (\(playCount))", action: #selector(playWithPet), keyEquivalent: "")
                playItem.target = self
                menu.addItem(playItem)
            }
            let cleanCount = countActionsFor("clean")
            if cleanCount > 0 {
                let cleanItem = NSMenuItem(title: "🧼 Clean All (\(cleanCount))", action: #selector(cleanPet), keyEquivalent: "")
                cleanItem.target = self
                menu.addItem(cleanItem)
            }
            let sleepCount = countActionsFor("sleep")
            if sleepCount > 0 {
                let sleepItem = NSMenuItem(title: "😴 Sleep All (\(sleepCount))", action: #selector(letPetSleep), keyEquivalent: "")
                sleepItem.target = self
                menu.addItem(sleepItem)
            }
        } else {
            let feedItem = NSMenuItem(title: "🍕 Feed All", action: #selector(feedPet), keyEquivalent: "")
            feedItem.target = self
            menu.addItem(feedItem)

            let playItem = NSMenuItem(title: "🎾 Play All", action: #selector(playWithPet), keyEquivalent: "")
            playItem.target = self
            menu.addItem(playItem)

            let cleanItem = NSMenuItem(title: "🧼 Clean All", action: #selector(cleanPet), keyEquivalent: "")
            cleanItem.target = self
            menu.addItem(cleanItem)

            let sleepItem = NSMenuItem(title: "😴 Sleep All", action: #selector(letPetSleep), keyEquivalent: "")
            sleepItem.target = self
            menu.addItem(sleepItem)
        }

        let customActionItem = NSMenuItem(title: "✨ Custom Action...", action: #selector(customAction), keyEquivalent: "")
        customActionItem.target = self
        menu.addItem(customActionItem)

        let chatItem: NSMenuItem
        if manager.isMultiPetMode {
            chatItem = NSMenuItem(title: "💬 Swarm Chat", action: #selector(openSwarmChat), keyEquivalent: "")
            chatItem.target = self
            chatItem.isEnabled = LLMService.shared.statusEnabled && !LLMService.shared.apiKey.isEmpty
        } else {
            chatItem = NSMenuItem(title: "💬 Chat with Pet", action: #selector(openChat), keyEquivalent: "")
            chatItem.target = self
            chatItem.isEnabled = LLMService.shared.statusEnabled
        }
        menu.addItem(chatItem)

        if !manager.isMultiPetMode {
            if PetState.shared.isDisobedient {
                let disobeyItem = NSMenuItem(title: "😡 \(PetState.shared.disobedienceMessage)", action: nil, keyEquivalent: "")
                disobeyItem.isEnabled = false
                menu.addItem(disobeyItem)

                let disciplineItem = NSMenuItem(title: "👋 🫏 Discipline", action: #selector(disciplinePet), keyEquivalent: "")
                disciplineItem.target = self
                menu.addItem(disciplineItem)
            }

            let obedienceItem = NSMenuItem(title: "  🎓 Obedience: \(Int(PetState.shared.obedience))%", action: nil, keyEquivalent: "")
            obedienceItem.isEnabled = false
            menu.addItem(obedienceItem)
        }

        menu.addItem(NSMenuItem.separator())

        // ===== Grouped Categories =====
        let mainPetSelectionSub = NSMenu()
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
                        item.state = isSelected(cases(char)) ? .on : .off
                        sub.addItem(item)
                    }
                } else if let char = chars.first {
                    let item = NSMenuItem(title: cases(char).displayName, action: #selector(selectCharacter(_:)), keyEquivalent: "")
                    item.target = self
                    item.representedObject = cases(char)
                    item.state = isSelected(cases(char)) ? .on : .off
                    sub.addItem(item)
                }
            }
            return sub
        }

        func isSelected(_ character: SelectableCharacter) -> Bool {
            if manager.isMultiPetMode {
                return manager.isSelected(character)
            }
            return character == spriteAnimator.currentPokemon
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
            if p == .pokeball {
                pokemonSub.addItem(NSMenuItem.separator())
            }
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
            i.state = isSelected(SelectableCharacter.marioItem(c)) ? .on : .off
            marioSub.addItem(i)
        }
        marioSub.addItem(NSMenuItem.separator())
        for c in marioItems {
            let i = NSMenuItem(title: c.displayName, action: #selector(selectCharacter(_:)), keyEquivalent: "")
            i.target = self; i.representedObject = SelectableCharacter.marioItem(c)
            i.state = isSelected(SelectableCharacter.marioItem(c)) ? .on : .off
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
        // Check if current character is from Video Games
        if case .pokemon(_) = spriteAnimator.currentPokemon { gamesMI.state = .on }
        if case .marioItem(_) = spriteAnimator.currentPokemon { gamesMI.state = .on }
        if case .marioKart(_) = spriteAnimator.currentPokemon { gamesMI.state = .on }
        if case .kirby(_) = spriteAnimator.currentPokemon { gamesMI.state = .on }
        if case .zelda(_) = spriteAnimator.currentPokemon { gamesMI.state = .on }
        if case .megaMan(_) = spriteAnimator.currentPokemon { gamesMI.state = .on }
        if case .contra(_) = spriteAnimator.currentPokemon { gamesMI.state = .on }
        if case .metalSlug(_) = spriteAnimator.currentPokemon { gamesMI.state = .on }
        if case .streetFighter(_) = spriteAnimator.currentPokemon { gamesMI.state = .on }
        if case .mortalKombat(_) = spriteAnimator.currentPokemon { gamesMI.state = .on }
        if case .tmnt(_) = spriteAnimator.currentPokemon { gamesMI.state = .on }
        if case .overwatch(_) = spriteAnimator.currentPokemon { gamesMI.state = .on }
        mainPetSelectionSub.addItem(gamesMI)

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
        // Check if current character is from Anime & Manga
        if case .dragonBall(_) = spriteAnimator.currentPokemon { animeMI.state = .on }
        if case .naruto(_) = spriteAnimator.currentPokemon { animeMI.state = .on }
        if case .gundam(_) = spriteAnimator.currentPokemon { animeMI.state = .on }
        if case .ghibli(_) = spriteAnimator.currentPokemon { animeMI.state = .on }
        if case .labubu(_) = spriteAnimator.currentPokemon { animeMI.state = .on }
        mainPetSelectionSub.addItem(animeMI)

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

        // Transformers
        let tfSub = NSMenu()
        for c in transformersCharacters {
            let i = NSMenuItem(title: c.displayName, action: #selector(selectCharacter(_:)), keyEquivalent: "")
            i.target = self; i.representedObject = SelectableCharacter.transformers(c)
            if case .transformers(let x) = spriteAnimator.currentPokemon, x == c { i.state = .on }
            tfSub.addItem(i)
        }
        let tfMI = NSMenuItem(title: "Transformers", action: nil, keyEquivalent: "")
        tfMI.submenu = tfSub
        if case .transformers(_) = spriteAnimator.currentPokemon { tfMI.state = .on }
        moviesTVMenu.addItem(tfMI)

        let moviesTVMI = NSMenuItem(title: "🎬 Movies & TV", action: nil, keyEquivalent: "")
        moviesTVMI.submenu = moviesTVMenu
        // Check if current character is from Movies & TV
        if case .marvel(_) = spriteAnimator.currentPokemon { moviesTVMI.state = .on }
        if case .dc(_) = spriteAnimator.currentPokemon { moviesTVMI.state = .on }
        if case .starWars(_) = spriteAnimator.currentPokemon { moviesTVMI.state = .on }
        if case .simpsons(_) = spriteAnimator.currentPokemon { moviesTVMI.state = .on }
        if case .kingOfTheHill(_) = spriteAnimator.currentPokemon { moviesTVMI.state = .on }
        if case .familyGuy(_) = spriteAnimator.currentPokemon { moviesTVMI.state = .on }
        if case .minions(_) = spriteAnimator.currentPokemon { moviesTVMI.state = .on }
        if case .futurama(_) = spriteAnimator.currentPokemon { moviesTVMI.state = .on }
        if case .batman(_) = spriteAnimator.currentPokemon { moviesTVMI.state = .on }
        if case .transformers(_) = spriteAnimator.currentPokemon { moviesTVMI.state = .on }
        mainPetSelectionSub.addItem(moviesTVMI)

        let mainPetSelectionMI = NSMenuItem(title: "🐾 Main Pet Selection", action: nil, keyEquivalent: "")
        mainPetSelectionMI.submenu = mainPetSelectionSub
        menu.addItem(mainPetSelectionMI)
        menu.addItem(petSelectionMenuItem)

        menu.addItem(NSMenuItem.separator())

        let speedItem = NSMenuItem(title: "Speed: \(spriteAnimator.speedLabel)", action: nil, keyEquivalent: "")
        speedItem.tag = 150
        menu.addItem(speedItem)

        let rotationSub = NSMenu()

        let rotationItem = NSMenuItem(title: "Random Rotation", action: #selector(toggleRotation), keyEquivalent: "")
        rotationItem.target = self
        rotationItem.state = spriteAnimator.rotationEnabled ? .on : .off
        rotationSub.addItem(rotationItem)

        let smartRotationItem = NSMenuItem(title: "Smart Rotation (prefer favorites)", action: #selector(toggleSmartRotation), keyEquivalent: "")
        smartRotationItem.target = self
        smartRotationItem.state = spriteAnimator.smartRotationEnabled ? .on : .off
        smartRotationItem.isEnabled = spriteAnimator.rotationEnabled
        rotationSub.addItem(smartRotationItem)

        let categoryOnlyItem = NSMenuItem(title: "Rotate Within Category Only", action: #selector(toggleCategoryOnly), keyEquivalent: "")
        categoryOnlyItem.target = self
        categoryOnlyItem.state = spriteAnimator.categoryOnlyEnabled ? .on : .off
        categoryOnlyItem.isEnabled = spriteAnimator.rotationEnabled
        rotationSub.addItem(categoryOnlyItem)

        rotationSub.addItem(NSMenuItem.separator())

        let intervalSub = NSMenu()
        let intervals: [(String, TimeInterval)] = [
            ("15 seconds", 15),
            ("30 seconds", 30),
            ("1 minute", 60),
            ("5 minutes", 300),
            ("10 minutes", 600),
            ("30 minutes", 1800),
            ("1 hour", 3600),
        ]
        for (label, interval) in intervals {
            let item = NSMenuItem(title: label, action: #selector(setRotationInterval(_:)), keyEquivalent: "")
            item.target = self
            item.tag = Int(interval)
            if spriteAnimator.rotationInterval == interval { item.state = .on }
            item.isEnabled = spriteAnimator.rotationEnabled
            intervalSub.addItem(item)
        }
        intervalSub.addItem(NSMenuItem.separator())
        let customItem = NSMenuItem(title: "Custom...", action: #selector(setCustomRotationInterval), keyEquivalent: "")
        customItem.target = self
        customItem.isEnabled = spriteAnimator.rotationEnabled
        intervalSub.addItem(customItem)
        let intervalItem = NSMenuItem(title: "Rotation Interval", action: nil, keyEquivalent: "")
        intervalItem.submenu = intervalSub
        rotationSub.addItem(intervalItem)

        let rotationMenuItem = NSMenuItem(title: "Rotation", action: nil, keyEquivalent: "")
        rotationMenuItem.submenu = rotationSub
        menu.addItem(rotationMenuItem)

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

        let companionSub = NSMenu()

        let serverRunning = PetServer.shared.isEnabled
        let serverToggleItem = NSMenuItem(title: serverRunning ? "⏹ Stop Server" : "▶️ Start Server", action: #selector(toggleServer), keyEquivalent: "")
        serverToggleItem.target = self
        companionSub.addItem(serverToggleItem)

        let serverStatusItem = NSMenuItem(title: serverRunning ? "Server: Running on port 18920" : "Server: Stopped", action: nil, keyEquivalent: "")
        serverStatusItem.isEnabled = false
        companionSub.addItem(serverStatusItem)

        var localIP = "Unknown"
        if let ip = getLocalIPAddress() { localIP = ip }
        let ipItem = NSMenuItem(title: "IP: \(localIP):18920", action: nil, keyEquivalent: "")
        ipItem.isEnabled = false
        companionSub.addItem(ipItem)

        companionSub.addItem(NSMenuItem.separator())

        let copyIPItem = NSMenuItem(title: "Copy IP Address", action: #selector(copyIPAddress), keyEquivalent: "")
        copyIPItem.target = self
        companionSub.addItem(copyIPItem)

        let copyURLItem = NSMenuItem(title: "Copy Connection URL", action: #selector(copyConnectionURL), keyEquivalent: "")
        copyURLItem.target = self
        companionSub.addItem(copyURLItem)

        let openCompanionItem = NSMenuItem(title: "Open in Browser", action: #selector(openInBrowser), keyEquivalent: "")
        openCompanionItem.target = self
        companionSub.addItem(openCompanionItem)

        let companionMenuItem = NSMenuItem(title: "📱 Companion App", action: nil, keyEquivalent: "")
        companionMenuItem.submenu = companionSub
        menu.addItem(companionMenuItem)

        let checkUpdateItem = NSMenuItem(title: "Check for Updates...", action: #selector(checkForUpdates), keyEquivalent: "")
        checkUpdateItem.target = self
        menu.addItem(checkUpdateItem)

        let llmSub = NSMenu()
        let llmEnableItem = NSMenuItem(title: "Enable Status", action: #selector(toggleLLMStatus), keyEquivalent: "")
        llmEnableItem.target = self
        llmEnableItem.state = LLMService.shared.statusEnabled ? .on : .off
        llmSub.addItem(llmEnableItem)
        llmSub.addItem(NSMenuItem.separator())
        for provider in LLMProvider.allCases.filter({ $0 != .custom }).sorted(by: { $0.rawValue < $1.rawValue }) {
            let providerSub = NSMenu()
            for modelName in provider.knownModels {
                let item = NSMenuItem(title: modelName, action: #selector(selectProviderModel(_:)), keyEquivalent: "")
                item.target = self
                item.representedObject = ["provider": provider, "model": modelName]
                item.state = (LLMService.shared.provider == provider && LLMService.shared.model == modelName) ? .on : .off
                providerSub.addItem(item)
            }
            providerSub.addItem(NSMenuItem.separator())
            let apiKeyItem = NSMenuItem(title: "Set API Key...", action: #selector(setLLMApiKeyForProvider(_:)), keyEquivalent: "")
            apiKeyItem.target = self
            apiKeyItem.representedObject = provider
            providerSub.addItem(apiKeyItem)
            let endpointItem = NSMenuItem(title: "Set Endpoint...", action: #selector(setLLMEndpointForProvider(_:)), keyEquivalent: "")
            endpointItem.target = self
            endpointItem.representedObject = provider
            providerSub.addItem(endpointItem)
            let providerMenuItem = NSMenuItem(title: provider.rawValue, action: nil, keyEquivalent: "")
            providerMenuItem.submenu = providerSub
            if LLMService.shared.provider == provider {
                providerMenuItem.title = "✓ \(provider.rawValue)"
            }
            llmSub.addItem(providerMenuItem)
        }
        let llmMenuItem = NSMenuItem(title: "AI Status", action: nil, keyEquivalent: "")
        llmMenuItem.submenu = llmSub
        menu.addItem(llmMenuItem)

        let versionItem = NSMenuItem(title: "Version \(UpdateChecker.shared.currentVersion)", action: nil, keyEquivalent: "")
        versionItem.isEnabled = false
        menu.addItem(versionItem)

        menu.addItem(NSMenuItem.separator())

        let startupItem = NSMenuItem(title: "Run at Startup", action: #selector(toggleLaunchAtLogin), keyEquivalent: "")
        startupItem.target = self
        startupItem.state = SMAppService.mainApp.status == .enabled ? .on : .off
        menu.addItem(startupItem)

        let quitItem = NSMenuItem(title: "Quit", action: #selector(quitApp), keyEquivalent: "q")
        quitItem.target = self
        menu.addItem(quitItem)

        updateCheckmarks(in: menu)
        statusItem.menu = menu
    }

    func updateMenu() {
        guard let menu = statusItem.menu else { return }
        let manager = MultiPetManager.shared
        for item in menu.items {
            if item.tag == 100 {
                item.title = "CPU Usage: \(Int(cpuMonitor.currentCPU))%"
            } else if item.tag == 150 {
                item.title = "Speed: \(spriteAnimator.speedLabel)"
            } else if item.tag == 300 {
                if manager.isMultiPetMode {
                    item.title = "🐾 Multi-Pet Mode (\(manager.petCount) pets)"
                } else {
                    item.title = "\(spriteAnimator.currentPokemon.emoji) \(spriteAnimator.currentPokemon.displayName) — \(spriteAnimator.currentPokemon.category)"
                }
            }
            if let submenu = item.submenu {
                updateCheckmarks(in: submenu)
            }
        }
    }

    private func updateCheckmarks(in menu: NSMenu) {
        let manager = MultiPetManager.shared
        for item in menu.items {
            if let submenu = item.submenu {
                updateCheckmarks(in: submenu)
            } else if let character = item.representedObject as? SelectableCharacter {
                if manager.isMultiPetMode {
                    item.state = manager.isSelected(character) ? .on : .off
                } else {
                    item.state = (character == spriteAnimator.currentPokemon) ? .on : .off
                }
            }
        }
    }

    @objc func selectCharacter(_ sender: NSMenuItem) {
        guard let character = sender.representedObject as? SelectableCharacter else { return }
        let manager = MultiPetManager.shared
        if manager.isMultiPetMode {
            manager.togglePet(character)
            if manager.isSelected(character) {
                spriteAnimator.setPokemon(character)
            } else if let primary = manager.primaryPet {
                spriteAnimator.setPokemon(primary)
            }
        } else {
            spriteAnimator.setPokemon(character)
        }
        spriteAnimator.resetRotationTimer()
        buildMenu()
    }

    private func hasSelectedIn(_ submenu: NSMenu) -> Bool {
        for item in submenu.items {
            if item.state == .on { return true }
            if let sub = item.submenu, hasSelectedIn(sub) { return true }
        }
        return false
    }

    private func markHeaders(_ menu: NSMenu) {
        for item in menu.items {
            if let sub = item.submenu {
                markHeaders(sub)
                item.state = hasSelectedIn(sub) ? .on : .off
            }
        }
    }

    @objc func togglePetSelection(_ sender: NSMenuItem) {
        guard let character = sender.representedObject as? SelectableCharacter else { return }
        let manager = MultiPetManager.shared
        let wasPrimary = manager.primaryPet
        manager.togglePet(character)
        if !manager.isSelected(character) && wasPrimary == character {
            if let primary = manager.primaryPet {
                spriteAnimator.setPokemon(primary)
            }
        }
        buildMenu()
    }

    @objc func selectAllPets() {
        let manager = MultiPetManager.shared
        let chars: [SelectableCharacter] =
            PokemonCharacter.allCases.map { .pokemon($0) } +
            marioCharacters.map { .marioItem($0) } + marioItems.map { .marioItem($0) } +
            marioKartList.map { .marioKart($0) } + marioKartItems.map { .marioKart($0) } +
            kirbyCharacters.map { .kirby($0) } + kirbyEnemies.map { .kirby($0) } +
            zeldaHeroes.map { .zelda($0) } + zeldaEnemies.map { .zelda($0) } +
            megaManCharacters.map { .megaMan($0) } + megaManBosses.map { .megaMan($0) } +
            contraCharacters.map { .contra($0) } + (contraItems + contraEnemies).map { .contra($0) } +
            metalSlugCharacters.map { .metalSlug($0) } + (metalSlugVehicles + metalSlugEnemies).map { .metalSlug($0) } +
            streetFighterCharacters.map { .streetFighter($0) } + streetFighterBosses.map { .streetFighter($0) } +
            MortalKombatCharacter.allCases.map { .mortalKombat($0) } +
            TMNTCharacter.allCases.map { .tmnt($0) } +
            OverwatchCharacter.allCases.map { .overwatch($0) } +
            MarvelCharacter.allCases.map { .marvel($0) } +
            DragonBallCharacter.allCases.map { .dragonBall($0) } +
            NarutoCharacter.allCases.map { .naruto($0) } +
            GundamCharacter.allCases.map { .gundam($0) } +
            GhibliCharacter.allCases.map { .ghibli($0) } +
            LabubuCharacter.allCases.map { .labubu($0) } +
            DCCharacter.allCases.map { .dc($0) } +
            StarWarsCharacter.allCases.map { .starWars($0) } +
            SimpsonsCharacter.allCases.map { .simpsons($0) } +
            KingOfTheHillCharacter.allCases.map { .kingOfTheHill($0) } +
            FamilyGuyCharacter.allCases.map { .familyGuy($0) } +
            MinionsCharacter.allCases.map { .minions($0) } +
            FuturamaCharacter.allCases.map { .futurama($0) } +
            BatmanCharacter.allCases.map { .batman($0) } +
            TransformersCharacter.allCases.map { .transformers($0) }
        for char in chars { manager.addPet(char) }
        if let first = chars.first { spriteAnimator.setPokemon(first) }
        buildMenu()
    }

    @objc func clearAllPets() {
        MultiPetManager.shared.clearAll()
        spriteAnimator.setPokemon(.pokemon(.jigglypuff))
        buildMenu()
    }

    @objc func openSwarmChat() {
        let manager = MultiPetManager.shared
        guard manager.isMultiPetMode, LLMService.shared.statusEnabled else { return }

        if let existing = swarmChatWindow {
            existing.makeKeyAndOrderFront(nil)
            NSApp.activate(ignoringOtherApps: true)
            return
        }

        let panel = NSPanel(contentRect: NSRect(x: 0, y: 0, width: 500, height: 600), styleMask: [.titled, .closable, .resizable], backing: .buffered, defer: false)
        panel.title = "🐝 Swarm Chat — \(manager.petCount) Pets"
        panel.center()
        panel.isReleasedWhenClosed = false
        panel.minSize = NSSize(width: 520, height: 300)
        swarmChatWindow = panel

        let scrollView = NSScrollView(frame: NSRect(x: 0, y: 50, width: 500, height: 510))
        scrollView.hasVerticalScroller = true
        scrollView.autoresizingMask = [.width, .height]
        scrollView.borderType = .noBorder
        scrollView.drawsBackground = false

        let contentSize = scrollView.contentSize
        let textView = ChatTextView(frame: NSRect(x: 0, y: 0, width: contentSize.width, height: contentSize.height))
        textView.minSize = NSSize(width: 0, height: 0)
        textView.maxSize = NSSize(width: CGFloat.greatestFiniteMagnitude, height: CGFloat.greatestFiniteMagnitude)
        textView.isVerticallyResizable = true
        textView.isHorizontallyResizable = false
        textView.textContainer?.containerSize = NSSize(width: contentSize.width, height: CGFloat.greatestFiniteMagnitude)
        textView.textContainer?.widthTracksTextView = true
        textView.isEditable = false
        textView.isSelectable = true
        textView.font = NSFont.systemFont(ofSize: 13)
        textView.textContainerInset = NSSize(width: 10, height: 10)
        textView.textContainer?.lineFragmentPadding = 0
        scrollView.documentView = textView
        panel.contentView?.addSubview(scrollView)
        swarmChatTextView = scrollView

        let inputField = ChatInputField(frame: NSRect(x: 10, y: 10, width: 389, height: 24))
        inputField.placeholderString = "Say something to the group..."
        inputField.isEditable = true
        inputField.isSelectable = true
        inputField.allowsEditingTextAttributes = true
        inputField.autoresizingMask = [.width]
        panel.contentView?.addSubview(inputField)
        swarmChatInputField = inputField

        let sendButton = NSButton(title: "Send", target: self, action: #selector(sendSwarmMessage))
        sendButton.frame = NSRect(x: 404, y: 9, width: 60, height: 26)
        sendButton.keyEquivalent = "\r"
        sendButton.autoresizingMask = [.minXMargin]
        panel.contentView?.addSubview(sendButton)

        let diceButton = NSButton(title: "🎲", target: self, action: #selector(triggerRandomInteraction))
        diceButton.frame = NSRect(x: 468, y: 9, width: 30, height: 26)
        diceButton.bezelStyle = .inline
        diceButton.autoresizingMask = [.minXMargin]
        diceButton.toolTip = "Random Pet Action"
        panel.contentView?.addSubview(diceButton)

        let petNames = manager.selectedPets.map { "\($0.emoji) \($0.displayName)" }.joined(separator: ", ")
        appendToSwarmChat(system: "Swarm chat started! Pets: \(petNames)")

        panel.initialFirstResponder = inputField
        panel.makeKeyAndOrderFront(nil)
        NSApp.activate(ignoringOtherApps: true)

        SwarmChatManager.shared.startSwarmConversation(topic: "greet each other and chat") { [weak self] messages in
            self?.displaySwarmMessages(messages)
        }
    }

    @objc func sendSwarmMessage() {
        guard let inputField = swarmChatInputField, !inputField.stringValue.isEmpty else { return }
        let userMessage = inputField.stringValue.trimmingCharacters(in: .whitespacesAndNewlines)
        guard !userMessage.isEmpty else { return }
        inputField.stringValue = ""

        appendToSwarmChat(user: userMessage)

        SwarmChatManager.shared.sendUserMessage(userMessage) { [weak self] messages in
            self?.displaySwarmMessages(messages)
        }
    }

    @objc func triggerRandomInteraction() {
        let manager = MultiPetManager.shared
        guard manager.isMultiPetMode, LLMService.shared.statusEnabled else { return }

        if let existing = swarmChatWindow {
            existing.makeKeyAndOrderFront(nil)
            NSApp.activate(ignoringOtherApps: true)
        } else {
            openSwarmChat()
        }

        appendToSwarmChat(system: "Random interaction starting...")

        SwarmChatManager.shared.triggerRandomInteraction { [weak self] messages in
            self?.displaySwarmMessages(messages)
        }
    }

    private func appendToSwarmChat(user: String) {
        guard let scrollView = swarmChatTextView, let textView = scrollView.documentView as? NSTextView else { return }
        let text = "You: \(user)\n\n"
        textView.textStorage?.append(NSAttributedString(string: text, attributes: [
            .font: NSFont.systemFont(ofSize: 13),
            .foregroundColor: NSColor.labelColor
        ]))
        textView.scrollRangeToVisible(NSRange(location: textView.string.count, length: 0))
    }

    private func appendToSwarmChat(pet: SelectableCharacter, text: String) {
        guard let scrollView = swarmChatTextView, let textView = scrollView.documentView as? NSTextView else { return }
        var cleanText = text
        let prefixes = ["\(pet.displayName): ", "\(pet.displayName):", "\(pet.emoji) \(pet.displayName): ", "\(pet.emoji) \(pet.displayName):"]
        for prefix in prefixes {
            if cleanText.hasPrefix(prefix) {
                cleanText = String(cleanText.dropFirst(prefix.count)).trimmingCharacters(in: .whitespaces)
                break
            }
        }
        let msgText = "\(pet.emoji) \(pet.displayName): \(cleanText)\n\n"
        textView.textStorage?.append(NSAttributedString(string: msgText, attributes: [
            .font: NSFont.systemFont(ofSize: 13),
            .foregroundColor: NSColor.systemBlue
        ]))
        textView.scrollRangeToVisible(NSRange(location: textView.string.count, length: 0))
    }

    private func appendToSwarmChat(system: String) {
        guard let scrollView = swarmChatTextView, let textView = scrollView.documentView as? NSTextView else { return }
        let text = "[\(system)]\n\n"
        textView.textStorage?.append(NSAttributedString(string: text, attributes: [
            .font: NSFont.systemFont(ofSize: 11),
            .foregroundColor: NSColor.secondaryLabelColor
        ]))
        textView.scrollRangeToVisible(NSRange(location: textView.string.count, length: 0))
    }

    private func showTypingIndicator(pet: SelectableCharacter) -> String {
        guard let scrollView = swarmChatTextView, let textView = scrollView.documentView as? NSTextView else { return "" }
        let petState = MultiPetManager.shared.state(for: pet)
        let statusInfo = "\(petState.moodEmoji) \(petState.mood) \(petState.stageEmoji)"
        let marker = "TYPING_\(pet.identifier)_\(UUID().uuidString.prefix(4))"
        let text = "\(pet.emoji) \(pet.displayName) is typing... \(statusInfo) [\(marker)]\n"
        textView.textStorage?.append(NSAttributedString(string: text, attributes: [
            .font: NSFont.systemFont(ofSize: 12),
            .foregroundColor: NSColor.secondaryLabelColor
        ]))
        textView.scrollRangeToVisible(NSRange(location: textView.string.count, length: 0))
        return marker
    }

    private func removeTypingIndicator(marker: String) {
        guard let scrollView = swarmChatTextView, let textView = scrollView.documentView as? NSTextView else { return }
        let fullText = textView.string
        guard let range = fullText.range(of: "[\(marker)]") else { return }
        var start = fullText.startIndex
        if let prevNewline = fullText[..<range.lowerBound].lastIndex(of: "\n") {
            start = fullText.index(after: prevNewline)
        }
        var end = fullText.endIndex
        if let nextNewline = fullText[range.upperBound...].firstIndex(of: "\n") {
            end = fullText.index(after: nextNewline)
        }
        let nsRange = NSRange(start..<end, in: fullText)
        textView.textStorage?.deleteCharacters(in: nsRange)
        textView.scrollRangeToVisible(NSRange(location: textView.string.count, length: 0))
    }

    private func displaySwarmMessages(_ messages: [SwarmMessage], delay: TimeInterval = 1.8) {
        guard !messages.isEmpty else { return }
        var currentDelay: TimeInterval = 0.5
        for msg in messages {
            let pet = msg.speaker
            let typingDuration = Double.random(in: 1.2...2.5)
            let pauseBetween = Double.random(in: 0.8...1.5)
            DispatchQueue.main.asyncAfter(deadline: .now() + currentDelay) { [weak self] in
                guard let self = self else { return }
                let marker = self.showTypingIndicator(pet: pet)
                DispatchQueue.main.asyncAfter(deadline: .now() + typingDuration) { [weak self] in
                    guard let self = self else { return }
                    self.removeTypingIndicator(marker: marker)
                    self.appendToSwarmChat(pet: pet, text: msg.text)
                }
            }
            currentDelay += typingDuration + pauseBetween
        }
    }

    @objc func toggleRotation() {
        spriteAnimator.toggleRotation()
        buildMenu()
    }

    @objc func toggleSmartRotation() {
        spriteAnimator.toggleSmartRotation()
        buildMenu()
    }

    @objc func toggleCategoryOnly() {
        spriteAnimator.toggleCategoryOnly()
        buildMenu()
    }

    @objc func setRotationInterval(_ sender: NSMenuItem) {
        let interval = TimeInterval(sender.tag)
        spriteAnimator.setRotationInterval(interval)
        buildMenu()
    }

    @objc func setCustomRotationInterval() {
        var running = true
        while running {
            let alert = NSAlert()
            alert.messageText = "Custom Rotation Interval"
            alert.informativeText = "Enter the interval in seconds (minimum 0.01):"
            alert.addButton(withTitle: "OK")
            alert.addButton(withTitle: "Cancel")

            let textField = NSTextField(frame: NSRect(x: 0, y: 0, width: 100, height: 24))
            textField.stringValue = "\(spriteAnimator.rotationInterval)"
            alert.accessoryView = textField

            if alert.runModal() == .alertFirstButtonReturn {
                if let value = Double(textField.stringValue), value >= 0.01 {
                    spriteAnimator.setRotationInterval(value)
                    buildMenu()
                    running = false
                } else {
                    let errorAlert = NSAlert()
                    errorAlert.messageText = "Invalid Interval"
                    errorAlert.informativeText = "The minimum rotation interval is 0.01 seconds."
                    errorAlert.alertStyle = .warning
                    errorAlert.addButton(withTitle: "OK")
                    errorAlert.runModal()
                }
            } else {
                running = false
            }
        }
    }

    @objc func searchCharacter(_ sender: NSMenuItem) {
        let characterName = spriteAnimator.currentPokemon.displayName
        let category = spriteAnimator.currentPokemon.category
        let searchTerm = "\(category) \(characterName)"
        let query = searchTerm.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? searchTerm
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

    @objc func toggleTransformMode() {
        spriteAnimator.toggleTransform()
        buildMenu()
    }

    @objc func setTransformInterval(_ sender: NSMenuItem) {
        let interval = TimeInterval(sender.tag)
        spriteAnimator.setTransformInterval(interval)
        buildMenu()
    }

    @objc func setCustomTransformInterval() {
        let alert = NSAlert()
        alert.messageText = "Custom Transform Interval"
        alert.informativeText = "Enter interval in seconds:"
        alert.addButton(withTitle: "OK")
        alert.addButton(withTitle: "Cancel")
        let textField = NSTextField(frame: NSRect(x: 0, y: 0, width: 100, height: 24))
        textField.stringValue = String(Int(spriteAnimator.transformInterval))
        alert.accessoryView = textField
        if alert.runModal() == .alertFirstButtonReturn {
            if let value = Double(textField.stringValue), value >= 10 {
                spriteAnimator.setTransformInterval(value)
                buildMenu()
            }
        }
    }

    @objc func copyStatusToClipboard() {
        guard let menu = statusItem.menu else { return }
        for item in menu.items where item.tag == 310 {
            let text = item.title.replacingOccurrences(of: "  💬 ", with: "")
            NSPasteboard.general.clearContents()
            NSPasteboard.general.setString(text, forType: .string)
            item.title = "  ✅ Copied to clipboard!"
            DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                item.title = "  💬 \(text)"
            }
            break
        }
    }

    @objc func toggleLLMStatus() {
        LLMService.shared.statusEnabled.toggle()
        buildMenu()
    }

    @objc func setLLMProvider(_ sender: NSMenuItem) {
        if let provider = sender.representedObject as? LLMProvider {
            LLMService.shared.provider = provider
            LLMService.shared.endpoint = ""
            LLMService.shared.model = ""
            buildMenu()
        }
    }

    @objc func selectProviderModel(_ sender: NSMenuItem) {
        if let info = sender.representedObject as? [String: Any],
           let provider = info["provider"] as? LLMProvider,
           let model = info["model"] as? String {
            LLMService.shared.provider = provider
            LLMService.shared.model = model
            LLMService.shared.invalidateCache()
            buildMenu()
        }
    }

    private var apiKeyTextField: NSTextField?
    private var editingProvider: LLMProvider?

    @objc func setLLMApiKeyForProvider(_ sender: NSMenuItem) {
        guard let provider = sender.representedObject as? LLMProvider else { return }
        editingProvider = provider
        let panel = NSPanel(contentRect: NSRect(x: 0, y: 0, width: 600, height: 150), styleMask: [.titled, .closable], backing: .buffered, defer: false)
        panel.title = "API Key for \(provider.rawValue)"
        panel.center()
        panel.isReleasedWhenClosed = false

        let label = NSTextField(labelWithString: "Your API key is stored locally and never shared.")
        label.frame = NSRect(x: 20, y: 115, width: 560, height: 20)
        label.font = NSFont.systemFont(ofSize: 11)
        label.textColor = .secondaryLabelColor
        panel.contentView?.addSubview(label)

        let textField = NSTextField(frame: NSRect(x: 20, y: 80, width: 560, height: 24))
        textField.stringValue = LLMService.shared.getApiKey(for: provider)
        textField.placeholderString = "Enter or paste your \(provider.rawValue) API key"
        panel.contentView?.addSubview(textField)
        apiKeyTextField = textField

        let pasteButton = NSButton(title: "📋 Paste from Clipboard", target: self, action: #selector(pasteApiKey))
        pasteButton.frame = NSRect(x: 20, y: 50, width: 160, height: 24)
        panel.contentView?.addSubview(pasteButton)

        let okButton = NSButton(title: "Save", target: self, action: #selector(saveApiKeyFromPanel))
        okButton.frame = NSRect(x: 420, y: 10, width: 80, height: 30)
        okButton.keyEquivalent = "\r"
        panel.contentView?.addSubview(okButton)

        let cancelButton = NSButton(title: "Cancel", target: panel, action: #selector(NSPanel.close))
        cancelButton.frame = NSRect(x: 510, y: 10, width: 80, height: 30)
        cancelButton.keyEquivalent = "\u{1b}"
        panel.contentView?.addSubview(cancelButton)

        panel.makeKeyAndOrderFront(nil)
        NSApp.activate(ignoringOtherApps: true)
        textField.window?.makeKeyAndOrderFront(nil)
        textField.becomeFirstResponder()
    }

    @objc func pasteApiKey() {
        if let string = NSPasteboard.general.string(forType: .string) {
            apiKeyTextField?.stringValue = string.trimmingCharacters(in: .whitespacesAndNewlines)
        }
    }

    @objc func saveApiKeyFromPanel() {
        if let textField = apiKeyTextField, let provider = editingProvider {
            LLMService.shared.setApiKey(textField.stringValue, for: provider)
        }
        apiKeyTextField?.window?.close()
        apiKeyTextField = nil
        editingProvider = nil
        buildMenu()
    }

    private var endpointTextField: NSTextField?
    private var editingEndpointProvider: LLMProvider?

    @objc func setLLMEndpointForProvider(_ sender: NSMenuItem) {
        guard let provider = sender.representedObject as? LLMProvider else { return }
        editingEndpointProvider = provider
        let panel = NSPanel(contentRect: NSRect(x: 0, y: 0, width: 550, height: 150), styleMask: [.titled, .closable], backing: .buffered, defer: false)
        panel.title = "Endpoint for \(provider.rawValue)"
        panel.center()
        panel.isReleasedWhenClosed = false

        let label = NSTextField(labelWithString: "Leave empty for default: \(provider.defaultEndpoint)")
        label.frame = NSRect(x: 20, y: 115, width: 510, height: 20)
        label.font = NSFont.systemFont(ofSize: 11)
        label.textColor = .secondaryLabelColor
        panel.contentView?.addSubview(label)

        let textField = NSTextField(frame: NSRect(x: 20, y: 80, width: 510, height: 24))
        textField.stringValue = LLMService.shared.endpoint
        textField.placeholderString = provider.defaultEndpoint
        panel.contentView?.addSubview(textField)
        endpointTextField = textField

        let pasteButton = NSButton(title: "📋 Paste from Clipboard", target: self, action: #selector(pasteEndpoint))
        pasteButton.frame = NSRect(x: 20, y: 50, width: 160, height: 24)
        panel.contentView?.addSubview(pasteButton)

        let okButton = NSButton(title: "Save", target: self, action: #selector(saveEndpointFromPanel))
        okButton.frame = NSRect(x: 370, y: 10, width: 80, height: 30)
        okButton.keyEquivalent = "\r"
        panel.contentView?.addSubview(okButton)

        let cancelButton = NSButton(title: "Cancel", target: panel, action: #selector(NSPanel.close))
        cancelButton.frame = NSRect(x: 460, y: 10, width: 80, height: 30)
        cancelButton.keyEquivalent = "\u{1b}"
        panel.contentView?.addSubview(cancelButton)

        panel.makeKeyAndOrderFront(nil)
        NSApp.activate(ignoringOtherApps: true)
        textField.window?.makeKeyAndOrderFront(nil)
        textField.becomeFirstResponder()
    }

    @objc func pasteEndpoint() {
        if let string = NSPasteboard.general.string(forType: .string) {
            endpointTextField?.stringValue = string.trimmingCharacters(in: .whitespacesAndNewlines)
        }
    }

    @objc func saveEndpointFromPanel() {
        if let textField = endpointTextField {
            LLMService.shared.endpoint = textField.stringValue
        }
        endpointTextField?.window?.close()
        endpointTextField = nil
        editingEndpointProvider = nil
        buildMenu()
    }

    private var modelTextField: NSTextField?

    @objc func setLLMModel(_ sender: NSMenuItem) {
        if let modelName = sender.representedObject as? String {
            LLMService.shared.model = modelName
        }
        buildMenu()
    }

    @objc func toggleLaunchAtLogin() {
        do {
            if SMAppService.mainApp.status == .enabled {
                try SMAppService.mainApp.unregister()
            } else {
                try SMAppService.mainApp.register()
            }
        } catch {
            print("Failed to toggle launch at login: \(error)")
        }
        buildMenu()
    }

    private func getLocalIPAddress() -> String? {
        var address: String?
        var ifaddr: UnsafeMutablePointer<ifaddrs>?
        guard getifaddrs(&ifaddr) == 0, let firstAddr = ifaddr else { return nil }
        defer { freeifaddrs(ifaddr) }
        for ptr in sequence(first: firstAddr, next: { $0.pointee.ifa_next }) {
            let interface = ptr.pointee
            let addrFamily = interface.ifa_addr.pointee.sa_family
            if addrFamily == UInt8(AF_INET) {
                let name = String(cString: interface.ifa_name)
                if name == "en0" || name == "en1" {
                    var hostname = [CChar](repeating: 0, count: Int(NI_MAXHOST))
                    getnameinfo(interface.ifa_addr, socklen_t(interface.ifa_addr.pointee.sa_len),
                                &hostname, socklen_t(hostname.count), nil, 0, NI_NUMERICHOST)
                    address = String(cString: hostname)
                }
            }
        }
        return address
    }

    @objc func copyIPAddress() {
        if let ip = getLocalIPAddress() {
            let pasteboard = NSPasteboard.general
            pasteboard.clearContents()
            pasteboard.setString(ip, forType: .string)
        }
    }

    @objc func copyConnectionURL() {
        if let ip = getLocalIPAddress() {
            let pasteboard = NSPasteboard.general
            pasteboard.clearContents()
            pasteboard.setString("http://\(ip):18920", forType: .string)
        }
    }

    @objc func openInBrowser() {
        if let ip = getLocalIPAddress(), let url = URL(string: "http://\(ip):18920/pet/ping") {
            NSWorkspace.shared.open(url)
        }
    }

    @objc func quitApp() {
        NSApplication.shared.terminate(nil)
    }

    @objc func toggleServer() {
        let server = PetServer.shared
        if server.isEnabled {
            server.stop()
            server.isEnabled = false
        } else {
            server.isEnabled = true
            server.start()
        }
        buildMenu()
    }

    @objc func feedPet() {
        let manager = MultiPetManager.shared
        if manager.isMultiPetMode {
            let affected = manager.feedAll()
            for pet in affected { LLMService.shared.invalidateCache(for: pet) }
            refreshAffectedPets(affected)
        } else {
            PetState.shared.feed(personality: spriteAnimator.currentPokemon.personality)
            LLMService.shared.invalidateCache()
            buildMenu()
            DispatchQueue.main.asyncAfter(deadline: .now() + 5) { [weak self] in self?.buildMenu() }
        }
    }

    @objc func playWithPet() {
        let manager = MultiPetManager.shared
        if manager.isMultiPetMode {
            let affected = manager.playAll()
            for pet in affected { LLMService.shared.invalidateCache(for: pet) }
            refreshAffectedPets(affected)
        } else {
            PetState.shared.play(personality: spriteAnimator.currentPokemon.personality)
            LLMService.shared.invalidateCache()
            buildMenu()
            DispatchQueue.main.asyncAfter(deadline: .now() + 5) { [weak self] in self?.buildMenu() }
        }
    }

    @objc func cleanPet() {
        let manager = MultiPetManager.shared
        if manager.isMultiPetMode {
            let affected = manager.cleanAll()
            for pet in affected { LLMService.shared.invalidateCache(for: pet) }
            refreshAffectedPets(affected)
        } else {
            PetState.shared.clean()
            LLMService.shared.invalidateCache()
            buildMenu()
            DispatchQueue.main.asyncAfter(deadline: .now() + 5) { [weak self] in self?.buildMenu() }
        }
    }

    @objc func letPetSleep() {
        let manager = MultiPetManager.shared
        if manager.isMultiPetMode {
            let affected = manager.sleepAll()
            for pet in affected { LLMService.shared.invalidateCache(for: pet) }
            refreshAffectedPets(affected)
        } else {
            PetState.shared.sleep()
            LLMService.shared.invalidateCache()
            buildMenu()
            DispatchQueue.main.asyncAfter(deadline: .now() + 5) { [weak self] in self?.buildMenu() }
        }
    }

    private var customActionTextField: NSTextField?

    @objc func customAction() {
        guard LLMService.shared.statusEnabled else { return }
        let panel = NSPanel(contentRect: NSRect(x: 0, y: 0, width: 500, height: 150), styleMask: [.titled, .closable, .resizable], backing: .buffered, defer: false)
        panel.title = "Custom Action"
        panel.center()
        panel.isReleasedWhenClosed = false

        let label = NSTextField(labelWithString: "Describe what you want to do to your pet:")
        label.frame = NSRect(x: 20, y: 115, width: 460, height: 20)
        label.font = NSFont.systemFont(ofSize: 12)
        label.textColor = .labelColor
        panel.contentView?.addSubview(label)

        let textField = NSTextField(frame: NSRect(x: 20, y: 80, width: 460, height: 24))
        textField.placeholderString = "e.g. give a bath, tell a joke, tickle"
        textField.isEditable = true
        textField.isSelectable = true
        panel.contentView?.addSubview(textField)
        customActionTextField = textField

        let pasteButton = NSButton(title: "📋 Paste from Clipboard", target: self, action: #selector(pasteCustomAction))
        pasteButton.frame = NSRect(x: 20, y: 50, width: 160, height: 24)
        panel.contentView?.addSubview(pasteButton)

        let okButton = NSButton(title: "Send", target: self, action: #selector(sendCustomAction))
        okButton.frame = NSRect(x: 320, y: 20, width: 80, height: 30)
        okButton.keyEquivalent = "\r"
        panel.contentView?.addSubview(okButton)

        let cancelButton = NSButton(title: "Cancel", target: panel, action: #selector(NSPanel.close))
        cancelButton.frame = NSRect(x: 410, y: 20, width: 80, height: 30)
        cancelButton.keyEquivalent = "\u{1b}"
        panel.contentView?.addSubview(cancelButton)

        panel.makeKeyAndOrderFront(nil)
        NSApp.activate(ignoringOtherApps: true)
        textField.window?.makeKeyAndOrderFront(nil)
        textField.becomeFirstResponder()
    }

    @objc func pasteCustomAction() {
        if let string = NSPasteboard.general.string(forType: .string) {
            customActionTextField?.stringValue = string.trimmingCharacters(in: .whitespacesAndNewlines)
        }
    }

    @objc func sendCustomAction() {
        if let textField = customActionTextField, !textField.stringValue.isEmpty {
            PetState.shared.lastAction = textField.stringValue
            LLMService.shared.invalidateCache()
            buildMenu()
            DispatchQueue.main.asyncAfter(deadline: .now() + 5) { PetState.shared.lastAction = nil }
        }
        customActionTextField?.window?.close()
        customActionTextField = nil
    }

    private var chatWindow: NSPanel?
    private var chatTextView: NSScrollView?
    private var chatInputField: NSTextField?
    private var chatHistory: [[String: String]] = []

    @objc func openChat() {
        guard LLMService.shared.statusEnabled else { return }

        if let existing = chatWindow {
            existing.makeKeyAndOrderFront(nil)
            NSApp.activate(ignoringOtherApps: true)
            return
        }

        let panel = NSPanel(contentRect: NSRect(x: 0, y: 0, width: 450, height: 550), styleMask: [.titled, .closable, .resizable], backing: .buffered, defer: false)
        panel.title = "Chat with \(spriteAnimator.currentPokemon.displayName)"
        panel.center()
        panel.isReleasedWhenClosed = false
        panel.minSize = NSSize(width: 350, height: 300)
        chatWindow = panel

        let scrollView = NSScrollView(frame: NSRect(x: 0, y: 50, width: 450, height: 460))
        scrollView.hasVerticalScroller = true
        scrollView.autoresizingMask = [.width, .height]
        scrollView.borderType = .noBorder
        scrollView.drawsBackground = false

        let contentSize = scrollView.contentSize
        let textView = ChatTextView(frame: NSRect(x: 0, y: 0, width: contentSize.width, height: contentSize.height))
        textView.minSize = NSSize(width: 0, height: 0)
        textView.maxSize = NSSize(width: CGFloat.greatestFiniteMagnitude, height: CGFloat.greatestFiniteMagnitude)
        textView.isVerticallyResizable = true
        textView.isHorizontallyResizable = false
        textView.textContainer?.containerSize = NSSize(width: contentSize.width, height: CGFloat.greatestFiniteMagnitude)
        textView.textContainer?.widthTracksTextView = true
        textView.isEditable = false
        textView.isSelectable = true
        textView.font = NSFont.systemFont(ofSize: 13)
        textView.textContainerInset = NSSize(width: 10, height: 10)
        textView.textContainer?.lineFragmentPadding = 0
        scrollView.documentView = textView
        panel.contentView?.addSubview(scrollView)
        chatTextView = scrollView

        let inputField = ChatInputField(frame: NSRect(x: 10, y: 10, width: 350, height: 24))
        inputField.placeholderString = "Say something to your pet..."
        inputField.isEditable = true
        inputField.isSelectable = true
        inputField.allowsEditingTextAttributes = true
        inputField.autoresizingMask = [.width]
        panel.contentView?.addSubview(inputField)
        chatInputField = inputField

        let sendButton = NSButton(title: "Send", target: self, action: #selector(sendChatMessage))
        sendButton.frame = NSRect(x: 370, y: 9, width: 60, height: 26)
        sendButton.keyEquivalent = "\r"
        sendButton.autoresizingMask = [.minXMargin]
        panel.contentView?.addSubview(sendButton)

        let clearButton = NSButton(title: "Clear", target: self, action: #selector(clearChat))
        clearButton.frame = NSRect(x: 10, y: 0, width: 50, height: 0)
        clearButton.isHidden = true
        panel.contentView?.addSubview(clearButton)

        chatHistory = []
        let petName = spriteAnimator.currentPokemon.displayName
        appendToChat(system: "\(petName) has joined the chat. Say hello!")

        panel.initialFirstResponder = textView
        panel.makeKeyAndOrderFront(nil)
        NSApp.activate(ignoringOtherApps: true)
        textView.window?.makeFirstResponder(textView)
    }

    @objc func sendChatMessage() {
        guard let inputField = chatInputField, !inputField.stringValue.isEmpty else { return }
        let userMessage = inputField.stringValue.trimmingCharacters(in: .whitespacesAndNewlines)
        guard !userMessage.isEmpty else { return }
        inputField.stringValue = ""

        appendToChat(user: userMessage)
        chatHistory.append(["role": "user", "content": userMessage])

        let char = spriteAnimator.currentPokemon
        appendToChat(system: "Thinking...")
        LLMService.shared.chat(character: char, messages: chatHistory) { [weak self] result in
            guard let self = self else { return }
            self.removeLastSystemMessage()
            switch result {
            case .success(let response):
                self.appendToChat(pet: response)
                self.chatHistory.append(["role": "assistant", "content": response])
            case .failure(let error):
                self.appendToChat(system: "Error: \(error.localizedDescription)")
            }
        }
    }

    @objc func clearChat() {
        chatHistory = []
        if let scrollView = chatTextView, let textView = scrollView.documentView as? NSTextView {
            textView.string = ""
        }
    }

    private func appendToChat(user: String) {
        guard let scrollView = chatTextView, let textView = scrollView.documentView as? NSTextView else { return }
        let text = "You: \(user)\n\n"
        textView.textStorage?.append(NSAttributedString(string: text, attributes: [
            .font: NSFont.systemFont(ofSize: 13),
            .foregroundColor: NSColor.labelColor
        ]))
        textView.scrollRangeToVisible(NSRange(location: textView.string.count, length: 0))
    }

    private func appendToChat(pet: String) {
        guard let scrollView = chatTextView, let textView = scrollView.documentView as? NSTextView else { return }
        let petName = spriteAnimator.currentPokemon.displayName
        let text = "\(petName): \(pet)\n\n"
        textView.textStorage?.append(NSAttributedString(string: text, attributes: [
            .font: NSFont.systemFont(ofSize: 13),
            .foregroundColor: NSColor.systemBlue
        ]))
        textView.scrollRangeToVisible(NSRange(location: textView.string.count, length: 0))
    }

    private func appendToChat(system: String) {
        guard let scrollView = chatTextView, let textView = scrollView.documentView as? NSTextView else { return }
        let text = "[\(system)]\n\n"
        textView.textStorage?.append(NSAttributedString(string: text, attributes: [
            .font: NSFont.systemFont(ofSize: 11),
            .foregroundColor: NSColor.secondaryLabelColor
        ]))
        textView.scrollRangeToVisible(NSRange(location: textView.string.count, length: 0))
    }

    private func removeLastSystemMessage() {
        guard let scrollView = chatTextView, let textView = scrollView.documentView as? NSTextView else { return }
        if let range = textView.string.range(of: "[Thinking...]", options: .backwards) {
            let before = textView.string[..<range.lowerBound]
            textView.string = before + "\n\n"
        }
    }

    func updatePetMenu() {
        guard let menu = statusItem.menu else { return }
        for item in menu.items {
            if item.tag == 200 {
                item.title = "Pet: \(PetState.shared.moodEmoji) \(PetState.shared.mood) \(PetState.shared.stageEmoji)"
            } else if item.tag == 201 {
                item.title = "  🍕 Hunger: \(Int(PetState.shared.hunger))%"
            } else if item.tag == 202 {
                item.title = "  😊 Happy: \(Int(PetState.shared.happiness))%"
            } else if item.tag == 203 {
                item.title = "  ⚡ Energy: \(Int(PetState.shared.energy))%"
            } else if item.tag == 204 {
                item.title = "  🧼 Clean: \(Int(PetState.shared.hygiene))%"
            } else if item.tag == 205 {
                item.title = "  \(PetState.shared.stageEmoji) Stage: \(PetState.shared.stageName) (\(Int(PetState.shared.careScore))%)"
            }
        }
    }

    func updateStatusBarTitle() {
        let manager = MultiPetManager.shared
        if manager.isMultiPetMode {
            let icons = manager.worstNeedIcons()
            statusItem.button?.title = icons.joined(separator: " ")
        } else {
            let pet = PetState.shared
            var worstStat = 100.0
            var icon = ""

            if pet.hunger < worstStat && pet.hunger < 30 {
                worstStat = pet.hunger
                icon = "🍕"
            }
            if pet.happiness < worstStat && pet.happiness < 30 {
                worstStat = pet.happiness
                icon = "😢"
            }
            if pet.energy < worstStat && pet.energy < 30 {
                worstStat = pet.energy
                icon = "😴"
            }
            if pet.hygiene < worstStat && pet.hygiene < 30 {
                worstStat = pet.hygiene
                icon = "🧼"
            }

            statusItem.button?.title = icon
        }
    }

    @objc func disciplinePet() {
        let manager = MultiPetManager.shared
        if manager.isMultiPetMode {
            let (affected, _) = manager.disciplineAll()
            for pet in affected {
                LLMService.shared.invalidateCache(for: pet)
            }
        } else {
            _ = PetState.shared.discipline()
            LLMService.shared.invalidateCache()
        }
        buildMenu()
        DispatchQueue.main.asyncAfter(deadline: .now() + 5) { [weak self] in self?.buildMenu() }
    }

    private func buildPetSubmenu(for pet: SelectableCharacter) -> NSMenu {
        let petState = MultiPetManager.shared.state(for: pet)
        let sub = NSMenu()

        let statusLine = NSMenuItem(title: "\(petState.moodEmoji) \(petState.mood) \(petState.stageEmoji) — \(petState.stageName) (\(Int(petState.careScore))%)", action: nil, keyEquivalent: "")
        statusLine.isEnabled = false
        sub.addItem(statusLine)

        let hungerItem = NSMenuItem(title: "  🍕 Hunger: \(Int(petState.hunger))%  😊 Happy: \(Int(petState.happiness))%", action: nil, keyEquivalent: "")
        hungerItem.isEnabled = false
        sub.addItem(hungerItem)

        let energyHygieneItem = NSMenuItem(title: "  ⚡ Energy: \(Int(petState.energy))%  🧼 Clean: \(Int(petState.hygiene))%", action: nil, keyEquivalent: "")
        energyHygieneItem.isEnabled = false
        sub.addItem(energyHygieneItem)

        let obedienceItem = NSMenuItem(title: "  🎓 Obedience: \(Int(petState.obedience))%", action: nil, keyEquivalent: "")
        obedienceItem.isEnabled = false
        sub.addItem(obedienceItem)

        if petState.isDisobedient {
            let disobeyItem = NSMenuItem(title: "  😡 \(petState.disobedienceMessage)", action: nil, keyEquivalent: "")
            disobeyItem.isEnabled = false
            sub.addItem(disobeyItem)
        }

        sub.addItem(NSMenuItem.separator())

        func addItem(_ title: String, action: Selector, needsAttention: Bool) {
            let item = NSMenuItem(title: title, action: action, keyEquivalent: "")
            item.target = self
            item.representedObject = pet
            if needsAttention {
                item.state = .on
            }
            sub.addItem(item)
        }

        addItem("  🍕 Feed", action: #selector(feedSinglePet(_:)), needsAttention: petState.hunger < 40)
        addItem("  🎾 Play", action: #selector(playSinglePet(_:)), needsAttention: petState.happiness < 40)
        addItem("  🧼 Clean", action: #selector(cleanSinglePet(_:)), needsAttention: petState.hygiene < 40)
        addItem("  😴 Sleep", action: #selector(sleepSinglePet(_:)), needsAttention: petState.energy < 40)

        sub.addItem(NSMenuItem.separator())

        addItem("  👋 Discipline", action: #selector(disciplineSinglePet(_:)), needsAttention: petState.isDisobedient)

        return sub
    }

    @objc func feedSinglePet(_ sender: NSMenuItem) {
        guard let pet = sender.representedObject as? SelectableCharacter else { return }
        MultiPetManager.shared.state(for: pet).feed(personality: pet.personality)
        LLMService.shared.invalidateCache(for: pet)
        refreshPetSubmenu(pet)
    }

    @objc func playSinglePet(_ sender: NSMenuItem) {
        guard let pet = sender.representedObject as? SelectableCharacter else { return }
        MultiPetManager.shared.state(for: pet).play(personality: pet.personality)
        LLMService.shared.invalidateCache(for: pet)
        refreshPetSubmenu(pet)
    }

    @objc func cleanSinglePet(_ sender: NSMenuItem) {
        guard let pet = sender.representedObject as? SelectableCharacter else { return }
        MultiPetManager.shared.state(for: pet).clean()
        LLMService.shared.invalidateCache(for: pet)
        refreshPetSubmenu(pet)
    }

    @objc func sleepSinglePet(_ sender: NSMenuItem) {
        guard let pet = sender.representedObject as? SelectableCharacter else { return }
        MultiPetManager.shared.state(for: pet).sleep()
        LLMService.shared.invalidateCache(for: pet)
        refreshPetSubmenu(pet)
    }

    @objc func disciplineSinglePet(_ sender: NSMenuItem) {
        guard let pet = sender.representedObject as? SelectableCharacter else { return }
        _ = MultiPetManager.shared.state(for: pet).discipline()
        LLMService.shared.invalidateCache(for: pet)
        refreshPetSubmenu(pet)
    }

    private func refreshPetSubmenu(_ char: SelectableCharacter) {
        guard let menu = statusItem.menu else { return }

        if let summaryItem = menu.items.first(where: { $0.tag == 200 }) {
            summaryItem.title = multiPetSummaryText()
        }

        updateActionButtons(in: menu)

        for item in menu.items where item.tag == 310 {
            if item.title.hasPrefix("  \(char.emoji)") {
                item.title = "  \(char.emoji) 💭 Thinking..."
                LLMService.shared.invalidateCache(for: char)
                let petState = MultiPetManager.shared.state(for: char)
                DispatchQueue.global(qos: .userInitiated).async {
                    LLMService.shared.generateStatus(for: char, petState: petState) { [weak self] _ in
                        DispatchQueue.main.async {
                            guard let menu = self?.statusItem.menu else { return }
                            for mi in menu.items where mi.tag == 310 && mi.title.hasPrefix("  \(char.emoji)") {
                                mi.title = "  \(char.emoji) \(LLMService.shared.getCachedStatus(for: char) ?? "...")"
                            }
                        }
                    }
                }
            }
        }

        for item in menu.items {
            if item.title == "📋 Pet Status", let statusSub = item.submenu {
                for subItem in statusSub.items {
                    if subItem.title == "\(char.emoji) \(char.displayName)" {
                        let newSub = buildPetSubmenu(for: char)
                        subItem.submenu = newSub
                        petSubmenus[char] = newSub
                        return
                    }
                }
            }
        }
    }

    private func refreshAffectedPets(_ pets: [SelectableCharacter]) {
        for pet in pets {
            refreshPetSubmenu(pet)
        }
    }

    private func updateActionButtons(in menu: NSMenu) {
        let manager = MultiPetManager.shared
        guard manager.isMultiPetMode else { return }

        let feedCount = countActionsFor("feed")
        let playCount = countActionsFor("play")
        let cleanCount = countActionsFor("clean")
        let sleepCount = countActionsFor("sleep")

        for item in menu.items {
            if item.title.hasPrefix("🍕 Feed All"), item.tag != 100 {
                menu.removeItem(item)
                if feedCount > 0 {
                    let feedItem = NSMenuItem(title: "🍕 Feed All (\(feedCount))", action: #selector(feedPet), keyEquivalent: "")
                    feedItem.target = self
                    let idx = menu.index(of: item) ?? menu.items.count
                    menu.insertItem(feedItem, at: idx)
                }
                break
            }
        }

        for item in menu.items where item.title.hasPrefix("🎾 Play All") {
            menu.removeItem(item)
            if playCount > 0 {
                let playItem = NSMenuItem(title: "🎾 Play All (\(playCount))", action: #selector(playWithPet), keyEquivalent: "")
                playItem.target = self
                let idx = menu.index(of: item) ?? menu.items.count
                menu.insertItem(playItem, at: idx)
            }
            break
        }

        for item in menu.items where item.title.hasPrefix("🧼 Clean All") {
            menu.removeItem(item)
            if cleanCount > 0 {
                let cleanItem = NSMenuItem(title: "🧼 Clean All (\(cleanCount))", action: #selector(cleanPet), keyEquivalent: "")
                cleanItem.target = self
                let idx = menu.index(of: item) ?? menu.items.count
                menu.insertItem(cleanItem, at: idx)
            }
            break
        }

        for item in menu.items where item.title.hasPrefix("😴 Sleep All") {
            menu.removeItem(item)
            if sleepCount > 0 {
                let sleepItem = NSMenuItem(title: "😴 Sleep All (\(sleepCount))", action: #selector(letPetSleep), keyEquivalent: "")
                sleepItem.target = self
                let idx = menu.index(of: item) ?? menu.items.count
                menu.insertItem(sleepItem, at: idx)
            }
            break
        }
    }

    private func countActionsFor(_ type: String) -> Int {
        let manager = MultiPetManager.shared
        guard manager.isMultiPetMode else { return 0 }
        switch type {
        case "feed": return manager.selectedPets.filter { manager.state(for: $0).hunger < 40 }.count
        case "play": return manager.selectedPets.filter { manager.state(for: $0).happiness < 40 }.count
        case "clean": return manager.selectedPets.filter { manager.state(for: $0).hygiene < 40 }.count
        case "sleep": return manager.selectedPets.filter { manager.state(for: $0).energy < 40 }.count
        default: return 0
        }
    }

    private func multiPetSummaryText() -> String {
        let manager = MultiPetManager.shared
        let icons = manager.worstNeedIcons()
        let uniqueIcons = Array(Set(icons)).prefix(4)
        if uniqueIcons.isEmpty {
            return "🐾 All pets happy!"
        }
        return "🐾 Needs: \(uniqueIcons.joined(separator: " "))"
    }
}
