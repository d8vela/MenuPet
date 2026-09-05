import AppKit

class SpriteRenderer {
    let pixelSize: CGFloat = 2
    let frameWidth = 48
    let frameHeight = 48

    func renderFrame(character: SelectableCharacter, frame: Int) -> NSImage {
        let pixels = getPixels(character: character, frame: frame)

        let isBoo: Bool
        if case .marioItem(.boo) = character { isBoo = true } else { isBoo = false }

        var minY = frameHeight, maxY = 0, minX = frameWidth, maxX = 0
        if isBoo {
            // Fixed bbox encompassing all circular positions: base(5,5) ±3 → x:2-23, y:2-19
            minX = 2; maxX = 23
            minY = 2; maxY = 19
        } else {
            for y in 0..<frameHeight {
                for x in 0..<frameWidth {
                    if pixels[y][x] != NSColor.clear {
                        minY = min(minY, y)
                        maxY = max(maxY, y)
                        minX = min(minX, x)
                        maxX = max(maxX, x)
                    }
                }
            }
        }

        let contentRows = CGFloat(maxY - minY + 1)
        let contentCols = CGFloat(maxX - minX + 1)
        let ps: CGFloat = 2
        let barHeight: CGFloat = 22
        let scale = barHeight / (contentRows * ps)
        let targetW = contentCols * ps * scale

        let img = NSImage(size: NSSize(width: targetW, height: barHeight))
        img.lockFocus()

        guard let context = NSGraphicsContext.current else {
            img.unlockFocus()
            return img
        }
        let ctx = context.cgContext
        ctx.saveGState()

        let offsetX = -(CGFloat(minX) * ps * scale)
        let offsetY = -(CGFloat(frameHeight - 1 - maxY)) * ps
        ctx.concatenate(CGAffineTransform(scaleX: scale, y: scale))
        ctx.concatenate(CGAffineTransform(translationX: offsetX / scale, y: offsetY))

        // Draw the actual sprite
        for y in 0..<frameHeight {
            for x in 0..<frameWidth {
                let color = pixels[y][x]
                color.setFill()
                NSRect(x: CGFloat(x) * ps, y: CGFloat(frameHeight - 1 - y) * ps,
                       width: ps, height: ps).fill()
            }
        }

        ctx.restoreGState()
        img.unlockFocus()
        img.isTemplate = false
        return img
    }

    private func getPixels(character: SelectableCharacter, frame: Int) -> [[NSColor]] {
        var grid = Array(repeating: Array(repeating: NSColor.clear, count: frameWidth), count: frameHeight)

        switch character {
        case .pokemon(let pokemon):
            switch pokemon {
            case .pikachu: drawPikachu(grid: &grid, frame: frame)
            case .psyduck: drawPsyduck(grid: &grid, frame: frame)
            case .snorlax: drawSnorlax(grid: &grid, frame: frame)
            case .charmander: drawCharmander(grid: &grid, frame: frame)
            case .bulbasaur: drawBulbasaur(grid: &grid, frame: frame)
            case .squirtle: drawSquirtle(grid: &grid, frame: frame)
            case .jigglypuff: drawJigglypuff(grid: &grid, frame: frame)
            case .meowth: drawMeowth(grid: &grid, frame: frame)
            case .eevee: drawEevee(grid: &grid, frame: frame)
            case .mew: drawMew(grid: &grid, frame: frame)
            case .gengar: drawGengar(grid: &grid, frame: frame)
            case .dragonite: drawDragonite(grid: &grid, frame: frame)
            case .gyarados: drawGyarados(grid: &grid, frame: frame)
            case .arcanine: drawArcanine(grid: &grid, frame: frame)
            case .alakazam: drawAlakazam(grid: &grid, frame: frame)
            case .machamp: drawMachamp(grid: &grid, frame: frame)
            case .golem: drawGolem(grid: &grid, frame: frame)
            case .onix: drawOnix(grid: &grid, frame: frame)
            case .jolteon: drawJolteon(grid: &grid, frame: frame)
            case .flareon: drawFlareon(grid: &grid, frame: frame)
            case .vaporeon: drawVaporeon(grid: &grid, frame: frame)
            case .porygon: drawPorygon(grid: &grid, frame: frame)
            case .ditto: drawDitto(grid: &grid, frame: frame)
            case .lapras: drawLapras(grid: &grid, frame: frame)
            case .marill: drawMarill(grid: &grid, frame: frame)
            case .umbreon: drawUmbreon(grid: &grid, frame: frame)
            case .pokeball: drawPokeball(grid: &grid, frame: frame)
            }
        case .marioItem(let item):
            switch item {
            case .mario: drawMario(grid: &grid, frame: frame)
            case .luigi: drawLuigi(grid: &grid, frame: frame)
            case .peach: drawPeach(grid: &grid, frame: frame)
            case .toad: drawToad(grid: &grid, frame: frame)
            case .bowser: drawBowser(grid: &grid, frame: frame)
            case .yoshi: drawYoshi(grid: &grid, frame: frame)
            case .donkeyKong: drawDonkeyKong(grid: &grid, frame: frame)
            case .wario: drawWario(grid: &grid, frame: frame)
            case .waluigi: drawWaluigi(grid: &grid, frame: frame)
            case .boo: drawBoo(grid: &grid, frame: frame)
            case .superMushroom: drawSuperMushroom(grid: &grid, frame: frame)
            case .fireFlower: drawFireFlower(grid: &grid, frame: frame)
            case .starman: drawStarman(grid: &grid, frame: frame)
            case .coin: drawCoin(grid: &grid, frame: frame)
            case .oneUpMushroom: drawOneUpMushroom(grid: &grid, frame: frame)
            case .yoshiEgg: drawYoshiEgg(grid: &grid, frame: frame)
            case .pipe: drawPipe(grid: &grid, frame: frame)
            case .questionBlock: drawQuestionBlock(grid: &grid, frame: frame)
            case .goomba: drawGoomba(grid: &grid, frame: frame)
            case .koopaTroopa: drawKoopaTroopa(grid: &grid, frame: frame)
            }
        case .marioKart(let kartChar):
            switch kartChar {
            case .mario: drawKartMario(grid: &grid, frame: frame)
            case .luigi: drawKartLuigi(grid: &grid, frame: frame)
            case .peach: drawKartPeach(grid: &grid, frame: frame)
            case .toad: drawKartToad(grid: &grid, frame: frame)
            case .bowser: drawKartBowser(grid: &grid, frame: frame)
            case .donkeyKong: drawKartDonkeyKong(grid: &grid, frame: frame)
            case .yoshi: drawKartYoshi(grid: &grid, frame: frame)
            case .wario: drawKartWario(grid: &grid, frame: frame)
            case .redShell: drawKartRedShell(grid: &grid, frame: frame)
            case .greenShell: drawKartGreenShell(grid: &grid, frame: frame)
            case .bananaPeel: drawKartBananaPeel(grid: &grid, frame: frame)
            case .bomb: drawKartBomb(grid: &grid, frame: frame)
            case .bulletBill: drawKartBulletBill(grid: &grid, frame: frame)
            case .blueShell: drawKartBlueShell(grid: &grid, frame: frame)
            case .star: drawKartStar(grid: &grid, frame: frame)
            case .lightning: drawKartLightning(grid: &grid, frame: frame)
            case .mushroom: drawKartMushroom(grid: &grid, frame: frame)
            case .tripleMushroom: drawKartTripleMushroom(grid: &grid, frame: frame)
            case .goldenMushroom: drawKartGoldenMushroom(grid: &grid, frame: frame)
            }
        case .contra(let contraChar):
            switch contraChar {
            case .bill: drawContraBill(grid: &grid, frame: frame)
            case .lance: drawContraLance(grid: &grid, frame: frame)
            case .alienWall: drawContraAlienWall(grid: &grid, frame: frame)
            case .neoDic: drawContraNeoDic(grid: &grid, frame: frame)
            case .turret: drawContraTurret(grid: &grid, frame: frame)
            case .sweat: drawContraSweat(grid: &grid, frame: frame)
            case .probox: drawContraProbox(grid: &grid, frame: frame)
            case .fireGun: drawContraFireGun(grid: &grid, frame: frame)
            case .machineGun: drawContraMachineGun(grid: &grid, frame: frame)
            case .spreadGun: drawContraSpreadGun(grid: &grid, frame: frame)
            case .laserGun: drawContraLaserGun(grid: &grid, frame: frame)
            case .barrier: drawContraBarrier(grid: &grid, frame: frame)
            case .rapidBullets: drawContraRapidBullets(grid: &grid, frame: frame)
            }
        case .tmnt(let tmntChar):
            switch tmntChar {
            case .leonardo: drawTMNTLeonardo(grid: &grid, frame: frame)
            case .donatello: drawTMNTDonatello(grid: &grid, frame: frame)
            case .raphael: drawTMNTRaphael(grid: &grid, frame: frame)
            case .michelangelo: drawTMNTMichelangelo(grid: &grid, frame: frame)
            case .splinter: drawTMNTSplinter(grid: &grid, frame: frame)
            case .shredder: drawTMNTShredder(grid: &grid, frame: frame)
            case .krang: drawTMNTKrang(grid: &grid, frame: frame)
            case .bebop: drawTMNTBebop(grid: &grid, frame: frame)
            case .rocksteady: drawTMNTRocksteady(grid: &grid, frame: frame)
            case .april: drawTMNTApril(grid: &grid, frame: frame)
            case .CaseyJones: drawTMNTCaseyJones(grid: &grid, frame: frame)
            }
        case .streetFighter(let sfChar):
            switch sfChar {
            case .ryu: drawSFRyu(grid: &grid, frame: frame)
            case .ken: drawSFKen(grid: &grid, frame: frame)
            case .chunLi: drawSFChunLi(grid: &grid, frame: frame)
            case .guile: drawSFGuile(grid: &grid, frame: frame)
            case .dhalsim: drawSFDhalsim(grid: &grid, frame: frame)
            case .zangief: drawSFZangief(grid: &grid, frame: frame)
            case .blanka: drawSFBlanka(grid: &grid, frame: frame)
            case .eHonda: drawSFEHonda(grid: &grid, frame: frame)
            case .balrog: drawSFBalrog(grid: &grid, frame: frame)
            case .vega: drawSFVega(grid: &grid, frame: frame)
            case .sagat: drawSFSagat(grid: &grid, frame: frame)
            case .dictator: drawSFDictator(grid: &grid, frame: frame)
            }
        case .metalSlug(let msChar):
            switch msChar {
            case .marco: drawMSMarco(grid: &grid, frame: frame)
            case .tarma: drawMSTarma(grid: &grid, frame: frame)
            case .eri: drawMSEri(grid: &grid, frame: frame)
            case .fio: drawMSFio(grid: &grid, frame: frame)
            case .morden: drawMSMorden(grid: &grid, frame: frame)
            case .camel: drawMSCamel(grid: &grid, frame: frame)
            case .slugTank: drawMSSlugTank(grid: &grid, frame: frame)
            case .zombie: drawMSZombie(grid: &grid, frame: frame)
            case .mummy: drawMSMummy(grid: &grid, frame: frame)
            case .ape: drawMSApe(grid: &grid, frame: frame)
            case .hermit: drawMSHermit(grid: &grid, frame: frame)
            case .crab: drawMSCrab(grid: &grid, frame: frame)
            }
        case .overwatch(let owChar):
            switch owChar {
            case .tracer: drawOWTracer(grid: &grid, frame: frame)
            case .genji: drawOWGenji(grid: &grid, frame: frame)
            case .mercy: drawOWMercy(grid: &grid, frame: frame)
            case .reinhardt: drawOWReinhardt(grid: &grid, frame: frame)
            case .dva: drawOWDva(grid: &grid, frame: frame)
            case .winston: drawOWWinston(grid: &grid, frame: frame)
            case .soldier76: drawOWSoldier76(grid: &grid, frame: frame)
            case .reaper: drawOWReaper(grid: &grid, frame: frame)
            case .widowmaker: drawOWWidowmaker(grid: &grid, frame: frame)
            case .mccree: drawOWCassidy(grid: &grid, frame: frame)
            case .pharah: drawOWPharah(grid: &grid, frame: frame)
            case .lucio: drawOWLucio(grid: &grid, frame: frame)
            case .ana: drawOWAna(grid: &grid, frame: frame)
            case .zarya: drawOWZarya(grid: &grid, frame: frame)
            case .mei: drawOWMei(grid: &grid, frame: frame)
            case .symmetra: drawOWSymmetra(grid: &grid, frame: frame)
            }
        case .kirby(let kirbyChar):
            switch kirbyChar {
            case .kirby: drawKirbyKirby(grid: &grid, frame: frame)
            case .kingDedede: drawKirbyKingDedede(grid: &grid, frame: frame)
            case .metaKnight: drawKirbyMetaKnight(grid: &grid, frame: frame)
            case .bandanaWaddleDee: drawKirbyBandanaWaddleDee(grid: &grid, frame: frame)
            case .waddleDee: drawKirbyWaddleDee(grid: &grid, frame: frame)
            case .waddleDoo: drawKirbyWaddleDoo(grid: &grid, frame: frame)
            case .Gordy: drawKirbyGordo(grid: &grid, frame: frame)
            case .brontoBurt: drawKirbyBrontoBurt(grid: &grid, frame: frame)
            case .bonkers: drawKirbyBonkers(grid: &grid, frame: frame)
            case .kingDededeBoss: drawKirbyKingDededeBoss(grid: &grid, frame: frame)
            }
        case .zelda(let zeldaChar):
            switch zeldaChar {
            case .link: drawZeldaLink(grid: &grid, frame: frame)
            case .zelda: drawZeldaPrincess(grid: &grid, frame: frame)
            case .ganon: drawZeldaGanon(grid: &grid, frame: frame)
            case .navi: drawZeldaNavi(grid: &grid, frame: frame)
            case .midna: drawZeldaMidna(grid: &grid, frame: frame)
            case .impa: drawZeldaImpa(grid: &grid, frame: frame)
            case .skullKid: drawZeldaSkullKid(grid: &grid, frame: frame)
            case .greatFairy: drawZeldaGreatFairy(grid: &grid, frame: frame)
            case .octorok: drawZeldaOctorok(grid: &grid, frame: frame)
            case .moblin: drawZeldaMoblin(grid: &grid, frame: frame)
            case .keese: drawZeldaKeese(grid: &grid, frame: frame)
            case .darkLink: drawZeldaDarkLink(grid: &grid, frame: frame)
            }
        case .megaMan(let mmChar):
            switch mmChar {
            case .megaMan: drawMMMegaMan(grid: &grid, frame: frame)
            case .protoMan: drawMMProtoMan(grid: &grid, frame: frame)
            case .bass: drawMMBass(grid: &grid, frame: frame)
            case .roll: drawMMRoll(grid: &grid, frame: frame)
            case .rush: drawMMRush(grid: &grid, frame: frame)
            case .cutMan: drawMMCutMan(grid: &grid, frame: frame)
            case .gutsMan: drawMMGutsMan(grid: &grid, frame: frame)
            case .iceMan: drawMMIceMan(grid: &grid, frame: frame)
            case .bombMan: drawMMBombMan(grid: &grid, frame: frame)
            case .fireMan: drawMMFireMan(grid: &grid, frame: frame)
            case .elecMan: drawMMElecMan(grid: &grid, frame: frame)
            case .metalMan: drawMMMetalMan(grid: &grid, frame: frame)
            case .crashMan: drawMMCrashMan(grid: &grid, frame: frame)
            case .hardMan: drawMMHardMan(grid: &grid, frame: frame)
            case .tornadoMan: drawMMTornadoMan(grid: &grid, frame: frame)
            case .stoneMan: drawMMStoneMan(grid: &grid, frame: frame)
            }
        case .marvel(let mvChar):
            switch mvChar {
            case .ironMan: drawMVIronMan(grid: &grid, frame: frame)
            case .captainAmerica: drawMVCaptainAmerica(grid: &grid, frame: frame)
            case .thor: drawMVThor(grid: &grid, frame: frame)
            case .hulk: drawMVHulk(grid: &grid, frame: frame)
            case .spiderMan: drawMVSpiderMan(grid: &grid, frame: frame)
            case .wolverine: drawMVWolverine(grid: &grid, frame: frame)
            case .blackPanther: drawMVBlackPanther(grid: &grid, frame: frame)
            case .daredevil: drawMVDaredevil(grid: &grid, frame: frame)
            case .blackWidow: drawMVBlackWidow(grid: &grid, frame: frame)
            case .hawkeye: drawMVHawkeye(grid: &grid, frame: frame)
            case .vision: drawMVVision(grid: &grid, frame: frame)
            case .scarletWitch: drawMVScarletWitch(grid: &grid, frame: frame)
            case .warMachine: drawMVWarMachine(grid: &grid, frame: frame)
            case .spiderWoman: drawMVSpiderWoman(grid: &grid, frame: frame)
            case .cyclops: drawMVCyclops(grid: &grid, frame: frame)
            case .sheHulk: drawMVSheHulk(grid: &grid, frame: frame)
            case .juggernaut: drawMVJuggernaut(grid: &grid, frame: frame)
            case .loki: drawMVLoki(grid: &grid, frame: frame)
            case .venom: drawMVVenom(grid: &grid, frame: frame)
            }
        case .dc(let dcChar):
            switch dcChar {
            case .batman: drawDCBatman(grid: &grid, frame: frame)
            case .superman: drawDCSuperman(grid: &grid, frame: frame)
            case .wonderWoman: drawDCWonderWoman(grid: &grid, frame: frame)
            case .flash: drawDCFlash(grid: &grid, frame: frame)
            case .greenLantern: drawDCGreenLantern(grid: &grid, frame: frame)
            case .aquaman: drawDCAquaman(grid: &grid, frame: frame)
            case .joker: drawDCJoker(grid: &grid, frame: frame)
            case .harleyQuinn: drawDCHarleyQuinn(grid: &grid, frame: frame)
            case .lexLuthor: drawDCLexLuthor(grid: &grid, frame: frame)
            case .darkseid: drawDCDarkseid(grid: &grid, frame: frame)
            }
        case .naruto(let nChar):
            switch nChar {
            case .naruto: drawNarutoNaruto(grid: &grid, frame: frame)
            case .sasuke: drawNarutoSasuke(grid: &grid, frame: frame)
            case .sakura: drawNarutoSakura(grid: &grid, frame: frame)
            case .kakashi: drawNarutoKakashi(grid: &grid, frame: frame)
            case .itachi: drawNarutoItachi(grid: &grid, frame: frame)
            case .gaara: drawNarutoGaara(grid: &grid, frame: frame)
            case .orochimaru: drawNarutoOrochimaru(grid: &grid, frame: frame)
            case .jiraiya: drawNarutoJiraiya(grid: &grid, frame: frame)
            case .tsunade: drawNarutoTsunade(grid: &grid, frame: frame)
            case .rockLee: drawNarutoRockLee(grid: &grid, frame: frame)
            case .hinata: drawNarutoHinata(grid: &grid, frame: frame)
            case .shikamaru: drawNarutoShikamaru(grid: &grid, frame: frame)
            }
        case .simpsons(let sChar):
            switch sChar {
            case .homer: drawSimpsonsHomer(grid: &grid, frame: frame)
            case .marge: drawSimpsonsMarge(grid: &grid, frame: frame)
            case .bart: drawSimpsonsBart(grid: &grid, frame: frame)
            case .lisa: drawSimpsonsLisa(grid: &grid, frame: frame)
            case .maggie: drawSimpsonsMaggie(grid: &grid, frame: frame)
            case .nedFlanders: drawSimpsonsNedFlanders(grid: &grid, frame: frame)
            case .mrBurns: drawSimpsonsMrBurns(grid: &grid, frame: frame)
            case .smithers: drawSimpsonsSmithers(grid: &grid, frame: frame)
            case .milhouse: drawSimpsonsMilhouse(grid: &grid, frame: frame)
            case .nelson: drawSimpsonsNelson(grid: &grid, frame: frame)
            case .principalSkinner: drawSimpsonsPrincipalSkinner(grid: &grid, frame: frame)
            case .krusty: drawSimpsonsKrusty(grid: &grid, frame: frame)
            }
        case .mortalKombat(let mkChar):
            switch mkChar {
            case .scorpion: drawMKScorpion(grid: &grid, frame: frame)
            case .subZero: drawMKSubZero(grid: &grid, frame: frame)
            case .raiden: drawMKRaiden(grid: &grid, frame: frame)
            case .liuKang: drawMKLiuKang(grid: &grid, frame: frame)
            case .sonya: drawMKSonya(grid: &grid, frame: frame)
            case .johnnyCage: drawMKJohnnyCage(grid: &grid, frame: frame)
            case .shangTsung: drawMKShangTsung(grid: &grid, frame: frame)
            case .goro: drawMKGoro(grid: &grid, frame: frame)
            case .kitana: drawMKKitana(grid: &grid, frame: frame)
            case .jade: drawMKJade(grid: &grid, frame: frame)
            case .milena: drawMKMilena(grid: &grid, frame: frame)
            case .reptile: drawMKReptile(grid: &grid, frame: frame)
            }
        case .minions(let mChar):
            switch mChar {
            case .kevin: drawMinionsKevin(grid: &grid, frame: frame)
            case .stuart: drawMinionsStuart(grid: &grid, frame: frame)
            case .bob: drawMinionsBob(grid: &grid, frame: frame)
            case .dave: drawMinionsDave(grid: &grid, frame: frame)
            case .jerry: drawMinionsJerry(grid: &grid, frame: frame)
            case .phil: drawMinionsPhil(grid: &grid, frame: frame)
            case .tim: drawMinionsTim(grid: &grid, frame: frame)
            case .mark: drawMinionsMark(grid: &grid, frame: frame)
            case .carl: drawMinionsCarl(grid: &grid, frame: frame)
            case .jorge: drawMinionsJorge(grid: &grid, frame: frame)
            case .donny: drawMinionsDonny(grid: &grid, frame: frame)
            case .eric: drawMinionsEric(grid: &grid, frame: frame)
            }
        case .dragonBall(let dbChar):
            switch dbChar {
            case .goku: drawDBGoku(grid: &grid, frame: frame)
            case .vegeta: drawDBVegeta(grid: &grid, frame: frame)
            case .gohan: drawDBGohan(grid: &grid, frame: frame)
            case .piccolo: drawDBPiccolo(grid: &grid, frame: frame)
            case .frieza: drawDBFrieza(grid: &grid, frame: frame)
            case .cell: drawDBCell(grid: &grid, frame: frame)
            case .majinBuu: drawDBMajinBuu(grid: &grid, frame: frame)
            case .krillin: drawDBKrillin(grid: &grid, frame: frame)
            case .trunks: drawDBTrunks(grid: &grid, frame: frame)
            case .goten: drawDBGoten(grid: &grid, frame: frame)
            case .beerus: drawDBBeerus(grid: &grid, frame: frame)
            case .whis: drawDBWhis(grid: &grid, frame: frame)
            }
        case .ghibli(let gChar):
            switch gChar {
            case .totoro: drawGhibliTotoro(grid: &grid, frame: frame)
            case .noFace: drawGhibliNoFace(grid: &grid, frame: frame)
            case .kiki: drawGhibliKiki(grid: &grid, frame: frame)
            case .calcifer: drawGhibliCalcifer(grid: &grid, frame: frame)
            case .ponyo: drawGhibliPonyo(grid: &grid, frame: frame)
            case .satsuki: drawGhibliSatsuki(grid: &grid, frame: frame)
            case .mei: drawGhibliMei(grid: &grid, frame: frame)
            case .howl: drawGhibliHowl(grid: &grid, frame: frame)
            case .sophie: drawGhibliSophie(grid: &grid, frame: frame)
            case .append: drawGhibliAppend(grid: &grid, frame: frame)
            case .jiro: drawGhibliJiro(grid: &grid, frame: frame)
            case .chihiro: drawGhibliChihiro(grid: &grid, frame: frame)
            }
        case .gundam(let gChar):
            switch gChar {
            case .rx78: drawGundamRX78(grid: &grid, frame: frame)
            case .zaku: drawGundamZaku(grid: &grid, frame: frame)
            case .freedom: drawGundamFreedom(grid: &grid, frame: frame)
            case .justice: drawGundamJustice(grid: &grid, frame: frame)
            case .strike: drawGundamStrike(grid: &grid, frame: frame)
            case .barbatos: drawGundamBarbatos(grid: &grid, frame: frame)
            case .unicorn: drawGundamUnicorn(grid: &grid, frame: frame)
            case .sinanju: drawGundamSinanju(grid: &grid, frame: frame)
            case .exia: drawGundamExia(grid: &grid, frame: frame)
            case .WingZero: drawGundamWingZero(grid: &grid, frame: frame)
            case .deathscythe: drawGundamDeathscythe(grid: &grid, frame: frame)
            case .heavyArms: drawGundamHeavyArms(grid: &grid, frame: frame)
            }
        case .starWars(let sChar):
            switch sChar {
            case .luke: drawStarWarsLuke(grid: &grid, frame: frame)
            case .vader: drawStarWarsVader(grid: &grid, frame: frame)
            case .leia: drawStarWarsLeia(grid: &grid, frame: frame)
            case .han: drawStarWarsHan(grid: &grid, frame: frame)
            case .chewbacca: drawStarWarsChewbacca(grid: &grid, frame: frame)
            case .yoda: drawStarWarsYoda(grid: &grid, frame: frame)
            case .maul: drawStarWarsMaul(grid: &grid, frame: frame)
            case .bobaFett: drawStarWarsBobaFett(grid: &grid, frame: frame)
            case .c3po: drawStarWarsC3PO(grid: &grid, frame: frame)
            case .r2d2: drawStarWarsR2D2(grid: &grid, frame: frame)
            case .obiWan: drawStarWarsObiWan(grid: &grid, frame: frame)
            case .kyloRen: drawStarWarsKyloRen(grid: &grid, frame: frame)
            case .stormtrooper: drawStarWarsStormtrooper(grid: &grid, frame: frame)
            case .grogu: drawStarWarsGrogu(grid: &grid, frame: frame)
            case .mandalorian: drawStarWarsMandalorian(grid: &grid, frame: frame)
            }
        case .labubu(let lChar):
            switch lChar {
            case .labubu: drawLabubu(grid: &grid, frame: frame, colorScheme: 0)
            case .labubuPink: drawLabubu(grid: &grid, frame: frame, colorScheme: 1)
            case .labubuGray: drawLabubu(grid: &grid, frame: frame, colorScheme: 2)
            case .labubuBrown: drawLabubu(grid: &grid, frame: frame, colorScheme: 3)
            case .labubuWhite: drawLabubu(grid: &grid, frame: frame, colorScheme: 4)
            case .labubuGolden: drawLabubu(grid: &grid, frame: frame, colorScheme: 5)
            }
        case .kingOfTheHill(let kChar):
            switch kChar {
            case .hank: drawKOTHHank(grid: &grid, frame: frame)
            case .peggy: drawKOTHPeggy(grid: &grid, frame: frame)
            case .bobby: drawKOTHBobby(grid: &grid, frame: frame)
            case .dale: drawKOTHDale(grid: &grid, frame: frame)
            case .bill: drawKOTHBill(grid: &grid, frame: frame)
            case .boomhauer: drawKOTHBoomhauer(grid: &grid, frame: frame)
            case .luanne: drawKOTHLuanne(grid: &grid, frame: frame)
            case .cotton: drawKOTHCotton(grid: &grid, frame: frame)
            case .kahn: drawKOTHKahn(grid: &grid, frame: frame)
            case .ladybird: drawKOTHLadybird(grid: &grid, frame: frame)
            case .johnRedcorn: drawKOTHJohnRedcorn(grid: &grid, frame: frame)
            case .buckStrickland: drawKOTHBuckStrickland(grid: &grid, frame: frame)
            }
        case .familyGuy(let fChar):
            switch fChar {
            case .peter: drawFamilyGuyPeter(grid: &grid, frame: frame)
            case .lois: drawFamilyGuyLois(grid: &grid, frame: frame)
            case .stewie: drawFamilyGuyStewie(grid: &grid, frame: frame)
            case .brian: drawFamilyGuyBrian(grid: &grid, frame: frame)
            case .chris: drawFamilyGuyChris(grid: &grid, frame: frame)
            case .meg: drawFamilyGuyMeg(grid: &grid, frame: frame)
            case .quagmire: drawFamilyGuyQuagmire(grid: &grid, frame: frame)
            case .cleveland: drawFamilyGuyCleveland(grid: &grid, frame: frame)
            case .joe: drawFamilyGuyJoe(grid: &grid, frame: frame)
            case .adamWest: drawFamilyGuyAdamWest(grid: &grid, frame: frame)
            case .herbert: drawFamilyGuyHerbert(grid: &grid, frame: frame)
            case .tomTucker: drawFamilyGuyTomTucker(grid: &grid, frame: frame)
            }
        case .futurama(let fChar):
            switch fChar {
            case .fry: drawFuturamaFry(grid: &grid, frame: frame)
            case .leela: drawFuturamaLeela(grid: &grid, frame: frame)
            case .bender: drawFuturamaBender(grid: &grid, frame: frame)
            case .amy: drawFuturamaAmy(grid: &grid, frame: frame)
            case .farnsworth: drawFuturamaFarnsworth(grid: &grid, frame: frame)
            case .hermes: drawFuturamaHermes(grid: &grid, frame: frame)
            case .zoidberg: drawFuturamaZoidberg(grid: &grid, frame: frame)
            case .cubert: drawFuturamaCubert(grid: &grid, frame: frame)
            case .ndnd: drawFuturamaNdnd(grid: &grid, frame: frame)
            case .zapp: drawFuturamaZapp(grid: &grid, frame: frame)
            }
        case .batman(let bChar):
            switch bChar {
            case .joker: drawBatmanJoker(grid: &grid, frame: frame)
            case .bane: drawBatmanBane(grid: &grid, frame: frame)
            case .riddler: drawBatmanRiddler(grid: &grid, frame: frame)
            case .penguin: drawBatmanPenguin(grid: &grid, frame: frame)
            case .harleyQuinn: drawBatmanHarleyQuinn(grid: &grid, frame: frame)
            case .scarecrow: drawBatmanScarecrow(grid: &grid, frame: frame)
            case .killerCroc: drawBatmanKillerCroc(grid: &grid, frame: frame)
            case .poisonIvy: drawBatmanPoisonIvy(grid: &grid, frame: frame)
            case .catwoman: drawBatmanCatwoman(grid: &grid, frame: frame)
            case .twoFace: drawBatmanTwoFace(grid: &grid, frame: frame)
            case .mrFreeze: drawBatmanMrFreeze(grid: &grid, frame: frame)
            case .redHood: drawBatmanRedHood(grid: &grid, frame: frame)
            case .rasAlGhul: drawBatmanRasAlGhul(grid: &grid, frame: frame)
            case .deathstroke: drawBatmanDeathstroke(grid: &grid, frame: frame)
            }
        }

        return grid
    }

    // MARK: - Pikachu (yellow body, red cheeks, pointy ears, running legs)
    private func drawPikachu(grid: inout [[NSColor]], frame: Int) {
        let y = NSColor(red: 1.0, green: 0.88, blue: 0.0, alpha: 1.0)
        let b = NSColor.black
        let r = NSColor(red: 0.9, green: 0.15, blue: 0.15, alpha: 1.0)
        let br = NSColor(red: 0.55, green: 0.3, blue: 0.1, alpha: 1.0)
        let anim = frame % 2

        // Row 0: ear tips
        setPixel(&grid, x: 5, y: 0, color: b)
        setPixel(&grid, x: 6, y: 0, color: y)
        setPixel(&grid, x: 9, y: 0, color: y)
        setPixel(&grid, x: 10, y: 0, color: b)

        // Row 1: ears
        setPixel(&grid, x: 5, y: 1, color: y)
        setPixel(&grid, x: 6, y: 1, color: y)
        setPixel(&grid, x: 9, y: 1, color: y)
        setPixel(&grid, x: 10, y: 1, color: y)

        // Row 2: head top
        for x in 5...10 { setPixel(&grid, x: x, y: 2, color: y) }

        // Row 3: head with eyes
        for x in 4...11 { setPixel(&grid, x: x, y: 3, color: y) }
        setPixel(&grid, x: 6, y: 3, color: b)
        setPixel(&grid, x: 9, y: 3, color: b)

        // Row 4: cheeks and mouth
        for x in 4...11 { setPixel(&grid, x: x, y: 4, color: y) }
        setPixel(&grid, x: 5, y: 4, color: r)
        setPixel(&grid, x: 10, y: 4, color: r)
        setPixel(&grid, x: 7, y: 4, color: br)
        setPixel(&grid, x: 8, y: 4, color: br)

        // Row 5: body
        for x in 5...10 { setPixel(&grid, x: x, y: 5, color: y) }

        // Row 6: body
        for x in 5...10 { setPixel(&grid, x: x, y: 6, color: y) }

        // Row 7: body
        for x in 5...10 { setPixel(&grid, x: x, y: 7, color: y) }

        // Row 8: feet
        if anim == 0 {
            setPixel(&grid, x: 6, y: 8, color: br)
            setPixel(&grid, x: 9, y: 8, color: br)
        } else {
            setPixel(&grid, x: 5, y: 8, color: br)
            setPixel(&grid, x: 10, y: 8, color: br)
        }

        // Tail (lightning bolt)
        setPixel(&grid, x: 11, y: 4, color: y)
        setPixel(&grid, x: 12, y: 3, color: y)
        setPixel(&grid, x: 13, y: 2, color: y)
        setPixel(&grid, x: 14, y: 1, color: br)
    }

    // MARK: - Psyduck (classic sprite style, confused head bob)
    private func drawPsyduck(grid: inout [[NSColor]], frame: Int) {
        let yellow = NSColor(red: 1.0, green: 0.92, blue: 0.2, alpha: 1.0)
        let darkYellow = NSColor(red: 0.85, green: 0.75, blue: 0.1, alpha: 1.0)
        let tan = NSColor(red: 0.95, green: 0.6, blue: 0.15, alpha: 1.0)
        let tanDark = NSColor(red: 0.8, green: 0.45, blue: 0.08, alpha: 1.0)
        let white = NSColor.white
        let black = NSColor.black
        let brown = NSColor(red: 0.5, green: 0.3, blue: 0.1, alpha: 1.0)

        let bob = frame % 2 == 0 ? 0 : 1

        func sp(_ x: Int, _ y: Int, _ color: NSColor) {
            setPixel(&grid, x: x + bob, y: y, color: color)
        }
        func sn(_ x: Int, _ y: Int, _ color: NSColor) {
            setPixel(&grid, x: x, y: y, color: color)
        }

        // Three signature hairs (bob with head, tall strands)
        sp(5, 0, brown)
        sp(5, 1, brown)
        sp(7, 0, brown)
        sp(7, 1, brown)
        sp(9, 0, brown)
        sp(9, 1, brown)

        // Head (bob)
        for x in 5...10 { sp(x, 2, yellow) }
        for x in 4...11 { sp(x, 3, yellow) }
        for x in 4...11 { sp(x, 4, yellow) }

        // Eyes (big, 2x2 white with pupil — bob)
        sp(5, 3, white)
        sp(5, 4, white)
        sp(6, 3, white)
        sp(6, 4, white)
        sp(9, 3, white)
        sp(9, 4, white)
        sp(10, 3, white)
        sp(10, 4, white)
        sp(6, 4, black)
        sp(9, 4, black)

        // Bill — wide, prominent, tan colored (bob, drawn on top)
        for x in 5...10 { sp(x, 5, tan) }
        for x in 4...11 { sp(x, 6, tan) }
        // Bill nostrils / shading
        sp(7, 5, tanDark)
        sp(8, 5, tanDark)
        sp(7, 6, tanDark)
        sp(8, 6, tanDark)

        // Body (stationary)
        for x in 4...11 { sn(x, 7, yellow) }
        for x in 3...12 { sn(x, 8, yellow) }
        for x in 3...12 { sn(x, 9, yellow) }
        for x in 4...11 { sn(x, 10, yellow) }

        // Arms at sides (stationary, dark yellow for visibility)
        sn(2, 8, darkYellow)
        sn(2, 9, darkYellow)
        sn(13, 8, darkYellow)
        sn(13, 9, darkYellow)

        // Belly highlight
        for x in 6...9 { sn(x, 8, NSColor(red: 1.0, green: 0.97, blue: 0.5, alpha: 1.0)) }

        // Feet (stationary)
        sn(4, 11, brown)
        sn(5, 11, brown)
        sn(10, 11, brown)
        sn(11, 11, brown)
    }

    // MARK: - Snorlax (large teal body, sleepy, minimal movement)
    private func drawSnorlax(grid: inout [[NSColor]], frame: Int) {
        let teal = NSColor(red: 0.25, green: 0.55, blue: 0.5, alpha: 1.0)
        let darkTeal = NSColor(red: 0.18, green: 0.42, blue: 0.38, alpha: 1.0)
        let cream = NSColor(red: 0.95, green: 0.92, blue: 0.75, alpha: 1.0)
        let black = NSColor.black

        // Head
        for x in 5...10 { setPixel(&grid, x: x, y: 2, color: teal) }
        for x in 4...11 { setPixel(&grid, x: x, y: 3, color: teal) }

        // Eyes (sleepy slits)
        setPixel(&grid, x: 6, y: 3, color: black)
        setPixel(&grid, x: 9, y: 3, color: black)

        // Mouth (small)
        setPixel(&grid, x: 7, y: 3, color: cream)
        setPixel(&grid, x: 8, y: 3, color: cream)

        // Body (large round)
        for x in 3...12 { setPixel(&grid, x: x, y: 4, color: teal) }
        for x in 3...12 { setPixel(&grid, x: x, y: 5, color: teal) }
        for x in 2...13 { setPixel(&grid, x: x, y: 6, color: teal) }
        for x in 2...13 { setPixel(&grid, x: x, y: 7, color: teal) }
        for x in 3...12 { setPixel(&grid, x: x, y: 8, color: teal) }

        // Belly
        for x in 5...10 { setPixel(&grid, x: x, y: 5, color: cream) }
        for x in 5...10 { setPixel(&grid, x: x, y: 6, color: cream) }
        for x in 5...10 { setPixel(&grid, x: x, y: 7, color: cream) }

        // Feet
        if frame % 4 < 2 {
            setPixel(&grid, x: 4, y: 9, color: darkTeal)
            setPixel(&grid, x: 5, y: 9, color: darkTeal)
            setPixel(&grid, x: 10, y: 9, color: darkTeal)
            setPixel(&grid, x: 11, y: 9, color: darkTeal)
        } else {
            setPixel(&grid, x: 4, y: 9, color: darkTeal)
            setPixel(&grid, x: 11, y: 9, color: darkTeal)
        }
    }

    // MARK: - Charmander
    private func drawCharmander(grid: inout [[NSColor]], frame: Int) {
        let o = NSColor(red: 0.95, green: 0.5, blue: 0.1, alpha: 1.0)
        let y = NSColor(red: 1.0, green: 0.85, blue: 0.3, alpha: 1.0)
        let b = NSColor.black
        let anim = frame % 2

        // Row 1: head top
        for x in 5...10 { setPixel(&grid, x: x, y: 1, color: o) }

        // Row 2: head with eyes
        for x in 4...11 { setPixel(&grid, x: x, y: 2, color: o) }
        setPixel(&grid, x: 6, y: 2, color: b)
        setPixel(&grid, x: 9, y: 2, color: b)

        // Row 3: head
        for x in 4...11 { setPixel(&grid, x: x, y: 3, color: o) }

        // Row 4: body top
        for x in 4...11 { setPixel(&grid, x: x, y: 4, color: o) }

        // Row 5: body with belly
        for x in 4...11 { setPixel(&grid, x: x, y: 5, color: o) }
        for x in 6...9 { setPixel(&grid, x: x, y: 5, color: y) }

        // Row 6: body with belly
        for x in 4...11 { setPixel(&grid, x: x, y: 6, color: o) }
        for x in 6...9 { setPixel(&grid, x: x, y: 6, color: y) }

        // Row 7: body
        for x in 4...11 { setPixel(&grid, x: x, y: 7, color: o) }

        // Row 8: feet
        if anim == 0 {
            setPixel(&grid, x: 5, y: 8, color: o)
            setPixel(&grid, x: 10, y: 8, color: o)
        } else {
            setPixel(&grid, x: 4, y: 8, color: o)
            setPixel(&grid, x: 11, y: 8, color: o)
        }

        // Tail
        setPixel(&grid, x: 12, y: 5, color: o)
        setPixel(&grid, x: 13, y: 4, color: o)
        setPixel(&grid, x: 13, y: 5, color: y)
    }

    // MARK: - Bulbasaur
    private func drawBulbasaur(grid: inout [[NSColor]], frame: Int) {
        let t = NSColor(red: 0.3, green: 0.6, blue: 0.55, alpha: 1.0)
        let g = NSColor(red: 0.3, green: 0.65, blue: 0.2, alpha: 1.0)
        let lg = NSColor(red: 0.45, green: 0.75, blue: 0.35, alpha: 1.0)
        let b = NSColor.black
        let anim = frame % 2

        // Row 0: bulb tip
        setPixel(&grid, x: 7, y: 0, color: g)
        setPixel(&grid, x: 8, y: 0, color: g)

        // Row 1: bulb
        for x in 6...9 { setPixel(&grid, x: x, y: 1, color: g) }
        setPixel(&grid, x: 7, y: 1, color: lg)
        setPixel(&grid, x: 8, y: 1, color: lg)

        // Row 2: bulb base
        for x in 5...10 { setPixel(&grid, x: x, y: 2, color: g) }
        setPixel(&grid, x: 7, y: 2, color: lg)
        setPixel(&grid, x: 8, y: 2, color: lg)

        // Row 3: head with eyes
        for x in 4...11 { setPixel(&grid, x: x, y: 3, color: t) }
        setPixel(&grid, x: 6, y: 3, color: b)
        setPixel(&grid, x: 9, y: 3, color: b)

        // Row 4: head
        for x in 4...11 { setPixel(&grid, x: x, y: 4, color: t) }

        // Row 5: body wide
        for x in 3...12 { setPixel(&grid, x: x, y: 5, color: t) }

        // Row 6: body with belly
        for x in 3...12 { setPixel(&grid, x: x, y: 6, color: t) }
        for x in 5...10 { setPixel(&grid, x: x, y: 6, color: g) }

        // Row 7: body
        for x in 3...12 { setPixel(&grid, x: x, y: 7, color: t) }

        // Row 8: feet
        if anim == 0 {
            setPixel(&grid, x: 4, y: 8, color: t)
            setPixel(&grid, x: 11, y: 8, color: t)
        } else {
            setPixel(&grid, x: 5, y: 8, color: t)
            setPixel(&grid, x: 10, y: 8, color: t)
        }
    }

    // MARK: - Squirtle
    private func drawSquirtle(grid: inout [[NSColor]], frame: Int) {
        let bl = NSColor(red: 0.3, green: 0.55, blue: 0.85, alpha: 1.0)
        let br = NSColor(red: 0.65, green: 0.45, blue: 0.2, alpha: 1.0)
        let or = NSColor(red: 0.85, green: 0.55, blue: 0.2, alpha: 1.0)
        let b = NSColor.black
        let anim = frame % 2

        // Row 1: head top
        for x in 5...10 { setPixel(&grid, x: x, y: 1, color: bl) }

        // Row 2: head with eyes
        for x in 4...11 { setPixel(&grid, x: x, y: 2, color: bl) }
        setPixel(&grid, x: 6, y: 2, color: b)
        setPixel(&grid, x: 9, y: 2, color: b)

        // Row 3: head
        for x in 4...11 { setPixel(&grid, x: x, y: 3, color: bl) }

        // Row 4: shell top
        for x in 4...11 { setPixel(&grid, x: x, y: 4, color: br) }

        // Row 5: shell with belly
        for x in 4...11 { setPixel(&grid, x: x, y: 5, color: br) }
        for x in 6...9 { setPixel(&grid, x: x, y: 5, color: or) }

        // Row 6: shell with belly
        for x in 4...11 { setPixel(&grid, x: x, y: 6, color: br) }
        for x in 6...9 { setPixel(&grid, x: x, y: 6, color: or) }

        // Row 7: shell bottom
        for x in 4...11 { setPixel(&grid, x: x, y: 7, color: br) }

        // Row 8: feet
        if anim == 0 {
            setPixel(&grid, x: 5, y: 8, color: bl)
            setPixel(&grid, x: 10, y: 8, color: bl)
        } else {
            setPixel(&grid, x: 4, y: 8, color: bl)
            setPixel(&grid, x: 11, y: 8, color: bl)
        }

        // Tail
        setPixel(&grid, x: 12, y: 5, color: bl)
        setPixel(&grid, x: 13, y: 4, color: bl)
    }

    // MARK: - Jigglypuff
    private func drawJigglypuff(grid: inout [[NSColor]], frame: Int) {
        let pink = NSColor(red: 1.0, green: 0.6, blue: 0.7, alpha: 1.0)
        let darkPink = NSColor(red: 0.9, green: 0.4, blue: 0.55, alpha: 1.0)
        let blue = NSColor(red: 0.2, green: 0.5, blue: 0.9, alpha: 1.0)
        let black = NSColor.black

        // Ear
        setPixel(&grid, x: 6, y: 0, color: pink)
        setPixel(&grid, x: 6, y: 1, color: darkPink)
        setPixel(&grid, x: 9, y: 0, color: pink)
        setPixel(&grid, x: 9, y: 1, color: darkPink)

        // Head/body (round)
        for x in 5...10 { setPixel(&grid, x: x, y: 2, color: pink) }
        for x in 4...11 { setPixel(&grid, x: x, y: 3, color: pink) }
        for x in 3...12 { setPixel(&grid, x: x, y: 4, color: pink) }
        for x in 3...12 { setPixel(&grid, x: x, y: 5, color: pink) }
        for x in 4...11 { setPixel(&grid, x: x, y: 6, color: pink) }
        for x in 4...11 { setPixel(&grid, x: x, y: 7, color: pink) }

        // Eyes
        setPixel(&grid, x: 6, y: 4, color: blue)
        setPixel(&grid, x: 9, y: 4, color: blue)
        setPixel(&grid, x: 6, y: 5, color: black)
        setPixel(&grid, x: 9, y: 5, color: black)

        // Mouth
        setPixel(&grid, x: 7, y: 5, color: darkPink)
        setPixel(&grid, x: 8, y: 5, color: darkPink)

        // Feet
        if frame % 2 == 0 {
            setPixel(&grid, x: 5, y: 8, color: darkPink)
            setPixel(&grid, x: 10, y: 8, color: darkPink)
        } else {
            setPixel(&grid, x: 6, y: 8, color: darkPink)
            setPixel(&grid, x: 9, y: 8, color: darkPink)
        }
    }

    // MARK: - Meowth
    private func drawMeowth(grid: inout [[NSColor]], frame: Int) {
        let cream = NSColor(red: 0.95, green: 0.9, blue: 0.75, alpha: 1.0)
        let darkCream = NSColor(red: 0.85, green: 0.78, blue: 0.6, alpha: 1.0)
        let gold = NSColor(red: 0.85, green: 0.75, blue: 0.1, alpha: 1.0)
        let black = NSColor.black

        // Ears
        setPixel(&grid, x: 5, y: 0, color: cream)
        setPixel(&grid, x: 5, y: 1, color: darkCream)
        setPixel(&grid, x: 10, y: 0, color: cream)
        setPixel(&grid, x: 10, y: 1, color: darkCream)

        // Coin on forehead
        setPixel(&grid, x: 7, y: 2, color: gold)
        setPixel(&grid, x: 8, y: 2, color: gold)

        // Head
        for x in 5...10 { setPixel(&grid, x: x, y: 2, color: cream) }
        for x in 4...11 { setPixel(&grid, x: x, y: 3, color: cream) }
        for x in 4...11 { setPixel(&grid, x: x, y: 4, color: cream) }

        // Eyes
        setPixel(&grid, x: 6, y: 3, color: black)
        setPixel(&grid, x: 9, y: 3, color: black)

        // Whiskers
        setPixel(&grid, x: 3, y: 4, color: black)
        setPixel(&grid, x: 12, y: 4, color: black)

        // Body
        for x in 5...10 { setPixel(&grid, x: x, y: 5, color: cream) }
        for x in 5...10 { setPixel(&grid, x: x, y: 6, color: cream) }
        for x in 5...10 { setPixel(&grid, x: x, y: 7, color: cream) }

        // Tail (curled)
        setPixel(&grid, x: 11, y: 5, color: cream)
        setPixel(&grid, x: 12, y: 4, color: cream)
        setPixel(&grid, x: 13, y: 3, color: darkCream)

        // Feet
        if frame % 2 == 0 {
            setPixel(&grid, x: 6, y: 8, color: cream)
            setPixel(&grid, x: 9, y: 8, color: cream)
        } else {
            setPixel(&grid, x: 5, y: 8, color: cream)
            setPixel(&grid, x: 10, y: 8, color: cream)
        }
    }

    // MARK: - Eevee
    private func drawEevee(grid: inout [[NSColor]], frame: Int) {
        let brown = NSColor(red: 0.65, green: 0.45, blue: 0.2, alpha: 1.0)
        let darkBrown = NSColor(red: 0.45, green: 0.3, blue: 0.12, alpha: 1.0)
        let cream = NSColor(red: 0.95, green: 0.9, blue: 0.75, alpha: 1.0)
        let black = NSColor.black

        // Big ears
        setPixel(&grid, x: 4, y: 0, color: brown)
        setPixel(&grid, x: 4, y: 1, color: darkBrown)
        setPixel(&grid, x: 11, y: 0, color: brown)
        setPixel(&grid, x: 11, y: 1, color: darkBrown)

        // Head
        for x in 5...10 { setPixel(&grid, x: x, y: 2, color: brown) }
        for x in 5...10 { setPixel(&grid, x: x, y: 3, color: brown) }
        for x in 4...11 { setPixel(&grid, x: x, y: 4, color: brown) }

        // Eyes
        setPixel(&grid, x: 6, y: 3, color: black)
        setPixel(&grid, x: 9, y: 3, color: black)

        // Ruff
        for x in 4...11 { setPixel(&grid, x: x, y: 5, color: cream) }

        // Body
        for x in 5...10 { setPixel(&grid, x: x, y: 6, color: brown) }
        for x in 5...10 { setPixel(&grid, x: x, y: 7, color: brown) }

        // Tail (bushy)
        setPixel(&grid, x: 11, y: 6, color: brown)
        setPixel(&grid, x: 12, y: 5, color: cream)
        setPixel(&grid, x: 13, y: 5, color: brown)
        setPixel(&grid, x: 12, y: 6, color: brown)

        // Legs
        if frame % 2 == 0 {
            setPixel(&grid, x: 6, y: 8, color: darkBrown)
            setPixel(&grid, x: 9, y: 8, color: darkBrown)
        } else {
            setPixel(&grid, x: 5, y: 8, color: darkBrown)
            setPixel(&grid, x: 10, y: 8, color: darkBrown)
        }
    }

    // MARK: - Mew
    private func drawMew(grid: inout [[NSColor]], frame: Int) {
        let pink = NSColor(red: 1.0, green: 0.6, blue: 0.7, alpha: 1.0)
        let lightPink = NSColor(red: 1.0, green: 0.75, blue: 0.8, alpha: 1.0)
        let blue = NSColor(red: 0.4, green: 0.7, blue: 1.0, alpha: 1.0)

        // Ears
        setPixel(&grid, x: 6, y: 0, color: pink)
        setPixel(&grid, x: 9, y: 0, color: pink)

        // Head
        for x in 5...10 { setPixel(&grid, x: x, y: 1, color: pink) }
        for x in 5...10 { setPixel(&grid, x: x, y: 2, color: pink) }
        for x in 4...11 { setPixel(&grid, x: x, y: 3, color: pink) }

        // Eyes
        setPixel(&grid, x: 6, y: 2, color: blue)
        setPixel(&grid, x: 9, y: 2, color: blue)

        // Small body
        for x in 5...10 { setPixel(&grid, x: x, y: 4, color: pink) }
        for x in 6...9 { setPixel(&grid, x: x, y: 5, color: pink) }
        for x in 6...9 { setPixel(&grid, x: x, y: 6, color: lightPink) }

        // Belly
        for x in 7...8 { setPixel(&grid, x: x, y: 5, color: lightPink) }

        // Tail (long thin)
        setPixel(&grid, x: 10, y: 5, color: pink)
        setPixel(&grid, x: 11, y: 6, color: pink)
        setPixel(&grid, x: 12, y: 7, color: pink)
        setPixel(&grid, x: 13, y: 8, color: pink)
        setPixel(&grid, x: 14, y: 7, color: pink)

        // Tiny feet
        if frame % 2 == 0 {
            setPixel(&grid, x: 6, y: 7, color: pink)
            setPixel(&grid, x: 9, y: 7, color: pink)
        } else {
            setPixel(&grid, x: 7, y: 7, color: pink)
            setPixel(&grid, x: 8, y: 7, color: pink)
        }
    }

    // MARK: - Gengar
    private func drawGengar(grid: inout [[NSColor]], frame: Int) {
        let purple = NSColor(red: 0.45, green: 0.2, blue: 0.6, alpha: 1.0)
        let darkPurple = NSColor(red: 0.3, green: 0.1, blue: 0.45, alpha: 1.0)
        let red = NSColor(red: 0.9, green: 0.15, blue: 0.15, alpha: 1.0)
        let black = NSColor.black

        // Spikes on head
        setPixel(&grid, x: 6, y: 0, color: purple)
        setPixel(&grid, x: 8, y: 0, color: purple)
        setPixel(&grid, x: 10, y: 0, color: purple)

        // Head/body (round blob)
        for x in 4...11 { setPixel(&grid, x: x, y: 1, color: purple) }
        for x in 3...12 { setPixel(&grid, x: x, y: 2, color: purple) }
        for x in 3...12 { setPixel(&grid, x: x, y: 3, color: purple) }
        for x in 2...13 { setPixel(&grid, x: x, y: 4, color: purple) }
        for x in 2...13 { setPixel(&grid, x: x, y: 5, color: purple) }
        for x in 3...12 { setPixel(&grid, x: x, y: 6, color: purple) }
        for x in 3...12 { setPixel(&grid, x: x, y: 7, color: purple) }
        for x in 4...11 { setPixel(&grid, x: x, y: 8, color: purple) }

        // Eyes
        setPixel(&grid, x: 5, y: 3, color: red)
        setPixel(&grid, x: 10, y: 3, color: red)
        setPixel(&grid, x: 5, y: 4, color: black)
        setPixel(&grid, x: 10, y: 4, color: black)

        // Mouth
        for x in 6...9 { setPixel(&grid, x: x, y: 5, color: darkPurple) }

        // Feet
        if frame % 2 == 0 {
            setPixel(&grid, x: 4, y: 9, color: darkPurple)
            setPixel(&grid, x: 11, y: 9, color: darkPurple)
        } else {
            setPixel(&grid, x: 5, y: 9, color: darkPurple)
            setPixel(&grid, x: 10, y: 9, color: darkPurple)
        }
    }

    // MARK: - Dragonite
    private func drawDragonite(grid: inout [[NSColor]], frame: Int) {
        let orange = NSColor(red: 1.0, green: 0.6, blue: 0.2, alpha: 1.0)
        let green = NSColor(red: 0.3, green: 0.7, blue: 0.3, alpha: 1.0)
        let blue = NSColor(red: 0.3, green: 0.5, blue: 1.0, alpha: 1.0)

        // Antenna
        setPixel(&grid, x: 6, y: 0, color: green)
        setPixel(&grid, x: 9, y: 0, color: green)

        // Head
        for x in 5...10 { setPixel(&grid, x: x, y: 1, color: orange) }
        for x in 5...10 { setPixel(&grid, x: x, y: 2, color: orange) }

        // Eyes
        setPixel(&grid, x: 6, y: 1, color: blue)
        setPixel(&grid, x: 9, y: 1, color: blue)

        // Body
        for x in 4...11 { setPixel(&grid, x: x, y: 3, color: orange) }
        for x in 3...12 { setPixel(&grid, x: x, y: 4, color: orange) }
        for x in 3...12 { setPixel(&grid, x: x, y: 5, color: orange) }
        for x in 4...11 { setPixel(&grid, x: x, y: 6, color: orange) }
        for x in 4...11 { setPixel(&grid, x: x, y: 7, color: orange) }

        // Belly
        for x in 5...10 { setPixel(&grid, x: x, y: 4, color: NSColor(red: 0.95, green: 0.85, blue: 0.5, alpha: 1.0)) }
        for x in 5...10 { setPixel(&grid, x: x, y: 5, color: NSColor(red: 0.95, green: 0.85, blue: 0.5, alpha: 1.0)) }

        // Wings
        setPixel(&grid, x: 2, y: 3, color: green)
        setPixel(&grid, x: 1, y: 2, color: green)
        setPixel(&grid, x: 13, y: 3, color: green)
        setPixel(&grid, x: 14, y: 2, color: green)

        // Legs
        if frame % 2 == 0 {
            setPixel(&grid, x: 5, y: 8, color: orange)
            setPixel(&grid, x: 10, y: 8, color: orange)
        } else {
            setPixel(&grid, x: 6, y: 8, color: orange)
            setPixel(&grid, x: 9, y: 8, color: orange)
        }
    }

    // MARK: - Gyarados (serpentine undulation animation)
    private func drawGyarados(grid: inout [[NSColor]], frame: Int) {
        let blue = NSColor(red: 0.3, green: 0.45, blue: 0.85, alpha: 1.0)
        let yellow = NSColor(red: 1.0, green: 0.85, blue: 0.2, alpha: 1.0)
        let red = NSColor(red: 0.9, green: 0.2, blue: 0.15, alpha: 1.0)
        let underside = NSColor(red: 0.85, green: 0.8, blue: 0.4, alpha: 1.0)

        // Head bob based on frame
        let headBob = frame % 2 == 0 ? 0 : 1

        // Head
        for x in 3...6 { setPixel(&grid, x: x, y: 1 + headBob, color: blue) }
        for x in 2...7 { setPixel(&grid, x: x, y: 2 + headBob, color: blue) }

        // Eyes
        setPixel(&grid, x: 3, y: 1 + headBob, color: red)
        setPixel(&grid, x: 5, y: 1 + headBob, color: red)

        // Crest
        setPixel(&grid, x: 4, y: 0 + headBob, color: yellow)

        // Serpentine body with wave offset
        let wave1 = frame % 4 == 0 ? 0 : frame % 4 == 1 ? 1 : frame % 4 == 2 ? 0 : -1
        let wave2 = frame % 4 == 0 ? 1 : frame % 4 == 1 ? 0 : frame % 4 == 2 ? -1 : 0

        // Body segments wave
        for x in 5...10 { setPixel(&grid, x: x, y: 3 + wave1, color: blue) }
        for x in 6...11 { setPixel(&grid, x: x, y: 4 + wave2, color: blue) }
        for x in 5...10 { setPixel(&grid, x: x, y: 5 + wave1, color: blue) }
        for x in 6...11 { setPixel(&grid, x: x, y: 6 + wave2, color: blue) }
        for x in 5...10 { setPixel(&grid, x: x, y: 7 + wave1, color: blue) }

        // Fins
        setPixel(&grid, x: 8, y: 3 + wave1, color: yellow)
        setPixel(&grid, x: 8, y: 5 + wave1, color: yellow)
        setPixel(&grid, x: 8, y: 7 + wave1, color: yellow)

        // Tail fin
        setPixel(&grid, x: 11, y: 5 + wave2, color: blue)
        setPixel(&grid, x: 12, y: 4 + wave1, color: yellow)
        setPixel(&grid, x: 12, y: 6 + wave2, color: yellow)

        // Underside
        for x in 6...10 { setPixel(&grid, x: x, y: 4 + wave2, color: underside) }
        for x in 6...10 { setPixel(&grid, x: x, y: 6 + wave2, color: underside) }
    }

    // MARK: - Arcanine
    private func drawArcanine(grid: inout [[NSColor]], frame: Int) {
        let orange = NSColor(red: 1.0, green: 0.55, blue: 0.15, alpha: 1.0)
        let cream = NSColor(red: 0.95, green: 0.9, blue: 0.75, alpha: 1.0)
        let black = NSColor.black

        // Ears/mane
        setPixel(&grid, x: 4, y: 0, color: orange)
        setPixel(&grid, x: 11, y: 0, color: orange)
        setPixel(&grid, x: 5, y: 1, color: cream)
        setPixel(&grid, x: 10, y: 1, color: cream)

        // Head
        for x in 5...10 { setPixel(&grid, x: x, y: 2, color: orange) }
        for x in 5...10 { setPixel(&grid, x: x, y: 3, color: orange) }

        // Eyes
        setPixel(&grid, x: 6, y: 2, color: black)
        setPixel(&grid, x: 9, y: 2, color: black)

        // Mane
        for x in 4...11 { setPixel(&grid, x: x, y: 4, color: cream) }

        // Body
        for x in 4...11 { setPixel(&grid, x: x, y: 5, color: orange) }
        for x in 3...12 { setPixel(&grid, x: x, y: 6, color: orange) }
        for x in 4...11 { setPixel(&grid, x: x, y: 7, color: orange) }

        // Legs (running)
        if frame % 2 == 0 {
            setPixel(&grid, x: 4, y: 8, color: orange)
            setPixel(&grid, x: 5, y: 9, color: orange)
            setPixel(&grid, x: 10, y: 8, color: orange)
            setPixel(&grid, x: 11, y: 7, color: orange)
        } else {
            setPixel(&grid, x: 4, y: 7, color: orange)
            setPixel(&grid, x: 5, y: 8, color: orange)
            setPixel(&grid, x: 10, y: 9, color: orange)
            setPixel(&grid, x: 11, y: 8, color: orange)
        }

        // Tail
        setPixel(&grid, x: 12, y: 5, color: cream)
        setPixel(&grid, x: 13, y: 4, color: cream)
    }

    // MARK: - Alakazam (spoon wave animation)
    private func drawAlakazam(grid: inout [[NSColor]], frame: Int) {
        let yellow = NSColor(red: 0.95, green: 0.8, blue: 0.2, alpha: 1.0)
        let purple = NSColor(red: 0.55, green: 0.2, blue: 0.65, alpha: 1.0)
        let black = NSColor.black
        let spoonColor = NSColor(red: 0.85, green: 0.8, blue: 0.2, alpha: 1.0)

        // Spoon wave animation (4 frames)
        let spoonY: Int
        switch frame % 4 {
        case 0: spoonY = 0
        case 1: spoonY = 1
        case 2: spoonY = 2
        case 3: spoonY = 1
        default: spoonY = 0
        }

        // Spoon
        setPixel(&grid, x: 12, y: spoonY, color: spoonColor)
        setPixel(&grid, x: 12, y: spoonY + 1, color: spoonColor)

        // Head
        for x in 6...9 { setPixel(&grid, x: x, y: 1, color: yellow) }
        for x in 5...10 { setPixel(&grid, x: x, y: 2, color: yellow) }
        for x in 5...10 { setPixel(&grid, x: x, y: 3, color: yellow) }

        // Beard
        for x in 6...9 { setPixel(&grid, x: x, y: 4, color: purple) }

        // Eyes
        setPixel(&grid, x: 6, y: 2, color: black)
        setPixel(&grid, x: 9, y: 2, color: black)

        // Body
        for x in 5...10 { setPixel(&grid, x: x, y: 5, color: yellow) }
        for x in 4...11 { setPixel(&grid, x: x, y: 6, color: yellow) }
        for x in 4...11 { setPixel(&grid, x: x, y: 7, color: purple) }

        // Arms (slight movement)
        let armOffset = frame % 2 == 0 ? 0 : 1
        setPixel(&grid, x: 3, y: 5 + armOffset, color: yellow)
        setPixel(&grid, x: 11, y: 5, color: yellow)
        setPixel(&grid, x: 12, y: 2 + armOffset, color: yellow)

        // Legs
        setPixel(&grid, x: 5, y: 8, color: yellow)
        setPixel(&grid, x: 10, y: 8, color: yellow)
    }

    // MARK: - Machamp (arm flex animation)
    private func drawMachamp(grid: inout [[NSColor]], frame: Int) {
        let gray = NSColor(red: 0.6, green: 0.6, blue: 0.65, alpha: 1.0)
        let darkGray = NSColor(red: 0.4, green: 0.4, blue: 0.45, alpha: 1.0)
        let black = NSColor.black

        // Head
        for x in 6...9 { setPixel(&grid, x: x, y: 1, color: gray) }
        for x in 5...10 { setPixel(&grid, x: x, y: 2, color: gray) }

        // Eyes
        setPixel(&grid, x: 6, y: 1, color: black)
        setPixel(&grid, x: 9, y: 1, color: black)

        // Body
        for x in 5...10 { setPixel(&grid, x: x, y: 3, color: gray) }
        for x in 4...11 { setPixel(&grid, x: x, y: 4, color: gray) }
        for x in 4...11 { setPixel(&grid, x: x, y: 5, color: gray) }
        for x in 4...11 { setPixel(&grid, x: x, y: 6, color: gray) }
        for x in 5...10 { setPixel(&grid, x: x, y: 7, color: gray) }

        // Four arms with flex animation
        let armFlex = frame % 2 == 0 ? 0 : 1
        // Upper arms (always out)
        setPixel(&grid, x: 3, y: 3, color: gray)
        setPixel(&grid, x: 3, y: 4, color: gray)
        setPixel(&grid, x: 12, y: 3, color: gray)
        setPixel(&grid, x: 12, y: 4, color: gray)
        // Lower arms (flex up/down)
        setPixel(&grid, x: 2, y: 5 + armFlex, color: gray)
        setPixel(&grid, x: 2, y: 6 + armFlex, color: gray)
        setPixel(&grid, x: 13, y: 5 + armFlex, color: gray)
        setPixel(&grid, x: 13, y: 6 + armFlex, color: gray)

        // Belt
        for x in 4...11 { setPixel(&grid, x: x, y: 5, color: darkGray) }

        // Legs
        setPixel(&grid, x: 5, y: 8, color: gray)
        setPixel(&grid, x: 10, y: 8, color: gray)
    }

    // MARK: - Golem (rock shift animation)
    private func drawGolem(grid: inout [[NSColor]], frame: Int) {
        let brown = NSColor(red: 0.6, green: 0.45, blue: 0.25, alpha: 1.0)
        let gray = NSColor(red: 0.55, green: 0.55, blue: 0.55, alpha: 1.0)
        let darkGray = NSColor(red: 0.35, green: 0.35, blue: 0.35, alpha: 1.0)
        let black = NSColor.black

        // Head with slight bob
        let headBob = frame % 2 == 0 ? 0 : 1
        for x in 6...9 { setPixel(&grid, x: x, y: 1 + headBob, color: gray) }
        for x in 5...10 { setPixel(&grid, x: x, y: 2 + headBob, color: gray) }

        // Eyes
        setPixel(&grid, x: 6, y: 1 + headBob, color: black)
        setPixel(&grid, x: 9, y: 1 + headBob, color: black)

        // Rocky body with subtle shift
        let bodyShift = frame % 4 == 0 ? 0 : frame % 4 == 1 ? 1 : frame % 4 == 2 ? 0 : -1
        for x in 3...12 { setPixel(&grid, x: x, y: 3, color: gray) }
        for x in 2...13 { setPixel(&grid, x: x, y: 4 + bodyShift, color: gray) }
        for x in 2...13 { setPixel(&grid, x: x, y: 5, color: gray) }
        for x in 3...12 { setPixel(&grid, x: x, y: 6 - bodyShift, color: gray) }
        for x in 4...11 { setPixel(&grid, x: x, y: 7, color: gray) }

        // Cracks (animate position)
        let crackOffset = frame % 2 == 0 ? 0 : 1
        setPixel(&grid, x: 5 + crackOffset, y: 4, color: darkGray)
        setPixel(&grid, x: 9 - crackOffset, y: 5, color: darkGray)
        setPixel(&grid, x: 7, y: 6 + crackOffset, color: darkGray)

        // Legs
        if frame % 2 == 0 {
            setPixel(&grid, x: 5, y: 8, color: brown)
            setPixel(&grid, x: 10, y: 8, color: brown)
        } else {
            setPixel(&grid, x: 6, y: 8, color: brown)
            setPixel(&grid, x: 9, y: 8, color: brown)
        }
    }

    // MARK: - Onix (body wave animation)
    private func drawOnix(grid: inout [[NSColor]], frame: Int) {
        let gray = NSColor(red: 0.5, green: 0.5, blue: 0.5, alpha: 1.0)
        let darkGray = NSColor(red: 0.35, green: 0.35, blue: 0.35, alpha: 1.0)
        let black = NSColor.black

        // Head
        for x in 3...6 { setPixel(&grid, x: x, y: 2, color: gray) }
        for x in 2...7 { setPixel(&grid, x: x, y: 3, color: gray) }

        // Horn
        setPixel(&grid, x: 4, y: 1, color: darkGray)

        // Eyes
        setPixel(&grid, x: 3, y: 2, color: black)
        setPixel(&grid, x: 5, y: 2, color: black)

        // Body segments (connected, tail tip moves)
        let tailWave = frame % 2 == 0 ? 0 : 1

        for x in 6...10 { setPixel(&grid, x: x, y: 4, color: gray) }
        for x in 8...12 { setPixel(&grid, x: x, y: 5, color: gray) }
        for x in 10...14 { setPixel(&grid, x: x, y: 6, color: gray) }

        // Segments darker
        setPixel(&grid, x: 7, y: 4, color: darkGray)
        setPixel(&grid, x: 9, y: 5, color: darkGray)
        setPixel(&grid, x: 12, y: 6, color: darkGray)

        // Tail (animated tip)
        setPixel(&grid, x: 14, y: 5 + tailWave, color: gray)
        setPixel(&grid, x: 15, y: 4 + tailWave, color: darkGray)
    }

    // MARK: - Jolteon
    private func drawJolteon(grid: inout [[NSColor]], frame: Int) {
        let yellow = NSColor(red: 1.0, green: 0.9, blue: 0.2, alpha: 1.0)
        let white = NSColor(red: 0.95, green: 0.95, blue: 0.9, alpha: 1.0)
        let black = NSColor.black

        // Spiky ears
        setPixel(&grid, x: 5, y: 0, color: yellow)
        setPixel(&grid, x: 10, y: 0, color: yellow)

        // Head
        for x in 5...10 { setPixel(&grid, x: x, y: 1, color: yellow) }
        for x in 5...10 { setPixel(&grid, x: x, y: 2, color: yellow) }

        // Eyes
        setPixel(&grid, x: 6, y: 1, color: black)
        setPixel(&grid, x: 9, y: 1, color: black)

        // Spiky ruff
        for x in 4...11 { setPixel(&grid, x: x, y: 3, color: white) }

        // Body
        for x in 5...10 { setPixel(&grid, x: x, y: 4, color: yellow) }
        for x in 5...10 { setPixel(&grid, x: x, y: 5, color: yellow) }
        for x in 5...10 { setPixel(&grid, x: x, y: 6, color: yellow) }

        // Spiky tail
        setPixel(&grid, x: 11, y: 4, color: white)
        setPixel(&grid, x: 12, y: 3, color: yellow)
        setPixel(&grid, x: 13, y: 2, color: white)

        // Legs
        if frame % 2 == 0 {
            setPixel(&grid, x: 6, y: 7, color: yellow)
            setPixel(&grid, x: 9, y: 7, color: yellow)
        } else {
            setPixel(&grid, x: 5, y: 7, color: yellow)
            setPixel(&grid, x: 10, y: 7, color: yellow)
        }
    }

    // MARK: - Flareon
    private func drawFlareon(grid: inout [[NSColor]], frame: Int) {
        let orange = NSColor(red: 1.0, green: 0.55, blue: 0.1, alpha: 1.0)
        let yellow = NSColor(red: 1.0, green: 0.85, blue: 0.2, alpha: 1.0)
        let cream = NSColor(red: 0.95, green: 0.9, blue: 0.7, alpha: 1.0)
        let black = NSColor.black

        // Fluffy ears
        setPixel(&grid, x: 5, y: 0, color: orange)
        setPixel(&grid, x: 10, y: 0, color: orange)
        setPixel(&grid, x: 5, y: 1, color: yellow)
        setPixel(&grid, x: 10, y: 1, color: yellow)

        // Head
        for x in 5...10 { setPixel(&grid, x: x, y: 2, color: orange) }
        for x in 5...10 { setPixel(&grid, x: x, y: 3, color: orange) }

        // Eyes
        setPixel(&grid, x: 6, y: 2, color: black)
        setPixel(&grid, x: 9, y: 2, color: black)

        // Fluffy collar
        for x in 4...11 { setPixel(&grid, x: x, y: 4, color: yellow) }

        // Body
        for x in 5...10 { setPixel(&grid, x: x, y: 5, color: orange) }
        for x in 5...10 { setPixel(&grid, x: x, y: 6, color: orange) }

        // Fluffy tail (fire-like)
        setPixel(&grid, x: 11, y: 5, color: yellow)
        setPixel(&grid, x: 12, y: 4, color: orange)
        setPixel(&grid, x: 13, y: 3, color: yellow)

        // Legs
        if frame % 2 == 0 {
            setPixel(&grid, x: 6, y: 7, color: cream)
            setPixel(&grid, x: 9, y: 7, color: cream)
        } else {
            setPixel(&grid, x: 5, y: 7, color: cream)
            setPixel(&grid, x: 10, y: 7, color: cream)
        }
    }

    // MARK: - Vaporeon
    private func drawVaporeon(grid: inout [[NSColor]], frame: Int) {
        let blue = NSColor(red: 0.3, green: 0.55, blue: 0.85, alpha: 1.0)
        let lightBlue = NSColor(red: 0.5, green: 0.75, blue: 1.0, alpha: 1.0)
        let cream = NSColor(red: 0.9, green: 0.9, blue: 0.8, alpha: 1.0)
        let black = NSColor.black

        // Fin on head
        setPixel(&grid, x: 7, y: 0, color: lightBlue)
        setPixel(&grid, x: 8, y: 0, color: lightBlue)

        // Head
        for x in 5...10 { setPixel(&grid, x: x, y: 1, color: blue) }
        for x in 5...10 { setPixel(&grid, x: x, y: 2, color: blue) }
        for x in 5...10 { setPixel(&grid, x: x, y: 3, color: blue) }

        // Eyes
        setPixel(&grid, x: 6, y: 2, color: black)
        setPixel(&grid, x: 9, y: 2, color: black)

        // Neck ruff
        for x in 4...11 { setPixel(&grid, x: x, y: 4, color: cream) }

        // Body
        for x in 5...10 { setPixel(&grid, x: x, y: 5, color: blue) }
        for x in 5...10 { setPixel(&grid, x: x, y: 6, color: blue) }
        for x in 5...10 { setPixel(&grid, x: x, y: 7, color: blue) }

        // Belly
        for x in 6...9 { setPixel(&grid, x: x, y: 6, color: cream) }

        // Tail fin
        setPixel(&grid, x: 11, y: 6, color: lightBlue)
        setPixel(&grid, x: 12, y: 5, color: blue)
        setPixel(&grid, x: 12, y: 7, color: blue)

        // Legs
        if frame % 2 == 0 {
            setPixel(&grid, x: 6, y: 8, color: blue)
            setPixel(&grid, x: 9, y: 8, color: blue)
        } else {
            setPixel(&grid, x: 5, y: 8, color: blue)
            setPixel(&grid, x: 10, y: 8, color: blue)
        }
    }

    // MARK: - Porygon (geometric shift animation)
    private func drawPorygon(grid: inout [[NSColor]], frame: Int) {
        let pink = NSColor(red: 0.9, green: 0.35, blue: 0.45, alpha: 1.0)
        let blue = NSColor(red: 0.3, green: 0.5, blue: 0.9, alpha: 1.0)

        // Head (angular) with slight shift
        let shift = frame % 2 == 0 ? 0 : 1
        for x in 6...9 { setPixel(&grid, x: x, y: 1 + shift, color: pink) }
        for x in 5...10 { setPixel(&grid, x: x, y: 2 + shift, color: pink) }

        // Eyes
        setPixel(&grid, x: 6, y: 1 + shift, color: blue)
        setPixel(&grid, x: 9, y: 1 + shift, color: blue)

        // Body (angular/geometric)
        for x in 4...11 { setPixel(&grid, x: x, y: 3, color: pink) }
        for x in 3...12 { setPixel(&grid, x: x, y: 4, color: pink) }
        for x in 3...12 { setPixel(&grid, x: x, y: 5, color: pink) }
        for x in 4...11 { setPixel(&grid, x: x, y: 6, color: pink) }

        // Tail (triangular) with animation
        let tailShift = frame % 4 == 0 ? 0 : frame % 4 == 1 ? 1 : frame % 4 == 2 ? 0 : -1
        setPixel(&grid, x: 12, y: 4 + tailShift, color: pink)
        setPixel(&grid, x: 13, y: 3 + tailShift, color: pink)
        setPixel(&grid, x: 13, y: 5 + tailShift, color: pink)

        // Legs (angular) with movement
        if frame % 2 == 0 {
            setPixel(&grid, x: 5, y: 7, color: blue)
            setPixel(&grid, x: 10, y: 7, color: blue)
        } else {
            setPixel(&grid, x: 6, y: 7, color: blue)
            setPixel(&grid, x: 9, y: 7, color: blue)
        }
    }

    // MARK: - Ditto (wobble animation)
    private func drawDitto(grid: inout [[NSColor]], frame: Int) {
        let purple = NSColor(red: 0.75, green: 0.55, blue: 0.8, alpha: 1.0)
        let darkPurple = NSColor(red: 0.6, green: 0.4, blue: 0.65, alpha: 1.0)
        let black = NSColor.black

        // Wobble animation (4 frames)
        let wobbleX: Int
        switch frame % 4 {
        case 0: wobbleX = 0
        case 1: wobbleX = 1
        case 2: wobbleX = 0
        case 3: wobbleX = -1
        default: wobbleX = 0
        }

        // Blobby body with wobble
        for x in 5...10 { setPixel(&grid, x: x + wobbleX, y: 2, color: purple) }
        for x in 4...11 { setPixel(&grid, x: x + wobbleX, y: 3, color: purple) }
        for x in 3...12 { setPixel(&grid, x: x + wobbleX, y: 4, color: purple) }
        for x in 3...12 { setPixel(&grid, x: x + wobbleX, y: 5, color: purple) }
        for x in 4...11 { setPixel(&grid, x: x + wobbleX, y: 6, color: purple) }
        for x in 5...10 { setPixel(&grid, x: x + wobbleX, y: 7, color: purple) }

        // Eyes (tiny dots)
        setPixel(&grid, x: 7 + wobbleX, y: 3, color: black)
        setPixel(&grid, x: 9 + wobbleX, y: 3, color: black)

        // Mouth
        setPixel(&grid, x: 8 + wobbleX, y: 4, color: darkPurple)

        // Little blobby tail with wobble
        setPixel(&grid, x: 12 + wobbleX, y: 5, color: purple)
        setPixel(&grid, x: 13 + wobbleX, y: 4, color: darkPurple)
    }

    // MARK: - Lapras
    private func drawLapras(grid: inout [[NSColor]], frame: Int) {
        let blue = NSColor(red: 0.35, green: 0.5, blue: 0.8, alpha: 1.0)
        let lightBlue = NSColor(red: 0.55, green: 0.75, blue: 0.95, alpha: 1.0)
        let gray = NSColor(red: 0.65, green: 0.65, blue: 0.7, alpha: 1.0)
        let black = NSColor.black

        // Head
        for x in 3...5 { setPixel(&grid, x: x, y: 2, color: blue) }
        for x in 3...5 { setPixel(&grid, x: x, y: 3, color: blue) }

        // Eyes
        setPixel(&grid, x: 3, y: 2, color: black)

        // Horns
        setPixel(&grid, x: 4, y: 1, color: gray)

        // Neck
        setPixel(&grid, x: 5, y: 3, color: blue)
        setPixel(&grid, x: 6, y: 4, color: blue)

        // Shell
        for x in 6...11 { setPixel(&grid, x: x, y: 4, color: gray) }
        for x in 5...12 { setPixel(&grid, x: x, y: 5, color: gray) }
        for x in 5...12 { setPixel(&grid, x: x, y: 6, color: gray) }
        for x in 6...11 { setPixel(&grid, x: x, y: 7, color: gray) }

        // Shell pattern
        setPixel(&grid, x: 7, y: 5, color: lightBlue)
        setPixel(&grid, x: 9, y: 5, color: lightBlue)
        setPixel(&grid, x: 8, y: 6, color: lightBlue)

        // Body under shell
        for x in 5...12 { setPixel(&grid, x: x, y: 8, color: blue) }

        // Flippers
        if frame % 2 == 0 {
            setPixel(&grid, x: 4, y: 6, color: blue)
            setPixel(&grid, x: 13, y: 6, color: blue)
        } else {
            setPixel(&grid, x: 4, y: 7, color: blue)
            setPixel(&grid, x: 13, y: 7, color: blue)
        }

        // Tail
        setPixel(&grid, x: 13, y: 5, color: blue)
        setPixel(&grid, x: 14, y: 4, color: blue)
    }

    // MARK: - Marill (blue body, round tail with ball, belly)
    private func drawMarill(grid: inout [[NSColor]], frame: Int) {
        let blue = NSColor(red: 0.2, green: 0.5, blue: 0.9, alpha: 1.0)
        let darkBlue = NSColor(red: 0.15, green: 0.35, blue: 0.7, alpha: 1.0)
        let yellow = NSColor(red: 1.0, green: 0.9, blue: 0.3, alpha: 1.0)
        let white = NSColor.white
        let pink = NSColor(red: 1.0, green: 0.6, blue: 0.7, alpha: 1.0)

        // Ears
        setPixel(&grid, x: 5, y: 0, color: blue)
        setPixel(&grid, x: 6, y: 0, color: blue)
        setPixel(&grid, x: 10, y: 0, color: blue)
        setPixel(&grid, x: 11, y: 0, color: blue)
        setPixel(&grid, x: 5, y: 1, color: pink)
        setPixel(&grid, x: 11, y: 1, color: pink)

        // Head
        for x in 5...11 { setPixel(&grid, x: x, y: 2, color: blue) }
        for x in 4...12 { setPixel(&grid, x: x, y: 3, color: blue) }

        // Eyes
        setPixel(&grid, x: 6, y: 3, color: white)
        setPixel(&grid, x: 10, y: 3, color: white)
        setPixel(&grid, x: 6, y: 2, color: darkBlue)
        setPixel(&grid, x: 10, y: 2, color: darkBlue)

        // Nose
        setPixel(&grid, x: 8, y: 3, color: pink)

        // Body
        for y in 4...7 {
            for x in 5...11 { setPixel(&grid, x: x, y: y, color: blue) }
        }
        // Belly
        for y in 5...7 {
            for x in 6...10 { setPixel(&grid, x: x, y: y, color: white) }
        }

        // Legs
        if frame % 2 == 0 {
            setPixel(&grid, x: 6, y: 8, color: blue)
            setPixel(&grid, x: 10, y: 8, color: blue)
            setPixel(&grid, x: 6, y: 9, color: yellow)
            setPixel(&grid, x: 10, y: 9, color: yellow)
        } else {
            setPixel(&grid, x: 5, y: 8, color: blue)
            setPixel(&grid, x: 11, y: 8, color: blue)
            setPixel(&grid, x: 5, y: 9, color: yellow)
            setPixel(&grid, x: 11, y: 9, color: yellow)
        }

        // Tail - thin zigzag going up with ball
        setPixel(&grid, x: 12, y: 5, color: blue)
        setPixel(&grid, x: 13, y: 5, color: blue)
        setPixel(&grid, x: 13, y: 4, color: blue)
        setPixel(&grid, x: 14, y: 4, color: blue)
        setPixel(&grid, x: 14, y: 3, color: blue)
        setPixel(&grid, x: 15, y: 3, color: blue)
        setPixel(&grid, x: 15, y: 2, color: blue)
        setPixel(&grid, x: 15, y: 1, color: blue)
        // Ball (3x3)
        setPixel(&grid, x: 14, y: 0, color: blue)
        setPixel(&grid, x: 15, y: 0, color: blue)
        setPixel(&grid, x: 13, y: 0, color: blue)
        setPixel(&grid, x: 14, y: 1, color: blue)
        setPixel(&grid, x: 13, y: 1, color: blue)
    }

    // MARK: - Umbreon (black body, yellow rings, red eyes)
    private func drawUmbreon(grid: inout [[NSColor]], frame: Int) {
        let g = NSColor(red: 0.45, green: 0.45, blue: 0.48, alpha: 1.0)
        let dg = NSColor(red: 0.3, green: 0.3, blue: 0.32, alpha: 1.0)
        let y = NSColor(red: 1.0, green: 0.85, blue: 0.0, alpha: 1.0)
        let r = NSColor(red: 0.9, green: 0.15, blue: 0.15, alpha: 1.0)
        let b = NSColor.black
        let anim = frame % 2

        // Row 0: ear tips
        setPixel(&grid, x: 4, y: 0, color: b)
        setPixel(&grid, x: 12, y: 0, color: b)

        // Row 1: ears with yellow rings
        for x in 4...12 { setPixel(&grid, x: x, y: 1, color: g) }
        setPixel(&grid, x: 4, y: 1, color: y)
        setPixel(&grid, x: 12, y: 1, color: y)

        // Row 2: head with eyes and forehead circle
        for x in 4...12 { setPixel(&grid, x: x, y: 2, color: g) }
        setPixel(&grid, x: 6, y: 2, color: r)
        setPixel(&grid, x: 10, y: 2, color: r)
        setPixel(&grid, x: 8, y: 2, color: y)

        // Row 3: head
        for x in 4...12 { setPixel(&grid, x: x, y: 3, color: g) }

        // Row 4: body top
        for x in 4...12 { setPixel(&grid, x: x, y: 4, color: g) }

        // Row 5: body with rings
        for x in 4...12 { setPixel(&grid, x: x, y: 5, color: g) }
        setPixel(&grid, x: 4, y: 5, color: y)
        setPixel(&grid, x: 12, y: 5, color: y)

        // Row 6: body with ring
        for x in 4...12 { setPixel(&grid, x: x, y: 6, color: g) }
        setPixel(&grid, x: 8, y: 6, color: y)

        // Row 7: body
        for x in 4...12 { setPixel(&grid, x: x, y: 7, color: g) }

        // Row 8: feet
        if anim == 0 {
            setPixel(&grid, x: 5, y: 8, color: dg)
            setPixel(&grid, x: 11, y: 8, color: dg)
        } else {
            setPixel(&grid, x: 4, y: 8, color: dg)
            setPixel(&grid, x: 12, y: 8, color: dg)
        }

        // Tail
        setPixel(&grid, x: 13, y: 5, color: g)
        setPixel(&grid, x: 14, y: 4, color: y)
    }

    private func drawPokeball(grid: inout [[NSColor]], frame: Int) {
        let red = NSColor(red: 0.9, green: 0.15, blue: 0.15, alpha: 1.0)
        let white = NSColor.white
        let black = NSColor.black
        let gray = NSColor(red: 0.6, green: 0.6, blue: 0.6, alpha: 1.0)
        let anim = frame % 2

        // Row 2: top
        for x in 6...9 { setPixel(&grid, x: x, y: 2, color: red) }

        // Row 3
        for x in 5...10 { setPixel(&grid, x: x, y: 3, color: red) }

        // Row 4
        for x in 4...11 { setPixel(&grid, x: x, y: 4, color: red) }

        // Row 5: middle line
        for x in 4...11 { setPixel(&grid, x: x, y: 5, color: black) }
        setPixel(&grid, x: 7, y: 5, color: white)
        setPixel(&grid, x: 8, y: 5, color: white)

        // Row 6: button
        setPixel(&grid, x: 7, y: 6, color: gray)
        setPixel(&grid, x: 8, y: 6, color: gray)

        // Row 7
        for x in 4...11 { setPixel(&grid, x: x, y: 7, color: white) }

        // Row 8
        for x in 5...10 { setPixel(&grid, x: x, y: 8, color: white) }

        // Row 9: bottom
        for x in 6...9 { setPixel(&grid, x: x, y: 9, color: white) }

        // Bounce animation
        if anim == 1 {
            setPixel(&grid, x: 7, y: 1, color: gray)
            setPixel(&grid, x: 8, y: 1, color: gray)
        }
    }

    // MARK: - Mario (red hat, blue overalls, mustache)
    private func drawMario(grid: inout [[NSColor]], frame: Int) {
        let red = NSColor(red: 0.9, green: 0.15, blue: 0.15, alpha: 1.0)
        let blue = NSColor(red: 0.15, green: 0.3, blue: 0.85, alpha: 1.0)
        let skin = NSColor(red: 1.0, green: 0.8, blue: 0.6, alpha: 1.0)
        let brown = NSColor(red: 0.5, green: 0.3, blue: 0.1, alpha: 1.0)
        let black = NSColor.black

        // Hat
        for x in 5...10 { setPixel(&grid, x: x, y: 1, color: red) }
        setPixel(&grid, x: 4, y: 2, color: red)
        for x in 5...10 { setPixel(&grid, x: x, y: 2, color: red) }

        // Face
        for x in 5...10 { setPixel(&grid, x: x, y: 3, color: skin) }
        for x in 5...10 { setPixel(&grid, x: x, y: 4, color: skin) }

        // Eyes
        setPixel(&grid, x: 6, y: 3, color: black)
        setPixel(&grid, x: 9, y: 3, color: black)

        // Mustache
        for x in 6...9 { setPixel(&grid, x: x, y: 4, color: brown) }

        // Body / overalls
        for x in 5...10 { setPixel(&grid, x: x, y: 5, color: blue) }
        for x in 4...11 { setPixel(&grid, x: x, y: 6, color: blue) }
        for x in 4...11 { setPixel(&grid, x: x, y: 7, color: blue) }

        // Shirt under overalls
        setPixel(&grid, x: 5, y: 5, color: red)
        setPixel(&grid, x: 10, y: 5, color: red)

        // Legs (running)
        if frame % 2 == 0 {
            setPixel(&grid, x: 5, y: 8, color: blue)
            setPixel(&grid, x: 10, y: 8, color: blue)
            setPixel(&grid, x: 5, y: 9, color: brown)
            setPixel(&grid, x: 10, y: 9, color: brown)
        } else {
            setPixel(&grid, x: 6, y: 8, color: blue)
            setPixel(&grid, x: 9, y: 8, color: blue)
            setPixel(&grid, x: 6, y: 9, color: brown)
            setPixel(&grid, x: 9, y: 9, color: brown)
        }
    }

    // MARK: - Luigi (green hat, blue overalls, taller)
    private func drawLuigi(grid: inout [[NSColor]], frame: Int) {
        let green = NSColor(red: 0.15, green: 0.7, blue: 0.2, alpha: 1.0)
        let blue = NSColor(red: 0.15, green: 0.3, blue: 0.85, alpha: 1.0)
        let skin = NSColor(red: 1.0, green: 0.8, blue: 0.6, alpha: 1.0)
        let brown = NSColor(red: 0.5, green: 0.3, blue: 0.1, alpha: 1.0)
        let black = NSColor.black

        // Hat
        for x in 5...10 { setPixel(&grid, x: x, y: 0, color: green) }
        setPixel(&grid, x: 4, y: 1, color: green)
        for x in 5...10 { setPixel(&grid, x: x, y: 1, color: green) }

        // Face
        for x in 5...10 { setPixel(&grid, x: x, y: 2, color: skin) }
        for x in 5...10 { setPixel(&grid, x: x, y: 3, color: skin) }

        // Eyes
        setPixel(&grid, x: 6, y: 2, color: black)
        setPixel(&grid, x: 9, y: 2, color: black)

        // Mustache
        for x in 6...9 { setPixel(&grid, x: x, y: 3, color: brown) }

        // Body / overalls
        for x in 5...10 { setPixel(&grid, x: x, y: 4, color: blue) }
        for x in 4...11 { setPixel(&grid, x: x, y: 5, color: blue) }
        for x in 4...11 { setPixel(&grid, x: x, y: 6, color: blue) }
        for x in 4...11 { setPixel(&grid, x: x, y: 7, color: blue) }

        // Shirt under overalls
        setPixel(&grid, x: 5, y: 4, color: green)
        setPixel(&grid, x: 10, y: 4, color: green)

        // Legs
        if frame % 2 == 0 {
            setPixel(&grid, x: 5, y: 8, color: blue)
            setPixel(&grid, x: 10, y: 8, color: blue)
            setPixel(&grid, x: 5, y: 9, color: brown)
            setPixel(&grid, x: 10, y: 9, color: brown)
        } else {
            setPixel(&grid, x: 6, y: 8, color: blue)
            setPixel(&grid, x: 9, y: 8, color: blue)
            setPixel(&grid, x: 6, y: 9, color: brown)
            setPixel(&grid, x: 9, y: 9, color: brown)
        }
    }

    // MARK: - Peach (pink dress, crown, blonde hair)
    private func drawPeach(grid: inout [[NSColor]], frame: Int) {
        let pink = NSColor(red: 1.0, green: 0.55, blue: 0.65, alpha: 1.0)
        let blonde = NSColor(red: 1.0, green: 0.85, blue: 0.3, alpha: 1.0)
        let gold = NSColor(red: 0.85, green: 0.75, blue: 0.1, alpha: 1.0)
        let blue = NSColor(red: 0.3, green: 0.5, blue: 0.9, alpha: 1.0)
        let skin = NSColor(red: 1.0, green: 0.8, blue: 0.6, alpha: 1.0)

        // Crown
        setPixel(&grid, x: 6, y: 0, color: gold)
        setPixel(&grid, x: 8, y: 0, color: gold)
        setPixel(&grid, x: 7, y: 0, color: gold)
        for x in 5...10 { setPixel(&grid, x: x, y: 1, color: gold) }

        // Hair
        for x in 4...11 { setPixel(&grid, x: x, y: 2, color: blonde) }
        for x in 4...11 { setPixel(&grid, x: x, y: 3, color: blonde) }

        // Face
        for x in 5...10 { setPixel(&grid, x: x, y: 3, color: skin) }

        // Eyes
        setPixel(&grid, x: 6, y: 3, color: blue)
        setPixel(&grid, x: 9, y: 3, color: blue)

        // Dress
        for x in 4...11 { setPixel(&grid, x: x, y: 4, color: pink) }
        for x in 3...12 { setPixel(&grid, x: x, y: 5, color: pink) }
        for x in 3...12 { setPixel(&grid, x: x, y: 6, color: pink) }
        for x in 4...11 { setPixel(&grid, x: x, y: 7, color: pink) }

        // Dress gem
        setPixel(&grid, x: 7, y: 4, color: blue)
        setPixel(&grid, x: 8, y: 4, color: blue)

        // Legs
        if frame % 2 == 0 {
            setPixel(&grid, x: 5, y: 8, color: pink)
            setPixel(&grid, x: 10, y: 8, color: pink)
        } else {
            setPixel(&grid, x: 6, y: 8, color: pink)
            setPixel(&grid, x: 9, y: 8, color: pink)
        }
    }

    // MARK: - Toad (mushroom cap, small body)
    private func drawToad(grid: inout [[NSColor]], frame: Int) {
        let white = NSColor.white
        let red = NSColor(red: 0.9, green: 0.15, blue: 0.15, alpha: 1.0)
        let skin = NSColor(red: 1.0, green: 0.85, blue: 0.7, alpha: 1.0)
        let blue = NSColor(red: 0.15, green: 0.3, blue: 0.85, alpha: 1.0)
        let black = NSColor.black

        // Mushroom cap (white with red spots)
        for x in 4...11 { setPixel(&grid, x: x, y: 1, color: white) }
        for x in 3...12 { setPixel(&grid, x: x, y: 2, color: white) }
        for x in 3...12 { setPixel(&grid, x: x, y: 3, color: white) }
        // Red spots
        setPixel(&grid, x: 5, y: 1, color: red)
        setPixel(&grid, x: 10, y: 1, color: red)
        setPixel(&grid, x: 7, y: 2, color: red)
        setPixel(&grid, x: 8, y: 2, color: red)
        setPixel(&grid, x: 4, y: 3, color: red)
        setPixel(&grid, x: 11, y: 3, color: red)

        // Face
        for x in 5...10 { setPixel(&grid, x: x, y: 4, color: skin) }

        // Eyes
        setPixel(&grid, x: 6, y: 4, color: black)
        setPixel(&grid, x: 9, y: 4, color: black)

        // Mouth
        setPixel(&grid, x: 7, y: 4, color: NSColor(red: 0.8, green: 0.2, blue: 0.2, alpha: 1.0))
        setPixel(&grid, x: 8, y: 4, color: NSColor(red: 0.8, green: 0.2, blue: 0.2, alpha: 1.0))

        // Vest
        for x in 5...10 { setPixel(&grid, x: x, y: 5, color: blue) }
        for x in 4...11 { setPixel(&grid, x: x, y: 6, color: blue) }

        // Legs
        if frame % 2 == 0 {
            setPixel(&grid, x: 5, y: 7, color: white)
            setPixel(&grid, x: 10, y: 7, color: white)
        } else {
            setPixel(&grid, x: 6, y: 7, color: white)
            setPixel(&grid, x: 9, y: 7, color: white)
        }
    }

    // MARK: - Bowser (green shell, spikes, horns)
    private func drawBowser(grid: inout [[NSColor]], frame: Int) {
        let green = NSColor(red: 0.2, green: 0.65, blue: 0.2, alpha: 1.0)
        let yellow = NSColor(red: 1.0, green: 0.85, blue: 0.2, alpha: 1.0)
        let orange = NSColor(red: 1.0, green: 0.5, blue: 0.1, alpha: 1.0)
        let black = NSColor.black

        // Horns
        setPixel(&grid, x: 4, y: 0, color: orange)
        setPixel(&grid, x: 11, y: 0, color: orange)

        // Head
        for x in 5...10 { setPixel(&grid, x: x, y: 1, color: green) }
        for x in 4...11 { setPixel(&grid, x: x, y: 2, color: green) }

        // Eyes
        setPixel(&grid, x: 6, y: 1, color: black)
        setPixel(&grid, x: 9, y: 1, color: black)

        // Snout
        for x in 6...9 { setPixel(&grid, x: x, y: 3, color: yellow) }

        // Shell body
        for x in 3...12 { setPixel(&grid, x: x, y: 4, color: green) }
        for x in 2...13 { setPixel(&grid, x: x, y: 5, color: green) }
        for x in 2...13 { setPixel(&grid, x: x, y: 6, color: green) }
        for x in 3...12 { setPixel(&grid, x: x, y: 7, color: green) }

        // Shell spikes
        setPixel(&grid, x: 6, y: 4, color: orange)
        setPixel(&grid, x: 8, y: 4, color: orange)
        setPixel(&grid, x: 10, y: 4, color: orange)
        setPixel(&grid, x: 7, y: 5, color: orange)
        setPixel(&grid, x: 9, y: 5, color: orange)

        // Belly
        for x in 5...10 { setPixel(&grid, x: x, y: 5, color: yellow) }
        for x in 5...10 { setPixel(&grid, x: x, y: 6, color: yellow) }

        // Legs
        if frame % 2 == 0 {
            setPixel(&grid, x: 4, y: 8, color: green)
            setPixel(&grid, x: 11, y: 8, color: green)
        } else {
            setPixel(&grid, x: 5, y: 8, color: green)
            setPixel(&grid, x: 10, y: 8, color: green)
        }
    }

    // MARK: - Yoshi (green body, big nose, saddle)
    private func drawYoshi(grid: inout [[NSColor]], frame: Int) {
        let green = NSColor(red: 0.25, green: 0.75, blue: 0.25, alpha: 1.0)
        let darkGreen = NSColor(red: 0.15, green: 0.55, blue: 0.15, alpha: 1.0)
        let white = NSColor.white
        let red = NSColor(red: 0.9, green: 0.15, blue: 0.15, alpha: 1.0)
        let black = NSColor.black
        let orange = NSColor(red: 0.9, green: 0.5, blue: 0.1, alpha: 1.0)
        let anim = frame % 2

        // Nose (big, round, green)
        for x in 2...5 { setPixel(&grid, x: x, y: 2, color: green) }
        for x in 1...5 { setPixel(&grid, x: x, y: 3, color: green) }
        for x in 2...5 { setPixel(&grid, x: x, y: 4, color: green) }

        // Eyes (on top of head)
        setPixel(&grid, x: 6, y: 1, color: white); setPixel(&grid, x: 7, y: 1, color: white)
        setPixel(&grid, x: 6, y: 2, color: white); setPixel(&grid, x: 7, y: 2, color: white)
        setPixel(&grid, x: 6, y: 1, color: black); setPixel(&grid, x: 7, y: 2, color: black)

        // Head (green)
        for x in 6...10 { setPixel(&grid, x: x, y: 2, color: green) }
        for x in 6...10 { setPixel(&grid, x: x, y: 3, color: green) }
        for x in 7...10 { setPixel(&grid, x: x, y: 4, color: green) }

        // Saddle (orange/brown on back)
        setPixel(&grid, x: 9, y: 3, color: orange); setPixel(&grid, x: 10, y: 3, color: orange)
        setPixel(&grid, x: 9, y: 4, color: orange); setPixel(&grid, x: 10, y: 4, color: orange)

        // Body (green with white belly)
        for x in 4...11 { setPixel(&grid, x: x, y: 5, color: green) }
        for x in 4...11 { setPixel(&grid, x: x, y: 6, color: green) }
        for x in 4...11 { setPixel(&grid, x: x, y: 7, color: green) }
        // White belly
        for x in 5...9 { setPixel(&grid, x: x, y: 5, color: white) }
        for x in 5...9 { setPixel(&grid, x: x, y: 6, color: white) }
        for x in 5...9 { setPixel(&grid, x: x, y: 7, color: white) }

        // Dark green spots on body
        setPixel(&grid, x: 10, y: 5, color: darkGreen); setPixel(&grid, x: 11, y: 5, color: darkGreen)
        setPixel(&grid, x: 10, y: 6, color: darkGreen); setPixel(&grid, x: 11, y: 6, color: darkGreen)

        // Tail
        setPixel(&grid, x: 12, y: 6, color: green); setPixel(&grid, x: 12, y: 7, color: green)

        // Red boots
        if anim == 0 {
            setPixel(&grid, x: 4, y: 8, color: red); setPixel(&grid, x: 5, y: 8, color: red)
            setPixel(&grid, x: 9, y: 8, color: red); setPixel(&grid, x: 10, y: 8, color: red)
        } else {
            setPixel(&grid, x: 3, y: 8, color: red); setPixel(&grid, x: 4, y: 8, color: red)
            setPixel(&grid, x: 10, y: 8, color: red); setPixel(&grid, x: 11, y: 8, color: red)
        }
    }

    // MARK: - Donkey Kong (brown, big arms, tie)
    private func drawDonkeyKong(grid: inout [[NSColor]], frame: Int) {
        let brown = NSColor(red: 0.6, green: 0.35, blue: 0.15, alpha: 1.0)
        let darkBrown = NSColor(red: 0.4, green: 0.22, blue: 0.08, alpha: 1.0)
        let tan = NSColor(red: 0.85, green: 0.7, blue: 0.45, alpha: 1.0)
        let red = NSColor(red: 0.9, green: 0.15, blue: 0.15, alpha: 1.0)
        let black = NSColor.black

        // Hair spikes (top of head)
        setPixel(&grid, x: 6, y: 0, color: brown)
        setPixel(&grid, x: 7, y: 0, color: brown)
        setPixel(&grid, x: 9, y: 0, color: brown)
        setPixel(&grid, x: 10, y: 0, color: brown)

        // Head
        for x in 5...11 { setPixel(&grid, x: x, y: 1, color: brown) }
        for x in 5...11 { setPixel(&grid, x: x, y: 2, color: brown) }

        // Body
        for x in 4...11 { setPixel(&grid, x: x, y: 3, color: brown) }
        for x in 3...10 { setPixel(&grid, x: x, y: 4, color: brown) }
        for x in 2...9 { setPixel(&grid, x: x, y: 5, color: brown) }
        for x in 2...9 { setPixel(&grid, x: x, y: 6, color: brown) }
        for x in 3...10 { setPixel(&grid, x: x, y: 7, color: brown) }

        // Face (drawn ON TOP of body, right side)
        for x in 10...12 { setPixel(&grid, x: x, y: 2, color: tan) }
        for x in 10...12 { setPixel(&grid, x: x, y: 3, color: tan) }

        // Eyes (on top of face)
        setPixel(&grid, x: 11, y: 2, color: black)
        setPixel(&grid, x: 12, y: 2, color: black)

        // Mouth
        setPixel(&grid, x: 12, y: 3, color: black)

        // Tie (drawn ON TOP of body, big and visible)
        setPixel(&grid, x: 7, y: 3, color: red)
        setPixel(&grid, x: 6, y: 4, color: red)
        setPixel(&grid, x: 7, y: 4, color: red)
        setPixel(&grid, x: 8, y: 4, color: red)
        setPixel(&grid, x: 7, y: 5, color: red)

        // Belly (drawn ON TOP of body)
        for x in 4...8 { setPixel(&grid, x: x, y: 5, color: tan) }
        for x in 4...8 { setPixel(&grid, x: x, y: 6, color: tan) }

        // Arms
        setPixel(&grid, x: 1, y: 5, color: brown)
        setPixel(&grid, x: 1, y: 6, color: brown)
        setPixel(&grid, x: 10, y: 5, color: brown)
        setPixel(&grid, x: 11, y: 5, color: brown)

        // Legs/feet
        if frame % 2 == 0 {
            setPixel(&grid, x: 3, y: 8, color: darkBrown)
            setPixel(&grid, x: 4, y: 8, color: darkBrown)
            setPixel(&grid, x: 7, y: 8, color: darkBrown)
            setPixel(&grid, x: 8, y: 8, color: darkBrown)
        } else {
            setPixel(&grid, x: 4, y: 8, color: darkBrown)
            setPixel(&grid, x: 5, y: 8, color: darkBrown)
            setPixel(&grid, x: 6, y: 8, color: darkBrown)
            setPixel(&grid, x: 7, y: 8, color: darkBrown)
        }
    }

    // MARK: - Wario (yellow hat, purple overalls, big nose)
    private func drawWario(grid: inout [[NSColor]], frame: Int) {
        let yellow = NSColor(red: 1.0, green: 0.85, blue: 0.1, alpha: 1.0)
        let purple = NSColor(red: 0.5, green: 0.15, blue: 0.65, alpha: 1.0)
        let skin = NSColor(red: 1.0, green: 0.8, blue: 0.6, alpha: 1.0)
        let brown = NSColor(red: 0.5, green: 0.3, blue: 0.1, alpha: 1.0)
        let black = NSColor.black

        // Hat
        for x in 5...10 { setPixel(&grid, x: x, y: 1, color: yellow) }
        setPixel(&grid, x: 4, y: 2, color: yellow)
        for x in 5...10 { setPixel(&grid, x: x, y: 2, color: yellow) }

        // Face (wider)
        for x in 4...11 { setPixel(&grid, x: x, y: 3, color: skin) }
        for x in 4...11 { setPixel(&grid, x: x, y: 4, color: skin) }

        // Eyes
        setPixel(&grid, x: 6, y: 3, color: black)
        setPixel(&grid, x: 9, y: 3, color: black)

        // Mustache (zigzag)
        setPixel(&grid, x: 5, y: 4, color: brown)
        setPixel(&grid, x: 6, y: 4, color: brown)
        setPixel(&grid, x: 9, y: 4, color: brown)
        setPixel(&grid, x: 10, y: 4, color: brown)

        // Body
        for x in 4...11 { setPixel(&grid, x: x, y: 5, color: purple) }
        for x in 3...12 { setPixel(&grid, x: x, y: 6, color: purple) }
        for x in 3...12 { setPixel(&grid, x: x, y: 7, color: purple) }

        // Shirt
        setPixel(&grid, x: 4, y: 5, color: yellow)
        setPixel(&grid, x: 11, y: 5, color: yellow)

        // Legs
        if frame % 2 == 0 {
            setPixel(&grid, x: 4, y: 8, color: purple)
            setPixel(&grid, x: 11, y: 8, color: purple)
        } else {
            setPixel(&grid, x: 5, y: 8, color: purple)
            setPixel(&grid, x: 10, y: 8, color: purple)
        }
    }

    // MARK: - Waluigi (purple hat, tall, lanky)
    private func drawWaluigi(grid: inout [[NSColor]], frame: Int) {
        let purple = NSColor(red: 0.45, green: 0.1, blue: 0.6, alpha: 1.0)
        let darkPurple = NSColor(red: 0.3, green: 0.05, blue: 0.4, alpha: 1.0)
        let yellow = NSColor(red: 1.0, green: 0.85, blue: 0.1, alpha: 1.0)
        let skin = NSColor(red: 1.0, green: 0.8, blue: 0.6, alpha: 1.0)
        let black = NSColor.black

        // Hat (inverted L shape)
        for x in 5...10 { setPixel(&grid, x: x, y: 0, color: purple) }
        setPixel(&grid, x: 10, y: 1, color: purple)
        setPixel(&grid, x: 11, y: 1, color: purple)
        for x in 5...10 { setPixel(&grid, x: x, y: 1, color: purple) }

        // Face (tall)
        for x in 5...10 { setPixel(&grid, x: x, y: 2, color: skin) }
        for x in 5...10 { setPixel(&grid, x: x, y: 3, color: skin) }

        // Eyes
        setPixel(&grid, x: 6, y: 2, color: black)
        setPixel(&grid, x: 9, y: 2, color: black)

        // Mustache (pointy)
        setPixel(&grid, x: 5, y: 3, color: black)
        setPixel(&grid, x: 6, y: 3, color: black)
        setPixel(&grid, x: 9, y: 3, color: black)
        setPixel(&grid, x: 10, y: 3, color: black)

        // Body (tall)
        for x in 5...10 { setPixel(&grid, x: x, y: 4, color: purple) }
        for x in 4...11 { setPixel(&grid, x: x, y: 5, color: purple) }
        for x in 4...11 { setPixel(&grid, x: x, y: 6, color: purple) }
        for x in 4...11 { setPixel(&grid, x: x, y: 7, color: purple) }

        // Overalls straps
        setPixel(&grid, x: 6, y: 4, color: yellow)
        setPixel(&grid, x: 9, y: 4, color: yellow)

        // Legs (long)
        if frame % 2 == 0 {
            setPixel(&grid, x: 5, y: 8, color: darkPurple)
            setPixel(&grid, x: 10, y: 8, color: darkPurple)
            setPixel(&grid, x: 5, y: 9, color: darkPurple)
            setPixel(&grid, x: 10, y: 9, color: darkPurple)
        } else {
            setPixel(&grid, x: 6, y: 8, color: darkPurple)
            setPixel(&grid, x: 9, y: 8, color: darkPurple)
            setPixel(&grid, x: 6, y: 9, color: darkPurple)
            setPixel(&grid, x: 9, y: 9, color: darkPurple)
        }
    }

    // MARK: - Super Mushroom (red cap, white spots)
    private func drawSuperMushroom(grid: inout [[NSColor]], frame: Int) {
        let red = NSColor(red: 0.9, green: 0.15, blue: 0.15, alpha: 1.0)
        let white = NSColor.white
        let tan = NSColor(red: 0.95, green: 0.85, blue: 0.65, alpha: 1.0)
        let black = NSColor.black
        let eyeColor = (frame % 4 == 0) ? tan : black

        // Cap top
        setPixel(&grid, x: 6, y: 1, color: red)
        setPixel(&grid, x: 7, y: 1, color: red)
        setPixel(&grid, x: 8, y: 1, color: red)
        setPixel(&grid, x: 9, y: 1, color: red)

        // Cap upper
        for x in 4...11 { setPixel(&grid, x: x, y: 2, color: red) }

        // Cap middle - wide with white spots
        for x in 3...12 { setPixel(&grid, x: x, y: 3, color: red) }
        setPixel(&grid, x: 5, y: 3, color: white)
        setPixel(&grid, x: 6, y: 3, color: white)
        setPixel(&grid, x: 9, y: 3, color: white)
        setPixel(&grid, x: 10, y: 3, color: white)

        // Cap middle - wider
        for x in 2...13 { setPixel(&grid, x: x, y: 4, color: red) }
        setPixel(&grid, x: 7, y: 4, color: white)
        setPixel(&grid, x: 8, y: 4, color: white)

        // Cap lower - widest
        for x in 2...13 { setPixel(&grid, x: x, y: 5, color: red) }
        setPixel(&grid, x: 4, y: 5, color: white)
        setPixel(&grid, x: 5, y: 5, color: white)
        setPixel(&grid, x: 10, y: 5, color: white)
        setPixel(&grid, x: 11, y: 5, color: white)

        // Cap bottom
        for x in 3...12 { setPixel(&grid, x: x, y: 6, color: red) }
        setPixel(&grid, x: 7, y: 6, color: white)
        setPixel(&grid, x: 8, y: 6, color: white)

        // Face / stem (short)
        for x in 5...10 { setPixel(&grid, x: x, y: 7, color: tan) }
        for x in 4...11 { setPixel(&grid, x: x, y: 8, color: tan) }

        // Eyes (blink animation, 2 pixels tall)
        setPixel(&grid, x: 6, y: 7, color: eyeColor)
        setPixel(&grid, x: 6, y: 8, color: eyeColor)
        setPixel(&grid, x: 9, y: 7, color: eyeColor)
        setPixel(&grid, x: 9, y: 8, color: eyeColor)

        // Face bottom (tapers to chin)
        for x in 5...10 { setPixel(&grid, x: x, y: 9, color: tan) }
    }

    // MARK: - Fire Flower (orange/yellow petals, stem)
    private func drawFireFlower(grid: inout [[NSColor]], frame: Int) {
        let orange = NSColor(red: 1.0, green: 0.5, blue: 0.1, alpha: 1.0)
        let yellow = NSColor(red: 1.0, green: 0.85, blue: 0.1, alpha: 1.0)
        let red = NSColor(red: 0.9, green: 0.15, blue: 0.15, alpha: 1.0)
        let green = NSColor(red: 0.2, green: 0.7, blue: 0.2, alpha: 1.0)
        let white = NSColor.white

        // Petals (animated glow)
        let glow = frame % 2 == 0 ? orange : yellow
        setPixel(&grid, x: 7, y: 0, color: glow)
        setPixel(&grid, x: 8, y: 0, color: glow)
        setPixel(&grid, x: 6, y: 1, color: red)
        setPixel(&grid, x: 9, y: 1, color: red)
        setPixel(&grid, x: 7, y: 1, color: yellow)
        setPixel(&grid, x: 8, y: 1, color: yellow)

        // Center
        setPixel(&grid, x: 7, y: 2, color: white)
        setPixel(&grid, x: 8, y: 2, color: white)

        // Stem
        setPixel(&grid, x: 7, y: 3, color: green)
        setPixel(&grid, x: 8, y: 3, color: green)
        setPixel(&grid, x: 7, y: 4, color: green)
        setPixel(&grid, x: 8, y: 4, color: green)

        // Leaves
        setPixel(&grid, x: 5, y: 4, color: green)
        setPixel(&grid, x: 6, y: 4, color: green)
        setPixel(&grid, x: 9, y: 4, color: green)
        setPixel(&grid, x: 10, y: 4, color: green)

        // Base
        for x in 6...9 { setPixel(&grid, x: x, y: 5, color: green) }
    }

    // MARK: - Starman (golden star, sparkle animation)
    private func drawStarman(grid: inout [[NSColor]], frame: Int) {
        let gold = NSColor(red: 1.0, green: 0.85, blue: 0.1, alpha: 1.0)
        let yellow = NSColor(red: 1.0, green: 0.95, blue: 0.4, alpha: 1.0)
        let black = NSColor.black

        // Top point
        setPixel(&grid, x: 7, y: 0, color: gold)
        setPixel(&grid, x: 8, y: 0, color: gold)

        // Upper arms
        setPixel(&grid, x: 6, y: 1, color: gold)
        setPixel(&grid, x: 7, y: 1, color: gold)
        setPixel(&grid, x: 8, y: 1, color: gold)
        setPixel(&grid, x: 9, y: 1, color: gold)

        // Widening
        setPixel(&grid, x: 5, y: 2, color: gold)
        setPixel(&grid, x: 6, y: 2, color: gold)
        setPixel(&grid, x: 7, y: 2, color: gold)
        setPixel(&grid, x: 8, y: 2, color: gold)
        setPixel(&grid, x: 9, y: 2, color: gold)
        setPixel(&grid, x: 10, y: 2, color: gold)

        // Side points + eyes top (blink)
        let showEyes = frame % 4 < 3
        setPixel(&grid, x: 2, y: 3, color: gold)
        setPixel(&grid, x: 3, y: 3, color: gold)
        setPixel(&grid, x: 4, y: 3, color: gold)
        setPixel(&grid, x: 5, y: 3, color: gold)
        setPixel(&grid, x: 6, y: 3, color: showEyes ? black : gold)
        setPixel(&grid, x: 7, y: 3, color: gold)
        setPixel(&grid, x: 8, y: 3, color: gold)
        setPixel(&grid, x: 9, y: 3, color: showEyes ? black : gold)
        setPixel(&grid, x: 10, y: 3, color: gold)
        setPixel(&grid, x: 11, y: 3, color: gold)
        setPixel(&grid, x: 12, y: 3, color: gold)
        setPixel(&grid, x: 13, y: 3, color: gold)

        // Widest + eyes bottom (blink)
        setPixel(&grid, x: 1, y: 4, color: gold)
        setPixel(&grid, x: 2, y: 4, color: gold)
        setPixel(&grid, x: 3, y: 4, color: gold)
        setPixel(&grid, x: 4, y: 4, color: gold)
        setPixel(&grid, x: 5, y: 4, color: gold)
        setPixel(&grid, x: 6, y: 4, color: showEyes ? black : gold)
        setPixel(&grid, x: 7, y: 4, color: gold)
        setPixel(&grid, x: 8, y: 4, color: gold)
        setPixel(&grid, x: 9, y: 4, color: showEyes ? black : gold)
        setPixel(&grid, x: 10, y: 4, color: gold)
        setPixel(&grid, x: 11, y: 4, color: gold)
        setPixel(&grid, x: 12, y: 4, color: gold)
        setPixel(&grid, x: 13, y: 4, color: gold)
        setPixel(&grid, x: 14, y: 4, color: gold)

        // Lower body
        setPixel(&grid, x: 2, y: 5, color: gold)
        setPixel(&grid, x: 3, y: 5, color: gold)
        setPixel(&grid, x: 4, y: 5, color: gold)
        setPixel(&grid, x: 5, y: 5, color: gold)
        setPixel(&grid, x: 6, y: 5, color: gold)
        setPixel(&grid, x: 7, y: 5, color: gold)
        setPixel(&grid, x: 8, y: 5, color: gold)
        setPixel(&grid, x: 9, y: 5, color: gold)
        setPixel(&grid, x: 10, y: 5, color: gold)
        setPixel(&grid, x: 11, y: 5, color: gold)
        setPixel(&grid, x: 12, y: 5, color: gold)
        setPixel(&grid, x: 13, y: 5, color: gold)

        // Side points bottom
        setPixel(&grid, x: 3, y: 6, color: gold)
        setPixel(&grid, x: 4, y: 6, color: gold)
        setPixel(&grid, x: 5, y: 6, color: gold)
        setPixel(&grid, x: 10, y: 6, color: gold)
        setPixel(&grid, x: 11, y: 6, color: gold)
        setPixel(&grid, x: 12, y: 6, color: gold)

        // Lower legs
        setPixel(&grid, x: 4, y: 7, color: gold)
        setPixel(&grid, x: 5, y: 7, color: gold)
        setPixel(&grid, x: 10, y: 7, color: gold)
        setPixel(&grid, x: 11, y: 7, color: gold)

        // Bottom points
        setPixel(&grid, x: 5, y: 8, color: gold)
        setPixel(&grid, x: 6, y: 8, color: gold)
        setPixel(&grid, x: 9, y: 8, color: gold)
        setPixel(&grid, x: 10, y: 8, color: gold)

        // Sparkle animation
        if frame % 2 == 0 {
            setPixel(&grid, x: 1, y: 1, color: yellow)
            setPixel(&grid, x: 14, y: 0, color: yellow)
        } else {
            setPixel(&grid, x: 0, y: 2, color: yellow)
            setPixel(&grid, x: 15, y: 1, color: yellow)
        }
    }

    // MARK: - Coin (golden, spinning animation)
    private func drawCoin(grid: inout [[NSColor]], frame: Int) {
        let gold = NSColor(red: 1.0, green: 0.82, blue: 0.0, alpha: 1.0)
        let darkGold = NSColor(red: 0.82, green: 0.62, blue: 0.0, alpha: 1.0)
        let brightGold = NSColor(red: 1.0, green: 0.95, blue: 0.4, alpha: 1.0)
        let black = NSColor.black

        let phase = frame % 4

        if phase == 0 {
            // Full face - round coin
            setPixel(&grid, x: 7, y: 1, color: black)
            setPixel(&grid, x: 8, y: 1, color: black)
            for x in 6...9 { setPixel(&grid, x: x, y: 2, color: gold) }
            setPixel(&grid, x: 6, y: 2, color: black)
            setPixel(&grid, x: 9, y: 2, color: black)
            for x in 5...10 { setPixel(&grid, x: x, y: 3, color: gold) }
            setPixel(&grid, x: 5, y: 3, color: black)
            setPixel(&grid, x: 10, y: 3, color: black)
            setPixel(&grid, x: 6, y: 3, color: brightGold)
            for x in 5...10 { setPixel(&grid, x: x, y: 4, color: gold) }
            setPixel(&grid, x: 5, y: 4, color: black)
            setPixel(&grid, x: 10, y: 4, color: black)
            setPixel(&grid, x: 7, y: 4, color: darkGold)
            setPixel(&grid, x: 8, y: 4, color: darkGold)
            for x in 5...10 { setPixel(&grid, x: x, y: 5, color: gold) }
            setPixel(&grid, x: 5, y: 5, color: black)
            setPixel(&grid, x: 10, y: 5, color: black)
            setPixel(&grid, x: 6, y: 5, color: brightGold)
            for x in 6...9 { setPixel(&grid, x: x, y: 6, color: gold) }
            setPixel(&grid, x: 6, y: 6, color: black)
            setPixel(&grid, x: 9, y: 6, color: black)
            setPixel(&grid, x: 7, y: 7, color: black)
            setPixel(&grid, x: 8, y: 7, color: black)
        } else if phase == 2 {
            // Edge-on - thin line
            for x in 7...8 { setPixel(&grid, x: x, y: 2, color: darkGold) }
            for x in 7...8 { setPixel(&grid, x: x, y: 3, color: gold) }
            for x in 7...8 { setPixel(&grid, x: x, y: 4, color: gold) }
            for x in 7...8 { setPixel(&grid, x: x, y: 5, color: darkGold) }
        } else {
            // Angled view - wider
            for x in 5...10 { setPixel(&grid, x: x, y: 2, color: gold) }
            setPixel(&grid, x: 5, y: 2, color: black)
            setPixel(&grid, x: 10, y: 2, color: black)
            for x in 4...11 { setPixel(&grid, x: x, y: 3, color: gold) }
            setPixel(&grid, x: 4, y: 3, color: black)
            setPixel(&grid, x: 11, y: 3, color: black)
            for x in 4...11 { setPixel(&grid, x: x, y: 4, color: gold) }
            setPixel(&grid, x: 4, y: 4, color: black)
            setPixel(&grid, x: 11, y: 4, color: black)
            for x in 4...11 { setPixel(&grid, x: x, y: 5, color: gold) }
            setPixel(&grid, x: 4, y: 5, color: black)
            setPixel(&grid, x: 11, y: 5, color: black)
            for x in 5...10 { setPixel(&grid, x: x, y: 6, color: gold) }
            setPixel(&grid, x: 5, y: 6, color: black)
            setPixel(&grid, x: 10, y: 6, color: black)
            // Shading
            setPixel(&grid, x: 5, y: 3, color: brightGold)
            setPixel(&grid, x: 5, y: 4, color: brightGold)
            setPixel(&grid, x: 5, y: 5, color: brightGold)
            setPixel(&grid, x: 10, y: 3, color: darkGold)
            setPixel(&grid, x: 10, y: 4, color: darkGold)
            setPixel(&grid, x: 10, y: 5, color: darkGold)
        }
    }

    // MARK: - 1-Up Mushroom (green cap)
    private func drawOneUpMushroom(grid: inout [[NSColor]], frame: Int) {
        let green = NSColor(red: 0.2, green: 0.7, blue: 0.2, alpha: 1.0)
        let white = NSColor.white
        let tan = NSColor(red: 0.95, green: 0.85, blue: 0.65, alpha: 1.0)
        let black = NSColor.black
        let eyeColor = (frame % 4 == 0) ? tan : black

        // Cap top
        setPixel(&grid, x: 6, y: 1, color: green)
        setPixel(&grid, x: 7, y: 1, color: green)
        setPixel(&grid, x: 8, y: 1, color: green)
        setPixel(&grid, x: 9, y: 1, color: green)

        // Cap upper
        for x in 4...11 { setPixel(&grid, x: x, y: 2, color: green) }

        // Cap middle - wide with white spots
        for x in 3...12 { setPixel(&grid, x: x, y: 3, color: green) }
        setPixel(&grid, x: 5, y: 3, color: white)
        setPixel(&grid, x: 6, y: 3, color: white)
        setPixel(&grid, x: 9, y: 3, color: white)
        setPixel(&grid, x: 10, y: 3, color: white)

        // Cap middle - wider
        for x in 2...13 { setPixel(&grid, x: x, y: 4, color: green) }
        setPixel(&grid, x: 7, y: 4, color: white)
        setPixel(&grid, x: 8, y: 4, color: white)

        // Cap lower - widest
        for x in 2...13 { setPixel(&grid, x: x, y: 5, color: green) }
        setPixel(&grid, x: 4, y: 5, color: white)
        setPixel(&grid, x: 5, y: 5, color: white)
        setPixel(&grid, x: 10, y: 5, color: white)
        setPixel(&grid, x: 11, y: 5, color: white)

        // Cap bottom
        for x in 3...12 { setPixel(&grid, x: x, y: 6, color: green) }
        setPixel(&grid, x: 7, y: 6, color: white)
        setPixel(&grid, x: 8, y: 6, color: white)

        // Face / stem (short)
        for x in 5...10 { setPixel(&grid, x: x, y: 7, color: tan) }
        for x in 4...11 { setPixel(&grid, x: x, y: 8, color: tan) }

        // Eyes (blink animation, 2 pixels tall)
        setPixel(&grid, x: 6, y: 7, color: eyeColor)
        setPixel(&grid, x: 6, y: 8, color: eyeColor)
        setPixel(&grid, x: 9, y: 7, color: eyeColor)
        setPixel(&grid, x: 9, y: 8, color: eyeColor)

        // Face bottom (tapers to chin)
        for x in 5...10 { setPixel(&grid, x: x, y: 9, color: tan) }
    }

    // MARK: - Yoshi Egg (white with green spots)
    private func drawYoshiEgg(grid: inout [[NSColor]], frame: Int) {
        let white = NSColor.white
        let green = NSColor(red: 0.2, green: 0.7, blue: 0.2, alpha: 1.0)

        // Egg shape
        for x in 6...9 { setPixel(&grid, x: x, y: 2, color: white) }
        for x in 5...10 { setPixel(&grid, x: x, y: 3, color: white) }
        for x in 4...11 { setPixel(&grid, x: x, y: 4, color: white) }
        for x in 4...11 { setPixel(&grid, x: x, y: 5, color: white) }
        for x in 5...10 { setPixel(&grid, x: x, y: 6, color: white) }
        for x in 6...9 { setPixel(&grid, x: x, y: 7, color: white) }

        // Green spots
        setPixel(&grid, x: 6, y: 3, color: green)
        setPixel(&grid, x: 9, y: 3, color: green)
        setPixel(&grid, x: 7, y: 5, color: green)
        setPixel(&grid, x: 10, y: 5, color: green)
    }

    // MARK: - Pipe (green, classic Mario pipe)
    private func drawPipe(grid: inout [[NSColor]], frame: Int) {
        let green = NSColor(red: 0.15, green: 0.6, blue: 0.15, alpha: 1.0)
        let darkGreen = NSColor(red: 0.1, green: 0.4, blue: 0.1, alpha: 1.0)
        let lightGreen = NSColor(red: 0.3, green: 0.8, blue: 0.3, alpha: 1.0)

        // Pipe top (wider)
        for x in 3...12 { setPixel(&grid, x: x, y: 2, color: green) }
        for x in 3...12 { setPixel(&grid, x: x, y: 3, color: green) }

        // Pipe body (narrower)
        for x in 4...11 { setPixel(&grid, x: x, y: 4, color: green) }
        for x in 4...11 { setPixel(&grid, x: x, y: 5, color: green) }
        for x in 4...11 { setPixel(&grid, x: x, y: 6, color: green) }
        for x in 4...11 { setPixel(&grid, x: x, y: 7, color: green) }

        // Highlights
        setPixel(&grid, x: 4, y: 2, color: lightGreen)
        setPixel(&grid, x: 4, y: 3, color: lightGreen)
        setPixel(&grid, x: 5, y: 4, color: lightGreen)
        setPixel(&grid, x: 5, y: 5, color: lightGreen)
        setPixel(&grid, x: 5, y: 6, color: lightGreen)

        // Shadows
        setPixel(&grid, x: 11, y: 2, color: darkGreen)
        setPixel(&grid, x: 11, y: 3, color: darkGreen)
        setPixel(&grid, x: 10, y: 4, color: darkGreen)
        setPixel(&grid, x: 10, y: 5, color: darkGreen)
        setPixel(&grid, x: 10, y: 6, color: darkGreen)
    }

    // MARK: - Question Block (golden, ? symbol, blinking)
    private func drawQuestionBlock(grid: inout [[NSColor]], frame: Int) {
        let gold = NSColor(red: 1.0, green: 0.8, blue: 0.1, alpha: 1.0)
        let darkGold = NSColor(red: 0.8, green: 0.6, blue: 0.05, alpha: 1.0)
        let brown = NSColor(red: 0.5, green: 0.3, blue: 0.1, alpha: 1.0)

        // Block outline
        for x in 4...11 { setPixel(&grid, x: x, y: 2, color: brown) }
        for x in 4...11 { setPixel(&grid, x: x, y: 7, color: brown) }
        for y in 2...7 { setPixel(&grid, x: 4, y: y, color: brown) }
        for y in 2...7 { setPixel(&grid, x: 11, y: y, color: brown) }

        // Fill
        for x in 5...10 { setPixel(&grid, x: x, y: 3, color: gold) }
        for x in 5...10 { setPixel(&grid, x: x, y: 4, color: gold) }
        for x in 5...10 { setPixel(&grid, x: x, y: 5, color: gold) }
        for x in 5...10 { setPixel(&grid, x: x, y: 6, color: gold) }

        // ? mark
        let qColor = frame % 2 == 0 ? darkGold : brown
        for x in 7...9 { setPixel(&grid, x: x, y: 3, color: qColor) }
        setPixel(&grid, x: 9, y: 4, color: qColor)
        setPixel(&grid, x: 8, y: 5, color: qColor)
        setPixel(&grid, x: 8, y: 6, color: qColor)

        // Corner rivets
        setPixel(&grid, x: 5, y: 3, color: darkGold)
        setPixel(&grid, x: 10, y: 3, color: darkGold)
        setPixel(&grid, x: 5, y: 6, color: darkGold)
        setPixel(&grid, x: 10, y: 6, color: darkGold)
    }

    // MARK: - Goomba (brown mushroom-like enemy)
    private func drawGoomba(grid: inout [[NSColor]], frame: Int) {
        let brown = NSColor(red: 0.55, green: 0.3, blue: 0.15, alpha: 1.0)
        let darkBrown = NSColor(red: 0.4, green: 0.2, blue: 0.08, alpha: 1.0)
        let tan = NSColor(red: 0.85, green: 0.7, blue: 0.45, alpha: 1.0)
        let black = NSColor.black
        let white = NSColor.white

        // Head (mushroom top)
        for x in 4...11 { setPixel(&grid, x: x, y: 2, color: brown) }
        for x in 3...12 { setPixel(&grid, x: x, y: 3, color: brown) }
        for x in 3...12 { setPixel(&grid, x: x, y: 4, color: brown) }

        // Eyes (angry)
        setPixel(&grid, x: 5, y: 3, color: white)
        setPixel(&grid, x: 6, y: 3, color: white)
        setPixel(&grid, x: 9, y: 3, color: white)
        setPixel(&grid, x: 10, y: 3, color: white)
        setPixel(&grid, x: 6, y: 3, color: black)
        setPixel(&grid, x: 9, y: 3, color: black)

        // Eyebrows (angry)
        setPixel(&grid, x: 5, y: 2, color: black)
        setPixel(&grid, x: 10, y: 2, color: black)

        // Body
        for x in 5...10 { setPixel(&grid, x: x, y: 5, color: tan) }
        for x in 4...11 { setPixel(&grid, x: x, y: 6, color: tan) }

        // Feet
        if frame % 2 == 0 {
            setPixel(&grid, x: 4, y: 7, color: darkBrown)
            setPixel(&grid, x: 5, y: 7, color: darkBrown)
            setPixel(&grid, x: 10, y: 7, color: darkBrown)
            setPixel(&grid, x: 11, y: 7, color: darkBrown)
        } else {
            setPixel(&grid, x: 5, y: 7, color: darkBrown)
            setPixel(&grid, x: 6, y: 7, color: darkBrown)
            setPixel(&grid, x: 9, y: 7, color: darkBrown)
            setPixel(&grid, x: 10, y: 7, color: darkBrown)
        }
    }

    // MARK: - Koopa Troopa (green shell, yellow body)
    private func drawKoopaTroopa(grid: inout [[NSColor]], frame: Int) {
        let green = NSColor(red: 0.2, green: 0.65, blue: 0.2, alpha: 1.0)
        let darkGreen = NSColor(red: 0.1, green: 0.45, blue: 0.1, alpha: 1.0)
        let yellow = NSColor(red: 1.0, green: 0.85, blue: 0.3, alpha: 1.0)
        let white = NSColor.white
        let black = NSColor.black

        // Head
        for x in 5...8 { setPixel(&grid, x: x, y: 1, color: yellow) }
        for x in 5...8 { setPixel(&grid, x: x, y: 2, color: yellow) }

        // Eyes
        setPixel(&grid, x: 6, y: 1, color: white)
        setPixel(&grid, x: 7, y: 1, color: white)
        setPixel(&grid, x: 6, y: 1, color: black)
        setPixel(&grid, x: 7, y: 2, color: black)

        // Shell
        for x in 4...11 { setPixel(&grid, x: x, y: 3, color: green) }
        for x in 3...12 { setPixel(&grid, x: x, y: 4, color: green) }
        for x in 3...12 { setPixel(&grid, x: x, y: 5, color: green) }
        for x in 4...11 { setPixel(&grid, x: x, y: 6, color: green) }

        // Shell pattern
        setPixel(&grid, x: 6, y: 4, color: darkGreen)
        setPixel(&grid, x: 8, y: 4, color: darkGreen)
        setPixel(&grid, x: 10, y: 4, color: darkGreen)
        setPixel(&grid, x: 7, y: 5, color: darkGreen)
        setPixel(&grid, x: 9, y: 5, color: darkGreen)

        // Belly
        for x in 5...10 { setPixel(&grid, x: x, y: 4, color: yellow) }

        // Feet
        if frame % 2 == 0 {
            setPixel(&grid, x: 4, y: 7, color: yellow)
            setPixel(&grid, x: 11, y: 7, color: yellow)
        } else {
            setPixel(&grid, x: 5, y: 7, color: yellow)
            setPixel(&grid, x: 10, y: 7, color: yellow)
        }
    }

    private func drawBoo(grid: inout [[NSColor]], frame: Int) {
        let white = NSColor.white
        let black = NSColor.black
        let red = NSColor(red: 0.9, green: 0.15, blue: 0.15, alpha: 1.0)
        let gray = NSColor(red: 0.7, green: 0.7, blue: 0.7, alpha: 1.0)

        // Circular motion using system uptime — immune to timer restarts
        let uptime = ProcessInfo.processInfo.systemUptime
        let angle = uptime * 2.0 // ~2 radians/sec
        let dx = Int(round(cos(angle) * 3.0))
        let dy = Int(round(sin(angle) * 3.0))

        // Offset base position so ±3 shift never goes out of bounds
        let bx = 5
        let by = 5
        func s(_ x: Int, _ y: Int) -> (Int, Int) { (x + bx + dx, y + by + dy) }

        // Row 0 - top
        setPixel(&grid, x: s(4,0).0, y: s(4,0).1, color: black)
        setPixel(&grid, x: s(5,0).0, y: s(5,0).1, color: black)
        setPixel(&grid, x: s(6,0).0, y: s(6,0).1, color: black)
        setPixel(&grid, x: s(7,0).0, y: s(7,0).1, color: black)
        setPixel(&grid, x: s(8,0).0, y: s(8,0).1, color: black)
        setPixel(&grid, x: s(9,0).0, y: s(9,0).1, color: black)
        setPixel(&grid, x: s(10,0).0, y: s(10,0).1, color: black)
        setPixel(&grid, x: s(11,0).0, y: s(11,0).1, color: black)

        // Row 1
        setPixel(&grid, x: s(3,1).0, y: s(3,1).1, color: black)
        setPixel(&grid, x: s(4,1).0, y: s(4,1).1, color: gray)
        setPixel(&grid, x: s(5,1).0, y: s(5,1).1, color: gray)
        setPixel(&grid, x: s(6,1).0, y: s(6,1).1, color: gray)
        setPixel(&grid, x: s(7,1).0, y: s(7,1).1, color: white)
        setPixel(&grid, x: s(8,1).0, y: s(8,1).1, color: white)
        setPixel(&grid, x: s(9,1).0, y: s(9,1).1, color: white)
        setPixel(&grid, x: s(10,1).0, y: s(10,1).1, color: white)
        setPixel(&grid, x: s(11,1).0, y: s(11,1).1, color: white)
        setPixel(&grid, x: s(12,1).0, y: s(12,1).1, color: black)

        // Row 2
        setPixel(&grid, x: s(2,2).0, y: s(2,2).1, color: black)
        setPixel(&grid, x: s(3,2).0, y: s(3,2).1, color: gray)
        setPixel(&grid, x: s(4,2).0, y: s(4,2).1, color: gray)
        setPixel(&grid, x: s(5,2).0, y: s(5,2).1, color: gray)
        setPixel(&grid, x: s(6,2).0, y: s(6,2).1, color: white)
        setPixel(&grid, x: s(7,2).0, y: s(7,2).1, color: white)
        setPixel(&grid, x: s(8,2).0, y: s(8,2).1, color: white)
        setPixel(&grid, x: s(9,2).0, y: s(9,2).1, color: white)
        setPixel(&grid, x: s(10,2).0, y: s(10,2).1, color: white)
        setPixel(&grid, x: s(11,2).0, y: s(11,2).1, color: white)
        setPixel(&grid, x: s(12,2).0, y: s(12,2).1, color: white)
        setPixel(&grid, x: s(13,2).0, y: s(13,2).1, color: black)

        // Row 3 - eyes top
        setPixel(&grid, x: s(1,3).0, y: s(1,3).1, color: black)
        setPixel(&grid, x: s(2,3).0, y: s(2,3).1, color: gray)
        setPixel(&grid, x: s(3,3).0, y: s(3,3).1, color: gray)
        setPixel(&grid, x: s(4,3).0, y: s(4,3).1, color: gray)
        setPixel(&grid, x: s(5,3).0, y: s(5,3).1, color: white)
        setPixel(&grid, x: s(6,3).0, y: s(6,3).1, color: white)
        setPixel(&grid, x: s(7,3).0, y: s(7,3).1, color: black)
        setPixel(&grid, x: s(8,3).0, y: s(8,3).1, color: white)
        setPixel(&grid, x: s(9,3).0, y: s(9,3).1, color: white)
        setPixel(&grid, x: s(10,3).0, y: s(10,3).1, color: black)
        setPixel(&grid, x: s(11,3).0, y: s(11,3).1, color: white)
        setPixel(&grid, x: s(12,3).0, y: s(12,3).1, color: white)
        setPixel(&grid, x: s(13,3).0, y: s(13,3).1, color: white)
        setPixel(&grid, x: s(14,3).0, y: s(14,3).1, color: black)

        // Row 4 - eyes bottom
        setPixel(&grid, x: s(1,4).0, y: s(1,4).1, color: black)
        setPixel(&grid, x: s(2,4).0, y: s(2,4).1, color: gray)
        setPixel(&grid, x: s(3,4).0, y: s(3,4).1, color: gray)
        setPixel(&grid, x: s(4,4).0, y: s(4,4).1, color: gray)
        setPixel(&grid, x: s(5,4).0, y: s(5,4).1, color: white)
        setPixel(&grid, x: s(6,4).0, y: s(6,4).1, color: white)
        setPixel(&grid, x: s(7,4).0, y: s(7,4).1, color: black)
        setPixel(&grid, x: s(8,4).0, y: s(8,4).1, color: white)
        setPixel(&grid, x: s(9,4).0, y: s(9,4).1, color: white)
        setPixel(&grid, x: s(10,4).0, y: s(10,4).1, color: black)
        setPixel(&grid, x: s(11,4).0, y: s(11,4).1, color: white)
        setPixel(&grid, x: s(12,4).0, y: s(12,4).1, color: white)
        setPixel(&grid, x: s(13,4).0, y: s(13,4).1, color: white)
        setPixel(&grid, x: s(14,4).0, y: s(14,4).1, color: black)

        // Row 5 - widest
        setPixel(&grid, x: s(0,5).0, y: s(0,5).1, color: black)
        setPixel(&grid, x: s(1,5).0, y: s(1,5).1, color: gray)
        setPixel(&grid, x: s(2,5).0, y: s(2,5).1, color: gray)
        setPixel(&grid, x: s(3,5).0, y: s(3,5).1, color: gray)
        setPixel(&grid, x: s(4,5).0, y: s(4,5).1, color: gray)
        setPixel(&grid, x: s(5,5).0, y: s(5,5).1, color: white)
        setPixel(&grid, x: s(6,5).0, y: s(6,5).1, color: white)
        setPixel(&grid, x: s(7,5).0, y: s(7,5).1, color: white)
        setPixel(&grid, x: s(8,5).0, y: s(8,5).1, color: white)
        setPixel(&grid, x: s(9,5).0, y: s(9,5).1, color: white)
        setPixel(&grid, x: s(10,5).0, y: s(10,5).1, color: white)
        setPixel(&grid, x: s(11,5).0, y: s(11,5).1, color: white)
        setPixel(&grid, x: s(12,5).0, y: s(12,5).1, color: white)
        setPixel(&grid, x: s(13,5).0, y: s(13,5).1, color: white)
        setPixel(&grid, x: s(14,5).0, y: s(14,5).1, color: white)
        setPixel(&grid, x: s(15,5).0, y: s(15,5).1, color: black)

        // Row 6 - mouth
        setPixel(&grid, x: s(0,6).0, y: s(0,6).1, color: black)
        setPixel(&grid, x: s(1,6).0, y: s(1,6).1, color: gray)
        setPixel(&grid, x: s(2,6).0, y: s(2,6).1, color: gray)
        setPixel(&grid, x: s(3,6).0, y: s(3,6).1, color: gray)
        setPixel(&grid, x: s(4,6).0, y: s(4,6).1, color: gray)
        setPixel(&grid, x: s(5,6).0, y: s(5,6).1, color: white)
        setPixel(&grid, x: s(6,6).0, y: s(6,6).1, color: white)
        setPixel(&grid, x: s(7,6).0, y: s(7,6).1, color: white)
        setPixel(&grid, x: s(8,6).0, y: s(8,6).1, color: red)
        setPixel(&grid, x: s(9,6).0, y: s(9,6).1, color: red)
        setPixel(&grid, x: s(10,6).0, y: s(10,6).1, color: red)
        setPixel(&grid, x: s(11,6).0, y: s(11,6).1, color: white)
        setPixel(&grid, x: s(12,6).0, y: s(12,6).1, color: white)
        setPixel(&grid, x: s(13,6).0, y: s(13,6).1, color: white)
        setPixel(&grid, x: s(14,6).0, y: s(14,6).1, color: white)
        setPixel(&grid, x: s(15,6).0, y: s(15,6).1, color: black)

        // Row 7 - mouth bottom
        setPixel(&grid, x: s(0,7).0, y: s(0,7).1, color: black)
        setPixel(&grid, x: s(1,7).0, y: s(1,7).1, color: gray)
        setPixel(&grid, x: s(2,7).0, y: s(2,7).1, color: gray)
        setPixel(&grid, x: s(3,7).0, y: s(3,7).1, color: gray)
        setPixel(&grid, x: s(4,7).0, y: s(4,7).1, color: gray)
        setPixel(&grid, x: s(5,7).0, y: s(5,7).1, color: white)
        setPixel(&grid, x: s(6,7).0, y: s(6,7).1, color: white)
        setPixel(&grid, x: s(7,7).0, y: s(7,7).1, color: white)
        setPixel(&grid, x: s(8,7).0, y: s(8,7).1, color: red)
        setPixel(&grid, x: s(9,7).0, y: s(9,7).1, color: red)
        setPixel(&grid, x: s(10,7).0, y: s(10,7).1, color: red)
        setPixel(&grid, x: s(11,7).0, y: s(11,7).1, color: white)
        setPixel(&grid, x: s(12,7).0, y: s(12,7).1, color: white)
        setPixel(&grid, x: s(13,7).0, y: s(13,7).1, color: white)
        setPixel(&grid, x: s(14,7).0, y: s(14,7).1, color: white)
        setPixel(&grid, x: s(15,7).0, y: s(15,7).1, color: black)

        // Row 8
        setPixel(&grid, x: s(1,8).0, y: s(1,8).1, color: black)
        setPixel(&grid, x: s(2,8).0, y: s(2,8).1, color: gray)
        setPixel(&grid, x: s(3,8).0, y: s(3,8).1, color: gray)
        setPixel(&grid, x: s(4,8).0, y: s(4,8).1, color: gray)
        setPixel(&grid, x: s(5,8).0, y: s(5,8).1, color: white)
        setPixel(&grid, x: s(6,8).0, y: s(6,8).1, color: white)
        setPixel(&grid, x: s(7,8).0, y: s(7,8).1, color: white)
        setPixel(&grid, x: s(8,8).0, y: s(8,8).1, color: white)
        setPixel(&grid, x: s(9,8).0, y: s(9,8).1, color: white)
        setPixel(&grid, x: s(10,8).0, y: s(10,8).1, color: white)
        setPixel(&grid, x: s(11,8).0, y: s(11,8).1, color: white)
        setPixel(&grid, x: s(12,8).0, y: s(12,8).1, color: white)
        setPixel(&grid, x: s(13,8).0, y: s(13,8).1, color: white)
        setPixel(&grid, x: s(14,8).0, y: s(14,8).1, color: black)

        // Row 9
        setPixel(&grid, x: s(2,9).0, y: s(2,9).1, color: black)
        setPixel(&grid, x: s(3,9).0, y: s(3,9).1, color: gray)
        setPixel(&grid, x: s(4,9).0, y: s(4,9).1, color: white)
        setPixel(&grid, x: s(5,9).0, y: s(5,9).1, color: white)
        setPixel(&grid, x: s(6,9).0, y: s(6,9).1, color: white)
        setPixel(&grid, x: s(7,9).0, y: s(7,9).1, color: white)
        setPixel(&grid, x: s(8,9).0, y: s(8,9).1, color: white)
        setPixel(&grid, x: s(9,9).0, y: s(9,9).1, color: white)
        setPixel(&grid, x: s(10,9).0, y: s(10,9).1, color: white)
        setPixel(&grid, x: s(11,9).0, y: s(11,9).1, color: white)
        setPixel(&grid, x: s(12,9).0, y: s(12,9).1, color: white)
        setPixel(&grid, x: s(13,9).0, y: s(13,9).1, color: black)

        // Row 10 - wavy bottom
        setPixel(&grid, x: s(2,10).0, y: s(2,10).1, color: black)
        setPixel(&grid, x: s(3,10).0, y: s(3,10).1, color: black)
        setPixel(&grid, x: s(5,10).0, y: s(5,10).1, color: black)
        setPixel(&grid, x: s(7,10).0, y: s(7,10).1, color: black)
        setPixel(&grid, x: s(9,10).0, y: s(9,10).1, color: black)
        setPixel(&grid, x: s(11,10).0, y: s(11,10).1, color: black)
        setPixel(&grid, x: s(13,10).0, y: s(13,10).1, color: black)

        // Row 11 - tentacles
        setPixel(&grid, x: s(3,11).0, y: s(3,11).1, color: black)
        setPixel(&grid, x: s(5,11).0, y: s(5,11).1, color: black)
        setPixel(&grid, x: s(7,11).0, y: s(7,11).1, color: black)
        setPixel(&grid, x: s(9,11).0, y: s(9,11).1, color: black)
        setPixel(&grid, x: s(11,11).0, y: s(11,11).1, color: black)
        setPixel(&grid, x: s(13,11).0, y: s(13,11).1, color: black)
    }

    // MARK: - Kart Characters (racing in go-kart)
    private func drawKartMario(grid: inout [[NSColor]], frame: Int) {
        let red = NSColor(red: 0.91, green: 0.20, blue: 0.14, alpha: 1.0)
        let blue = NSColor(red: 0.00, green: 0.00, blue: 0.96, alpha: 1.0)
        let skin = NSColor(red: 0.97, green: 0.81, blue: 0.61, alpha: 1.0)
        let skinShadow = NSColor(red: 0.52, green: 0.35, blue: 0.18, alpha: 1.0)
        let yellow = NSColor(red: 0.97, green: 0.78, blue: 0.30, alpha: 1.0)
        let white = NSColor.white
        let black = NSColor.black
        let gray = NSColor(red: 0.50, green: 0.50, blue: 0.50, alpha: 1.0)
        let lightGray = NSColor(red: 0.75, green: 0.75, blue: 0.75, alpha: 1.0)

        let anim = frame % 2
        let rows: [String] = [
            "...........KKKRRRRK.............", // 00
            "..........KRRRRRRRRK............", // 01
            ".........KRRRRRRRRWK............", // 02
            "........KRRRRRRRRWWK............", // 03
            ".......KRRRRRKKKKKKKK...........", // 04
            "......KRRRRRKKRRRRRRRK..........", // 05
            ".....KRRRRKKRRKKKKKKRKK.........", // 06
            ".....KRRRKSSKKKSWWSKK...........", // 07
            ".....KKRKtSSSKSSWKSK............", // 08
            "......KRKtSSSKSSWKSKKK..........", // 09
            ".......KKKttSKSSKSSSSSK.........", // 10
            ".......KKKKKSSSSKKKtttK.........", // 11
            "........KKKttSSSSKKKKK..........", // 12
            "..........KKKttSSSKKK...........", // 13
            ".........KBRRKKttttKK...........", // 14
            "........KBRRRRRKKKKWWKK.........", // 15
            ".......KKBRRRRRRRRWWWWKK........", // 16
            "......KSKBRRRRRRRRKWWWKKK.......", // 17
            "......KSKBKRRRRRRRRKKKKYYK......", // 18
            "......KSKBBKKRRRRKKBBBYRKKKK....", // 19
            "......KSKBBBBKKKKBBBBBBRK...K...", // 20
            "....KKKKKBBBBBBBBBBBBBRRKKK.K...", // 21
            "....KKGKKBBBBBBBBBBBBBRKKGGKK...", // 22
            "...KKGGGKKKBBBBBBBBBBRRKGGGGK...", // 23
            "...KGgggGKWKKBBBBKKKRRKGGggGK...", // 24
            "...KGgWgGKRWWKKKKRRRKKKGgWWgGK..", // 25
            "...KGGgGGKRRRWWWWWWWWRKGGggGGK..", // 26
            "....KGGGGKKKKKKKKKKKKK.KGGGGK...", // 27
            ".....KKKK...............KKKK....", // 28
            "................................", // 29
            "................................", // 30
            "................................", // 31
        ]

        for (rIdx, row) in rows.enumerated() {
            var rowChars = Array(row)

            // Animated wheel spin
            if anim == 1 {
                if rIdx == 24 {
                    rowChars[5] = "g"; rowChars[6] = "W"; rowChars[7] = "g"
                    rowChars[24] = "g"; rowChars[25] = "W"; rowChars[26] = "g"
                } else if rIdx == 25 {
                    rowChars[5] = "W"; rowChars[6] = "g"; rowChars[7] = "W"
                    rowChars[24] = "W"; rowChars[25] = "g"; rowChars[26] = "W"
                }
            }

            for (cIdx, ch) in rowChars.enumerated() {
                switch ch {
                case "K": setPixel(&grid, x: cIdx, y: rIdx, color: black)
                case "R": setPixel(&grid, x: cIdx, y: rIdx, color: red)
                case "B": setPixel(&grid, x: cIdx, y: rIdx, color: blue)
                case "S": setPixel(&grid, x: cIdx, y: rIdx, color: skin)
                case "t": setPixel(&grid, x: cIdx, y: rIdx, color: skinShadow)
                case "Y": setPixel(&grid, x: cIdx, y: rIdx, color: yellow)
                case "W": setPixel(&grid, x: cIdx, y: rIdx, color: white)
                case "G": setPixel(&grid, x: cIdx, y: rIdx, color: gray)
                case "g": setPixel(&grid, x: cIdx, y: rIdx, color: lightGray)
                default: break
                }
            }
        }
    }

    private func drawKartLuigi(grid: inout [[NSColor]], frame: Int) {
        let green = NSColor(red: 0.15, green: 0.7, blue: 0.2, alpha: 1.0)
        let skin = NSColor(red: 1.0, green: 0.8, blue: 0.6, alpha: 1.0)
        let gray = NSColor(red: 0.5, green: 0.5, blue: 0.55, alpha: 1.0)
        let black = NSColor.black
        let white = NSColor.white

        // Hat
        for x in 6...9 { setPixel(&grid, x: x, y: 0, color: green) }
        for x in 5...10 { setPixel(&grid, x: x, y: 1, color: green) }

        // Face
        for x in 5...10 { setPixel(&grid, x: x, y: 2, color: skin) }
        setPixel(&grid, x: 6, y: 2, color: black)
        setPixel(&grid, x: 9, y: 2, color: black)

        // Shirt
        for x in 4...11 { setPixel(&grid, x: x, y: 3, color: green) }

        // Kart body
        setPixel(&grid, x: 1, y: 4, color: black)
        for x in 2...13 { setPixel(&grid, x: x, y: 4, color: green) }
        setPixel(&grid, x: 14, y: 4, color: black)

        // Kart stripe
        for x in 4...11 { setPixel(&grid, x: x, y: 5, color: white) }
        setPixel(&grid, x: 3, y: 5, color: green)
        setPixel(&grid, x: 12, y: 5, color: green)

        // Kart bottom
        for x in 2...13 { setPixel(&grid, x: x, y: 6, color: gray) }

        // Wheels
        let w = frame % 2 == 0 ? 0 : 1
        setPixel(&grid, x: 1 + w, y: 7, color: black)
        setPixel(&grid, x: 2 + w, y: 7, color: gray)
        setPixel(&grid, x: 2 + w, y: 8, color: black)
        setPixel(&grid, x: 12 - w, y: 7, color: gray)
        setPixel(&grid, x: 13 - w, y: 7, color: black)
        setPixel(&grid, x: 12 - w, y: 8, color: black)
    }

    private func drawKartPeach(grid: inout [[NSColor]], frame: Int) {
        let pink = NSColor(red: 1.0, green: 0.55, blue: 0.65, alpha: 1.0)
        let blonde = NSColor(red: 1.0, green: 0.85, blue: 0.3, alpha: 1.0)
        let gold = NSColor(red: 0.85, green: 0.75, blue: 0.1, alpha: 1.0)
        let skin = NSColor(red: 1.0, green: 0.8, blue: 0.6, alpha: 1.0)
        let gray = NSColor(red: 0.5, green: 0.5, blue: 0.55, alpha: 1.0)
        let black = NSColor.black
        let white = NSColor.white

        // Crown
        setPixel(&grid, x: 7, y: 0, color: gold)
        setPixel(&grid, x: 8, y: 0, color: gold)
        for x in 6...9 { setPixel(&grid, x: x, y: 1, color: blonde) }

        // Face
        for x in 5...10 { setPixel(&grid, x: x, y: 2, color: skin) }
        setPixel(&grid, x: 6, y: 2, color: black)
        setPixel(&grid, x: 9, y: 2, color: black)

        // Dress
        for x in 4...11 { setPixel(&grid, x: x, y: 3, color: pink) }

        // Kart body
        setPixel(&grid, x: 1, y: 4, color: black)
        for x in 2...13 { setPixel(&grid, x: x, y: 4, color: pink) }
        setPixel(&grid, x: 14, y: 4, color: black)

        // Kart stripe
        for x in 4...11 { setPixel(&grid, x: x, y: 5, color: white) }
        setPixel(&grid, x: 3, y: 5, color: pink)
        setPixel(&grid, x: 12, y: 5, color: pink)

        // Kart bottom
        for x in 2...13 { setPixel(&grid, x: x, y: 6, color: gray) }

        // Wheels
        let w = frame % 2 == 0 ? 0 : 1
        setPixel(&grid, x: 1 + w, y: 7, color: black)
        setPixel(&grid, x: 2 + w, y: 7, color: gray)
        setPixel(&grid, x: 2 + w, y: 8, color: black)
        setPixel(&grid, x: 12 - w, y: 7, color: gray)
        setPixel(&grid, x: 13 - w, y: 7, color: black)
        setPixel(&grid, x: 12 - w, y: 8, color: black)
    }

    private func drawKartToad(grid: inout [[NSColor]], frame: Int) {
        let white = NSColor.white
        let red = NSColor(red: 0.9, green: 0.15, blue: 0.15, alpha: 1.0)
        let skin = NSColor(red: 1.0, green: 0.85, blue: 0.7, alpha: 1.0)
        let blue = NSColor(red: 0.15, green: 0.3, blue: 0.85, alpha: 1.0)
        let gray = NSColor(red: 0.5, green: 0.5, blue: 0.55, alpha: 1.0)
        let black = NSColor.black

        // Mushroom cap
        for x in 6...9 { setPixel(&grid, x: x, y: 0, color: white) }
        for x in 5...10 { setPixel(&grid, x: x, y: 1, color: white) }
        setPixel(&grid, x: 7, y: 0, color: red)
        setPixel(&grid, x: 8, y: 0, color: red)

        // Face
        for x in 5...10 { setPixel(&grid, x: x, y: 2, color: skin) }
        setPixel(&grid, x: 6, y: 2, color: black)
        setPixel(&grid, x: 9, y: 2, color: black)

        // Vest
        for x in 4...11 { setPixel(&grid, x: x, y: 3, color: blue) }

        // Kart body
        setPixel(&grid, x: 1, y: 4, color: black)
        for x in 2...13 { setPixel(&grid, x: x, y: 4, color: blue) }
        setPixel(&grid, x: 14, y: 4, color: black)

        // Kart stripe
        for x in 4...11 { setPixel(&grid, x: x, y: 5, color: white) }
        setPixel(&grid, x: 3, y: 5, color: blue)
        setPixel(&grid, x: 12, y: 5, color: blue)

        // Kart bottom
        for x in 2...13 { setPixel(&grid, x: x, y: 6, color: gray) }

        // Wheels
        let w = frame % 2 == 0 ? 0 : 1
        setPixel(&grid, x: 1 + w, y: 7, color: black)
        setPixel(&grid, x: 2 + w, y: 7, color: gray)
        setPixel(&grid, x: 2 + w, y: 8, color: black)
        setPixel(&grid, x: 12 - w, y: 7, color: gray)
        setPixel(&grid, x: 13 - w, y: 7, color: black)
        setPixel(&grid, x: 12 - w, y: 8, color: black)
    }

    private func drawKartBowser(grid: inout [[NSColor]], frame: Int) {
        let green = NSColor(red: 0.2, green: 0.65, blue: 0.2, alpha: 1.0)
        let orange = NSColor(red: 1.0, green: 0.5, blue: 0.1, alpha: 1.0)
        let gray = NSColor(red: 0.5, green: 0.5, blue: 0.55, alpha: 1.0)
        let black = NSColor.black

        // Horns
        setPixel(&grid, x: 6, y: 0, color: orange)
        setPixel(&grid, x: 9, y: 0, color: orange)

        // Head
        for x in 6...9 { setPixel(&grid, x: x, y: 1, color: green) }
        for x in 5...10 { setPixel(&grid, x: x, y: 2, color: green) }
        setPixel(&grid, x: 6, y: 1, color: black)
        setPixel(&grid, x: 9, y: 1, color: black)

        // Shell
        for x in 4...11 { setPixel(&grid, x: x, y: 3, color: green) }
        setPixel(&grid, x: 6, y: 3, color: orange)
        setPixel(&grid, x: 9, y: 3, color: orange)

        // Kart body
        setPixel(&grid, x: 1, y: 4, color: black)
        for x in 2...13 { setPixel(&grid, x: x, y: 4, color: green) }
        setPixel(&grid, x: 14, y: 4, color: black)

        // Kart stripe
        for x in 4...11 { setPixel(&grid, x: x, y: 5, color: orange) }
        setPixel(&grid, x: 3, y: 5, color: green)
        setPixel(&grid, x: 12, y: 5, color: green)

        // Kart bottom
        for x in 2...13 { setPixel(&grid, x: x, y: 6, color: gray) }

        // Wheels
        let w = frame % 2 == 0 ? 0 : 1
        setPixel(&grid, x: 1 + w, y: 7, color: black)
        setPixel(&grid, x: 2 + w, y: 7, color: gray)
        setPixel(&grid, x: 2 + w, y: 8, color: black)
        setPixel(&grid, x: 12 - w, y: 7, color: gray)
        setPixel(&grid, x: 13 - w, y: 7, color: black)
        setPixel(&grid, x: 12 - w, y: 8, color: black)
    }

    private func drawKartDonkeyKong(grid: inout [[NSColor]], frame: Int) {
        let brown = NSColor(red: 0.6, green: 0.35, blue: 0.15, alpha: 1.0)
        let tan = NSColor(red: 0.85, green: 0.7, blue: 0.45, alpha: 1.0)
        let red = NSColor(red: 0.9, green: 0.15, blue: 0.15, alpha: 1.0)
        let gray = NSColor(red: 0.5, green: 0.5, blue: 0.55, alpha: 1.0)
        let black = NSColor.black

        // Head
        for x in 6...9 { setPixel(&grid, x: x, y: 0, color: brown) }
        for x in 5...10 { setPixel(&grid, x: x, y: 1, color: brown) }
        setPixel(&grid, x: 6, y: 0, color: black)
        setPixel(&grid, x: 9, y: 0, color: black)
        for x in 7...8 { setPixel(&grid, x: x, y: 1, color: tan) }

        // Tie
        setPixel(&grid, x: 7, y: 2, color: red)

        // Chest
        for x in 5...10 { setPixel(&grid, x: x, y: 2, color: brown) }

        // Kart body
        setPixel(&grid, x: 1, y: 3, color: black)
        for x in 2...13 { setPixel(&grid, x: x, y: 3, color: brown) }
        setPixel(&grid, x: 14, y: 3, color: black)

        // Kart stripe
        for x in 4...11 { setPixel(&grid, x: x, y: 4, color: tan) }
        setPixel(&grid, x: 3, y: 4, color: brown)
        setPixel(&grid, x: 12, y: 4, color: brown)

        // Kart bottom
        for x in 2...13 { setPixel(&grid, x: x, y: 5, color: gray) }

        // Wheels
        let w = frame % 2 == 0 ? 0 : 1
        setPixel(&grid, x: 1 + w, y: 6, color: black)
        setPixel(&grid, x: 2 + w, y: 6, color: gray)
        setPixel(&grid, x: 2 + w, y: 7, color: black)
        setPixel(&grid, x: 12 - w, y: 6, color: gray)
        setPixel(&grid, x: 13 - w, y: 6, color: black)
        setPixel(&grid, x: 12 - w, y: 7, color: black)
    }

    private func drawKartYoshi(grid: inout [[NSColor]], frame: Int) {
        let green = NSColor(red: 0.25, green: 0.7, blue: 0.2, alpha: 1.0)
        let darkGreen = NSColor(red: 0.15, green: 0.5, blue: 0.15, alpha: 1.0)
        let white = NSColor.white
        let red = NSColor(red: 0.9, green: 0.15, blue: 0.15, alpha: 1.0)
        let orange = NSColor(red: 1.0, green: 0.5, blue: 0.1, alpha: 1.0)
        let blue = NSColor(red: 0.1, green: 0.3, blue: 0.85, alpha: 1.0)
        let gray = NSColor(red: 0.55, green: 0.55, blue: 0.6, alpha: 1.0)
        let black = NSColor.black

        // Crest
        setPixel(&grid, x: 6, y: 0, color: darkGreen)
        setPixel(&grid, x: 7, y: 0, color: darkGreen)

        // Head with eye
        setPixel(&grid, x: 5, y: 1, color: black)
        setPixel(&grid, x: 6, y: 1, color: white)
        setPixel(&grid, x: 7, y: 1, color: white)
        setPixel(&grid, x: 8, y: 1, color: green)
        setPixel(&grid, x: 9, y: 1, color: black)

        // Snout
        for x in 5...10 { setPixel(&grid, x: x, y: 2, color: green) }

        // Body with white belly
        for x in 5...9 { setPixel(&grid, x: x, y: 3, color: white) }
        setPixel(&grid, x: 4, y: 3, color: green)
        setPixel(&grid, x: 10, y: 3, color: green)

        // Red spines
        setPixel(&grid, x: 4, y: 4, color: red)

        // Body
        for x in 5...9 { setPixel(&grid, x: x, y: 4, color: green) }

        // Kart body
        setPixel(&grid, x: 1, y: 5, color: black)
        for x in 2...13 { setPixel(&grid, x: x, y: 5, color: orange) }
        setPixel(&grid, x: 14, y: 5, color: black)

        // Kart stripe
        for x in 4...11 { setPixel(&grid, x: x, y: 6, color: blue) }
        setPixel(&grid, x: 3, y: 6, color: orange)
        setPixel(&grid, x: 12, y: 6, color: orange)

        // Kart bottom
        for x in 2...13 { setPixel(&grid, x: x, y: 7, color: gray) }

        // Wheels
        let w = frame % 2 == 0 ? 0 : 1
        setPixel(&grid, x: 1 + w, y: 8, color: black)
        setPixel(&grid, x: 2 + w, y: 8, color: gray)
        setPixel(&grid, x: 2 + w, y: 9, color: black)
        setPixel(&grid, x: 12 - w, y: 8, color: gray)
        setPixel(&grid, x: 13 - w, y: 8, color: black)
        setPixel(&grid, x: 12 - w, y: 9, color: black)
    }

    private func drawKartWario(grid: inout [[NSColor]], frame: Int) {
        let yellow = NSColor(red: 1.0, green: 0.85, blue: 0.1, alpha: 1.0)
        let purple = NSColor(red: 0.5, green: 0.15, blue: 0.65, alpha: 1.0)
        let skin = NSColor(red: 1.0, green: 0.8, blue: 0.6, alpha: 1.0)
        let gray = NSColor(red: 0.5, green: 0.5, blue: 0.55, alpha: 1.0)
        let black = NSColor.black

        // Hat
        for x in 6...9 { setPixel(&grid, x: x, y: 0, color: yellow) }
        for x in 5...10 { setPixel(&grid, x: x, y: 1, color: yellow) }

        // Face
        for x in 5...10 { setPixel(&grid, x: x, y: 2, color: skin) }
        setPixel(&grid, x: 6, y: 2, color: black)
        setPixel(&grid, x: 9, y: 2, color: black)

        // Shirt
        for x in 4...11 { setPixel(&grid, x: x, y: 3, color: purple) }

        // Kart body
        setPixel(&grid, x: 1, y: 4, color: black)
        for x in 2...13 { setPixel(&grid, x: x, y: 4, color: purple) }
        setPixel(&grid, x: 14, y: 4, color: black)

        // Kart stripe
        for x in 4...11 { setPixel(&grid, x: x, y: 5, color: yellow) }
        setPixel(&grid, x: 3, y: 5, color: purple)
        setPixel(&grid, x: 12, y: 5, color: purple)

        // Kart bottom
        for x in 2...13 { setPixel(&grid, x: x, y: 6, color: gray) }

        // Wheels
        let w = frame % 2 == 0 ? 0 : 1
        setPixel(&grid, x: 1 + w, y: 7, color: black)
        setPixel(&grid, x: 2 + w, y: 7, color: gray)
        setPixel(&grid, x: 2 + w, y: 8, color: black)
        setPixel(&grid, x: 12 - w, y: 7, color: gray)
        setPixel(&grid, x: 13 - w, y: 7, color: black)
        setPixel(&grid, x: 12 - w, y: 8, color: black)
    }

    // MARK: - Contra Characters

    private func drawContraBill(grid: inout [[NSColor]], frame: Int) {
        // Bill Rizer: dark hair, red headband, bare chest, teal pants (NES Contra style)
        let darkHair = NSColor(red: 0.15, green: 0.1, blue: 0.08, alpha: 1.0)
        let skin = NSColor(red: 0.95, green: 0.75, blue: 0.55, alpha: 1.0)
        let darkSkin = NSColor(red: 0.8, green: 0.55, blue: 0.35, alpha: 1.0)
        let muscleRed = NSColor(red: 0.85, green: 0.25, blue: 0.15, alpha: 1.0)
        let red = NSColor(red: 0.9, green: 0.15, blue: 0.1, alpha: 1.0)
        let teal = NSColor(red: 0.15, green: 0.55, blue: 0.6, alpha: 1.0)
        let darkTeal = NSColor(red: 0.1, green: 0.4, blue: 0.45, alpha: 1.0)
        let black = NSColor.black
        let brown = NSColor(red: 0.45, green: 0.28, blue: 0.1, alpha: 1.0)
        let gun = NSColor(red: 0.3, green: 0.3, blue: 0.35, alpha: 1.0)
        let white = NSColor.white

        // === DARK HAIR ===
        for x in 6...9 { setPixel(&grid, x: x, y: 0, color: darkHair) }
        for x in 5...10 { setPixel(&grid, x: x, y: 1, color: darkHair) }

        // === RED HEADBAND (iconic!) ===
        for x in 4...11 { setPixel(&grid, x: x, y: 1, color: red) }
        // Headband tails flowing behind
        setPixel(&grid, x: 4, y: 0, color: red)
        setPixel(&grid, x: 3, y: 0, color: red)

        // === FACE ===
        for x in 5...10 { setPixel(&grid, x: x, y: 2, color: skin) }
        for x in 5...10 { setPixel(&grid, x: x, y: 3, color: skin) }

        // Eyes (determined, blue)
        setPixel(&grid, x: 6, y: 2, color: NSColor(red: 0.2, green: 0.4, blue: 0.85, alpha: 1.0))
        setPixel(&grid, x: 9, y: 2, color: NSColor(red: 0.2, green: 0.4, blue: 0.85, alpha: 1.0))
        setPixel(&grid, x: 6, y: 2, color: black)
        setPixel(&grid, x: 9, y: 2, color: black)

        // Mouth
        setPixel(&grid, x: 7, y: 3, color: darkSkin)
        setPixel(&grid, x: 8, y: 3, color: darkSkin)

        // === BARE CHEST (muscular, with red shading like pixel art) ===
        for x in 4...11 { setPixel(&grid, x: x, y: 4, color: skin) }
        for x in 3...12 { setPixel(&grid, x: x, y: 5, color: skin) }

        // Muscle definition (red shading from pixel art)
        setPixel(&grid, x: 6, y: 4, color: muscleRed)
        setPixel(&grid, x: 9, y: 4, color: muscleRed)
        setPixel(&grid, x: 7, y: 5, color: muscleRed)
        setPixel(&grid, x: 8, y: 5, color: muscleRed)
        // Abs
        setPixel(&grid, x: 7, y: 4, color: darkSkin)
        setPixel(&grid, x: 8, y: 4, color: darkSkin)

        // === RED WRISTBANDS ===
        setPixel(&grid, x: 3, y: 5, color: red)
        setPixel(&grid, x: 12, y: 5, color: red)

        // === LEFT ARM (holding rifle) ===
        setPixel(&grid, x: 3, y: 4, color: skin)
        setPixel(&grid, x: 2, y: 5, color: skin)
        setPixel(&grid, x: 2, y: 6, color: skin)
        setPixel(&grid, x: 1, y: 6, color: skin)

        // === RIGHT ARM (extended, holding gun) ===
        setPixel(&grid, x: 12, y: 4, color: skin)
        setPixel(&grid, x: 13, y: 4, color: skin)
        setPixel(&grid, x: 14, y: 4, color: skin)
        setPixel(&grid, x: 14, y: 5, color: skin)
        setPixel(&grid, x: 15, y: 5, color: skin)

        // === RIFLE ===
        setPixel(&grid, x: 12, y: 3, color: gun)
        setPixel(&grid, x: 13, y: 3, color: gun)
        setPixel(&grid, x: 14, y: 3, color: gun)
        setPixel(&grid, x: 15, y: 3, color: gun)
        setPixel(&grid, x: 12, y: 2, color: gun)
        setPixel(&grid, x: 13, y: 2, color: gun)
        setPixel(&grid, x: 15, y: 2, color: gun)
        // Stock
        setPixel(&grid, x: 11, y: 3, color: brown)

        // === BELT ===
        for x in 4...11 { setPixel(&grid, x: x, y: 6, color: brown) }

        // === TEAL PANTS ===
        for x in 4...6 { setPixel(&grid, x: x, y: 7, color: teal) }
        for x in 9...11 { setPixel(&grid, x: x, y: 7, color: teal) }
        for x in 4...6 { setPixel(&grid, x: x, y: 8, color: darkTeal) }
        for x in 9...11 { setPixel(&grid, x: x, y: 8, color: darkTeal) }
        // Pant folds (black outlines like pixel art)
        setPixel(&grid, x: 4, y: 7, color: black)
        setPixel(&grid, x: 11, y: 7, color: black)
        setPixel(&grid, x: 4, y: 8, color: black)
        setPixel(&grid, x: 11, y: 8, color: black)
        setPixel(&grid, x: 7, y: 7, color: black)

        // === BLACK BOOTS ===
        for x in 3...6 { setPixel(&grid, x: x, y: 9, color: black) }
        for x in 9...12 { setPixel(&grid, x: x, y: 9, color: black) }
        setPixel(&grid, x: 3, y: 9, color: NSColor(red: 0.15, green: 0.1, blue: 0.08, alpha: 1.0))
        setPixel(&grid, x: 12, y: 9, color: NSColor(red: 0.15, green: 0.1, blue: 0.08, alpha: 1.0))

        // === MUZZLE FLASH ===
        let flashPhase = frame % 4
        if flashPhase == 0 {
            setPixel(&grid, x: 15, y: 1, color: NSColor(red: 1.0, green: 0.8, blue: 0.0, alpha: 1.0))
            setPixel(&grid, x: 15, y: 2, color: white)
        } else if flashPhase == 1 {
            setPixel(&grid, x: 15, y: 1, color: NSColor(red: 1.0, green: 0.5, blue: 0.0, alpha: 1.0))
            setPixel(&grid, x: 14, y: 1, color: NSColor(red: 1.0, green: 0.8, blue: 0.0, alpha: 1.0))
        } else if flashPhase == 2 {
            setPixel(&grid, x: 15, y: 0, color: NSColor(red: 1.0, green: 0.6, blue: 0.0, alpha: 1.0))
            setPixel(&grid, x: 15, y: 1, color: white)
        } else {
            setPixel(&grid, x: 15, y: 1, color: NSColor(red: 1.0, green: 0.9, blue: 0.2, alpha: 1.0))
        }
    }

    private func drawContraLance(grid: inout [[NSColor]], frame: Int) {
        // Lance Bean: brown hair, blue headband, blue tank top, teal pants - DISTINCT from Bill
        let brownHair = NSColor(red: 0.55, green: 0.35, blue: 0.15, alpha: 1.0)
        let darkBrownHair = NSColor(red: 0.4, green: 0.25, blue: 0.1, alpha: 1.0)
        let skin = NSColor(red: 0.95, green: 0.75, blue: 0.55, alpha: 1.0)
        let darkSkin = NSColor(red: 0.8, green: 0.55, blue: 0.35, alpha: 1.0)
        let blue = NSColor(red: 0.15, green: 0.35, blue: 0.85, alpha: 1.0)
        let darkBlue = NSColor(red: 0.08, green: 0.22, blue: 0.6, alpha: 1.0)
        let teal = NSColor(red: 0.15, green: 0.55, blue: 0.6, alpha: 1.0)
        let darkTeal = NSColor(red: 0.1, green: 0.4, blue: 0.45, alpha: 1.0)
        let black = NSColor.black
        let brown = NSColor(red: 0.45, green: 0.28, blue: 0.1, alpha: 1.0)
        let gun = NSColor(red: 0.3, green: 0.3, blue: 0.35, alpha: 1.0)
        let white = NSColor.white

        // === BROWN HAIR (messy, different from Bill's dark hair) ===
        for x in 6...9 { setPixel(&grid, x: x, y: 0, color: brownHair) }
        setPixel(&grid, x: 5, y: 0, color: brownHair)
        setPixel(&grid, x: 10, y: 0, color: brownHair)
        for x in 5...10 { setPixel(&grid, x: x, y: 1, color: brownHair) }
        // Hair highlights
        setPixel(&grid, x: 7, y: 0, color: NSColor(red: 0.7, green: 0.5, blue: 0.25, alpha: 1.0))
        setPixel(&grid, x: 9, y: 0, color: darkBrownHair)
        // Hair outline
        setPixel(&grid, x: 5, y: 0, color: black)
        setPixel(&grid, x: 10, y: 0, color: black)

        // === BLUE HEADBAND (Lance's signature - not red!) ===
        for x in 4...11 { setPixel(&grid, x: x, y: 1, color: blue) }
        setPixel(&grid, x: 4, y: 0, color: blue)
        setPixel(&grid, x: 3, y: 0, color: blue)
        setPixel(&grid, x: 3, y: 1, color: blue)
        // Headband outline
        setPixel(&grid, x: 4, y: 1, color: black)
        setPixel(&grid, x: 11, y: 1, color: black)

        // === FACE ===
        for x in 5...10 { setPixel(&grid, x: x, y: 2, color: skin) }
        for x in 5...10 { setPixel(&grid, x: x, y: 3, color: skin) }

        // Eyes (brown/hazel, different from Bill's blue)
        setPixel(&grid, x: 6, y: 2, color: NSColor(red: 0.5, green: 0.35, blue: 0.15, alpha: 1.0))
        setPixel(&grid, x: 9, y: 2, color: NSColor(red: 0.5, green: 0.35, blue: 0.15, alpha: 1.0))
        setPixel(&grid, x: 6, y: 2, color: black)
        setPixel(&grid, x: 9, y: 2, color: black)

        // Mouth
        setPixel(&grid, x: 7, y: 3, color: darkSkin)
        setPixel(&grid, x: 8, y: 3, color: darkSkin)

        // === BLUE TANK TOP (not bare chest like Bill!) ===
        for x in 4...11 { setPixel(&grid, x: x, y: 4, color: blue) }
        for x in 3...12 { setPixel(&grid, x: x, y: 5, color: blue) }
        for x in 3...12 { setPixel(&grid, x: x, y: 6, color: darkBlue) }
        for x in 4...11 { setPixel(&grid, x: x, y: 7, color: blue) }

        // Tank top details / folds
        setPixel(&grid, x: 6, y: 4, color: darkBlue)
        setPixel(&grid, x: 9, y: 4, color: darkBlue)
        setPixel(&grid, x: 7, y: 5, color: darkBlue)

        // Tank top outline
        setPixel(&grid, x: 4, y: 4, color: black)
        setPixel(&grid, x: 11, y: 4, color: black)

        // Belt
        for x in 4...11 { setPixel(&grid, x: x, y: 6, color: brown) }

        // === BLUE WRISTBANDS (matches headband) ===
        setPixel(&grid, x: 3, y: 5, color: blue)
        setPixel(&grid, x: 12, y: 5, color: blue)

        // === LEFT ARM (bare, muscular) ===
        setPixel(&grid, x: 3, y: 4, color: skin)
        setPixel(&grid, x: 2, y: 5, color: skin)
        setPixel(&grid, x: 2, y: 6, color: skin)
        setPixel(&grid, x: 1, y: 6, color: skin)
        setPixel(&grid, x: 1, y: 7, color: skin)
        // Muscle definition
        setPixel(&grid, x: 2, y: 6, color: darkSkin)
        setPixel(&grid, x: 1, y: 7, color: darkSkin)
        // Arm outline
        setPixel(&grid, x: 1, y: 7, color: black)

        // === RIGHT ARM (bare, holding machine gun) ===
        setPixel(&grid, x: 12, y: 4, color: skin)
        setPixel(&grid, x: 13, y: 4, color: skin)
        setPixel(&grid, x: 14, y: 4, color: skin)
        setPixel(&grid, x: 14, y: 5, color: skin)
        setPixel(&grid, x: 15, y: 5, color: skin)
        // Muscle shading
        setPixel(&grid, x: 13, y: 4, color: darkSkin)
        // Arm outline
        setPixel(&grid, x: 12, y: 4, color: black)

        // === MACHINE GUN (different from Bill's rifle) ===
        setPixel(&grid, x: 12, y: 3, color: gun)
        setPixel(&grid, x: 13, y: 3, color: gun)
        setPixel(&grid, x: 14, y: 3, color: gun)
        setPixel(&grid, x: 15, y: 3, color: gun)
        setPixel(&grid, x: 12, y: 2, color: gun)
        setPixel(&grid, x: 13, y: 2, color: gun)
        setPixel(&grid, x: 14, y: 2, color: gun)
        setPixel(&grid, x: 15, y: 2, color: gun)
        // Stock
        setPixel(&grid, x: 11, y: 3, color: brown)
        setPixel(&grid, x: 11, y: 2, color: brown)
        // Barrel
        setPixel(&grid, x: 15, y: 2, color: black)
        setPixel(&grid, x: 15, y: 3, color: black)
        // Gun outline
        setPixel(&grid, x: 12, y: 2, color: black)
        setPixel(&grid, x: 15, y: 2, color: black)

        // === TEAL PANTS (same as Bill, iconic Contra) ===
        for x in 4...6 { setPixel(&grid, x: x, y: 7, color: teal) }
        for x in 9...11 { setPixel(&grid, x: x, y: 7, color: teal) }
        for x in 4...6 { setPixel(&grid, x: x, y: 8, color: darkTeal) }
        for x in 9...11 { setPixel(&grid, x: x, y: 8, color: darkTeal) }
        // Black outlines
        setPixel(&grid, x: 4, y: 7, color: black)
        setPixel(&grid, x: 11, y: 7, color: black)
        setPixel(&grid, x: 4, y: 8, color: black)
        setPixel(&grid, x: 11, y: 8, color: black)
        setPixel(&grid, x: 7, y: 7, color: black)

        // === BLACK BOOTS ===
        for x in 3...6 { setPixel(&grid, x: x, y: 9, color: black) }
        for x in 9...12 { setPixel(&grid, x: x, y: 9, color: black) }

        // === MUZZLE FLASH ===
        let flashPhase = frame % 4
        if flashPhase == 0 {
            setPixel(&grid, x: 15, y: 1, color: NSColor(red: 1.0, green: 0.8, blue: 0.0, alpha: 1.0))
            setPixel(&grid, x: 15, y: 2, color: white)
        } else if flashPhase == 1 {
            setPixel(&grid, x: 15, y: 1, color: NSColor(red: 1.0, green: 0.5, blue: 0.0, alpha: 1.0))
            setPixel(&grid, x: 14, y: 1, color: NSColor(red: 1.0, green: 0.8, blue: 0.0, alpha: 1.0))
        } else if flashPhase == 2 {
            setPixel(&grid, x: 15, y: 0, color: NSColor(red: 1.0, green: 0.6, blue: 0.0, alpha: 1.0))
        } else {
            setPixel(&grid, x: 15, y: 1, color: NSColor(red: 1.0, green: 0.9, blue: 0.2, alpha: 1.0))
        }
    }


    private func drawContraAlienWall(grid: inout [[NSColor]], frame: Int) {
        let red = NSColor(red: 0.8, green: 0.2, blue: 0.15, alpha: 1.0)
        let darkRed = NSColor(red: 0.6, green: 0.1, blue: 0.1, alpha: 1.0)
        let brightRed = NSColor(red: 0.95, green: 0.3, blue: 0.2, alpha: 1.0)
        let yellow = NSColor(red: 1.0, green: 0.85, blue: 0.2, alpha: 1.0)
        let black = NSColor.black
        let orange = NSColor(red: 1.0, green: 0.5, blue: 0.0, alpha: 1.0)

        let pulse = frame % 2 == 0 ? 0 : 1

        // === ALIEN ORGANIC WALL (pulsing, fleshy) ===
        for x in 1...14 { setPixel(&grid, x: x, y: 1 + pulse, color: darkRed) }
        for x in 0...15 { setPixel(&grid, x: x, y: 2, color: red) }
        for x in 0...15 { setPixel(&grid, x: x, y: 3, color: brightRed) }
        for x in 0...15 { setPixel(&grid, x: x, y: 4, color: red) }
        for x in 0...15 { setPixel(&grid, x: x, y: 5, color: darkRed) }
        for x in 0...15 { setPixel(&grid, x: x, y: 6, color: red) }
        for x in 1...14 { setPixel(&grid, x: x, y: 7 + pulse, color: darkRed) }

        // Organic texture (veins)
        setPixel(&grid, x: 3, y: 3, color: darkRed)
        setPixel(&grid, x: 4, y: 2, color: darkRed)
        setPixel(&grid, x: 11, y: 3, color: darkRed)
        setPixel(&grid, x: 12, y: 4, color: darkRed)

        // === GIANT EYE (center, menacing) ===
        setPixel(&grid, x: 6, y: 3, color: yellow)
        setPixel(&grid, x: 7, y: 3, color: yellow)
        setPixel(&grid, x: 8, y: 3, color: yellow)
        setPixel(&grid, x: 9, y: 3, color: yellow)
        setPixel(&grid, x: 6, y: 4, color: yellow)
        setPixel(&grid, x: 7, y: 4, color: orange)
        setPixel(&grid, x: 8, y: 4, color: orange)
        setPixel(&grid, x: 9, y: 4, color: yellow)
        setPixel(&grid, x: 6, y: 5, color: yellow)
        setPixel(&grid, x: 7, y: 5, color: yellow)
        setPixel(&grid, x: 8, y: 5, color: yellow)
        setPixel(&grid, x: 9, y: 5, color: yellow)
        // Pupil (follows movement)
        setPixel(&grid, x: 7, y: 4, color: black)
        setPixel(&grid, x: 8, y: 4, color: black)
        // Red iris ring
        setPixel(&grid, x: 7, y: 3, color: red)
        setPixel(&grid, x: 8, y: 3, color: red)

        // === TENTACLES (animated writhing!) ===
        let tentPhase = frame % 4
        if tentPhase == 0 {
            setPixel(&grid, x: 2, y: 8, color: darkRed)
            setPixel(&grid, x: 3, y: 9, color: darkRed)
            setPixel(&grid, x: 4, y: 9, color: red)
            setPixel(&grid, x: 11, y: 9, color: red)
            setPixel(&grid, x: 12, y: 8, color: darkRed)
            setPixel(&grid, x: 13, y: 9, color: darkRed)
        } else if tentPhase == 1 {
            setPixel(&grid, x: 3, y: 8, color: darkRed)
            setPixel(&grid, x: 2, y: 9, color: red)
            setPixel(&grid, x: 4, y: 8, color: darkRed)
            setPixel(&grid, x: 11, y: 8, color: darkRed)
            setPixel(&grid, x: 13, y: 8, color: red)
            setPixel(&grid, x: 12, y: 9, color: darkRed)
        } else if tentPhase == 2 {
            setPixel(&grid, x: 2, y: 9, color: darkRed)
            setPixel(&grid, x: 3, y: 8, color: red)
            setPixel(&grid, x: 5, y: 9, color: darkRed)
            setPixel(&grid, x: 10, y: 9, color: darkRed)
            setPixel(&grid, x: 12, y: 8, color: red)
            setPixel(&grid, x: 14, y: 9, color: darkRed)
        } else {
            setPixel(&grid, x: 3, y: 9, color: red)
            setPixel(&grid, x: 4, y: 8, color: darkRed)
            setPixel(&grid, x: 2, y: 8, color: darkRed)
            setPixel(&grid, x: 11, y: 9, color: red)
            setPixel(&grid, x: 13, y: 9, color: darkRed)
            setPixel(&grid, x: 12, y: 8, color: darkRed)
        }

        // Acid drip
        setPixel(&grid, x: 7, y: 8, color: orange)
        setPixel(&grid, x: 8, y: 8, color: orange)
    }

    private func drawContraNeoDic(grid: inout [[NSColor]], frame: Int) {
        let purple = NSColor(red: 0.5, green: 0.15, blue: 0.65, alpha: 1.0)
        let darkPurple = NSColor(red: 0.35, green: 0.1, blue: 0.5, alpha: 1.0)
        let brightPurple = NSColor(red: 0.65, green: 0.25, blue: 0.8, alpha: 1.0)
        let yellow = NSColor(red: 1.0, green: 0.85, blue: 0.2, alpha: 1.0)
        let black = NSColor.black
        let white = NSColor.white

        let bob = frame % 2 == 0 ? 0 : 1

        // === ALIEN HEAD (bulbous, organic) ===
        for x in 5...10 { setPixel(&grid, x: x, y: 1 + bob, color: purple) }
        for x in 4...11 { setPixel(&grid, x: x, y: 2 + bob, color: brightPurple) }
        for x in 4...11 { setPixel(&grid, x: x, y: 3 + bob, color: purple) }

        // Head ridges
        setPixel(&grid, x: 4, y: 2 + bob, color: darkPurple)
        setPixel(&grid, x: 11, y: 2 + bob, color: darkPurple)

        // === GIANT ALIEN EYES ===
        setPixel(&grid, x: 5, y: 2 + bob, color: black)
        setPixel(&grid, x: 6, y: 2 + bob, color: black)
        setPixel(&grid, x: 9, y: 2 + bob, color: black)
        setPixel(&grid, x: 10, y: 2 + bob, color: black)
        // Eye shine
        setPixel(&grid, x: 5, y: 2 + bob, color: white)
        setPixel(&grid, x: 10, y: 2 + bob, color: white)

        // Mouth (open, menacing)
        for x in 6...9 { setPixel(&grid, x: x, y: 3 + bob, color: black) }
        // Teeth
        setPixel(&grid, x: 6, y: 3 + bob, color: white)
        setPixel(&grid, x: 8, y: 3 + bob, color: white)

        // === BODY (organic, alien) ===
        for x in 5...10 { setPixel(&grid, x: x, y: 4 + bob, color: darkPurple) }
        for x in 4...11 { setPixel(&grid, x: x, y: 5 + bob, color: purple) }
        for x in 5...10 { setPixel(&grid, x: x, y: 6 + bob, color: darkPurple) }

        // === TENTACLES (4 legs, writhing!) ===
        let tentPhase = frame % 4
        if tentPhase == 0 {
            setPixel(&grid, x: 4, y: 7, color: darkPurple)
            setPixel(&grid, x: 5, y: 8, color: purple)
            setPixel(&grid, x: 10, y: 7, color: darkPurple)
            setPixel(&grid, x: 11, y: 8, color: purple)
            setPixel(&grid, x: 6, y: 7, color: darkPurple)
            setPixel(&grid, x: 7, y: 8, color: purple)
            setPixel(&grid, x: 8, y: 7, color: darkPurple)
            setPixel(&grid, x: 9, y: 8, color: purple)
        } else if tentPhase == 1 {
            setPixel(&grid, x: 5, y: 7, color: darkPurple)
            setPixel(&grid, x: 4, y: 8, color: purple)
            setPixel(&grid, x: 11, y: 7, color: darkPurple)
            setPixel(&grid, x: 10, y: 8, color: purple)
            setPixel(&grid, x: 7, y: 7, color: darkPurple)
            setPixel(&grid, x: 6, y: 8, color: purple)
            setPixel(&grid, x: 9, y: 7, color: darkPurple)
            setPixel(&grid, x: 8, y: 8, color: purple)
        } else {
            setPixel(&grid, x: 4, y: 7, color: purple)
            setPixel(&grid, x: 5, y: 8, color: darkPurple)
            setPixel(&grid, x: 10, y: 7, color: purple)
            setPixel(&grid, x: 11, y: 8, color: darkPurple)
            setPixel(&grid, x: 6, y: 7, color: purple)
            setPixel(&grid, x: 9, y: 8, color: darkPurple)
        }
    }

    private func drawContraTurret(grid: inout [[NSColor]], frame: Int) {
        let gray = NSColor(red: 0.5, green: 0.5, blue: 0.55, alpha: 1.0)
        let darkGray = NSColor(red: 0.35, green: 0.35, blue: 0.4, alpha: 1.0)
        let brightGray = NSColor(red: 0.65, green: 0.65, blue: 0.7, alpha: 1.0)
        let red = NSColor(red: 0.9, green: 0.15, blue: 0.15, alpha: 1.0)
        let orange = NSColor(red: 1.0, green: 0.5, blue: 0.0, alpha: 1.0)

        // === TURRET BASE (heavy, armored) ===
        for x in 3...12 { setPixel(&grid, x: x, y: 7, color: darkGray) }
        for x in 4...11 { setPixel(&grid, x: x, y: 8, color: gray) }
        setPixel(&grid, x: 4, y: 7, color: brightGray)
        setPixel(&grid, x: 11, y: 7, color: brightGray)

        // Bolts
        setPixel(&grid, x: 4, y: 7, color: NSColor(red: 0.4, green: 0.4, blue: 0.42, alpha: 1.0))
        setPixel(&grid, x: 11, y: 7, color: NSColor(red: 0.4, green: 0.4, blue: 0.42, alpha: 1.0))

        // === TURRET GUN (rotating barrel) ===
        let gunAngle = frame % 4
        let gunX = gunAngle < 2 ? 7 : 8
        // Gun housing
        for x in 6...9 { setPixel(&grid, x: x, y: 5, color: gray) }
        for x in 6...9 { setPixel(&grid, x: x, y: 6, color: darkGray) }
        setPixel(&grid, x: 6, y: 5, color: brightGray)
        setPixel(&grid, x: 9, y: 5, color: brightGray)

        // Barrel (long, double)
        setPixel(&grid, x: 10, y: 5, color: darkGray)
        setPixel(&grid, x: 11, y: 5, color: darkGray)
        setPixel(&grid, x: 12, y: 5, color: gray)
        setPixel(&grid, x: 10, y: 6, color: darkGray)
        setPixel(&grid, x: 11, y: 6, color: darkGray)
        setPixel(&grid, x: 12, y: 6, color: gray)

        // Red targeting light
        setPixel(&grid, x: 7, y: 5, color: red)
        setPixel(&grid, x: 8, y: 5, color: red)
        // Light glow
        setPixel(&grid, x: 7, y: 4, color: orange)
        setPixel(&grid, x: 8, y: 4, color: orange)

        // === MUZZLE FLASH (animated) ===
        let flashPhase = frame % 4
        if flashPhase == 0 {
            setPixel(&grid, x: 13, y: 5, color: orange)
            setPixel(&grid, x: 13, y: 6, color: orange)
        } else if flashPhase == 1 {
            setPixel(&grid, x: 13, y: 5, color: NSColor(red: 1.0, green: 0.8, blue: 0.0, alpha: 1.0))
            setPixel(&grid, x: 14, y: 5, color: orange)
        } else if flashPhase == 2 {
            setPixel(&grid, x: 14, y: 5, color: NSColor(red: 1.0, green: 0.8, blue: 0.0, alpha: 1.0))
            setPixel(&grid, x: 14, y: 6, color: orange)
        }
    }

    private func drawContraSweat(grid: inout [[NSColor]], frame: Int) {
        let brown = NSColor(red: 0.6, green: 0.4, blue: 0.15, alpha: 1.0)
        let darkBrown = NSColor(red: 0.4, green: 0.25, blue: 0.1, alpha: 1.0)
        let brightBrown = NSColor(red: 0.7, green: 0.5, blue: 0.25, alpha: 1.0)
        let yellow = NSColor(red: 1.0, green: 0.85, blue: 0.2, alpha: 1.0)
        let black = NSColor.black
        let green = NSColor(red: 0.3, green: 0.5, blue: 0.2, alpha: 1.0)
        let skin = NSColor(red: 0.9, green: 0.7, blue: 0.5, alpha: 1.0)

        // === SOLDIER ENEMY (running, armed!) ===
        // Helmet (green military)
        for x in 5...10 { setPixel(&grid, x: x, y: 0, color: green) }
        for x in 5...10 { setPixel(&grid, x: x, y: 1, color: green) }
        setPixel(&grid, x: 5, y: 1, color: NSColor(red: 0.2, green: 0.4, blue: 0.15, alpha: 1.0))
        setPixel(&grid, x: 10, y: 1, color: NSColor(red: 0.2, green: 0.4, blue: 0.15, alpha: 1.0))

        // Face (visible under helmet)
        for x in 5...10 { setPixel(&grid, x: x, y: 2, color: skin) }
        for x in 5...10 { setPixel(&grid, x: x, y: 3, color: skin) }

        // Eyes (angry)
        setPixel(&grid, x: 6, y: 2, color: black)
        setPixel(&grid, x: 9, y: 2, color: black)

        // Mouth
        setPixel(&grid, x: 7, y: 3, color: darkBrown)
        setPixel(&grid, x: 8, y: 3, color: darkBrown)

        // === BODY (brown uniform) ===
        for x in 4...11 { setPixel(&grid, x: x, y: 4, color: brown) }
        for x in 3...12 { setPixel(&grid, x: x, y: 5, color: brown) }
        for x in 4...11 { setPixel(&grid, x: x, y: 6, color: darkBrown) }

        // Ammo belt
        setPixel(&grid, x: 5, y: 4, color: yellow)
        setPixel(&grid, x: 6, y: 5, color: yellow)
        setPixel(&grid, x: 10, y: 4, color: yellow)

        // Belt
        for x in 4...11 { setPixel(&grid, x: x, y: 6, color: black) }

        // === LEFT ARM (holding rifle) ===
        setPixel(&grid, x: 3, y: 4, color: brown)
        setPixel(&grid, x: 3, y: 5, color: brown)
        setPixel(&grid, x: 2, y: 5, color: skin)
        setPixel(&grid, x: 2, y: 6, color: skin)

        // === RIGHT ARM ===
        setPixel(&grid, x: 12, y: 4, color: brown)
        setPixel(&grid, x: 12, y: 5, color: brown)
        setPixel(&grid, x: 13, y: 5, color: skin)

        // === GUN ===
        setPixel(&grid, x: 13, y: 4, color: NSColor(red: 0.4, green: 0.4, blue: 0.45, alpha: 1.0))
        setPixel(&grid, x: 14, y: 4, color: NSColor(red: 0.4, green: 0.4, blue: 0.45, alpha: 1.0))
        setPixel(&grid, x: 15, y: 4, color: NSColor(red: 0.3, green: 0.3, blue: 0.35, alpha: 1.0))

        // === LEGS (running animation) ===
        if frame % 2 == 0 {
            setPixel(&grid, x: 4, y: 7, color: brown)
            setPixel(&grid, x: 5, y: 8, color: brown)
            setPixel(&grid, x: 10, y: 7, color: brown)
            setPixel(&grid, x: 11, y: 8, color: brown)
            setPixel(&grid, x: 4, y: 9, color: darkBrown)
            setPixel(&grid, x: 11, y: 9, color: darkBrown)
        } else {
            setPixel(&grid, x: 5, y: 7, color: brown)
            setPixel(&grid, x: 4, y: 8, color: brown)
            setPixel(&grid, x: 11, y: 7, color: brown)
            setPixel(&grid, x: 10, y: 8, color: brown)
            setPixel(&grid, x: 5, y: 9, color: darkBrown)
            setPixel(&grid, x: 10, y: 9, color: darkBrown)
        }
    }

    private func drawContraProbox(grid: inout [[NSColor]], frame: Int) {
        let gray = NSColor(red: 0.55, green: 0.55, blue: 0.6, alpha: 1.0)
        let darkGray = NSColor(red: 0.35, green: 0.35, blue: 0.4, alpha: 1.0)
        let brightGray = NSColor(red: 0.7, green: 0.7, blue: 0.73, alpha: 1.0)
        let red = NSColor(red: 0.9, green: 0.15, blue: 0.15, alpha: 1.0)
        let orange = NSColor(red: 1.0, green: 0.5, blue: 0.0, alpha: 1.0)
        let black = NSColor.black

        // === ROBOT ENEMY (armored, menacing) ===
        // Head (angular, robotic)
        for x in 5...10 { setPixel(&grid, x: x, y: 0, color: gray) }
        for x in 5...10 { setPixel(&grid, x: x, y: 1, color: gray) }
        setPixel(&grid, x: 5, y: 0, color: darkGray)
        setPixel(&grid, x: 10, y: 0, color: darkGray)
        setPixel(&grid, x: 6, y: 0, color: brightGray)
        setPixel(&grid, x: 9, y: 0, color: brightGray)

        // Red robot eyes (glowing!)
        setPixel(&grid, x: 6, y: 0, color: red)
        setPixel(&grid, x: 9, y: 0, color: red)
        setPixel(&grid, x: 6, y: 1, color: black)
        setPixel(&grid, x: 7, y: 1, color: black)
        setPixel(&grid, x: 8, y: 1, color: black)
        setPixel(&grid, x: 9, y: 1, color: black)

        // Antenna
        setPixel(&grid, x: 7, y: 0, color: black)
        setPixel(&grid, x: 8, y: 0, color: black)

        // === BODY (heavy armor) ===
        for x in 3...12 { setPixel(&grid, x: x, y: 2, color: gray) }
        for x in 2...13 { setPixel(&grid, x: x, y: 3, color: darkGray) }
        for x in 2...13 { setPixel(&grid, x: x, y: 4, color: gray) }
        for x in 3...12 { setPixel(&grid, x: x, y: 5, color: darkGray) }

        // Chest plate detail
        setPixel(&grid, x: 6, y: 3, color: brightGray)
        setPixel(&grid, x: 7, y: 3, color: brightGray)
        setPixel(&grid, x: 8, y: 3, color: brightGray)
        setPixel(&grid, x: 9, y: 3, color: brightGray)
        // Power core
        setPixel(&grid, x: 7, y: 3, color: red)
        setPixel(&grid, x: 8, y: 3, color: red)

        // === ARMS (robotic, weapon-mounted) ===
        // Left arm
        setPixel(&grid, x: 1, y: 3, color: gray)
        setPixel(&grid, x: 1, y: 4, color: darkGray)
        setPixel(&grid, x: 0, y: 4, color: gray)
        setPixel(&grid, x: 0, y: 5, color: darkGray)

        // Right arm (gun arm!)
        setPixel(&grid, x: 14, y: 3, color: gray)
        setPixel(&grid, x: 14, y: 4, color: darkGray)
        setPixel(&grid, x: 15, y: 3, color: gray)
        setPixel(&grid, x: 15, y: 4, color: gray)

        // Gun barrel
        setPixel(&grid, x: 15, y: 2, color: darkGray)
        setPixel(&grid, x: 14, y: 2, color: darkGray)

        // === LEGS (robotic) ===
        setPixel(&grid, x: 4, y: 6, color: darkGray)
        setPixel(&grid, x: 5, y: 7, color: darkGray)
        setPixel(&grid, x: 10, y: 6, color: darkGray)
        setPixel(&grid, x: 11, y: 7, color: darkGray)

        // Feet (treads)
        for x in 3...6 { setPixel(&grid, x: x, y: 8, color: gray) }
        for x in 9...12 { setPixel(&grid, x: x, y: 8, color: gray) }

        // Eye glow animation
        let glowPhase = frame % 4
        if glowPhase == 0 {
            setPixel(&grid, x: 7, y: 3, color: orange)
            setPixel(&grid, x: 8, y: 3, color: orange)
        }
    }

    private func drawContraFireGun(grid: inout [[NSColor]], frame: Int) {
        let gun = NSColor(red: 0.4, green: 0.4, blue: 0.45, alpha: 1.0)
        let darkGun = NSColor(red: 0.3, green: 0.3, blue: 0.35, alpha: 1.0)
        let brightGun = NSColor(red: 0.55, green: 0.55, blue: 0.6, alpha: 1.0)
        let fire = NSColor(red: 1.0, green: 0.5, blue: 0.1, alpha: 1.0)
        let yellow = NSColor(red: 1.0, green: 0.85, blue: 0.2, alpha: 1.0)
        let orange = NSColor(red: 1.0, green: 0.6, blue: 0.0, alpha: 1.0)

        // === FIRE GUN POWER-UP (flame thrower!) ===
        // Grip
        setPixel(&grid, x: 7, y: 7, color: darkGun)
        setPixel(&grid, x: 7, y: 8, color: darkGun)

        // Gun body (wider, fuel tank)
        for x in 5...10 { setPixel(&grid, x: x, y: 5, color: gun) }
        for x in 5...10 { setPixel(&grid, x: x, y: 6, color: darkGun) }
        setPixel(&grid, x: 5, y: 5, color: brightGun)
        setPixel(&grid, x: 10, y: 5, color: brightGun)

        // Fuel tank
        setPixel(&grid, x: 5, y: 4, color: NSColor(red: 0.8, green: 0.1, blue: 0.1, alpha: 1.0))
        setPixel(&grid, x: 6, y: 4, color: NSColor(red: 0.8, green: 0.1, blue: 0.1, alpha: 1.0))

        // Barrel
        setPixel(&grid, x: 11, y: 5, color: gun)
        setPixel(&grid, x: 12, y: 5, color: darkGun)

        // === FLAME (animated, 4-phase!) ===
        let flamePhase = frame % 4
        if flamePhase == 0 {
            setPixel(&grid, x: 13, y: 5, color: yellow)
            setPixel(&grid, x: 14, y: 5, color: fire)
            setPixel(&grid, x: 13, y: 4, color: orange)
            setPixel(&grid, x: 14, y: 4, color: fire)
            setPixel(&grid, x: 15, y: 5, color: orange)
        } else if flamePhase == 1 {
            setPixel(&grid, x: 13, y: 5, color: fire)
            setPixel(&grid, x: 14, y: 5, color: yellow)
            setPixel(&grid, x: 13, y: 4, color: fire)
            setPixel(&grid, x: 14, y: 4, color: orange)
            setPixel(&grid, x: 15, y: 4, color: fire)
            setPixel(&grid, x: 15, y: 5, color: orange)
        } else if flamePhase == 2 {
            setPixel(&grid, x: 13, y: 4, color: yellow)
            setPixel(&grid, x: 14, y: 4, color: fire)
            setPixel(&grid, x: 15, y: 4, color: yellow)
            setPixel(&grid, x: 13, y: 5, color: orange)
            setPixel(&grid, x: 14, y: 5, color: fire)
            setPixel(&grid, x: 15, y: 5, color: fire)
        } else {
            setPixel(&grid, x: 13, y: 5, color: fire)
            setPixel(&grid, x: 14, y: 4, color: yellow)
            setPixel(&grid, x: 15, y: 5, color: orange)
            setPixel(&grid, x: 14, y: 5, color: fire)
        }
    }

    private func drawContraMachineGun(grid: inout [[NSColor]], frame: Int) {
        let gun = NSColor(red: 0.4, green: 0.4, blue: 0.45, alpha: 1.0)
        let darkGun = NSColor(red: 0.3, green: 0.3, blue: 0.35, alpha: 1.0)
        let brightGun = NSColor(red: 0.55, green: 0.55, blue: 0.6, alpha: 1.0)
        let red = NSColor(red: 0.9, green: 0.15, blue: 0.15, alpha: 1.0)
        let orange = NSColor(red: 1.0, green: 0.5, blue: 0.0, alpha: 1.0)
        let yellow = NSColor(red: 1.0, green: 0.85, blue: 0.2, alpha: 1.0)

        // === MACHINE GUN POWER-UP (rapid fire!) ===
        // Grip
        setPixel(&grid, x: 7, y: 7, color: darkGun)
        setPixel(&grid, x: 7, y: 8, color: darkGun)

        // Gun body
        for x in 5...10 { setPixel(&grid, x: x, y: 5, color: gun) }
        for x in 5...10 { setPixel(&grid, x: x, y: 6, color: darkGun) }
        setPixel(&grid, x: 5, y: 5, color: brightGun)
        setPixel(&grid, x: 10, y: 5, color: brightGun)

        // Extended barrel
        setPixel(&grid, x: 11, y: 5, color: gun)
        setPixel(&grid, x: 12, y: 5, color: gun)
        setPixel(&grid, x: 13, y: 5, color: darkGun)

        // Muzzle brake
        setPixel(&grid, x: 14, y: 5, color: gun)
        setPixel(&grid, x: 14, y: 4, color: gun)
        setPixel(&grid, x: 14, y: 6, color: gun)

        // === RAPID FIRE MUZZLE FLASH (animated, intense!) ===
        let flashPhase = frame % 4
        if flashPhase == 0 {
            setPixel(&grid, x: 15, y: 5, color: yellow)
            setPixel(&grid, x: 15, y: 4, color: orange)
            setPixel(&grid, x: 15, y: 6, color: orange)
        } else if flashPhase == 1 {
            setPixel(&grid, x: 15, y: 5, color: orange)
            setPixel(&grid, x: 15, y: 4, color: red)
            setPixel(&grid, x: 15, y: 6, color: yellow)
            setPixel(&grid, x: 14, y: 5, color: yellow)
        } else if flashPhase == 2 {
            setPixel(&grid, x: 15, y: 5, color: red)
            setPixel(&grid, x: 15, y: 4, color: orange)
            setPixel(&grid, x: 15, y: 6, color: orange)
        } else {
            setPixel(&grid, x: 15, y: 5, color: yellow)
            setPixel(&grid, x: 15, y: 4, color: red)
        }
    }

    private func drawContraSpreadGun(grid: inout [[NSColor]], frame: Int) {
        let gun = NSColor(red: 0.4, green: 0.4, blue: 0.45, alpha: 1.0)
        let darkGun = NSColor(red: 0.3, green: 0.3, blue: 0.35, alpha: 1.0)
        let brightGun = NSColor(red: 0.55, green: 0.55, blue: 0.6, alpha: 1.0)
        let yellow = NSColor(red: 1.0, green: 0.85, blue: 0.2, alpha: 1.0)
        let orange = NSColor(red: 1.0, green: 0.6, blue: 0.1, alpha: 1.0)
        let red = NSColor(red: 0.9, green: 0.15, blue: 0.15, alpha: 1.0)

        // === SPREAD GUN POWER-UP (fan shot!) ===
        // Grip
        setPixel(&grid, x: 7, y: 7, color: darkGun)
        setPixel(&grid, x: 7, y: 8, color: darkGun)

        // Gun body
        for x in 5...10 { setPixel(&grid, x: x, y: 5, color: gun) }
        for x in 5...10 { setPixel(&grid, x: x, y: 6, color: darkGun) }
        setPixel(&grid, x: 5, y: 5, color: brightGun)
        setPixel(&grid, x: 10, y: 5, color: brightGun)

        // Triple barrel (spread!)
        setPixel(&grid, x: 11, y: 4, color: gun)
        setPixel(&grid, x: 11, y: 5, color: gun)
        setPixel(&grid, x: 11, y: 6, color: gun)
        setPixel(&grid, x: 12, y: 4, color: darkGun)
        setPixel(&grid, x: 12, y: 5, color: darkGun)
        setPixel(&grid, x: 12, y: 6, color: darkGun)

        // === SPREAD SHOT (5-way fan!) ===
        let spreadPhase = frame % 4
        if spreadPhase == 0 {
            setPixel(&grid, x: 13, y: 3, color: yellow)
            setPixel(&grid, x: 14, y: 2, color: orange)
            setPixel(&grid, x: 13, y: 5, color: yellow)
            setPixel(&grid, x: 14, y: 5, color: orange)
            setPixel(&grid, x: 13, y: 7, color: yellow)
            setPixel(&grid, x: 14, y: 8, color: orange)
        } else if spreadPhase == 1 {
            setPixel(&grid, x: 13, y: 3, color: orange)
            setPixel(&grid, x: 14, y: 2, color: red)
            setPixel(&grid, x: 13, y: 4, color: yellow)
            setPixel(&grid, x: 14, y: 5, color: yellow)
            setPixel(&grid, x: 13, y: 6, color: yellow)
            setPixel(&grid, x: 14, y: 7, color: orange)
            setPixel(&grid, x: 13, y: 7, color: orange)
            setPixel(&grid, x: 14, y: 8, color: red)
        } else if spreadPhase == 2 {
            setPixel(&grid, x: 13, y: 4, color: yellow)
            setPixel(&grid, x: 14, y: 3, color: orange)
            setPixel(&grid, x: 15, y: 2, color: red)
            setPixel(&grid, x: 13, y: 5, color: yellow)
            setPixel(&grid, x: 15, y: 5, color: orange)
            setPixel(&grid, x: 13, y: 6, color: yellow)
            setPixel(&grid, x: 14, y: 7, color: orange)
            setPixel(&grid, x: 15, y: 8, color: red)
        } else {
            setPixel(&grid, x: 14, y: 3, color: yellow)
            setPixel(&grid, x: 14, y: 4, color: orange)
            setPixel(&grid, x: 15, y: 5, color: yellow)
            setPixel(&grid, x: 14, y: 6, color: orange)
            setPixel(&grid, x: 14, y: 7, color: yellow)
        }
    }

    private func drawContraLaserGun(grid: inout [[NSColor]], frame: Int) {
        let gun = NSColor(red: 0.4, green: 0.4, blue: 0.45, alpha: 1.0)
        let darkGun = NSColor(red: 0.3, green: 0.3, blue: 0.35, alpha: 1.0)
        let brightGun = NSColor(red: 0.55, green: 0.55, blue: 0.6, alpha: 1.0)
        let laser = NSColor(red: 0.2, green: 0.8, blue: 1.0, alpha: 1.0)
        let brightLaser = NSColor(red: 0.5, green: 0.95, blue: 1.0, alpha: 1.0)
        let white = NSColor.white

        // === LASER GUN POWER-UP (beam weapon!) ===
        // Grip
        setPixel(&grid, x: 7, y: 7, color: darkGun)
        setPixel(&grid, x: 7, y: 8, color: darkGun)

        // Gun body
        for x in 5...10 { setPixel(&grid, x: x, y: 5, color: gun) }
        for x in 5...10 { setPixel(&grid, x: x, y: 6, color: darkGun) }
        setPixel(&grid, x: 5, y: 5, color: brightGun)
        setPixel(&grid, x: 10, y: 5, color: brightGun)

        // Energy cell (glowing)
        setPixel(&grid, x: 6, y: 4, color: laser)
        setPixel(&grid, x: 7, y: 4, color: brightLaser)
        setPixel(&grid, x: 8, y: 4, color: brightLaser)
        setPixel(&grid, x: 9, y: 4, color: laser)

        // Barrel
        setPixel(&grid, x: 11, y: 5, color: gun)
        setPixel(&grid, x: 12, y: 5, color: darkGun)

        // === LASER BEAM (animated, piercing!) ===
        let laserPhase = frame % 4
        if laserPhase == 0 {
            setPixel(&grid, x: 13, y: 5, color: brightLaser)
            setPixel(&grid, x: 14, y: 5, color: white)
            setPixel(&grid, x: 15, y: 5, color: laser)
        } else if laserPhase == 1 {
            setPixel(&grid, x: 13, y: 5, color: laser)
            setPixel(&grid, x: 14, y: 5, color: brightLaser)
            setPixel(&grid, x: 15, y: 5, color: white)
            setPixel(&grid, x: 13, y: 4, color: laser)
            setPixel(&grid, x: 13, y: 6, color: laser)
        } else if laserPhase == 2 {
            setPixel(&grid, x: 13, y: 4, color: brightLaser)
            setPixel(&grid, x: 14, y: 5, color: white)
            setPixel(&grid, x: 15, y: 5, color: brightLaser)
            setPixel(&grid, x: 13, y: 6, color: brightLaser)
        } else {
            setPixel(&grid, x: 13, y: 5, color: white)
            setPixel(&grid, x: 14, y: 5, color: laser)
            setPixel(&grid, x: 15, y: 5, color: brightLaser)
            setPixel(&grid, x: 14, y: 4, color: laser)
            setPixel(&grid, x: 14, y: 6, color: laser)
        }
    }

    private func drawContraBarrier(grid: inout [[NSColor]], frame: Int) {
        let blue = NSColor(red: 0.2, green: 0.6, blue: 1.0, alpha: 1.0)
        let lightBlue = NSColor(red: 0.4, green: 0.8, blue: 1.0, alpha: 1.0)
        let brightBlue = NSColor(red: 0.5, green: 0.9, blue: 1.0, alpha: 1.0)
        let white = NSColor.white
        let darkBlue = NSColor(red: 0.1, green: 0.4, blue: 0.8, alpha: 1.0)

        // === BARRIER POWER-UP (shield, pulsing!) ===
        let bright = frame % 4 < 2

        // Shield shape (hexagonal)
        for x in 7...9 { setPixel(&grid, x: x, y: 2, color: bright ? brightBlue : blue) }
        for x in 6...10 { setPixel(&grid, x: x, y: 3, color: bright ? lightBlue : blue) }
        for x in 5...11 { setPixel(&grid, x: x, y: 4, color: bright ? brightBlue : blue) }
        for x in 5...11 { setPixel(&grid, x: x, y: 5, color: bright ? lightBlue : blue) }
        for x in 6...10 { setPixel(&grid, x: x, y: 6, color: bright ? brightBlue : blue) }
        for x in 7...9 { setPixel(&grid, x: x, y: 7, color: bright ? lightBlue : blue) }

        // Inner ring
        setPixel(&grid, x: 7, y: 4, color: darkBlue)
        setPixel(&grid, x: 8, y: 4, color: darkBlue)
        setPixel(&grid, x: 9, y: 4, color: darkBlue)
        setPixel(&grid, x: 7, y: 5, color: darkBlue)
        setPixel(&grid, x: 8, y: 5, color: darkBlue)
        setPixel(&grid, x: 9, y: 5, color: darkBlue)

        // Center glow
        setPixel(&grid, x: 8, y: 4, color: bright ? white : lightBlue)
        setPixel(&grid, x: 8, y: 5, color: bright ? white : lightBlue)

        // Energy ring animation
        let ringPhase = frame % 4
        if ringPhase == 0 {
            setPixel(&grid, x: 6, y: 4, color: white)
            setPixel(&grid, x: 10, y: 5, color: white)
        } else if ringPhase == 2 {
            setPixel(&grid, x: 6, y: 5, color: white)
            setPixel(&grid, x: 10, y: 4, color: white)
        }
    }

    private func drawContraRapidBullets(grid: inout [[NSColor]], frame: Int) {
        let bullet = NSColor(red: 1.0, green: 0.85, blue: 0.2, alpha: 1.0)
        let orange = NSColor(red: 1.0, green: 0.6, blue: 0.1, alpha: 1.0)
        let red = NSColor(red: 0.9, green: 0.15, blue: 0.15, alpha: 1.0)
        let gun = NSColor(red: 0.4, green: 0.4, blue: 0.45, alpha: 1.0)
        let darkGun = NSColor(red: 0.3, green: 0.3, blue: 0.35, alpha: 1.0)

        // === RAPID BULLETS POWER-UP ===
        // Mini gun body
        for x in 2...8 { setPixel(&grid, x: x, y: 5, color: gun) }
        for x in 2...8 { setPixel(&grid, x: x, y: 6, color: darkGun) }
        setPixel(&grid, x: 2, y: 5, color: NSColor(red: 0.55, green: 0.55, blue: 0.6, alpha: 1.0))

        // Barrel
        setPixel(&grid, x: 9, y: 5, color: gun)
        setPixel(&grid, x: 10, y: 5, color: gun)
        setPixel(&grid, x: 11, y: 5, color: darkGun)

        // === 3 BULLETS IN FLIGHT (animated!) ===
        let bulletPhase = frame % 4
        if bulletPhase == 0 {
            setPixel(&grid, x: 12, y: 3, color: bullet)
            setPixel(&grid, x: 13, y: 3, color: orange)
            setPixel(&grid, x: 14, y: 3, color: red)
            setPixel(&grid, x: 12, y: 5, color: bullet)
            setPixel(&grid, x: 13, y: 5, color: orange)
            setPixel(&grid, x: 14, y: 5, color: red)
            setPixel(&grid, x: 12, y: 7, color: bullet)
            setPixel(&grid, x: 13, y: 7, color: orange)
            setPixel(&grid, x: 14, y: 7, color: red)
        } else if bulletPhase == 1 {
            setPixel(&grid, x: 13, y: 3, color: bullet)
            setPixel(&grid, x: 14, y: 3, color: orange)
            setPixel(&grid, x: 13, y: 5, color: bullet)
            setPixel(&grid, x: 14, y: 5, color: orange)
            setPixel(&grid, x: 13, y: 7, color: bullet)
            setPixel(&grid, x: 14, y: 7, color: orange)
        } else if bulletPhase == 2 {
            setPixel(&grid, x: 14, y: 3, color: bullet)
            setPixel(&grid, x: 15, y: 3, color: orange)
            setPixel(&grid, x: 14, y: 5, color: bullet)
            setPixel(&grid, x: 15, y: 5, color: orange)
            setPixel(&grid, x: 14, y: 7, color: bullet)
            setPixel(&grid, x: 15, y: 7, color: orange)
        } else {
            setPixel(&grid, x: 12, y: 3, color: bullet)
            setPixel(&grid, x: 13, y: 3, color: orange)
            setPixel(&grid, x: 12, y: 5, color: bullet)
            setPixel(&grid, x: 13, y: 5, color: orange)
            setPixel(&grid, x: 12, y: 7, color: bullet)
            setPixel(&grid, x: 13, y: 7, color: orange)
        }
    }


    // MARK: - TMNT Characters

    private func drawTMNTLeonardo(grid: inout [[NSColor]], frame: Int) {
        let blue = NSColor(red: 0.15, green: 0.3, blue: 0.85, alpha: 1.0)
        let green = NSColor(red: 0.35, green: 0.65, blue: 0.2, alpha: 1.0)
        let white = NSColor.white
        let black = NSColor.black
        let brown = NSColor(red: 0.55, green: 0.35, blue: 0.15, alpha: 1.0)
        let tan = NSColor(red: 0.85, green: 0.7, blue: 0.45, alpha: 1.0)

        // Head top
        setPixel(&grid, x: 6, y: 0, color: green)
        setPixel(&grid, x: 7, y: 0, color: green)
        setPixel(&grid, x: 8, y: 0, color: green)
        setPixel(&grid, x: 9, y: 0, color: green)

        // Head
        for x in 5...10 { setPixel(&grid, x: x, y: 1, color: green) }

        // Mask (blue)
        for x in 3...12 { setPixel(&grid, x: x, y: 2, color: blue) }

        // Eyes (white)
        setPixel(&grid, x: 5, y: 2, color: white)
        setPixel(&grid, x: 6, y: 2, color: white)
        setPixel(&grid, x: 9, y: 2, color: white)
        setPixel(&grid, x: 10, y: 2, color: white)

        // Mask band
        for x in 4...11 { setPixel(&grid, x: x, y: 3, color: blue) }

        // Face
        for x in 5...10 { setPixel(&grid, x: x, y: 3, color: green) }

        // Neck
        for x in 6...9 { setPixel(&grid, x: x, y: 4, color: green) }

        // Arms + shell
        setPixel(&grid, x: 2, y: 5, color: green)
        setPixel(&grid, x: 3, y: 5, color: green)
        for x in 5...10 { setPixel(&grid, x: x, y: 5, color: brown) }
        setPixel(&grid, x: 12, y: 5, color: green)
        setPixel(&grid, x: 13, y: 5, color: green)

        // Shell + belly
        setPixel(&grid, x: 2, y: 6, color: green)
        setPixel(&grid, x: 3, y: 6, color: green)
        setPixel(&grid, x: 4, y: 6, color: brown)
        for x in 5...10 { setPixel(&grid, x: x, y: 6, color: tan) }
        setPixel(&grid, x: 11, y: 6, color: brown)
        setPixel(&grid, x: 12, y: 6, color: green)
        setPixel(&grid, x: 13, y: 6, color: green)

        // Lower shell
        setPixel(&grid, x: 4, y: 7, color: brown)
        for x in 5...10 { setPixel(&grid, x: x, y: 7, color: tan) }
        setPixel(&grid, x: 11, y: 7, color: brown)

        // Legs
        setPixel(&grid, x: 5, y: 8, color: green)
        setPixel(&grid, x: 6, y: 8, color: green)
        setPixel(&grid, x: 9, y: 8, color: green)
        setPixel(&grid, x: 10, y: 8, color: green)

        // Feet
        setPixel(&grid, x: 5, y: 9, color: green)
        setPixel(&grid, x: 6, y: 9, color: green)
        setPixel(&grid, x: 9, y: 9, color: green)
        setPixel(&grid, x: 10, y: 9, color: green)
    }

    private func drawTMNTDonatello(grid: inout [[NSColor]], frame: Int) {
        let purple = NSColor(red: 0.5, green: 0.15, blue: 0.65, alpha: 1.0)
        let green = NSColor(red: 0.35, green: 0.65, blue: 0.2, alpha: 1.0)
        let white = NSColor.white
        let brown = NSColor(red: 0.55, green: 0.35, blue: 0.15, alpha: 1.0)
        let tan = NSColor(red: 0.85, green: 0.7, blue: 0.45, alpha: 1.0)

        // Head top
        setPixel(&grid, x: 6, y: 0, color: green)
        setPixel(&grid, x: 7, y: 0, color: green)
        setPixel(&grid, x: 8, y: 0, color: green)
        setPixel(&grid, x: 9, y: 0, color: green)

        // Head
        for x in 5...10 { setPixel(&grid, x: x, y: 1, color: green) }

        // Mask (purple)
        for x in 3...12 { setPixel(&grid, x: x, y: 2, color: purple) }

        // Eyes (white)
        setPixel(&grid, x: 5, y: 2, color: white)
        setPixel(&grid, x: 6, y: 2, color: white)
        setPixel(&grid, x: 9, y: 2, color: white)
        setPixel(&grid, x: 10, y: 2, color: white)

        // Mask band
        for x in 4...11 { setPixel(&grid, x: x, y: 3, color: purple) }

        // Face
        for x in 5...10 { setPixel(&grid, x: x, y: 3, color: green) }

        // Neck
        for x in 6...9 { setPixel(&grid, x: x, y: 4, color: green) }

        // Arms + shell
        setPixel(&grid, x: 2, y: 5, color: green)
        setPixel(&grid, x: 3, y: 5, color: green)
        for x in 5...10 { setPixel(&grid, x: x, y: 5, color: brown) }
        setPixel(&grid, x: 12, y: 5, color: green)
        setPixel(&grid, x: 13, y: 5, color: green)

        // Shell + belly
        setPixel(&grid, x: 2, y: 6, color: green)
        setPixel(&grid, x: 3, y: 6, color: green)
        setPixel(&grid, x: 4, y: 6, color: brown)
        for x in 5...10 { setPixel(&grid, x: x, y: 6, color: tan) }
        setPixel(&grid, x: 11, y: 6, color: brown)
        setPixel(&grid, x: 12, y: 6, color: green)
        setPixel(&grid, x: 13, y: 6, color: green)

        // Lower shell
        setPixel(&grid, x: 4, y: 7, color: brown)
        for x in 5...10 { setPixel(&grid, x: x, y: 7, color: tan) }
        setPixel(&grid, x: 11, y: 7, color: brown)

        // Legs
        setPixel(&grid, x: 5, y: 8, color: green)
        setPixel(&grid, x: 6, y: 8, color: green)
        setPixel(&grid, x: 9, y: 8, color: green)
        setPixel(&grid, x: 10, y: 8, color: green)

        // Feet
        setPixel(&grid, x: 5, y: 9, color: green)
        setPixel(&grid, x: 6, y: 9, color: green)
        setPixel(&grid, x: 9, y: 9, color: green)
        setPixel(&grid, x: 10, y: 9, color: green)
    }

    private func drawTMNTRaphael(grid: inout [[NSColor]], frame: Int) {
        let red = NSColor(red: 0.85, green: 0.15, blue: 0.15, alpha: 1.0)
        let green = NSColor(red: 0.35, green: 0.65, blue: 0.2, alpha: 1.0)
        let white = NSColor.white
        let brown = NSColor(red: 0.55, green: 0.35, blue: 0.15, alpha: 1.0)
        let tan = NSColor(red: 0.85, green: 0.7, blue: 0.45, alpha: 1.0)

        // Head top
        setPixel(&grid, x: 6, y: 0, color: green)
        setPixel(&grid, x: 7, y: 0, color: green)
        setPixel(&grid, x: 8, y: 0, color: green)
        setPixel(&grid, x: 9, y: 0, color: green)

        // Head
        for x in 5...10 { setPixel(&grid, x: x, y: 1, color: green) }

        // Mask (red)
        for x in 3...12 { setPixel(&grid, x: x, y: 2, color: red) }

        // Eyes (white)
        setPixel(&grid, x: 5, y: 2, color: white)
        setPixel(&grid, x: 6, y: 2, color: white)
        setPixel(&grid, x: 9, y: 2, color: white)
        setPixel(&grid, x: 10, y: 2, color: white)

        // Mask band
        for x in 4...11 { setPixel(&grid, x: x, y: 3, color: red) }

        // Face
        for x in 5...10 { setPixel(&grid, x: x, y: 3, color: green) }

        // Neck
        for x in 6...9 { setPixel(&grid, x: x, y: 4, color: green) }

        // Arms + shell
        setPixel(&grid, x: 2, y: 5, color: green)
        setPixel(&grid, x: 3, y: 5, color: green)
        for x in 5...10 { setPixel(&grid, x: x, y: 5, color: brown) }
        setPixel(&grid, x: 12, y: 5, color: green)
        setPixel(&grid, x: 13, y: 5, color: green)

        // Shell + belly
        setPixel(&grid, x: 2, y: 6, color: green)
        setPixel(&grid, x: 3, y: 6, color: green)
        setPixel(&grid, x: 4, y: 6, color: brown)
        for x in 5...10 { setPixel(&grid, x: x, y: 6, color: tan) }
        setPixel(&grid, x: 11, y: 6, color: brown)
        setPixel(&grid, x: 12, y: 6, color: green)
        setPixel(&grid, x: 13, y: 6, color: green)

        // Lower shell
        setPixel(&grid, x: 4, y: 7, color: brown)
        for x in 5...10 { setPixel(&grid, x: x, y: 7, color: tan) }
        setPixel(&grid, x: 11, y: 7, color: brown)

        // Legs
        setPixel(&grid, x: 5, y: 8, color: green)
        setPixel(&grid, x: 6, y: 8, color: green)
        setPixel(&grid, x: 9, y: 8, color: green)
        setPixel(&grid, x: 10, y: 8, color: green)

        // Feet
        setPixel(&grid, x: 5, y: 9, color: green)
        setPixel(&grid, x: 6, y: 9, color: green)
        setPixel(&grid, x: 9, y: 9, color: green)
        setPixel(&grid, x: 10, y: 9, color: green)
    }

    private func drawTMNTMichelangelo(grid: inout [[NSColor]], frame: Int) {
        let orange = NSColor(red: 1.0, green: 0.55, blue: 0.1, alpha: 1.0)
        let green = NSColor(red: 0.35, green: 0.65, blue: 0.2, alpha: 1.0)
        let white = NSColor.white
        let brown = NSColor(red: 0.55, green: 0.35, blue: 0.15, alpha: 1.0)
        let tan = NSColor(red: 0.85, green: 0.7, blue: 0.45, alpha: 1.0)

        // Head top
        setPixel(&grid, x: 6, y: 0, color: green)
        setPixel(&grid, x: 7, y: 0, color: green)
        setPixel(&grid, x: 8, y: 0, color: green)
        setPixel(&grid, x: 9, y: 0, color: green)

        // Head
        for x in 5...10 { setPixel(&grid, x: x, y: 1, color: green) }

        // Mask (orange)
        for x in 3...12 { setPixel(&grid, x: x, y: 2, color: orange) }

        // Eyes (white)
        setPixel(&grid, x: 5, y: 2, color: white)
        setPixel(&grid, x: 6, y: 2, color: white)
        setPixel(&grid, x: 9, y: 2, color: white)
        setPixel(&grid, x: 10, y: 2, color: white)

        // Mask band
        for x in 4...11 { setPixel(&grid, x: x, y: 3, color: orange) }

        // Face
        for x in 5...10 { setPixel(&grid, x: x, y: 3, color: green) }

        // Neck
        for x in 6...9 { setPixel(&grid, x: x, y: 4, color: green) }

        // Arms + shell
        setPixel(&grid, x: 2, y: 5, color: green)
        setPixel(&grid, x: 3, y: 5, color: green)
        for x in 5...10 { setPixel(&grid, x: x, y: 5, color: brown) }
        setPixel(&grid, x: 12, y: 5, color: green)
        setPixel(&grid, x: 13, y: 5, color: green)

        // Shell + belly
        setPixel(&grid, x: 2, y: 6, color: green)
        setPixel(&grid, x: 3, y: 6, color: green)
        setPixel(&grid, x: 4, y: 6, color: brown)
        for x in 5...10 { setPixel(&grid, x: x, y: 6, color: tan) }
        setPixel(&grid, x: 11, y: 6, color: brown)
        setPixel(&grid, x: 12, y: 6, color: green)
        setPixel(&grid, x: 13, y: 6, color: green)

        // Lower shell
        setPixel(&grid, x: 4, y: 7, color: brown)
        for x in 5...10 { setPixel(&grid, x: x, y: 7, color: tan) }
        setPixel(&grid, x: 11, y: 7, color: brown)

        // Legs
        setPixel(&grid, x: 5, y: 8, color: green)
        setPixel(&grid, x: 6, y: 8, color: green)
        setPixel(&grid, x: 9, y: 8, color: green)
        setPixel(&grid, x: 10, y: 8, color: green)

        // Feet
        setPixel(&grid, x: 5, y: 9, color: green)
        setPixel(&grid, x: 6, y: 9, color: green)
        setPixel(&grid, x: 9, y: 9, color: green)
        setPixel(&grid, x: 10, y: 9, color: green)
    }

    private func drawTMNTSplinter(grid: inout [[NSColor]], frame: Int) {
        let brown = NSColor(red: 0.6, green: 0.4, blue: 0.15, alpha: 1.0)
        let darkBrown = NSColor(red: 0.4, green: 0.25, blue: 0.1, alpha: 1.0)
        let lightBrown = NSColor(red: 0.7, green: 0.5, blue: 0.25, alpha: 1.0)
        let yellow = NSColor(red: 1.0, green: 0.85, blue: 0.2, alpha: 1.0)
        let black = NSColor.black
        let gray = NSColor(red: 0.6, green: 0.6, blue: 0.65, alpha: 1.0)
        let darkGray = NSColor(red: 0.4, green: 0.4, blue: 0.45, alpha: 1.0)

        // === RAT EARS ===
        setPixel(&grid, x: 5, y: 0, color: brown)
        setPixel(&grid, x: 10, y: 0, color: brown)
        setPixel(&grid, x: 5, y: 0, color: lightBrown)
        setPixel(&grid, x: 10, y: 0, color: lightBrown)

        // === HEAD (rat, wise old) ===
        for x in 6...9 { setPixel(&grid, x: x, y: 0, color: brown) }
        for x in 5...10 { setPixel(&grid, x: x, y: 1, color: brown) }
        setPixel(&grid, x: 5, y: 1, color: darkBrown)
        setPixel(&grid, x: 10, y: 1, color: darkBrown)

        // Eyes (wise, yellow)
        setPixel(&grid, x: 6, y: 1, color: yellow)
        setPixel(&grid, x: 9, y: 1, color: yellow)
        setPixel(&grid, x: 6, y: 1, color: black)
        setPixel(&grid, x: 9, y: 1, color: black)
        setPixel(&grid, x: 6, y: 1, color: yellow)
        setPixel(&grid, x: 9, y: 1, color: yellow)

        // Nose
        setPixel(&grid, x: 7, y: 1, color: black)
        setPixel(&grid, x: 8, y: 1, color: black)

        // Whiskers
        setPixel(&grid, x: 4, y: 1, color: darkBrown)
        setPixel(&grid, x: 11, y: 1, color: darkBrown)

        // Face
        for x in 5...10 { setPixel(&grid, x: x, y: 2, color: brown) }
        setPixel(&grid, x: 7, y: 2, color: darkBrown)
        setPixel(&grid, x: 8, y: 2, color: darkBrown)

        // === ROBE (gray, flowing) ===
        for x in 4...11 { setPixel(&grid, x: x, y: 3, color: gray) }
        for x in 3...12 { setPixel(&grid, x: x, y: 4, color: gray) }
        for x in 3...12 { setPixel(&grid, x: x, y: 5, color: darkGray) }
        for x in 4...11 { setPixel(&grid, x: x, y: 6, color: gray) }

        // Robe trim
        setPixel(&grid, x: 3, y: 4, color: darkGray)
        setPixel(&grid, x: 12, y: 4, color: darkGray)

        // === STAFF (held in right hand, meditating) ===
        setPixel(&grid, x: 13, y: 2, color: brown)
        setPixel(&grid, x: 13, y: 3, color: brown)
        setPixel(&grid, x: 13, y: 4, color: brown)
        setPixel(&grid, x: 13, y: 5, color: brown)
        setPixel(&grid, x: 13, y: 6, color: brown)
        // Staff top
        setPixel(&grid, x: 13, y: 1, color: lightBrown)
        setPixel(&grid, x: 14, y: 1, color: lightBrown)

        // === LEFT HAND (meditation pose) ===
        setPixel(&grid, x: 2, y: 4, color: brown)
        setPixel(&grid, x: 2, y: 5, color: brown)
        setPixel(&grid, x: 1, y: 5, color: brown)
        setPixel(&grid, x: 1, y: 6, color: darkBrown)

        // === RIGHT HAND (holding staff) ===
        setPixel(&grid, x: 14, y: 4, color: brown)
        setPixel(&grid, x: 14, y: 5, color: brown)
        setPixel(&grid, x: 15, y: 5, color: brown)

        // === LEGS (sitting/meditating) ===
        for x in 5...7 { setPixel(&grid, x: x, y: 7, color: brown) }
        for x in 8...10 { setPixel(&grid, x: x, y: 7, color: brown) }
        setPixel(&grid, x: 5, y: 7, color: darkBrown)
        setPixel(&grid, x: 10, y: 7, color: darkBrown)

        // === CHI EFFECT (animated) ===
        let chiPhase = frame % 4
        if chiPhase == 0 {
            setPixel(&grid, x: 1, y: 4, color: yellow)
            setPixel(&grid, x: 15, y: 4, color: yellow)
        } else if chiPhase == 2 {
            setPixel(&grid, x: 1, y: 3, color: yellow)
            setPixel(&grid, x: 15, y: 3, color: yellow)
        }
    }

    private func drawTMNTShredder(grid: inout [[NSColor]], frame: Int) {
        let silver = NSColor(red: 0.75, green: 0.75, blue: 0.8, alpha: 1.0)
        let darkSilver = NSColor(red: 0.55, green: 0.55, blue: 0.6, alpha: 1.0)
        let brightSilver = NSColor(red: 0.9, green: 0.9, blue: 0.92, alpha: 1.0)
        let gray = NSColor(red: 0.5, green: 0.5, blue: 0.55, alpha: 1.0)
        let purple = NSColor(red: 0.4, green: 0.1, blue: 0.5, alpha: 1.0)
        let darkPurple = NSColor(red: 0.25, green: 0.05, blue: 0.35, alpha: 1.0)
        let black = NSColor.black
        let red = NSColor(red: 0.9, green: 0.15, blue: 0.15, alpha: 1.0)

        // === HELMET (silver, angular, menacing) ===
        for x in 5...10 { setPixel(&grid, x: x, y: 0, color: silver) }
        for x in 4...11 { setPixel(&grid, x: x, y: 1, color: silver) }
        setPixel(&grid, x: 4, y: 0, color: darkSilver)
        setPixel(&grid, x: 11, y: 0, color: darkSilver)
        setPixel(&grid, x: 5, y: 0, color: brightSilver)
        setPixel(&grid, x: 10, y: 0, color: brightSilver)

        // Helmet crest
        setPixel(&grid, x: 7, y: 0, color: brightSilver)
        setPixel(&grid, x: 8, y: 0, color: brightSilver)

        // Eyes (red, through mask!)
        setPixel(&grid, x: 6, y: 1, color: black)
        setPixel(&grid, x: 7, y: 1, color: black)
        setPixel(&grid, x: 8, y: 1, color: black)
        setPixel(&grid, x: 9, y: 1, color: black)
        setPixel(&grid, x: 6, y: 1, color: red)
        setPixel(&grid, x: 9, y: 1, color: red)

        // Face mask (silver, angular)
        for x in 5...10 { setPixel(&grid, x: x, y: 2, color: silver) }
        setPixel(&grid, x: 5, y: 2, color: darkSilver)
        setPixel(&grid, x: 10, y: 2, color: darkSilver)

        // Mask details
        setPixel(&grid, x: 7, y: 2, color: darkSilver)
        setPixel(&grid, x: 8, y: 2, color: darkSilver)

        // === BODY ARMOR (purple with metal plates) ===
        for x in 3...12 { setPixel(&grid, x: x, y: 3, color: purple) }
        for x in 2...13 { setPixel(&grid, x: x, y: 4, color: purple) }
        for x in 2...13 { setPixel(&grid, x: x, y: 5, color: darkPurple) }
        for x in 3...12 { setPixel(&grid, x: x, y: 6, color: purple) }

        // Shoulder armor (silver, spiked!)
        setPixel(&grid, x: 2, y: 3, color: silver)
        setPixel(&grid, x: 13, y: 3, color: silver)
        setPixel(&grid, x: 2, y: 4, color: darkSilver)
        setPixel(&grid, x: 13, y: 4, color: darkSilver)
        // Shoulder spikes
        setPixel(&grid, x: 1, y: 3, color: brightSilver)
        setPixel(&grid, x: 14, y: 3, color: brightSilver)

        // Chest plate
        setPixel(&grid, x: 6, y: 4, color: silver)
        setPixel(&grid, x: 7, y: 4, color: brightSilver)
        setPixel(&grid, x: 8, y: 4, color: brightSilver)
        setPixel(&grid, x: 9, y: 4, color: silver)

        // === LEFT ARM (blades extended!) ===
        setPixel(&grid, x: 2, y: 5, color: purple)
        setPixel(&grid, x: 1, y: 5, color: purple)
        setPixel(&grid, x: 1, y: 6, color: darkPurple)
        setPixel(&grid, x: 0, y: 6, color: purple)
        setPixel(&grid, x: 0, y: 7, color: purple)

        // ARM BLADES (animated slashing!)
        let bladePhase = frame % 4
        if bladePhase == 0 {
            setPixel(&grid, x: 0, y: 5, color: silver)
            setPixel(&grid, x: 0, y: 4, color: silver)
            setPixel(&grid, x: 0, y: 3, color: brightSilver)
        } else if bladePhase == 1 {
            setPixel(&grid, x: 0, y: 5, color: brightSilver)
            setPixel(&grid, x: 0, y: 4, color: silver)
            setPixel(&grid, x: 1, y: 4, color: silver)
        } else if bladePhase == 2 {
            setPixel(&grid, x: 0, y: 5, color: silver)
            setPixel(&grid, x: 0, y: 4, color: brightSilver)
        } else {
            setPixel(&grid, x: 0, y: 5, color: brightSilver)
            setPixel(&grid, x: 0, y: 4, color: silver)
            setPixel(&grid, x: 1, y: 5, color: silver)
        }

        // === RIGHT ARM (blades extended!) ===
        setPixel(&grid, x: 13, y: 5, color: purple)
        setPixel(&grid, x: 14, y: 5, color: purple)
        setPixel(&grid, x: 14, y: 6, color: darkPurple)
        setPixel(&grid, x: 15, y: 6, color: purple)
        setPixel(&grid, x: 15, y: 7, color: purple)

        // ARM BLADES
        if bladePhase == 0 {
            setPixel(&grid, x: 15, y: 5, color: silver)
            setPixel(&grid, x: 15, y: 4, color: silver)
            setPixel(&grid, x: 15, y: 3, color: brightSilver)
        } else if bladePhase == 1 {
            setPixel(&grid, x: 15, y: 5, color: brightSilver)
            setPixel(&grid, x: 15, y: 4, color: silver)
            setPixel(&grid, x: 14, y: 4, color: silver)
        } else if bladePhase == 2 {
            setPixel(&grid, x: 15, y: 5, color: silver)
            setPixel(&grid, x: 15, y: 4, color: brightSilver)
        } else {
            setPixel(&grid, x: 15, y: 5, color: brightSilver)
            setPixel(&grid, x: 15, y: 4, color: silver)
            setPixel(&grid, x: 14, y: 5, color: silver)
        }

        // === LEGS ===
        for x in 4...6 { setPixel(&grid, x: x, y: 7, color: purple) }
        for x in 9...11 { setPixel(&grid, x: x, y: 7, color: purple) }
        for x in 4...6 { setPixel(&grid, x: x, y: 8, color: darkPurple) }
        for x in 9...11 { setPixel(&grid, x: x, y: 8, color: darkPurple) }
        // Boots
        for x in 3...6 { setPixel(&grid, x: x, y: 9, color: gray) }
        for x in 9...12 { setPixel(&grid, x: x, y: 9, color: gray) }
    }

    private func drawTMNTKrang(grid: inout [[NSColor]], frame: Int) {
        let pink = NSColor(red: 0.9, green: 0.5, blue: 0.6, alpha: 1.0)
        let lightPink = NSColor(red: 1.0, green: 0.7, blue: 0.75, alpha: 1.0)
        let darkPink = NSColor(red: 0.7, green: 0.35, blue: 0.45, alpha: 1.0)
        let gray = NSColor(red: 0.5, green: 0.5, blue: 0.55, alpha: 1.0)
        let darkGray = NSColor(red: 0.35, green: 0.35, blue: 0.4, alpha: 1.0)
        let brightGray = NSColor(red: 0.65, green: 0.65, blue: 0.7, alpha: 1.0)
        let black = NSColor.black
        let red = NSColor(red: 0.9, green: 0.15, blue: 0.15, alpha: 1.0)
        let orange = NSColor(red: 1.0, green: 0.5, blue: 0.0, alpha: 1.0)

        // === ROBOT BODY (tall, menacing) ===
        for x in 4...11 { setPixel(&grid, x: x, y: 4, color: gray) }
        for x in 3...12 { setPixel(&grid, x: x, y: 5, color: gray) }
        for x in 3...12 { setPixel(&grid, x: x, y: 6, color: darkGray) }
        for x in 4...11 { setPixel(&grid, x: x, y: 7, color: gray) }

        // Robot head
        for x in 5...10 { setPixel(&grid, x: x, y: 3, color: gray) }
        setPixel(&grid, x: 5, y: 3, color: darkGray)
        setPixel(&grid, x: 10, y: 3, color: darkGray)

        // Robot eyes (red, glowing)
        setPixel(&grid, x: 6, y: 3, color: red)
        setPixel(&grid, x: 9, y: 3, color: red)
        setPixel(&grid, x: 6, y: 3, color: orange)
        setPixel(&grid, x: 9, y: 3, color: orange)

        // Antenna
        setPixel(&grid, x: 7, y: 2, color: brightGray)
        setPixel(&grid, x: 8, y: 2, color: brightGray)

        // Cockpit window (open, showing Krang!)
        for x in 6...9 { setPixel(&grid, x: x, y: 4, color: darkGray) }

        // === KRANG BRAIN (in cockpit!) ===
        for x in 6...9 { setPixel(&grid, x: x, y: 4, color: pink) }
        setPixel(&grid, x: 6, y: 4, color: lightPink)
        setPixel(&grid, x: 9, y: 4, color: lightPink)

        // Krang eyes
        setPixel(&grid, x: 7, y: 4, color: red)
        setPixel(&grid, x: 8, y: 4, color: red)

        // === TENTACLES (animated writhing!) ===
        let tentPhase = frame % 4
        // Left tentacle
        setPixel(&grid, x: 3, y: 5, color: pink)
        setPixel(&grid, x: 2, y: 5, color: pink)
        if tentPhase == 0 {
            setPixel(&grid, x: 2, y: 4, color: pink)
            setPixel(&grid, x: 1, y: 4, color: darkPink)
        } else if tentPhase == 1 {
            setPixel(&grid, x: 2, y: 4, color: darkPink)
            setPixel(&grid, x: 1, y: 5, color: pink)
        } else if tentPhase == 2 {
            setPixel(&grid, x: 2, y: 6, color: pink)
            setPixel(&grid, x: 1, y: 6, color: darkPink)
        } else {
            setPixel(&grid, x: 2, y: 5, color: darkPink)
            setPixel(&grid, x: 1, y: 4, color: pink)
        }

        // Right tentacle
        setPixel(&grid, x: 12, y: 5, color: pink)
        setPixel(&grid, x: 13, y: 5, color: pink)
        if tentPhase == 0 {
            setPixel(&grid, x: 13, y: 4, color: pink)
            setPixel(&grid, x: 14, y: 4, color: darkPink)
        } else if tentPhase == 1 {
            setPixel(&grid, x: 13, y: 4, color: darkPink)
            setPixel(&grid, x: 14, y: 5, color: pink)
        } else if tentPhase == 2 {
            setPixel(&grid, x: 13, y: 6, color: pink)
            setPixel(&grid, x: 14, y: 6, color: darkPink)
        } else {
            setPixel(&grid, x: 13, y: 5, color: darkPink)
            setPixel(&grid, x: 14, y: 4, color: pink)
        }

        // === LEGS (robotic) ===
        setPixel(&grid, x: 5, y: 8, color: darkGray)
        setPixel(&grid, x: 6, y: 8, color: gray)
        setPixel(&grid, x: 9, y: 8, color: gray)
        setPixel(&grid, x: 10, y: 8, color: darkGray)
        // Feet
        for x in 4...7 { setPixel(&grid, x: x, y: 9, color: gray) }
        for x in 8...11 { setPixel(&grid, x: x, y: 9, color: gray) }
    }

    private func drawTMNTBebop(grid: inout [[NSColor]], frame: Int) {
        let purple = NSColor(red: 0.5, green: 0.15, blue: 0.65, alpha: 1.0)
        let darkPurple = NSColor(red: 0.3, green: 0.08, blue: 0.4, alpha: 1.0)
        let pink = NSColor(red: 0.9, green: 0.5, blue: 0.6, alpha: 1.0)
        let brown = NSColor(red: 0.55, green: 0.35, blue: 0.15, alpha: 1.0)
        let black = NSColor.black
        let yellow = NSColor(red: 1.0, green: 0.85, blue: 0.2, alpha: 1.0)
        let green = NSColor(red: 0.3, green: 0.6, blue: 0.2, alpha: 1.0)

        // === WARTHOG HEAD ===
        for x in 5...10 { setPixel(&grid, x: x, y: 0, color: pink) }
        for x in 5...10 { setPixel(&grid, x: x, y: 1, color: pink) }
        setPixel(&grid, x: 5, y: 1, color: NSColor(red: 0.75, green: 0.4, blue: 0.5, alpha: 1.0))
        setPixel(&grid, x: 10, y: 1, color: NSColor(red: 0.75, green: 0.4, blue: 0.5, alpha: 1.0))

        // Snout
        setPixel(&grid, x: 7, y: 1, color: brown)
        setPixel(&grid, x: 8, y: 1, color: brown)
        setPixel(&grid, x: 7, y: 0, color: brown)
        setPixel(&grid, x: 8, y: 0, color: brown)

        // Eyes (crazy!)
        setPixel(&grid, x: 6, y: 0, color: black)
        setPixel(&grid, x: 9, y: 0, color: black)
        setPixel(&grid, x: 6, y: 0, color: green)
        setPixel(&grid, x: 9, y: 0, color: green)

        // Mohawk (purple, tall)
        setPixel(&grid, x: 7, y: 0, color: purple)
        setPixel(&grid, x: 8, y: 0, color: purple)
        setPixel(&grid, x: 7, y: 1, color: darkPurple)

        // Tusks
        setPixel(&grid, x: 6, y: 1, color: yellow)
        setPixel(&grid, x: 9, y: 1, color: yellow)

        // === BODY (purple, muscular) ===
        for x in 4...11 { setPixel(&grid, x: x, y: 2, color: purple) }
        for x in 3...12 { setPixel(&grid, x: x, y: 3, color: purple) }
        for x in 3...12 { setPixel(&grid, x: x, y: 4, color: darkPurple) }
        for x in 4...11 { setPixel(&grid, x: x, y: 5, color: purple) }

        // Yellow vest
        for x in 5...10 { setPixel(&grid, x: x, y: 2, color: yellow) }
        for x in 5...10 { setPixel(&grid, x: x, y: 3, color: yellow) }

        // Belt
        for x in 4...11 { setPixel(&grid, x: x, y: 5, color: brown) }

        // === ARMS ===
        setPixel(&grid, x: 2, y: 3, color: pink)
        setPixel(&grid, x: 2, y: 4, color: pink)
        setPixel(&grid, x: 1, y: 4, color: pink)
        setPixel(&grid, x: 1, y: 5, color: pink)
        setPixel(&grid, x: 13, y: 3, color: pink)
        setPixel(&grid, x: 13, y: 4, color: pink)
        setPixel(&grid, x: 14, y: 4, color: pink)
        setPixel(&grid, x: 14, y: 5, color: pink)

        // === LEGS (walking animation) ===
        if frame % 2 == 0 {
            setPixel(&grid, x: 4, y: 6, color: purple)
            setPixel(&grid, x: 5, y: 7, color: purple)
            setPixel(&grid, x: 10, y: 6, color: purple)
            setPixel(&grid, x: 11, y: 7, color: purple)
            setPixel(&grid, x: 4, y: 8, color: darkPurple)
            setPixel(&grid, x: 11, y: 8, color: darkPurple)
        } else {
            setPixel(&grid, x: 5, y: 6, color: purple)
            setPixel(&grid, x: 4, y: 7, color: purple)
            setPixel(&grid, x: 11, y: 6, color: purple)
            setPixel(&grid, x: 10, y: 7, color: purple)
            setPixel(&grid, x: 5, y: 8, color: darkPurple)
            setPixel(&grid, x: 10, y: 8, color: darkPurple)
        }
    }

    private func drawTMNTRocksteady(grid: inout [[NSColor]], frame: Int) {
        let gray = NSColor(red: 0.55, green: 0.55, blue: 0.6, alpha: 1.0)
        let darkGray = NSColor(red: 0.35, green: 0.35, blue: 0.4, alpha: 1.0)
        let lightGray = NSColor(red: 0.7, green: 0.7, blue: 0.73, alpha: 1.0)
        let brown = NSColor(red: 0.55, green: 0.35, blue: 0.15, alpha: 1.0)
        let black = NSColor.black
        let yellow = NSColor(red: 1.0, green: 0.85, blue: 0.2, alpha: 1.0)
        let green = NSColor(red: 0.3, green: 0.6, blue: 0.2, alpha: 1.0)

        // === RHINO HEAD ===
        for x in 5...10 { setPixel(&grid, x: x, y: 0, color: gray) }
        for x in 5...10 { setPixel(&grid, x: x, y: 1, color: gray) }
        setPixel(&grid, x: 5, y: 1, color: darkGray)
        setPixel(&grid, x: 10, y: 1, color: darkGray)

        // Horn (yellow, prominent!)
        setPixel(&grid, x: 7, y: 0, color: yellow)
        setPixel(&grid, x: 8, y: 0, color: yellow)
        setPixel(&grid, x: 7, y: 1, color: NSColor(red: 0.8, green: 0.7, blue: 0.1, alpha: 1.0))

        // Eyes (angry)
        setPixel(&grid, x: 6, y: 0, color: black)
        setPixel(&grid, x: 9, y: 0, color: black)
        setPixel(&grid, x: 6, y: 0, color: green)
        setPixel(&grid, x: 9, y: 0, color: green)

        // Ears
        setPixel(&grid, x: 5, y: 0, color: lightGray)
        setPixel(&grid, x: 10, y: 0, color: lightGray)

        // === BODY (gray, muscular) ===
        for x in 4...11 { setPixel(&grid, x: x, y: 2, color: gray) }
        for x in 3...12 { setPixel(&grid, x: x, y: 3, color: gray) }
        for x in 3...12 { setPixel(&grid, x: x, y: 4, color: darkGray) }
        for x in 4...11 { setPixel(&grid, x: x, y: 5, color: gray) }

        // Belt
        for x in 4...11 { setPixel(&grid, x: x, y: 5, color: brown) }

        // === ARMS ===
        setPixel(&grid, x: 2, y: 3, color: gray)
        setPixel(&grid, x: 2, y: 4, color: gray)
        setPixel(&grid, x: 1, y: 4, color: gray)
        setPixel(&grid, x: 1, y: 5, color: gray)
        setPixel(&grid, x: 13, y: 3, color: gray)
        setPixel(&grid, x: 13, y: 4, color: gray)
        setPixel(&grid, x: 14, y: 4, color: gray)
        setPixel(&grid, x: 14, y: 5, color: gray)

        // === LEGS (walking) ===
        if frame % 2 == 0 {
            setPixel(&grid, x: 4, y: 6, color: gray)
            setPixel(&grid, x: 5, y: 7, color: gray)
            setPixel(&grid, x: 10, y: 6, color: gray)
            setPixel(&grid, x: 11, y: 7, color: gray)
            setPixel(&grid, x: 4, y: 8, color: darkGray)
            setPixel(&grid, x: 11, y: 8, color: darkGray)
        } else {
            setPixel(&grid, x: 5, y: 6, color: gray)
            setPixel(&grid, x: 4, y: 7, color: gray)
            setPixel(&grid, x: 11, y: 6, color: gray)
            setPixel(&grid, x: 10, y: 7, color: gray)
            setPixel(&grid, x: 5, y: 8, color: darkGray)
            setPixel(&grid, x: 10, y: 8, color: darkGray)
        }
    }

    private func drawTMNTApril(grid: inout [[NSColor]], frame: Int) {
        let yellow = NSColor(red: 1.0, green: 0.85, blue: 0.2, alpha: 1.0)
        let darkYellow = NSColor(red: 0.8, green: 0.65, blue: 0.1, alpha: 1.0)
        let orange = NSColor(red: 1.0, green: 0.6, blue: 0.1, alpha: 1.0)
        let skin = NSColor(red: 1.0, green: 0.8, blue: 0.6, alpha: 1.0)
        let black = NSColor.black
        let blue = NSColor(red: 0.15, green: 0.3, blue: 0.85, alpha: 1.0)
        let white = NSColor.white

        // === YELLOW HAIR (long, flowing!) ===
        for x in 4...11 { setPixel(&grid, x: x, y: 0, color: yellow) }
        for x in 4...11 { setPixel(&grid, x: x, y: 1, color: yellow) }
        setPixel(&grid, x: 4, y: 2, color: yellow)
        setPixel(&grid, x: 11, y: 2, color: yellow)
        setPixel(&grid, x: 4, y: 3, color: darkYellow)
        setPixel(&grid, x: 11, y: 3, color: darkYellow)

        // Hair shine
        setPixel(&grid, x: 5, y: 0, color: NSColor(red: 1.0, green: 0.95, blue: 0.4, alpha: 1.0))

        // === FACE ===
        for x in 5...10 { setPixel(&grid, x: x, y: 2, color: skin) }
        for x in 5...10 { setPixel(&grid, x: x, y: 3, color: skin) }

        // Eyes (blue, pretty)
        setPixel(&grid, x: 6, y: 2, color: blue)
        setPixel(&grid, x: 9, y: 2, color: blue)
        setPixel(&grid, x: 6, y: 2, color: black)
        setPixel(&grid, x: 9, y: 2, color: black)
        // Eye shine
        setPixel(&grid, x: 6, y: 2, color: white)
        setPixel(&grid, x: 9, y: 2, color: white)

        // Mouth (smiling)
        setPixel(&grid, x: 7, y: 3, color: NSColor(red: 0.8, green: 0.3, blue: 0.3, alpha: 1.0))
        setPixel(&grid, x: 8, y: 3, color: NSColor(red: 0.8, green: 0.3, blue: 0.3, alpha: 1.0))

        // === ORANGE JUMPSUIT ===
        for x in 5...10 { setPixel(&grid, x: x, y: 4, color: orange) }
        for x in 4...11 { setPixel(&grid, x: x, y: 5, color: orange) }
        for x in 4...11 { setPixel(&grid, x: x, y: 6, color: orange) }
        for x in 4...11 { setPixel(&grid, x: x, y: 7, color: orange) }

        // Collar
        setPixel(&grid, x: 6, y: 4, color: skin)
        setPixel(&grid, x: 7, y: 4, color: skin)
        setPixel(&grid, x: 8, y: 4, color: skin)
        setPixel(&grid, x: 9, y: 4, color: skin)

        // Blue belt
        for x in 4...11 { setPixel(&grid, x: x, y: 6, color: blue) }

        // === ARMS ===
        setPixel(&grid, x: 3, y: 5, color: skin)
        setPixel(&grid, x: 3, y: 6, color: skin)
        setPixel(&grid, x: 2, y: 5, color: skin)
        setPixel(&grid, x: 2, y: 6, color: skin)
        setPixel(&grid, x: 12, y: 5, color: skin)
        setPixel(&grid, x: 12, y: 6, color: skin)
        setPixel(&grid, x: 13, y: 5, color: skin)
        setPixel(&grid, x: 13, y: 6, color: skin)

        // === LEGS ===
        if frame % 2 == 0 {
            setPixel(&grid, x: 4, y: 8, color: orange)
            setPixel(&grid, x: 5, y: 9, color: orange)
            setPixel(&grid, x: 10, y: 8, color: orange)
            setPixel(&grid, x: 11, y: 9, color: orange)
        } else {
            setPixel(&grid, x: 5, y: 8, color: orange)
            setPixel(&grid, x: 4, y: 9, color: orange)
            setPixel(&grid, x: 11, y: 8, color: orange)
            setPixel(&grid, x: 10, y: 9, color: orange)
        }

        // === CAMERA (she's a reporter!) ===
        setPixel(&grid, x: 14, y: 5, color: NSColor(red: 0.3, green: 0.3, blue: 0.32, alpha: 1.0))
        setPixel(&grid, x: 14, y: 6, color: NSColor(red: 0.3, green: 0.3, blue: 0.32, alpha: 1.0))
        setPixel(&grid, x: 15, y: 5, color: NSColor(red: 0.2, green: 0.2, blue: 0.22, alpha: 1.0))
        setPixel(&grid, x: 15, y: 6, color: NSColor(red: 0.2, green: 0.2, blue: 0.22, alpha: 1.0))
        // Lens
        setPixel(&grid, x: 15, y: 5, color: blue)
    }

    private func drawTMNTCaseyJones(grid: inout [[NSColor]], frame: Int) {
        let white = NSColor.white
        let black = NSColor.black
        let gray = NSColor(red: 0.5, green: 0.5, blue: 0.55, alpha: 1.0)
        let darkGray = NSColor(red: 0.35, green: 0.35, blue: 0.4, alpha: 1.0)
        let brown = NSColor(red: 0.55, green: 0.35, blue: 0.15, alpha: 1.0)
        let skin = NSColor(red: 1.0, green: 0.8, blue: 0.6, alpha: 1.0)
        let red = NSColor(red: 0.85, green: 0.15, blue: 0.15, alpha: 1.0)

        // === HOCKEY MASK (white, iconic!) ===
        for x in 5...10 { setPixel(&grid, x: x, y: 0, color: white) }
        for x in 5...10 { setPixel(&grid, x: x, y: 1, color: white) }
        setPixel(&grid, x: 5, y: 0, color: gray)
        setPixel(&grid, x: 10, y: 0, color: gray)

        // Mask holes (eyes)
        setPixel(&grid, x: 6, y: 0, color: black)
        setPixel(&grid, x: 7, y: 0, color: black)
        setPixel(&grid, x: 8, y: 0, color: black)
        setPixel(&grid, x: 9, y: 0, color: black)
        // Eyes behind mask
        setPixel(&grid, x: 6, y: 0, color: red)
        setPixel(&grid, x: 9, y: 0, color: red)

        // Mask details
        setPixel(&grid, x: 6, y: 1, color: gray)
        setPixel(&grid, x: 7, y: 1, color: gray)
        setPixel(&grid, x: 8, y: 1, color: gray)
        setPixel(&grid, x: 9, y: 1, color: gray)

        // === HEAD (under mask) ===
        for x in 5...10 { setPixel(&grid, x: x, y: 2, color: skin) }

        // === BODY (gray, hockey gear) ===
        for x in 4...11 { setPixel(&grid, x: x, y: 3, color: gray) }
        for x in 3...12 { setPixel(&grid, x: x, y: 4, color: gray) }
        for x in 3...12 { setPixel(&grid, x: x, y: 5, color: darkGray) }
        for x in 4...11 { setPixel(&grid, x: x, y: 6, color: gray) }

        // Shoulder pads
        setPixel(&grid, x: 3, y: 3, color: white)
        setPixel(&grid, x: 12, y: 3, color: white)
        setPixel(&grid, x: 3, y: 4, color: gray)
        setPixel(&grid, x: 12, y: 4, color: gray)

        // === LEFT ARM (holding hockey stick!) ===
        setPixel(&grid, x: 2, y: 4, color: gray)
        setPixel(&grid, x: 2, y: 5, color: gray)
        setPixel(&grid, x: 1, y: 5, color: skin)
        setPixel(&grid, x: 1, y: 6, color: skin)

        // === HOCKEY STICK (animated swing!) ===
        let stickPhase = frame % 4
        if stickPhase == 0 {
            setPixel(&grid, x: 13, y: 2, color: brown)
            setPixel(&grid, x: 14, y: 1, color: brown)
            setPixel(&grid, x: 15, y: 0, color: brown)
            setPixel(&grid, x: 15, y: 1, color: NSColor(red: 0.65, green: 0.45, blue: 0.2, alpha: 1.0))
        } else if stickPhase == 1 {
            setPixel(&grid, x: 13, y: 3, color: brown)
            setPixel(&grid, x: 14, y: 2, color: brown)
            setPixel(&grid, x: 15, y: 1, color: brown)
            setPixel(&grid, x: 15, y: 2, color: NSColor(red: 0.65, green: 0.45, blue: 0.2, alpha: 1.0))
        } else if stickPhase == 2 {
            setPixel(&grid, x: 13, y: 4, color: brown)
            setPixel(&grid, x: 14, y: 3, color: brown)
            setPixel(&grid, x: 15, y: 2, color: brown)
            setPixel(&grid, x: 15, y: 3, color: NSColor(red: 0.65, green: 0.45, blue: 0.2, alpha: 1.0))
        } else {
            setPixel(&grid, x: 13, y: 3, color: brown)
            setPixel(&grid, x: 14, y: 2, color: brown)
            setPixel(&grid, x: 15, y: 1, color: brown)
            setPixel(&grid, x: 14, y: 1, color: NSColor(red: 0.65, green: 0.45, blue: 0.2, alpha: 1.0))
        }

        // === RIGHT ARM ===
        setPixel(&grid, x: 13, y: 4, color: gray)
        setPixel(&grid, x: 14, y: 4, color: gray)
        setPixel(&grid, x: 14, y: 5, color: skin)
        setPixel(&grid, x: 15, y: 5, color: skin)

        // === LEGS ===
        if frame % 2 == 0 {
            setPixel(&grid, x: 4, y: 7, color: gray)
            setPixel(&grid, x: 5, y: 8, color: gray)
            setPixel(&grid, x: 10, y: 7, color: gray)
            setPixel(&grid, x: 11, y: 8, color: gray)
            setPixel(&grid, x: 4, y: 9, color: darkGray)
            setPixel(&grid, x: 11, y: 9, color: darkGray)
        } else {
            setPixel(&grid, x: 5, y: 7, color: gray)
            setPixel(&grid, x: 4, y: 8, color: gray)
            setPixel(&grid, x: 11, y: 7, color: gray)
            setPixel(&grid, x: 10, y: 8, color: gray)
            setPixel(&grid, x: 5, y: 9, color: darkGray)
            setPixel(&grid, x: 10, y: 9, color: darkGray)
        }

        // Hockey bag (on back)
        setPixel(&grid, x: 3, y: 3, color: red)
        setPixel(&grid, x: 3, y: 4, color: red)
    }


    // MARK: - Street Fighter Characters

    private func drawSFRyu(grid: inout [[NSColor]], frame: Int) {
        let white = NSColor.white
        let red = NSColor(red: 0.9, green: 0.15, blue: 0.15, alpha: 1.0)
        let skin = NSColor(red: 1.0, green: 0.8, blue: 0.6, alpha: 1.0)
        let black = NSColor.black
        let brown = NSColor(red: 0.55, green: 0.35, blue: 0.15, alpha: 1.0)

        // Headband
        for x in 5...10 { setPixel(&grid, x: x, y: 1, color: red) }

        // Hair
        for x in 5...10 { setPixel(&grid, x: x, y: 0, color: brown) }

        // Head
        for x in 5...10 { setPixel(&grid, x: x, y: 2, color: skin) }
        for x in 5...10 { setPixel(&grid, x: x, y: 3, color: skin) }

        // Eyes
        setPixel(&grid, x: 6, y: 2, color: black)
        setPixel(&grid, x: 9, y: 2, color: black)

        // Gi
        for x in 4...11 { setPixel(&grid, x: x, y: 4, color: white) }
        for x in 3...12 { setPixel(&grid, x: x, y: 5, color: white) }
        for x in 3...12 { setPixel(&grid, x: x, y: 6, color: white) }
        for x in 4...11 { setPixel(&grid, x: x, y: 7, color: white) }

        // Belt
        for x in 4...11 { setPixel(&grid, x: x, y: 5, color: red) }

        // Fighting stance
        if frame % 2 == 0 {
            setPixel(&grid, x: 3, y: 4, color: skin)
            setPixel(&grid, x: 12, y: 5, color: skin)
        } else {
            setPixel(&grid, x: 3, y: 5, color: skin)
            setPixel(&grid, x: 12, y: 4, color: skin)
        }

        // Legs
        setPixel(&grid, x: 5, y: 8, color: white)
        setPixel(&grid, x: 10, y: 8, color: white)
    }

    private func drawSFKen(grid: inout [[NSColor]], frame: Int) {
        let red = NSColor(red: 0.9, green: 0.15, blue: 0.15, alpha: 1.0)
        let yellow = NSColor(red: 1.0, green: 0.85, blue: 0.2, alpha: 1.0)
        let skin = NSColor(red: 1.0, green: 0.8, blue: 0.6, alpha: 1.0)
        let black = NSColor.black

        // Hair
        for x in 5...10 { setPixel(&grid, x: x, y: 0, color: yellow) }
        for x in 5...10 { setPixel(&grid, x: x, y: 1, color: yellow) }

        // Head
        for x in 5...10 { setPixel(&grid, x: x, y: 2, color: skin) }
        for x in 5...10 { setPixel(&grid, x: x, y: 3, color: skin) }

        // Eyes
        setPixel(&grid, x: 6, y: 2, color: black)
        setPixel(&grid, x: 9, y: 2, color: black)

        // Gi
        for x in 4...11 { setPixel(&grid, x: x, y: 4, color: red) }
        for x in 3...12 { setPixel(&grid, x: x, y: 5, color: red) }
        for x in 3...12 { setPixel(&grid, x: x, y: 6, color: red) }
        for x in 4...11 { setPixel(&grid, x: x, y: 7, color: red) }

        // Fighting stance
        if frame % 2 == 0 {
            setPixel(&grid, x: 3, y: 4, color: skin)
            setPixel(&grid, x: 12, y: 5, color: skin)
        } else {
            setPixel(&grid, x: 3, y: 5, color: skin)
            setPixel(&grid, x: 12, y: 4, color: skin)
        }

        // Legs
        setPixel(&grid, x: 5, y: 8, color: red)
        setPixel(&grid, x: 10, y: 8, color: red)
    }

    private func drawSFChunLi(grid: inout [[NSColor]], frame: Int) {
        let blue = NSColor(red: 0.15, green: 0.3, blue: 0.85, alpha: 1.0)
        let yellow = NSColor(red: 1.0, green: 0.85, blue: 0.2, alpha: 1.0)
        let skin = NSColor(red: 1.0, green: 0.8, blue: 0.6, alpha: 1.0)
        let black = NSColor.black
        let brown = NSColor(red: 0.55, green: 0.35, blue: 0.15, alpha: 1.0)

        // Hair buns
        setPixel(&grid, x: 4, y: 0, color: brown)
        setPixel(&grid, x: 11, y: 0, color: brown)
        setPixel(&grid, x: 4, y: 1, color: yellow)
        setPixel(&grid, x: 11, y: 1, color: yellow)

        // Head
        for x in 5...10 { setPixel(&grid, x: x, y: 1, color: skin) }
        for x in 5...10 { setPixel(&grid, x: x, y: 2, color: skin) }

        // Eyes
        setPixel(&grid, x: 6, y: 1, color: black)
        setPixel(&grid, x: 9, y: 1, color: black)

        // Dress
        for x in 5...10 { setPixel(&grid, x: x, y: 3, color: blue) }
        for x in 4...11 { setPixel(&grid, x: x, y: 4, color: blue) }
        for x in 4...11 { setPixel(&grid, x: x, y: 5, color: blue) }
        for x in 4...11 { setPixel(&grid, x: x, y: 6, color: blue) }
        for x in 3...12 { setPixel(&grid, x: x, y: 7, color: blue) }

        // Spikes on dress
        setPixel(&grid, x: 3, y: 7, color: yellow)
        setPixel(&grid, x: 12, y: 7, color: yellow)

        // Legs (power!)
        if frame % 2 == 0 {
            setPixel(&grid, x: 5, y: 8, color: skin)
            setPixel(&grid, x: 10, y: 8, color: skin)
        } else {
            setPixel(&grid, x: 4, y: 8, color: skin)
            setPixel(&grid, x: 11, y: 8, color: skin)
        }
    }

    private func drawSFGuile(grid: inout [[NSColor]], frame: Int) {
        let green = NSColor(red: 0.2, green: 0.6, blue: 0.2, alpha: 1.0)
        let yellow = NSColor(red: 1.0, green: 0.85, blue: 0.2, alpha: 1.0)
        let skin = NSColor(red: 1.0, green: 0.8, blue: 0.6, alpha: 1.0)
        let black = NSColor.black
        let brown = NSColor(red: 0.55, green: 0.35, blue: 0.15, alpha: 1.0)

        // Flat top hair
        for x in 5...10 { setPixel(&grid, x: x, y: 0, color: yellow) }
        for x in 5...10 { setPixel(&grid, x: x, y: 1, color: yellow) }

        // Head
        for x in 5...10 { setPixel(&grid, x: x, y: 2, color: skin) }
        for x in 5...10 { setPixel(&grid, x: x, y: 3, color: skin) }

        // Eyes
        setPixel(&grid, x: 6, y: 2, color: black)
        setPixel(&grid, x: 9, y: 2, color: black)

        // Dog tags
        setPixel(&grid, x: 7, y: 3, color: NSColor(red: 0.8, green: 0.8, blue: 0.85, alpha: 1.0))

        // Tank top
        for x in 5...10 { setPixel(&grid, x: x, y: 4, color: green) }
        for x in 4...11 { setPixel(&grid, x: x, y: 5, color: green) }
        for x in 4...11 { setPixel(&grid, x: x, y: 6, color: green) }
        for x in 4...11 { setPixel(&grid, x: x, y: 7, color: green) }

        // Jeans
        for x in 4...11 { setPixel(&grid, x: x, y: 6, color: NSColor(red: 0.2, green: 0.3, blue: 0.7, alpha: 1.0)) }
        for x in 4...11 { setPixel(&grid, x: x, y: 7, color: NSColor(red: 0.2, green: 0.3, blue: 0.7, alpha: 1.0)) }

        // Legs
        setPixel(&grid, x: 5, y: 8, color: NSColor(red: 0.2, green: 0.3, blue: 0.7, alpha: 1.0))
        setPixel(&grid, x: 10, y: 8, color: NSColor(red: 0.2, green: 0.3, blue: 0.7, alpha: 1.0))
    }

    private func drawSFDhalsim(grid: inout [[NSColor]], frame: Int) {
        let orange = NSColor(red: 1.0, green: 0.6, blue: 0.1, alpha: 1.0)
        let yellow = NSColor(red: 1.0, green: 0.85, blue: 0.2, alpha: 1.0)
        let skin = NSColor(red: 0.8, green: 0.6, blue: 0.4, alpha: 1.0)
        let black = NSColor.black
        let red = NSColor(red: 0.9, green: 0.15, blue: 0.15, alpha: 1.0)

        // Head (bald with skull necklace)
        for x in 6...9 { setPixel(&grid, x: x, y: 1, color: skin) }
        for x in 5...10 { setPixel(&grid, x: x, y: 2, color: skin) }

        // Eyes
        setPixel(&grid, x: 7, y: 1, color: black)
        setPixel(&grid, x: 9, y: 1, color: black)

        // Skull necklace
        setPixel(&grid, x: 6, y: 3, color: NSColor.white)
        setPixel(&grid, x: 9, y: 3, color: NSColor.white)

        // Body (thin)
        for x in 6...9 { setPixel(&grid, x: x, y: 3, color: orange) }
        for x in 6...9 { setPixel(&grid, x: x, y: 4, color: orange) }
        for x in 6...9 { setPixel(&grid, x: x, y: 5, color: orange) }

        // Stretchy arms (animated)
        let armStretch = frame % 2 == 0 ? 0 : 2
        for x in 2...(4 + armStretch) { setPixel(&grid, x: x, y: 4, color: skin) }
        for x in (11 - armStretch)...13 { setPixel(&grid, x: x, y: 4, color: skin) }

        // Shorts
        for x in 5...10 { setPixel(&grid, x: x, y: 6, color: yellow) }
        for x in 5...10 { setPixel(&grid, x: x, y: 7, color: yellow) }

        // Legs
        setPixel(&grid, x: 6, y: 8, color: skin)
        setPixel(&grid, x: 9, y: 8, color: skin)
    }

    private func drawSFZangief(grid: inout [[NSColor]], frame: Int) {
        let red = NSColor(red: 0.9, green: 0.15, blue: 0.15, alpha: 1.0)
        let skin = NSColor(red: 1.0, green: 0.8, blue: 0.6, alpha: 1.0)
        let black = NSColor.black
        let brown = NSColor(red: 0.4, green: 0.25, blue: 0.1, alpha: 1.0)
        let yellow = NSColor(red: 1.0, green: 0.85, blue: 0.2, alpha: 1.0)

        // Hair top
        setPixel(&grid, x: 6, y: 0, color: brown)
        setPixel(&grid, x: 7, y: 0, color: brown)
        setPixel(&grid, x: 8, y: 0, color: brown)
        setPixel(&grid, x: 9, y: 0, color: brown)

        // Head
        for x in 5...10 { setPixel(&grid, x: x, y: 1, color: skin) }
        for x in 4...11 { setPixel(&grid, x: x, y: 2, color: skin) }

        // Eyes
        setPixel(&grid, x: 5, y: 1, color: black)
        setPixel(&grid, x: 10, y: 1, color: black)

        // Mouth
        setPixel(&grid, x: 6, y: 2, color: black)
        setPixel(&grid, x: 7, y: 2, color: black)
        setPixel(&grid, x: 8, y: 2, color: black)
        setPixel(&grid, x: 9, y: 2, color: black)

        // Neck
        setPixel(&grid, x: 6, y: 3, color: skin)
        setPixel(&grid, x: 7, y: 3, color: skin)
        setPixel(&grid, x: 8, y: 3, color: skin)
        setPixel(&grid, x: 9, y: 3, color: skin)

        // Massive arms + chest
        setPixel(&grid, x: 1, y: 4, color: skin)
        setPixel(&grid, x: 2, y: 4, color: skin)
        setPixel(&grid, x: 3, y: 4, color: skin)
        setPixel(&grid, x: 4, y: 4, color: skin)
        for x in 5...10 { setPixel(&grid, x: x, y: 4, color: skin) }
        setPixel(&grid, x: 11, y: 4, color: skin)
        setPixel(&grid, x: 12, y: 4, color: skin)
        setPixel(&grid, x: 13, y: 4, color: skin)
        setPixel(&grid, x: 14, y: 4, color: skin)

        // Body
        setPixel(&grid, x: 1, y: 5, color: skin)
        setPixel(&grid, x: 2, y: 5, color: skin)
        setPixel(&grid, x: 3, y: 5, color: skin)
        setPixel(&grid, x: 4, y: 5, color: skin)
        for x in 5...10 { setPixel(&grid, x: x, y: 5, color: skin) }
        setPixel(&grid, x: 11, y: 5, color: skin)
        setPixel(&grid, x: 12, y: 5, color: skin)
        setPixel(&grid, x: 13, y: 5, color: skin)
        setPixel(&grid, x: 14, y: 5, color: skin)

        // Abs + belt
        setPixel(&grid, x: 4, y: 6, color: skin)
        for x in 5...10 { setPixel(&grid, x: x, y: 6, color: yellow) }
        setPixel(&grid, x: 11, y: 6, color: skin)

        // Trunks
        setPixel(&grid, x: 4, y: 7, color: red)
        setPixel(&grid, x: 5, y: 7, color: red)
        setPixel(&grid, x: 6, y: 7, color: red)
        setPixel(&grid, x: 7, y: 7, color: red)
        setPixel(&grid, x: 8, y: 7, color: red)
        setPixel(&grid, x: 9, y: 7, color: red)
        setPixel(&grid, x: 10, y: 7, color: red)
        setPixel(&grid, x: 11, y: 7, color: red)

        // Legs
        setPixel(&grid, x: 4, y: 8, color: skin)
        setPixel(&grid, x: 5, y: 8, color: skin)
        setPixel(&grid, x: 10, y: 8, color: skin)
        setPixel(&grid, x: 11, y: 8, color: skin)

        // Boots
        setPixel(&grid, x: 3, y: 9, color: red)
        setPixel(&grid, x: 4, y: 9, color: red)
        setPixel(&grid, x: 5, y: 9, color: red)
        setPixel(&grid, x: 10, y: 9, color: red)
        setPixel(&grid, x: 11, y: 9, color: red)
        setPixel(&grid, x: 12, y: 9, color: red)
    }

    private func drawSFBlanka(grid: inout [[NSColor]], frame: Int) {
        let green = NSColor(red: 0.3, green: 0.75, blue: 0.2, alpha: 1.0)
        let lightGreen = NSColor(red: 0.45, green: 0.85, blue: 0.3, alpha: 1.0)
        let orange = NSColor(red: 1.0, green: 0.55, blue: 0.1, alpha: 1.0)
        let red = NSColor(red: 0.9, green: 0.2, blue: 0.15, alpha: 1.0)
        let black = NSColor.black
        let yellow = NSColor(red: 1.0, green: 0.85, blue: 0.2, alpha: 1.0)

        // Hair top (orange/red)
        setPixel(&grid, x: 5, y: 0, color: orange)
        setPixel(&grid, x: 6, y: 0, color: orange)
        setPixel(&grid, x: 7, y: 0, color: red)
        setPixel(&grid, x: 8, y: 0, color: red)
        setPixel(&grid, x: 9, y: 0, color: orange)
        setPixel(&grid, x: 10, y: 0, color: orange)

        // Hair wider
        setPixel(&grid, x: 4, y: 1, color: orange)
        setPixel(&grid, x: 5, y: 1, color: orange)
        setPixel(&grid, x: 6, y: 1, color: red)
        setPixel(&grid, x: 7, y: 1, color: red)
        setPixel(&grid, x: 8, y: 1, color: red)
        setPixel(&grid, x: 9, y: 1, color: red)
        setPixel(&grid, x: 10, y: 1, color: orange)
        setPixel(&grid, x: 11, y: 1, color: orange)

        // Hair sides
        setPixel(&grid, x: 3, y: 2, color: orange)
        setPixel(&grid, x: 4, y: 2, color: orange)
        setPixel(&grid, x: 5, y: 2, color: orange)
        setPixel(&grid, x: 10, y: 2, color: orange)
        setPixel(&grid, x: 11, y: 2, color: orange)
        setPixel(&grid, x: 12, y: 2, color: orange)

        // Head
        for x in 5...10 { setPixel(&grid, x: x, y: 2, color: green) }
        for x in 4...11 { setPixel(&grid, x: x, y: 3, color: green) }

        // Eyes
        setPixel(&grid, x: 5, y: 3, color: yellow)
        setPixel(&grid, x: 6, y: 3, color: black)
        setPixel(&grid, x: 9, y: 3, color: black)
        setPixel(&grid, x: 10, y: 3, color: yellow)

        // Face
        for x in 5...10 { setPixel(&grid, x: x, y: 4, color: green) }

        // Body
        setPixel(&grid, x: 3, y: 5, color: green)
        setPixel(&grid, x: 4, y: 5, color: green)
        for x in 5...10 { setPixel(&grid, x: x, y: 5, color: lightGreen) }
        setPixel(&grid, x: 11, y: 5, color: green)
        setPixel(&grid, x: 12, y: 5, color: green)

        // Body lower
        setPixel(&grid, x: 3, y: 6, color: green)
        setPixel(&grid, x: 4, y: 6, color: green)
        for x in 5...10 { setPixel(&grid, x: x, y: 6, color: green) }
        setPixel(&grid, x: 11, y: 6, color: green)
        setPixel(&grid, x: 12, y: 6, color: green)

        // Shorts
        setPixel(&grid, x: 4, y: 7, color: orange)
        setPixel(&grid, x: 5, y: 7, color: orange)
        setPixel(&grid, x: 6, y: 7, color: orange)
        setPixel(&grid, x: 7, y: 7, color: orange)
        setPixel(&grid, x: 8, y: 7, color: orange)
        setPixel(&grid, x: 9, y: 7, color: orange)
        setPixel(&grid, x: 10, y: 7, color: orange)
        setPixel(&grid, x: 11, y: 7, color: orange)

        // Legs
        setPixel(&grid, x: 4, y: 8, color: green)
        setPixel(&grid, x: 5, y: 8, color: green)
        setPixel(&grid, x: 10, y: 8, color: green)
        setPixel(&grid, x: 11, y: 8, color: green)

        // Feet
        setPixel(&grid, x: 3, y: 9, color: orange)
        setPixel(&grid, x: 4, y: 9, color: orange)
        setPixel(&grid, x: 5, y: 9, color: orange)
        setPixel(&grid, x: 10, y: 9, color: orange)
        setPixel(&grid, x: 11, y: 9, color: orange)
        setPixel(&grid, x: 12, y: 9, color: orange)
    }

    private func drawSFEHonda(grid: inout [[NSColor]], frame: Int) {
        let blue = NSColor(red: 0.15, green: 0.3, blue: 0.85, alpha: 1.0)
        let skin = NSColor(red: 1.0, green: 0.8, blue: 0.6, alpha: 1.0)
        let black = NSColor.black
        let red = NSColor(red: 0.9, green: 0.15, blue: 0.15, alpha: 1.0)

        // Head
        for x in 5...10 { setPixel(&grid, x: x, y: 1, color: skin) }
        for x in 5...10 { setPixel(&grid, x: x, y: 2, color: skin) }

        // Sumo markings
        setPixel(&grid, x: 7, y: 1, color: red)
        setPixel(&grid, x: 8, y: 1, color: red)

        // Eyes
        setPixel(&grid, x: 6, y: 1, color: black)
        setPixel(&grid, x: 9, y: 1, color: black)

        // Body (massive)
        for x in 3...12 { setPixel(&grid, x: x, y: 3, color: skin) }
        for x in 2...13 { setPixel(&grid, x: x, y: 4, color: skin) }
        for x in 2...13 { setPixel(&grid, x: x, y: 5, color: skin) }
        for x in 3...12 { setPixel(&grid, x: x, y: 6, color: skin) }

        // Mawashi (sumo belt)
        for x in 4...11 { setPixel(&grid, x: x, y: 5, color: blue) }

        // Slap animation
        if frame % 2 == 0 {
            setPixel(&grid, x: 1, y: 4, color: skin)
            setPixel(&grid, x: 14, y: 4, color: skin)
        } else {
            setPixel(&grid, x: 1, y: 3, color: skin)
            setPixel(&grid, x: 14, y: 3, color: skin)
        }

        // Legs
        setPixel(&grid, x: 4, y: 7, color: skin)
        setPixel(&grid, x: 11, y: 7, color: skin)
    }

    private func drawSFBalrog(grid: inout [[NSColor]], frame: Int) {
        let blue = NSColor(red: 0.15, green: 0.3, blue: 0.85, alpha: 1.0)
        let skin = NSColor(red: 0.8, green: 0.6, blue: 0.4, alpha: 1.0)
        let black = NSColor.black
        let red = NSColor(red: 0.9, green: 0.15, blue: 0.15, alpha: 1.0)

        // Head
        for x in 5...10 { setPixel(&grid, x: x, y: 1, color: skin) }
        for x in 5...10 { setPixel(&grid, x: x, y: 2, color: skin) }

        // Eyes
        setPixel(&grid, x: 6, y: 1, color: black)
        setPixel(&grid, x: 9, y: 1, color: black)

        // Boxing gloves
        setPixel(&grid, x: 3, y: 4, color: red)
        setPixel(&grid, x: 12, y: 4, color: red)

        // Body
        for x in 4...11 { setPixel(&grid, x: x, y: 3, color: skin) }
        for x in 3...12 { setPixel(&grid, x: x, y: 4, color: skin) }
        for x in 3...12 { setPixel(&grid, x: x, y: 5, color: skin) }
        for x in 4...11 { setPixel(&grid, x: x, y: 6, color: skin) }

        // Trunks
        for x in 5...10 { setPixel(&grid, x: x, y: 6, color: blue) }

        // Punch animation
        if frame % 2 == 0 {
            setPixel(&grid, x: 2, y: 3, color: red)
            setPixel(&grid, x: 13, y: 4, color: red)
        } else {
            setPixel(&grid, x: 2, y: 4, color: red)
            setPixel(&grid, x: 13, y: 3, color: red)
        }

        // Legs
        setPixel(&grid, x: 5, y: 7, color: skin)
        setPixel(&grid, x: 10, y: 7, color: skin)
    }

    private func drawSFVega(grid: inout [[NSColor]], frame: Int) {
        let yellow = NSColor(red: 1.0, green: 0.85, blue: 0.2, alpha: 1.0)
        let skin = NSColor(red: 1.0, green: 0.8, blue: 0.6, alpha: 1.0)
        let black = NSColor.black
        let purple = NSColor(red: 0.5, green: 0.15, blue: 0.65, alpha: 1.0)
        let silver = NSColor(red: 0.75, green: 0.75, blue: 0.8, alpha: 1.0)

        // Hair
        for x in 5...10 { setPixel(&grid, x: x, y: 0, color: yellow) }
        for x in 5...10 { setPixel(&grid, x: x, y: 1, color: yellow) }

        // Head
        for x in 5...10 { setPixel(&grid, x: x, y: 2, color: skin) }
        for x in 5...10 { setPixel(&grid, x: x, y: 3, color: skin) }

        // Mask
        setPixel(&grid, x: 5, y: 2, color: silver)

        // Eyes
        setPixel(&grid, x: 6, y: 2, color: black)
        setPixel(&grid, x: 9, y: 2, color: black)

        // Body
        for x in 4...11 { setPixel(&grid, x: x, y: 4, color: purple) }
        for x in 3...12 { setPixel(&grid, x: x, y: 5, color: purple) }
        for x in 3...12 { setPixel(&grid, x: x, y: 6, color: purple) }
        for x in 4...11 { setPixel(&grid, x: x, y: 7, color: purple) }

        // Claw
        setPixel(&grid, x: 13, y: 4, color: silver)
        setPixel(&grid, x: 14, y: 3, color: silver)
        setPixel(&grid, x: 14, y: 4, color: silver)

        // Legs
        setPixel(&grid, x: 5, y: 8, color: purple)
        setPixel(&grid, x: 10, y: 8, color: purple)
    }

    private func drawSFSagat(grid: inout [[NSColor]], frame: Int) {
        let white = NSColor.white
        let skin = NSColor(red: 0.8, green: 0.6, blue: 0.4, alpha: 1.0)
        let black = NSColor.black
        let blue = NSColor(red: 0.15, green: 0.3, blue: 0.85, alpha: 1.0)
        let red = NSColor(red: 0.9, green: 0.15, blue: 0.15, alpha: 1.0)

        // Head (bald)
        for x in 6...9 { setPixel(&grid, x: x, y: 1, color: skin) }
        for x in 5...10 { setPixel(&grid, x: x, y: 2, color: skin) }

        // Eye patch
        setPixel(&grid, x: 9, y: 1, color: black)

        // Eyes
        setPixel(&grid, x: 7, y: 1, color: black)

        // Scar on chest
        setPixel(&grid, x: 7, y: 3, color: red)

        // Body
        for x in 4...11 { setPixel(&grid, x: x, y: 3, color: skin) }
        for x in 3...12 { setPixel(&grid, x: x, y: 4, color: skin) }
        for x in 3...12 { setPixel(&grid, x: x, y: 5, color: skin) }
        for x in 4...11 { setPixel(&grid, x: x, y: 6, color: skin) }

        // Muay Thai shorts
        for x in 5...10 { setPixel(&grid, x: x, y: 6, color: blue) }

        // Tiger knee animation
        if frame % 2 == 0 {
            setPixel(&grid, x: 5, y: 7, color: skin)
            setPixel(&grid, x: 10, y: 7, color: skin)
        } else {
            setPixel(&grid, x: 5, y: 6, color: skin)
            setPixel(&grid, x: 10, y: 7, color: skin)
        }
    }

    private func drawSFDictator(grid: inout [[NSColor]], frame: Int) {
        let red = NSColor(red: 0.9, green: 0.15, blue: 0.15, alpha: 1.0)
        let darkRed = NSColor(red: 0.6, green: 0.1, blue: 0.1, alpha: 1.0)
        let black = NSColor.black
        let gray = NSColor(red: 0.5, green: 0.5, blue: 0.55, alpha: 1.0)
        let skin = NSColor(red: 1.0, green: 0.8, blue: 0.6, alpha: 1.0)
        let purple = NSColor(red: 0.5, green: 0.15, blue: 0.65, alpha: 1.0)

        // Military cap
        for x in 5...10 { setPixel(&grid, x: x, y: 0, color: darkRed) }
        for x in 4...11 { setPixel(&grid, x: x, y: 1, color: darkRed) }

        // Star on cap
        setPixel(&grid, x: 7, y: 0, color: NSColor.yellow)
        setPixel(&grid, x: 8, y: 0, color: NSColor.yellow)

        // Head
        for x in 5...10 { setPixel(&grid, x: x, y: 2, color: skin) }
        for x in 5...10 { setPixel(&grid, x: x, y: 3, color: skin) }

        // Sunglasses
        setPixel(&grid, x: 6, y: 2, color: black)
        setPixel(&grid, x: 7, y: 2, color: black)
        setPixel(&grid, x: 9, y: 2, color: black)
        setPixel(&grid, x: 10, y: 2, color: black)

        // Military uniform
        for x in 4...11 { setPixel(&grid, x: x, y: 4, color: red) }
        for x in 3...12 { setPixel(&grid, x: x, y: 5, color: red) }
        for x in 3...12 { setPixel(&grid, x: x, y: 6, color: red) }
        for x in 4...11 { setPixel(&grid, x: x, y: 7, color: red) }

        // Belt with buckle
        for x in 4...11 { setPixel(&grid, x: x, y: 5, color: black) }
        setPixel(&grid, x: 7, y: 5, color: NSColor.yellow)
        setPixel(&grid, x: 8, y: 5, color: NSColor.yellow)

        // Psycho Power aura
        if frame % 2 == 0 {
            setPixel(&grid, x: 2, y: 4, color: purple)
            setPixel(&grid, x: 13, y: 4, color: purple)
        }

        // Legs
        setPixel(&grid, x: 5, y: 8, color: red)
        setPixel(&grid, x: 10, y: 8, color: red)
    }

    // MARK: - Metal Slug Characters

    private func drawMSMarco(grid: inout [[NSColor]], frame: Int) {
        // Marco Rossi - BIG NES Metal Slug pixel art (fills more of 32x32 grid)
        let blonde = NSColor(red: 0.95, green: 0.88, blue: 0.22, alpha: 1.0)
        let darkBlonde = NSColor(red: 0.78, green: 0.68, blue: 0.15, alpha: 1.0)
        let brightYellow = NSColor(red: 1.0, green: 0.95, blue: 0.35, alpha: 1.0)
        let skin = NSColor(red: 0.92, green: 0.75, blue: 0.55, alpha: 1.0)
        let darkSkin = NSColor(red: 0.75, green: 0.52, blue: 0.32, alpha: 1.0)
        let nose = NSColor(red: 0.85, green: 0.62, blue: 0.42, alpha: 1.0)
        let red = NSColor(red: 0.9, green: 0.15, blue: 0.1, alpha: 1.0)
        let darkRed = NSColor(red: 0.7, green: 0.08, blue: 0.06, alpha: 1.0)
        let olive = NSColor(red: 0.42, green: 0.48, blue: 0.28, alpha: 1.0)
        let darkOlive = NSColor(red: 0.32, green: 0.38, blue: 0.2, alpha: 1.0)
        let brown = NSColor(red: 0.52, green: 0.35, blue: 0.12, alpha: 1.0)
        let darkBrown = NSColor(red: 0.38, green: 0.24, blue: 0.08, alpha: 1.0)
        let black = NSColor.black
        let white = NSColor.white
        let gun = NSColor(red: 0.32, green: 0.28, blue: 0.22, alpha: 1.0)

        // ====== HAIR (spiky, big on top) ======
        // Row 0 - top of hair spikes
        setPixel(&grid, x: 10, y: 0, color: black)
        setPixel(&grid, x: 11, y: 0, color: blonde)
        setPixel(&grid, x: 12, y: 0, color: blonde)
        setPixel(&grid, x: 13, y: 0, color: brightYellow)
        setPixel(&grid, x: 14, y: 0, color: blonde)
        setPixel(&grid, x: 15, y: 0, color: darkBlonde)
        setPixel(&grid, x: 16, y: 0, color: black)
        // Row 1 - more hair
        setPixel(&grid, x: 9, y: 1, color: black)
        setPixel(&grid, x: 10, y: 1, color: blonde)
        setPixel(&grid, x: 11, y: 1, color: blonde)
        setPixel(&grid, x: 12, y: 1, color: brightYellow)
        setPixel(&grid, x: 13, y: 1, color: blonde)
        setPixel(&grid, x: 14, y: 1, color: blonde)
        setPixel(&grid, x: 15, y: 1, color: blonde)
        setPixel(&grid, x: 16, y: 1, color: darkBlonde)
        setPixel(&grid, x: 17, y: 1, color: black)

        // ====== WHITE HEADBAND ======
        for x in 8...18 { setPixel(&grid, x: x, y: 2, color: white) }
        setPixel(&grid, x: 7, y: 1, color: white)
        setPixel(&grid, x: 7, y: 2, color: white)
        setPixel(&grid, x: 8, y: 1, color: white)
        // Headband tails flowing left
        setPixel(&grid, x: 6, y: 1, color: white)
        setPixel(&grid, x: 5, y: 1, color: white)
        setPixel(&grid, x: 5, y: 2, color: white)
        // Headband outline
        setPixel(&grid, x: 8, y: 2, color: black)
        setPixel(&grid, x: 18, y: 2, color: black)
        setPixel(&grid, x: 5, y: 1, color: black)

        // ====== FACE ======
        for x in 9...17 { setPixel(&grid, x: x, y: 3, color: skin) }
        for x in 9...17 { setPixel(&grid, x: x, y: 4, color: skin) }
        for x in 9...17 { setPixel(&grid, x: x, y: 5, color: skin) }

        // LARGE NOSE (pointing left, very prominent!)
        setPixel(&grid, x: 9, y: 3, color: nose)
        setPixel(&grid, x: 9, y: 4, color: nose)
        setPixel(&grid, x: 8, y: 4, color: nose)
        setPixel(&grid, x: 8, y: 3, color: skin)
        setPixel(&grid, x: 9, y: 4, color: darkSkin)

        // Eyes (big, determined)
        setPixel(&grid, x: 11, y: 3, color: black)
        setPixel(&grid, x: 11, y: 3, color: NSColor(red: 0.2, green: 0.5, blue: 0.8, alpha: 1.0))
        setPixel(&grid, x: 11, y: 3, color: black)
        setPixel(&grid, x: 14, y: 3, color: black)
        setPixel(&grid, x: 14, y: 3, color: NSColor(red: 0.2, green: 0.5, blue: 0.8, alpha: 1.0))
        setPixel(&grid, x: 14, y: 3, color: black)

        // Eyebrows
        setPixel(&grid, x: 11, y: 3, color: darkBlonde)
        setPixel(&grid, x: 14, y: 3, color: darkBlonde)

        // Mouth (open, gritting)
        setPixel(&grid, x: 11, y: 5, color: black)
        setPixel(&grid, x: 12, y: 5, color: black)
        setPixel(&grid, x: 13, y: 5, color: black)

        // Face outline
        setPixel(&grid, x: 9, y: 3, color: black)
        setPixel(&grid, x: 17, y: 3, color: black)
        setPixel(&grid, x: 9, y: 5, color: black)
        setPixel(&grid, x: 17, y: 5, color: black)

        // ====== RED VEST (sleeveless, open front) ======
        for x in 8...18 { setPixel(&grid, x: x, y: 6, color: red) }
        for x in 7...19 { setPixel(&grid, x: x, y: 7, color: red) }
        for x in 7...19 { setPixel(&grid, x: x, y: 8, color: darkRed) }
        for x in 7...19 { setPixel(&grid, x: x, y: 9, color: red) }
        for x in 8...18 { setPixel(&grid, x: x, y: 10, color: red) }

        // Bare chest showing through open vest
        setPixel(&grid, x: 11, y: 6, color: skin)
        setPixel(&grid, x: 12, y: 6, color: skin)
        setPixel(&grid, x: 13, y: 6, color: skin)
        setPixel(&grid, x: 14, y: 6, color: skin)
        setPixel(&grid, x: 11, y: 7, color: skin)
        setPixel(&grid, x: 12, y: 7, color: skin)
        setPixel(&grid, x: 13, y: 7, color: skin)
        setPixel(&grid, x: 14, y: 7, color: skin)
        // Muscle shading
        setPixel(&grid, x: 12, y: 7, color: darkSkin)
        setPixel(&grid, x: 13, y: 7, color: darkSkin)

        // Vest outlines
        setPixel(&grid, x: 8, y: 6, color: black)
        setPixel(&grid, x: 17, y: 6, color: black)
        setPixel(&grid, x: 7, y: 7, color: black)
        setPixel(&grid, x: 18, y: 7, color: black)

        // Belt
        for x in 7...19 { setPixel(&grid, x: x, y: 9, color: brown) }
        setPixel(&grid, x: 12, y: 9, color: NSColor(red: 0.85, green: 0.75, blue: 0.0, alpha: 1.0))
        setPixel(&grid, x: 13, y: 9, color: NSColor(red: 0.85, green: 0.75, blue: 0.0, alpha: 1.0))

        // ====== BROWN BACKPACK (on back) ======
        setPixel(&grid, x: 6, y: 4, color: brown)
        setPixel(&grid, x: 6, y: 5, color: brown)
        setPixel(&grid, x: 6, y: 6, color: brown)
        setPixel(&grid, x: 6, y: 7, color: brown)
        setPixel(&grid, x: 6, y: 8, color: darkBrown)
        setPixel(&grid, x: 5, y: 5, color: brown)
        setPixel(&grid, x: 5, y: 6, color: darkBrown)
        setPixel(&grid, x: 5, y: 7, color: darkBrown)
        setPixel(&grid, x: 5, y: 8, color: darkBrown)
        setPixel(&grid, x: 5, y: 9, color: darkBrown)
        setPixel(&grid, x: 5, y: 4, color: brown)
        // Backpack top (visible above shoulder)
        setPixel(&grid, x: 6, y: 3, color: brown)
        setPixel(&grid, x: 5, y: 4, color: brown)
        // Backpack straps
        setPixel(&grid, x: 7, y: 6, color: darkBrown)
        setPixel(&grid, x: 7, y: 7, color: darkBrown)
        // Backpack outline
        setPixel(&grid, x: 5, y: 5, color: black)
        setPixel(&grid, x: 5, y: 6, color: black)
        setPixel(&grid, x: 5, y: 7, color: black)

        // ====== LEFT ARM (bare, muscular, behind body) ======
        setPixel(&grid, x: 6, y: 7, color: skin)
        setPixel(&grid, x: 6, y: 8, color: skin)
        setPixel(&grid, x: 5, y: 8, color: skin)
        setPixel(&grid, x: 5, y: 9, color: skin)
        setPixel(&grid, x: 4, y: 9, color: skin)
        setPixel(&grid, x: 4, y: 10, color: skin)
        setPixel(&grid, x: 3, y: 10, color: skin)
        setPixel(&grid, x: 3, y: 11, color: skin)
        // Muscle definition
        setPixel(&grid, x: 6, y: 8, color: darkSkin)
        setPixel(&grid, x: 4, y: 10, color: darkSkin)
        // Arm outline
        setPixel(&grid, x: 3, y: 11, color: black)

        // ====== RIGHT ARM (bare, extended with gun) ======
        setPixel(&grid, x: 18, y: 6, color: skin)
        setPixel(&grid, x: 19, y: 6, color: skin)
        setPixel(&grid, x: 20, y: 6, color: skin)
        setPixel(&grid, x: 21, y: 6, color: skin)
        setPixel(&grid, x: 22, y: 6, color: skin)
        setPixel(&grid, x: 22, y: 7, color: skin)
        // Red wristband
        setPixel(&grid, x: 21, y: 7, color: red)
        setPixel(&grid, x: 22, y: 7, color: red)
        // Muscle shading
        setPixel(&grid, x: 19, y: 6, color: darkSkin)
        // Arm outline
        setPixel(&grid, x: 18, y: 6, color: black)

        // ====== GUN (large rifle, held forward) ======
        setPixel(&grid, x: 19, y: 5, color: gun)
        setPixel(&grid, x: 20, y: 5, color: gun)
        setPixel(&grid, x: 21, y: 5, color: gun)
        setPixel(&grid, x: 22, y: 5, color: gun)
        setPixel(&grid, x: 23, y: 5, color: gun)
        setPixel(&grid, x: 24, y: 5, color: gun)
        setPixel(&grid, x: 19, y: 4, color: gun)
        setPixel(&grid, x: 20, y: 4, color: gun)
        setPixel(&grid, x: 21, y: 4, color: gun)
        setPixel(&grid, x: 22, y: 4, color: gun)
        setPixel(&grid, x: 23, y: 4, color: gun)
        setPixel(&grid, x: 24, y: 4, color: gun)
        // Stock
        setPixel(&grid, x: 18, y: 5, color: brown)
        setPixel(&grid, x: 18, y: 4, color: brown)
        // Barrel
        setPixel(&grid, x: 24, y: 4, color: black)
        setPixel(&grid, x: 24, y: 5, color: black)
        // Gun outline
        setPixel(&grid, x: 19, y: 4, color: black)
        setPixel(&grid, x: 24, y: 4, color: black)
        setPixel(&grid, x: 19, y: 5, color: black)

        // ====== OLIVE PANTS (with black outlines) ======
        // Left leg
        for x in 7...12 { setPixel(&grid, x: x, y: 11, color: olive) }
        for x in 7...12 { setPixel(&grid, x: x, y: 12, color: olive) }
        for x in 7...12 { setPixel(&grid, x: x, y: 13, color: darkOlive) }
        for x in 7...12 { setPixel(&grid, x: x, y: 14, color: darkOlive) }
        // Right leg
        for x in 14...19 { setPixel(&grid, x: x, y: 11, color: olive) }
        for x in 14...19 { setPixel(&grid, x: x, y: 12, color: olive) }
        for x in 14...19 { setPixel(&grid, x: x, y: 13, color: darkOlive) }
        for x in 14...19 { setPixel(&grid, x: x, y: 14, color: darkOlive) }

        // Black outlines (NES style!)
        setPixel(&grid, x: 7, y: 11, color: black)
        setPixel(&grid, x: 7, y: 12, color: black)
        setPixel(&grid, x: 7, y: 13, color: black)
        setPixel(&grid, x: 7, y: 14, color: black)
        setPixel(&grid, x: 12, y: 11, color: black)
        setPixel(&grid, x: 12, y: 12, color: black)
        setPixel(&grid, x: 12, y: 13, color: black)
        setPixel(&grid, x: 12, y: 14, color: black)
        setPixel(&grid, x: 14, y: 11, color: black)
        setPixel(&grid, x: 14, y: 12, color: black)
        setPixel(&grid, x: 14, y: 13, color: black)
        setPixel(&grid, x: 14, y: 14, color: black)
        setPixel(&grid, x: 18, y: 11, color: black)
        setPixel(&grid, x: 18, y: 12, color: black)
        setPixel(&grid, x: 18, y: 13, color: black)
        setPixel(&grid, x: 18, y: 14, color: black)
        // Leg separation
        setPixel(&grid, x: 12, y: 11, color: black)
        setPixel(&grid, x: 13, y: 11, color: black)
        setPixel(&grid, x: 12, y: 12, color: black)
        setPixel(&grid, x: 13, y: 12, color: black)
        setPixel(&grid, x: 12, y: 13, color: black)
        setPixel(&grid, x: 13, y: 13, color: black)
        setPixel(&grid, x: 12, y: 14, color: black)
        setPixel(&grid, x: 13, y: 14, color: black)

        // Pant pocket details
        setPixel(&grid, x: 9, y: 12, color: darkOlive)
        setPixel(&grid, x: 16, y: 12, color: darkOlive)

        // ====== BROWN BOOTS ======
        for x in 6...12 { setPixel(&grid, x: x, y: 15, color: brown) }
        for x in 6...12 { setPixel(&grid, x: x, y: 16, color: brown) }
        for x in 14...19 { setPixel(&grid, x: x, y: 15, color: brown) }
        for x in 14...19 { setPixel(&grid, x: x, y: 16, color: brown) }
        // Boot soles
        for x in 6...12 { setPixel(&grid, x: x, y: 17, color: darkBrown) }
        for x in 14...19 { setPixel(&grid, x: x, y: 17, color: darkBrown) }
        // Boot tops
        setPixel(&grid, x: 8, y: 15, color: darkBrown)
        setPixel(&grid, x: 16, y: 15, color: darkBrown)
        // Boot outlines
        setPixel(&grid, x: 6, y: 15, color: black)
        setPixel(&grid, x: 12, y: 15, color: black)
        setPixel(&grid, x: 14, y: 15, color: black)
        setPixel(&grid, x: 18, y: 15, color: black)
        setPixel(&grid, x: 6, y: 17, color: black)
        setPixel(&grid, x: 12, y: 17, color: black)
        setPixel(&grid, x: 14, y: 17, color: black)
        setPixel(&grid, x: 18, y: 17, color: black)

        // ====== MUZZLE FLASH (animated) ======
        let flashPhase = frame % 4
        if flashPhase == 0 {
            setPixel(&grid, x: 25, y: 4, color: NSColor(red: 1.0, green: 0.9, blue: 0.2, alpha: 1.0))
            setPixel(&grid, x: 25, y: 3, color: white)
            setPixel(&grid, x: 26, y: 4, color: NSColor(red: 1.0, green: 0.8, blue: 0.0, alpha: 1.0))
        } else if flashPhase == 1 {
            setPixel(&grid, x: 25, y: 4, color: NSColor(red: 1.0, green: 0.5, blue: 0.0, alpha: 1.0))
            setPixel(&grid, x: 25, y: 3, color: NSColor(red: 1.0, green: 0.8, blue: 0.0, alpha: 1.0))
            setPixel(&grid, x: 26, y: 3, color: NSColor(red: 1.0, green: 0.6, blue: 0.0, alpha: 1.0))
        } else if flashPhase == 2 {
            setPixel(&grid, x: 25, y: 3, color: NSColor(red: 1.0, green: 0.6, blue: 0.0, alpha: 1.0))
            setPixel(&grid, x: 25, y: 4, color: white)
        } else {
            setPixel(&grid, x: 25, y: 4, color: NSColor(red: 1.0, green: 0.95, blue: 0.3, alpha: 1.0))
            setPixel(&grid, x: 25, y: 3, color: NSColor(red: 1.0, green: 0.7, blue: 0.0, alpha: 1.0))
        }
    }

    private func drawMSTarma(grid: inout [[NSColor]], frame: Int) {
        // Tarma: auburn hair, sunglasses, golden vest, khaki pants
        let auburn = NSColor(red: 0.6, green: 0.35, blue: 0.15, alpha: 1.0)
        let darkAuburn = NSColor(red: 0.45, green: 0.25, blue: 0.1, alpha: 1.0)
        let skin = NSColor(red: 1.0, green: 0.82, blue: 0.62, alpha: 1.0)
        let gold = NSColor(red: 0.85, green: 0.65, blue: 0.15, alpha: 1.0)
        let darkGold = NSColor(red: 0.65, green: 0.5, blue: 0.1, alpha: 1.0)
        let khaki = NSColor(red: 0.45, green: 0.5, blue: 0.3, alpha: 1.0)
        let darkKhaki = NSColor(red: 0.35, green: 0.4, blue: 0.22, alpha: 1.0)
        let brown = NSColor(red: 0.5, green: 0.32, blue: 0.12, alpha: 1.0)
        let black = NSColor.black
        let white = NSColor.white
        let gun = NSColor(red: 0.35, green: 0.35, blue: 0.4, alpha: 1.0)

        // === AUBURN HAIR (medium parted bangs + sideburns) ===
        for x in 5...10 { setPixel(&grid, x: x, y: 0, color: auburn) }
        for x in 4...11 { setPixel(&grid, x: x, y: 1, color: auburn) }
        setPixel(&grid, x: 4, y: 1, color: darkAuburn)
        setPixel(&grid, x: 11, y: 1, color: darkAuburn)
        // Sideburns
        setPixel(&grid, x: 4, y: 2, color: auburn)
        setPixel(&grid, x: 11, y: 2, color: auburn)

        // Parted bangs
        setPixel(&grid, x: 7, y: 0, color: darkAuburn)
        setPixel(&grid, x: 8, y: 0, color: darkAuburn)

        // Face
        for x in 5...10 { setPixel(&grid, x: x, y: 2, color: skin) }
        for x in 5...10 { setPixel(&grid, x: x, y: 3, color: skin) }

        // SUNGLASSES (Tarma's signature!)
        setPixel(&grid, x: 6, y: 2, color: black)
        setPixel(&grid, x: 7, y: 2, color: black)
        setPixel(&grid, x: 8, y: 2, color: black)
        setPixel(&grid, x: 9, y: 2, color: black)
        // Glare on glasses
        setPixel(&grid, x: 6, y: 2, color: NSColor(red: 0.25, green: 0.25, blue: 0.3, alpha: 1.0))

        // Mouth
        setPixel(&grid, x: 7, y: 3, color: darkAuburn)
        setPixel(&grid, x: 8, y: 3, color: darkAuburn)

        // === GOLDEN VEST ===
        for x in 4...11 { setPixel(&grid, x: x, y: 4, color: gold) }
        for x in 3...12 { setPixel(&grid, x: x, y: 5, color: gold) }
        for x in 3...12 { setPixel(&grid, x: x, y: 6, color: darkGold) }
        for x in 4...11 { setPixel(&grid, x: x, y: 7, color: gold) }

        // White shirt showing
        setPixel(&grid, x: 7, y: 4, color: white)
        setPixel(&grid, x: 8, y: 4, color: white)

        // Vest details
        setPixel(&grid, x: 5, y: 5, color: darkGold)
        setPixel(&grid, x: 10, y: 5, color: darkGold)

        // Belt
        for x in 4...11 { setPixel(&grid, x: x, y: 6, color: brown) }

        // === LEFT ARM with black wristband ===
        setPixel(&grid, x: 3, y: 4, color: gold)
        setPixel(&grid, x: 3, y: 5, color: gold)
        setPixel(&grid, x: 2, y: 5, color: skin)
        setPixel(&grid, x: 2, y: 6, color: black)

        // === RIGHT ARM ===
        setPixel(&grid, x: 12, y: 4, color: gold)
        setPixel(&grid, x: 13, y: 4, color: skin)
        setPixel(&grid, x: 13, y: 5, color: skin)
        setPixel(&grid, x: 14, y: 5, color: black)

        // SHOTGUN
        setPixel(&grid, x: 12, y: 3, color: gun)
        setPixel(&grid, x: 13, y: 3, color: gun)
        setPixel(&grid, x: 14, y: 3, color: gun)
        setPixel(&grid, x: 14, y: 2, color: gun)
        setPixel(&grid, x: 11, y: 3, color: brown)

        // === KHAKI PANTS ===
        for x in 4...6 { setPixel(&grid, x: x, y: 8, color: khaki) }
        for x in 9...11 { setPixel(&grid, x: x, y: 8, color: khaki) }
        for x in 4...6 { setPixel(&grid, x: x, y: 9, color: darkKhaki) }
        for x in 9...11 { setPixel(&grid, x: x, y: 9, color: darkKhaki) }

        // BROWN BOOTS
        for x in 3...6 { setPixel(&grid, x: x, y: 10, color: brown) }
        for x in 9...12 { setPixel(&grid, x: x, y: 10, color: brown) }

        // MUZZLE FLASH
        let flashPhase = frame % 4
        if flashPhase == 0 {
            setPixel(&grid, x: 14, y: 1, color: NSColor(red: 1.0, green: 0.9, blue: 0.2, alpha: 1.0))
            setPixel(&grid, x: 15, y: 1, color: white)
        } else if flashPhase == 1 {
            setPixel(&grid, x: 14, y: 1, color: NSColor(red: 1.0, green: 0.5, blue: 0.0, alpha: 1.0))
        }
    }

    private func drawMSEri(grid: inout [[NSColor]], frame: Int) {
        // Eri Kasamoto: blonde hair (dyed), bandana, military gear, former gang leader
        let blonde = NSColor(red: 0.95, green: 0.85, blue: 0.3, alpha: 1.0)
        let darkBlonde = NSColor(red: 0.8, green: 0.7, blue: 0.2, alpha: 1.0)
        let skin = NSColor(red: 1.0, green: 0.82, blue: 0.62, alpha: 1.0)
        let green = NSColor(red: 0.25, green: 0.5, blue: 0.2, alpha: 1.0)
        let darkGreen = NSColor(red: 0.15, green: 0.35, blue: 0.12, alpha: 1.0)
        let brown = NSColor(red: 0.5, green: 0.32, blue: 0.12, alpha: 1.0)
        let black = NSColor.black
        let white = NSColor.white
        let gun = NSColor(red: 0.35, green: 0.35, blue: 0.4, alpha: 1.0)
        let red = NSColor(red: 0.85, green: 0.12, blue: 0.15, alpha: 1.0)

        // === BLONDE HAIR (long, flowing from bandana) ===
        for x in 5...10 { setPixel(&grid, x: x, y: 0, color: blonde) }
        for x in 4...11 { setPixel(&grid, x: x, y: 1, color: blonde) }
        setPixel(&grid, x: 4, y: 2, color: darkBlonde)
        setPixel(&grid, x: 11, y: 2, color: darkBlonde)
        setPixel(&grid, x: 3, y: 2, color: blonde)
        setPixel(&grid, x: 12, y: 2, color: blonde)
        // Hair shine
        setPixel(&grid, x: 6, y: 0, color: white)

        // GREEN BANDANA
        for x in 5...10 { setPixel(&grid, x: x, y: 1, color: green) }
        setPixel(&grid, x: 5, y: 0, color: green)
        setPixel(&grid, x: 10, y: 0, color: green)

        // Face
        for x in 5...10 { setPixel(&grid, x: x, y: 2, color: skin) }
        for x in 5...10 { setPixel(&grid, x: x, y: 3, color: skin) }

        // Eyes (determined)
        setPixel(&grid, x: 6, y: 2, color: NSColor(red: 0.2, green: 0.5, blue: 0.9, alpha: 1.0))
        setPixel(&grid, x: 9, y: 2, color: NSColor(red: 0.2, green: 0.5, blue: 0.9, alpha: 1.0))
        setPixel(&grid, x: 6, y: 2, color: black)
        setPixel(&grid, x: 9, y: 2, color: black)

        // Mouth
        setPixel(&grid, x: 7, y: 3, color: NSColor(red: 0.8, green: 0.3, blue: 0.3, alpha: 1.0))

        // === MILITARY VEST (green) ===
        for x in 4...11 { setPixel(&grid, x: x, y: 4, color: green) }
        for x in 3...12 { setPixel(&grid, x: x, y: 5, color: green) }
        for x in 3...12 { setPixel(&grid, x: x, y: 6, color: darkGreen) }
        for x in 4...11 { setPixel(&grid, x: x, y: 7, color: green) }

        // Vest details
        setPixel(&grid, x: 5, y: 5, color: darkGreen)
        setPixel(&grid, x: 10, y: 5, color: darkGreen)

        // Ammo belt
        setPixel(&grid, x: 6, y: 5, color: brown)
        setPixel(&grid, x: 7, y: 5, color: brown)
        setPixel(&grid, x: 8, y: 5, color: brown)
        setPixel(&grid, x: 9, y: 5, color: brown)

        // Belt
        for x in 4...11 { setPixel(&grid, x: x, y: 6, color: brown) }

        // === LEFT ARM ===
        setPixel(&grid, x: 3, y: 4, color: green)
        setPixel(&grid, x: 3, y: 5, color: green)
        setPixel(&grid, x: 2, y: 5, color: green)
        setPixel(&grid, x: 2, y: 6, color: darkGreen)
        setPixel(&grid, x: 1, y: 6, color: skin)

        // === RIGHT ARM (throwing grenade!) ===
        setPixel(&grid, x: 12, y: 4, color: green)
        setPixel(&grid, x: 13, y: 4, color: green)
        setPixel(&grid, x: 14, y: 4, color: skin)
        setPixel(&grid, x: 14, y: 5, color: skin)

        // Grenade in hand
        setPixel(&grid, x: 14, y: 3, color: NSColor(red: 0.2, green: 0.5, blue: 0.2, alpha: 1.0))

        // === KHAKI PANTS ===
        for x in 4...6 { setPixel(&grid, x: x, y: 8, color: green) }
        for x in 9...11 { setPixel(&grid, x: x, y: 8, color: green) }
        for x in 4...6 { setPixel(&grid, x: x, y: 9, color: darkGreen) }
        for x in 9...11 { setPixel(&grid, x: x, y: 9, color: darkGreen) }

        // BROWN BOOTS
        for x in 3...6 { setPixel(&grid, x: x, y: 10, color: brown) }
        for x in 9...12 { setPixel(&grid, x: x, y: 10, color: brown) }

        // GRENADE THROW EFFECT
        let throwPhase = frame % 4
        if throwPhase == 0 {
            setPixel(&grid, x: 15, y: 2, color: NSColor(red: 0.2, green: 0.5, blue: 0.2, alpha: 1.0))
        } else if throwPhase == 1 {
            setPixel(&grid, x: 15, y: 1, color: NSColor(red: 0.2, green: 0.5, blue: 0.2, alpha: 1.0))
        } else if throwPhase == 2 {
            setPixel(&grid, x: 14, y: 0, color: NSColor(red: 0.2, green: 0.5, blue: 0.2, alpha: 1.0))
        } else {
            // Explosion
            setPixel(&grid, x: 15, y: 0, color: NSColor(red: 1.0, green: 0.5, blue: 0.0, alpha: 1.0))
            setPixel(&grid, x: 15, y: 1, color: NSColor(red: 1.0, green: 0.8, blue: 0.0, alpha: 1.0))
        }
    }

    private func drawMSFio(grid: inout [[NSColor]], frame: Int) {
        // Fio Germi: brown/orange hair ponytail, glasses, tan vest, white tanktop, brown shorts
        let orange = NSColor(red: 0.85, green: 0.5, blue: 0.15, alpha: 1.0)
        let darkOrange = NSColor(red: 0.65, green: 0.35, blue: 0.1, alpha: 1.0)
        let skin = NSColor(red: 1.0, green: 0.82, blue: 0.62, alpha: 1.0)
        let tan = NSColor(red: 0.75, green: 0.65, blue: 0.45, alpha: 1.0)
        let darkTan = NSColor(red: 0.55, green: 0.48, blue: 0.32, alpha: 1.0)
        let brown = NSColor(red: 0.5, green: 0.35, blue: 0.15, alpha: 1.0)
        let darkBrown = NSColor(red: 0.35, green: 0.25, blue: 0.1, alpha: 1.0)
        let black = NSColor.black
        let white = NSColor.white
        let gun = NSColor(red: 0.35, green: 0.35, blue: 0.4, alpha: 1.0)
        let glasses = NSColor(red: 0.5, green: 0.6, blue: 0.8, alpha: 1.0)

        // === ORANGE HAIR (ponytail, tied back) ===
        for x in 5...10 { setPixel(&grid, x: x, y: 0, color: orange) }
        for x in 4...11 { setPixel(&grid, x: x, y: 1, color: orange) }
        setPixel(&grid, x: 4, y: 1, color: darkOrange)
        setPixel(&grid, x: 11, y: 1, color: darkOrange)
        // Ponytail going back
        setPixel(&grid, x: 11, y: 0, color: orange)
        setPixel(&grid, x: 12, y: 0, color: orange)
        setPixel(&grid, x: 12, y: 1, color: darkOrange)

        // Hair tie
        setPixel(&grid, x: 11, y: 0, color: brown)

        // Face
        for x in 5...10 { setPixel(&grid, x: x, y: 2, color: skin) }
        for x in 5...10 { setPixel(&grid, x: x, y: 3, color: skin) }

        // GLASSES (Fio's signature!)
        setPixel(&grid, x: 6, y: 2, color: glasses)
        setPixel(&grid, x: 7, y: 2, color: glasses)
        setPixel(&grid, x: 8, y: 2, color: glasses)
        setPixel(&grid, x: 9, y: 2, color: glasses)
        // Eyes behind glasses
        setPixel(&grid, x: 6, y: 2, color: NSColor(red: 0.4, green: 0.3, blue: 0.2, alpha: 1.0))
        setPixel(&grid, x: 9, y: 2, color: NSColor(red: 0.4, green: 0.3, blue: 0.2, alpha: 1.0))

        // Mouth
        setPixel(&grid, x: 7, y: 3, color: NSColor(red: 0.8, green: 0.3, blue: 0.3, alpha: 1.0))

        // === WHITE TANKTOP (under tan vest) ===
        setPixel(&grid, x: 7, y: 4, color: white)
        setPixel(&grid, x: 8, y: 4, color: white)

        // === TAN VEST ===
        for x in 4...11 { setPixel(&grid, x: x, y: 4, color: tan) }
        for x in 3...12 { setPixel(&grid, x: x, y: 5, color: tan) }
        for x in 3...12 { setPixel(&grid, x: x, y: 6, color: darkTan) }
        for x in 4...11 { setPixel(&grid, x: x, y: 7, color: tan) }

        // Vest pockets
        setPixel(&grid, x: 5, y: 5, color: darkTan)
        setPixel(&grid, x: 10, y: 5, color: darkTan)

        // Belt
        for x in 4...11 { setPixel(&grid, x: x, y: 6, color: brown) }

        // === LEFT ARM ===
        setPixel(&grid, x: 3, y: 4, color: tan)
        setPixel(&grid, x: 3, y: 5, color: tan)
        setPixel(&grid, x: 2, y: 5, color: skin)
        setPixel(&grid, x: 2, y: 6, color: skin)

        // === RIGHT ARM (holding rifle) ===
        setPixel(&grid, x: 12, y: 4, color: tan)
        setPixel(&grid, x: 13, y: 4, color: skin)
        setPixel(&grid, x: 13, y: 5, color: skin)
        setPixel(&grid, x: 14, y: 5, color: skin)

        // RIFLE
        setPixel(&grid, x: 12, y: 3, color: gun)
        setPixel(&grid, x: 13, y: 3, color: gun)
        setPixel(&grid, x: 14, y: 3, color: gun)
        setPixel(&grid, x: 14, y: 2, color: gun)
        setPixel(&grid, x: 11, y: 3, color: brown)

        // === BROWN SHORTS ===
        for x in 4...6 { setPixel(&grid, x: x, y: 8, color: brown) }
        for x in 9...11 { setPixel(&grid, x: x, y: 8, color: brown) }
        for x in 4...6 { setPixel(&grid, x: x, y: 9, color: darkBrown) }
        for x in 9...11 { setPixel(&grid, x: x, y: 9, color: darkBrown) }

        // KNEE PADS
        setPixel(&grid, x: 5, y: 9, color: darkTan)
        setPixel(&grid, x: 10, y: 9, color: darkTan)

        // BROWN BOOTS
        for x in 3...6 { setPixel(&grid, x: x, y: 10, color: brown) }
        for x in 9...12 { setPixel(&grid, x: x, y: 10, color: brown) }

        // MUZZLE FLASH
        let flashPhase = frame % 4
        if flashPhase == 0 {
            setPixel(&grid, x: 14, y: 1, color: NSColor(red: 1.0, green: 0.9, blue: 0.2, alpha: 1.0))
        }
    }

    private func drawMSMorden(grid: inout [[NSColor]], frame: Int) {
        // General Morden: green military cap with red star, mustache, medals, officer uniform
        let green = NSColor(red: 0.2, green: 0.45, blue: 0.2, alpha: 1.0)
        let darkGreen = NSColor(red: 0.12, green: 0.32, blue: 0.12, alpha: 1.0)
        let skin = NSColor(red: 1.0, green: 0.82, blue: 0.62, alpha: 1.0)
        let black = NSColor.black
        let brown = NSColor(red: 0.45, green: 0.3, blue: 0.12, alpha: 1.0)
        let red = NSColor(red: 0.85, green: 0.12, blue: 0.15, alpha: 1.0)
        let gold = NSColor(red: 1.0, green: 0.85, blue: 0.0, alpha: 1.0)
        let white = NSColor.white

        // === MILITARY CAP (with red star!) ===
        for x in 5...10 { setPixel(&grid, x: x, y: 0, color: green) }
        for x in 4...11 { setPixel(&grid, x: x, y: 1, color: green) }
        setPixel(&grid, x: 4, y: 0, color: darkGreen)
        setPixel(&grid, x: 11, y: 0, color: darkGreen)

        // Red star on cap
        setPixel(&grid, x: 7, y: 0, color: red)
        setPixel(&grid, x: 8, y: 0, color: red)
        setPixel(&grid, x: 7, y: 0, color: red)

        // Cap brim (black)
        setPixel(&grid, x: 4, y: 1, color: black)
        setPixel(&grid, x: 11, y: 1, color: black)

        // Face
        for x in 5...10 { setPixel(&grid, x: x, y: 2, color: skin) }
        for x in 5...10 { setPixel(&grid, x: x, y: 3, color: skin) }

        // Eyes (evil)
        setPixel(&grid, x: 6, y: 2, color: black)
        setPixel(&grid, x: 9, y: 2, color: black)

        // MUSTACHE (iconic Morden!)
        setPixel(&grid, x: 6, y: 3, color: brown)
        setPixel(&grid, x: 7, y: 3, color: brown)
        setPixel(&grid, x: 8, y: 3, color: brown)
        setPixel(&grid, x: 9, y: 3, color: brown)

        // Evil grin
        setPixel(&grid, x: 7, y: 3, color: black)
        setPixel(&grid, x: 8, y: 3, color: black)

        // === MILITARY UNIFORM (officer) ===
        for x in 4...11 { setPixel(&grid, x: x, y: 4, color: green) }
        for x in 3...12 { setPixel(&grid, x: x, y: 5, color: green) }
        for x in 3...12 { setPixel(&grid, x: x, y: 6, color: darkGreen) }
        for x in 4...11 { setPixel(&grid, x: x, y: 7, color: green) }

        // Medals (gold!)
        setPixel(&grid, x: 7, y: 4, color: gold)
        setPixel(&grid, x: 8, y: 4, color: gold)
        setPixel(&grid, x: 7, y: 5, color: gold)

        // Belt (officer)
        for x in 4...11 { setPixel(&grid, x: x, y: 6, color: brown) }
        setPixel(&grid, x: 7, y: 6, color: gold)
        setPixel(&grid, x: 8, y: 6, color: gold)

        // Shoulder boards
        setPixel(&grid, x: 3, y: 4, color: gold)
        setPixel(&grid, x: 12, y: 4, color: gold)

        // === ARMS ===
        setPixel(&grid, x: 2, y: 5, color: green)
        setPixel(&grid, x: 2, y: 6, color: green)
        setPixel(&grid, x: 1, y: 6, color: green)
        setPixel(&grid, x: 13, y: 5, color: green)
        setPixel(&grid, x: 14, y: 5, color: green)

        // === LEGS ===
        for x in 4...6 { setPixel(&grid, x: x, y: 8, color: green) }
        for x in 9...11 { setPixel(&grid, x: x, y: 8, color: green) }
        for x in 4...6 { setPixel(&grid, x: x, y: 9, color: darkGreen) }
        for x in 9...11 { setPixel(&grid, x: x, y: 9, color: darkGreen) }

        // BLACK BOOTS
        for x in 3...6 { setPixel(&grid, x: x, y: 10, color: black) }
        for x in 9...12 { setPixel(&grid, x: x, y: 10, color: black) }
    }

    private func drawMSCamel(grid: inout [[NSColor]], frame: Int) {
        // SV-Camel: tan camel with machine gun mounted on side
        let tan = NSColor(red: 0.82, green: 0.68, blue: 0.38, alpha: 1.0)
        let darkTan = NSColor(red: 0.62, green: 0.5, blue: 0.25, alpha: 1.0)
        let brightTan = NSColor(red: 0.92, green: 0.78, blue: 0.48, alpha: 1.0)
        let black = NSColor.black
        let brown = NSColor(red: 0.5, green: 0.32, blue: 0.12, alpha: 1.0)
        let gun = NSColor(red: 0.35, green: 0.35, blue: 0.4, alpha: 1.0)
        let darkGun = NSColor(red: 0.25, green: 0.25, blue: 0.3, alpha: 1.0)

        // === HEAD (camel-like, expressive) ===
        for x in 3...5 { setPixel(&grid, x: x, y: 0, color: tan) }
        for x in 3...5 { setPixel(&grid, x: x, y: 1, color: tan) }
        setPixel(&grid, x: 3, y: 0, color: darkTan)

        // Eyes
        setPixel(&grid, x: 4, y: 0, color: black)
        // Nostrils
        setPixel(&grid, x: 3, y: 1, color: black)

        // === HUMP ===
        setPixel(&grid, x: 7, y: 0, color: brightTan)
        setPixel(&grid, x: 8, y: 0, color: brightTan)

        // === BODY (massive, muscular!) ===
        for x in 3...12 { setPixel(&grid, x: x, y: 2, color: tan) }
        for x in 2...13 { setPixel(&grid, x: x, y: 3, color: tan) }
        for x in 2...13 { setPixel(&grid, x: x, y: 4, color: darkTan) }
        for x in 3...12 { setPixel(&grid, x: x, y: 5, color: tan) }

        // Saddle (brown, detailed)
        for x in 6...9 { setPixel(&grid, x: x, y: 2, color: brown) }
        setPixel(&grid, x: 6, y: 2, color: NSColor(red: 0.4, green: 0.25, blue: 0.1, alpha: 1.0))
        setPixel(&grid, x: 9, y: 2, color: NSColor(red: 0.4, green: 0.25, blue: 0.1, alpha: 1.0))

        // === MACHINE GUN (mounted on side) ===
        setPixel(&grid, x: 12, y: 3, color: gun)
        setPixel(&grid, x: 13, y: 3, color: gun)
        setPixel(&grid, x: 14, y: 3, color: darkGun)
        setPixel(&grid, x: 14, y: 2, color: gun)
        setPixel(&grid, x: 11, y: 3, color: gun)

        // === LEGS (4 legs, animated!) ===
        let legPhase = frame % 4
        if legPhase == 0 {
            setPixel(&grid, x: 3, y: 6, color: tan)
            setPixel(&grid, x: 5, y: 6, color: tan)
            setPixel(&grid, x: 10, y: 6, color: tan)
            setPixel(&grid, x: 12, y: 6, color: tan)
        } else if legPhase == 1 {
            setPixel(&grid, x: 3, y: 6, color: darkTan)
            setPixel(&grid, x: 4, y: 6, color: tan)
            setPixel(&grid, x: 11, y: 6, color: tan)
            setPixel(&grid, x: 12, y: 6, color: darkTan)
        } else if legPhase == 2 {
            setPixel(&grid, x: 4, y: 6, color: tan)
            setPixel(&grid, x: 5, y: 6, color: tan)
            setPixel(&grid, x: 10, y: 6, color: tan)
            setPixel(&grid, x: 11, y: 6, color: tan)
        } else {
            setPixel(&grid, x: 3, y: 6, color: tan)
            setPixel(&grid, x: 5, y: 6, color: darkTan)
            setPixel(&grid, x: 10, y: 6, color: darkTan)
            setPixel(&grid, x: 12, y: 6, color: tan)
        }

        // Hooves
        setPixel(&grid, x: 3, y: 7, color: darkTan)
        setPixel(&grid, x: 5, y: 7, color: darkTan)
        setPixel(&grid, x: 10, y: 7, color: darkTan)
        setPixel(&grid, x: 12, y: 7, color: darkTan)

        // === VULCAN FIRE ===
        let firePhase = frame % 4
        if firePhase == 0 {
            setPixel(&grid, x: 15, y: 3, color: NSColor(red: 1.0, green: 0.8, blue: 0.0, alpha: 1.0))
        } else if firePhase == 1 {
            setPixel(&grid, x: 15, y: 2, color: NSColor(red: 1.0, green: 0.5, blue: 0.0, alpha: 1.0))
        } else if firePhase == 2 {
            setPixel(&grid, x: 15, y: 3, color: NSColor(red: 1.0, green: 0.9, blue: 0.2, alpha: 1.0))
        }
    }

    private func drawMSSlugTank(grid: inout [[NSColor]], frame: Int) {
        // Metal Slug tank: green armored, rounded turret, cannon, treads
        let green = NSColor(red: 0.2, green: 0.55, blue: 0.2, alpha: 1.0)
        let darkGreen = NSColor(red: 0.1, green: 0.4, blue: 0.1, alpha: 1.0)
        let brightGreen = NSColor(red: 0.3, green: 0.65, blue: 0.3, alpha: 1.0)
        let gray = NSColor(red: 0.5, green: 0.5, blue: 0.55, alpha: 1.0)
        let darkGray = NSColor(red: 0.35, green: 0.35, blue: 0.4, alpha: 1.0)
        let black = NSColor.black
        let orange = NSColor(red: 1.0, green: 0.5, blue: 0.0, alpha: 1.0)
        let white = NSColor.white

        // === TURRET (rounded, iconic Metal Slug shape) ===
        for x in 6...9 { setPixel(&grid, x: x, y: 0, color: green) }
        for x in 5...10 { setPixel(&grid, x: x, y: 1, color: green) }
        setPixel(&grid, x: 5, y: 0, color: darkGreen)
        setPixel(&grid, x: 10, y: 0, color: darkGreen)
        setPixel(&grid, x: 6, y: 0, color: brightGreen)

        // Turret hatch
        setPixel(&grid, x: 7, y: 0, color: gray)
        setPixel(&grid, x: 8, y: 0, color: gray)

        // === CANNON (long, powerful!) ===
        for x in 10...14 { setPixel(&grid, x: x, y: 0, color: gray) }
        for x in 10...14 { setPixel(&grid, x: x, y: 1, color: darkGray) }
        setPixel(&grid, x: 14, y: 0, color: black)
        setPixel(&grid, x: 14, y: 1, color: black)

        // === BODY (armored hull, rounded) ===
        for x in 3...12 { setPixel(&grid, x: x, y: 2, color: green) }
        for x in 2...13 { setPixel(&grid, x: x, y: 3, color: green) }
        for x in 2...13 { setPixel(&grid, x: x, y: 4, color: darkGreen) }
        for x in 3...12 { setPixel(&grid, x: x, y: 5, color: green) }

        // Armor plates
        setPixel(&grid, x: 4, y: 2, color: brightGreen)
        setPixel(&grid, x: 11, y: 2, color: brightGreen)

        // Rivets
        setPixel(&grid, x: 3, y: 3, color: gray)
        setPixel(&grid, x: 12, y: 3, color: gray)

        // === TREADS ===
        for x in 2...13 { setPixel(&grid, x: x, y: 6, color: gray) }
        for x in 2...13 { setPixel(&grid, x: x, y: 7, color: darkGray) }

        // Wheels (animated!)
        let wheelOffset = frame % 4
        if wheelOffset == 0 {
            setPixel(&grid, x: 3, y: 6, color: black)
            setPixel(&grid, x: 6, y: 6, color: black)
            setPixel(&grid, x: 9, y: 6, color: black)
            setPixel(&grid, x: 12, y: 6, color: black)
        } else if wheelOffset == 1 {
            setPixel(&grid, x: 4, y: 6, color: black)
            setPixel(&grid, x: 7, y: 6, color: black)
            setPixel(&grid, x: 10, y: 6, color: black)
        } else if wheelOffset == 2 {
            setPixel(&grid, x: 3, y: 6, color: black)
            setPixel(&grid, x: 5, y: 6, color: black)
            setPixel(&grid, x: 8, y: 6, color: black)
            setPixel(&grid, x: 11, y: 6, color: black)
        } else {
            setPixel(&grid, x: 4, y: 6, color: black)
            setPixel(&grid, x: 6, y: 6, color: black)
            setPixel(&grid, x: 9, y: 6, color: black)
            setPixel(&grid, x: 12, y: 6, color: black)
        }

        // === CANNON FIRE (animated!) ===
        let firePhase = frame % 4
        if firePhase == 0 {
            setPixel(&grid, x: 15, y: 0, color: orange)
            setPixel(&grid, x: 15, y: 1, color: orange)
        } else if firePhase == 1 {
            setPixel(&grid, x: 15, y: 0, color: white)
            setPixel(&grid, x: 15, y: 1, color: white)
        } else if firePhase == 2 {
            setPixel(&grid, x: 15, y: 0, color: orange)
        }
    }

    private func drawMSZombie(grid: inout [[NSColor]], frame: Int) {
        // Metal Slug zombie: greenish-gray undead, torn clothes, shambling
        let gray = NSColor(red: 0.45, green: 0.48, blue: 0.42, alpha: 1.0)
        let darkGray = NSColor(red: 0.3, green: 0.32, blue: 0.28, alpha: 1.0)
        let green = NSColor(red: 0.35, green: 0.55, blue: 0.25, alpha: 1.0)
        let darkGreen = NSColor(red: 0.2, green: 0.38, blue: 0.15, alpha: 1.0)
        let black = NSColor.black
        let red = NSColor(red: 0.85, green: 0.1, blue: 0.1, alpha: 1.0)
        let darkRed = NSColor(red: 0.55, green: 0.05, blue: 0.05, alpha: 1.0)
        let white = NSColor.white

        // === DECAYING HEAD ===
        for x in 5...10 { setPixel(&grid, x: x, y: 0, color: green) }
        for x in 5...10 { setPixel(&grid, x: x, y: 1, color: darkGreen) }
        setPixel(&grid, x: 5, y: 0, color: darkGreen)
        setPixel(&grid, x: 10, y: 0, color: darkGreen)

        // Exposed skull
        setPixel(&grid, x: 7, y: 0, color: white)
        setPixel(&grid, x: 8, y: 0, color: white)

        // Glowing zombie eyes!
        setPixel(&grid, x: 6, y: 0, color: red)
        setPixel(&grid, x: 9, y: 0, color: red)

        // Mouth (bloody, open!)
        for x in 6...9 { setPixel(&grid, x: x, y: 1, color: black) }
        setPixel(&grid, x: 6, y: 1, color: red)
        setPixel(&grid, x: 8, y: 1, color: red)
        setPixel(&grid, x: 7, y: 1, color: darkRed)
        setPixel(&grid, x: 7, y: 2, color: darkRed)

        // === TORN BODY ===
        for x in 4...11 { setPixel(&grid, x: x, y: 2, color: green) }
        for x in 3...12 { setPixel(&grid, x: x, y: 3, color: darkGreen) }
        for x in 3...12 { setPixel(&grid, x: x, y: 4, color: green) }
        for x in 4...11 { setPixel(&grid, x: x, y: 5, color: darkGreen) }

        // Torn clothes
        setPixel(&grid, x: 5, y: 2, color: darkGray)
        setPixel(&grid, x: 10, y: 2, color: darkGray)

        // Exposed ribs
        setPixel(&grid, x: 7, y: 3, color: white)
        setPixel(&grid, x: 8, y: 3, color: white)

        // === ARMS (reaching forward!) ===
        let armPhase = frame % 4
        if armPhase == 0 {
            setPixel(&grid, x: 2, y: 2, color: green)
            setPixel(&grid, x: 1, y: 2, color: green)
            setPixel(&grid, x: 13, y: 3, color: green)
            setPixel(&grid, x: 14, y: 3, color: green)
        } else if armPhase == 1 {
            setPixel(&grid, x: 2, y: 3, color: green)
            setPixel(&grid, x: 1, y: 3, color: green)
            setPixel(&grid, x: 13, y: 2, color: green)
            setPixel(&grid, x: 14, y: 2, color: green)
        } else {
            setPixel(&grid, x: 2, y: 2, color: green)
            setPixel(&grid, x: 1, y: 3, color: green)
            setPixel(&grid, x: 13, y: 3, color: green)
            setPixel(&grid, x: 14, y: 2, color: green)
        }

        // Claws
        setPixel(&grid, x: 1, y: 2, color: darkGray)
        setPixel(&grid, x: 14, y: 3, color: darkGray)

        // === LEGS (shuffling) ===
        if armPhase == 0 || armPhase == 2 {
            setPixel(&grid, x: 5, y: 6, color: darkGreen)
            setPixel(&grid, x: 6, y: 7, color: darkGreen)
            setPixel(&grid, x: 10, y: 6, color: darkGreen)
            setPixel(&grid, x: 9, y: 7, color: darkGreen)
        } else {
            setPixel(&grid, x: 6, y: 6, color: darkGreen)
            setPixel(&grid, x: 5, y: 7, color: darkGreen)
            setPixel(&grid, x: 9, y: 6, color: darkGreen)
            setPixel(&grid, x: 10, y: 7, color: darkGreen)
        }
    }

    private func drawMSMummy(grid: inout [[NSColor]], frame: Int) {
        // Metal Slug mummy: beige/white bandages, green glowing eyes, slow shambling
        let beige = NSColor(red: 0.88, green: 0.82, blue: 0.65, alpha: 1.0)
        let darkBeige = NSColor(red: 0.68, green: 0.62, blue: 0.48, alpha: 1.0)
        let offWhite = NSColor(red: 0.82, green: 0.8, blue: 0.72, alpha: 1.0)
        let black = NSColor.black
        let green = NSColor(red: 0.3, green: 0.7, blue: 0.2, alpha: 1.0)
        let darkGreen = NSColor(red: 0.15, green: 0.45, blue: 0.1, alpha: 1.0)
        let gold = NSColor(red: 1.0, green: 0.85, blue: 0.0, alpha: 1.0)

        // === BANDAGE-WRAPPED HEAD ===
        for x in 5...10 { setPixel(&grid, x: x, y: 0, color: beige) }
        for x in 5...10 { setPixel(&grid, x: x, y: 1, color: darkBeige) }
        setPixel(&grid, x: 5, y: 0, color: darkBeige)
        setPixel(&grid, x: 10, y: 0, color: darkBeige)

        // Loose bandage trailing
        setPixel(&grid, x: 5, y: 1, color: offWhite)
        setPixel(&grid, x: 4, y: 1, color: offWhite)

        // Glowing green eyes (through bandages!)
        setPixel(&grid, x: 6, y: 0, color: green)
        setPixel(&grid, x: 9, y: 0, color: green)
        // Eye glow
        setPixel(&grid, x: 6, y: 1, color: green)
        setPixel(&grid, x: 9, y: 1, color: green)

        // === BANDAGE BODY ===
        for x in 4...11 { setPixel(&grid, x: x, y: 2, color: beige) }
        for x in 3...12 { setPixel(&grid, x: x, y: 3, color: darkBeige) }
        for x in 3...12 { setPixel(&grid, x: x, y: 4, color: beige) }
        for x in 4...11 { setPixel(&grid, x: x, y: 5, color: darkBeige) }

        // Torn bandages hanging
        setPixel(&grid, x: 3, y: 3, color: offWhite)
        setPixel(&grid, x: 12, y: 4, color: offWhite)
        setPixel(&grid, x: 3, y: 4, color: darkBeige)

        // Gold amulet
        setPixel(&grid, x: 7, y: 2, color: gold)
        setPixel(&grid, x: 8, y: 2, color: gold)

        // === ARMS (reaching, wrapped) ===
        let armPhase = frame % 4
        if armPhase == 0 {
            setPixel(&grid, x: 2, y: 2, color: beige)
            setPixel(&grid, x: 1, y: 2, color: beige)
            setPixel(&grid, x: 13, y: 3, color: beige)
            setPixel(&grid, x: 14, y: 3, color: beige)
        } else if armPhase == 1 {
            setPixel(&grid, x: 2, y: 3, color: beige)
            setPixel(&grid, x: 1, y: 3, color: beige)
            setPixel(&grid, x: 13, y: 2, color: beige)
            setPixel(&grid, x: 14, y: 2, color: beige)
        } else {
            setPixel(&grid, x: 2, y: 2, color: darkBeige)
            setPixel(&grid, x: 1, y: 3, color: darkBeige)
            setPixel(&grid, x: 13, y: 3, color: darkBeige)
            setPixel(&grid, x: 14, y: 2, color: darkBeige)
        }

        // === LEGS ===
        if armPhase == 0 || armPhase == 2 {
            setPixel(&grid, x: 5, y: 6, color: darkBeige)
            setPixel(&grid, x: 6, y: 7, color: darkBeige)
            setPixel(&grid, x: 10, y: 6, color: darkBeige)
            setPixel(&grid, x: 9, y: 7, color: darkBeige)
        } else {
            setPixel(&grid, x: 6, y: 6, color: darkBeige)
            setPixel(&grid, x: 5, y: 7, color: darkBeige)
            setPixel(&grid, x: 9, y: 6, color: darkBeige)
            setPixel(&grid, x: 10, y: 7, color: darkBeige)
        }
    }

    private func drawMSApe(grid: inout [[NSColor]], frame: Int) {
        // Space Ape: brown muscular ape, red angry eyes, from Moon
        let brown = NSColor(red: 0.55, green: 0.35, blue: 0.15, alpha: 1.0)
        let darkBrown = NSColor(red: 0.4, green: 0.25, blue: 0.1, alpha: 1.0)
        let brightBrown = NSColor(red: 0.65, green: 0.45, blue: 0.2, alpha: 1.0)
        let tan = NSColor(red: 0.85, green: 0.7, blue: 0.4, alpha: 1.0)
        let black = NSColor.black
        let red = NSColor(red: 0.9, green: 0.15, blue: 0.15, alpha: 1.0)
        let white = NSColor.white

        // === HEAD (big, aggressive!) ===
        for x in 5...10 { setPixel(&grid, x: x, y: 0, color: brown) }
        for x in 4...11 { setPixel(&grid, x: x, y: 1, color: brown) }
        setPixel(&grid, x: 4, y: 0, color: darkBrown)
        setPixel(&grid, x: 11, y: 0, color: darkBrown)
        setPixel(&grid, x: 5, y: 0, color: brightBrown)

        // Brow ridge (heavy!)
        setPixel(&grid, x: 5, y: 0, color: darkBrown)
        setPixel(&grid, x: 6, y: 0, color: darkBrown)
        setPixel(&grid, x: 9, y: 0, color: darkBrown)
        setPixel(&grid, x: 10, y: 0, color: darkBrown)

        // RED EYES (angry!)
        setPixel(&grid, x: 6, y: 0, color: red)
        setPixel(&grid, x: 7, y: 0, color: red)
        setPixel(&grid, x: 8, y: 0, color: red)
        setPixel(&grid, x: 9, y: 0, color: red)
        setPixel(&grid, x: 6, y: 0, color: black)
        setPixel(&grid, x: 9, y: 0, color: black)

        // Snout (ape-like)
        for x in 6...9 { setPixel(&grid, x: x, y: 1, color: tan) }
        setPixel(&grid, x: 7, y: 1, color: black)
        setPixel(&grid, x: 8, y: 1, color: black)

        // Mouth (open, roaring!)
        setPixel(&grid, x: 6, y: 1, color: black)
        setPixel(&grid, x: 7, y: 1, color: red)
        setPixel(&grid, x: 8, y: 1, color: red)
        setPixel(&grid, x: 9, y: 1, color: black)
        setPixel(&grid, x: 7, y: 1, color: white)
        setPixel(&grid, x: 8, y: 1, color: white)

        // === MASSIVE BODY ===
        for x in 3...12 { setPixel(&grid, x: x, y: 2, color: brown) }
        for x in 2...13 { setPixel(&grid, x: x, y: 3, color: brown) }
        for x in 2...13 { setPixel(&grid, x: x, y: 4, color: darkBrown) }
        for x in 3...12 { setPixel(&grid, x: x, y: 5, color: brown) }

        // Chest (lighter)
        setPixel(&grid, x: 6, y: 2, color: brightBrown)
        setPixel(&grid, x: 7, y: 2, color: brightBrown)
        setPixel(&grid, x: 8, y: 2, color: brightBrown)
        setPixel(&grid, x: 9, y: 2, color: brightBrown)

        // Muscle definition
        setPixel(&grid, x: 5, y: 3, color: darkBrown)
        setPixel(&grid, x: 10, y: 3, color: darkBrown)

        // === ARMS (beating chest!) ===
        let armPhase = frame % 4
        if armPhase == 0 {
            setPixel(&grid, x: 1, y: 2, color: brown)
            setPixel(&grid, x: 0, y: 2, color: brown)
            setPixel(&grid, x: 14, y: 2, color: brown)
            setPixel(&grid, x: 15, y: 2, color: brown)
        } else if armPhase == 1 {
            setPixel(&grid, x: 1, y: 3, color: brown)
            setPixel(&grid, x: 0, y: 3, color: brown)
            setPixel(&grid, x: 14, y: 3, color: brown)
            setPixel(&grid, x: 15, y: 3, color: brown)
        } else if armPhase == 2 {
            setPixel(&grid, x: 2, y: 2, color: brown)
            setPixel(&grid, x: 1, y: 2, color: darkBrown)
            setPixel(&grid, x: 13, y: 2, color: brown)
            setPixel(&grid, x: 14, y: 2, color: darkBrown)
        } else {
            setPixel(&grid, x: 2, y: 3, color: brown)
            setPixel(&grid, x: 1, y: 3, color: darkBrown)
            setPixel(&grid, x: 13, y: 3, color: brown)
            setPixel(&grid, x: 14, y: 3, color: darkBrown)
        }

        // Hands (fists)
        setPixel(&grid, x: 0, y: 3, color: tan)
        setPixel(&grid, x: 15, y: 3, color: tan)

        // === LEGS (thick, powerful) ===
        for x in 4...6 { setPixel(&grid, x: x, y: 6, color: brown) }
        for x in 9...11 { setPixel(&grid, x: x, y: 6, color: brown) }
        for x in 4...6 { setPixel(&grid, x: x, y: 7, color: darkBrown) }
        for x in 9...11 { setPixel(&grid, x: x, y: 7, color: darkBrown) }
        for x in 3...6 { setPixel(&grid, x: x, y: 8, color: tan) }
        for x in 9...12 { setPixel(&grid, x: x, y: 8, color: tan) }
    }

    private func drawMSHermit(grid: inout [[NSColor]], frame: Int) {
        // Huge Hermit: hermit crab with Denturion tank shell, cannon
        let purple = NSColor(red: 0.5, green: 0.15, blue: 0.65, alpha: 1.0)
        let darkPurple = NSColor(red: 0.35, green: 0.1, blue: 0.5, alpha: 1.0)
        let brightPurple = NSColor(red: 0.65, green: 0.25, blue: 0.8, alpha: 1.0)
        let gray = NSColor(red: 0.5, green: 0.5, blue: 0.55, alpha: 1.0)
        let darkGray = NSColor(red: 0.35, green: 0.35, blue: 0.4, alpha: 1.0)
        let black = NSColor.black
        let white = NSColor.white
        let orange = NSColor(red: 1.0, green: 0.5, blue: 0.0, alpha: 1.0)

        // === TANK SHELL (Denturion, on top) ===
        for x in 5...10 { setPixel(&grid, x: x, y: 0, color: gray) }
        for x in 4...11 { setPixel(&grid, x: x, y: 1, color: gray) }
        for x in 4...11 { setPixel(&grid, x: x, y: 2, color: darkGray) }
        for x in 5...10 { setPixel(&grid, x: x, y: 3, color: gray) }

        // Turret on shell
        setPixel(&grid, x: 7, y: 0, color: darkGray)
        setPixel(&grid, x: 8, y: 0, color: darkGray)
        // Cannon
        setPixel(&grid, x: 10, y: 0, color: darkGray)
        setPixel(&grid, x: 11, y: 0, color: darkGray)
        setPixel(&grid, x: 12, y: 0, color: black)

        // Shell rivets
        setPixel(&grid, x: 5, y: 1, color: white)
        setPixel(&grid, x: 10, y: 1, color: white)

        // === CRAB BODY (purple, underneath) ===
        for x in 4...11 { setPixel(&grid, x: x, y: 4, color: purple) }
        for x in 3...12 { setPixel(&grid, x: x, y: 5, color: purple) }
        for x in 3...12 { setPixel(&grid, x: x, y: 6, color: darkPurple) }
        for x in 4...11 { setPixel(&grid, x: x, y: 7, color: purple) }

        // Shell texture
        setPixel(&grid, x: 5, y: 4, color: brightPurple)
        setPixel(&grid, x: 10, y: 4, color: brightPurple)
        setPixel(&grid, x: 6, y: 5, color: brightPurple)
        setPixel(&grid, x: 9, y: 5, color: brightPurple)

        // === EYES ON STALKS ===
        setPixel(&grid, x: 5, y: 3, color: orange)
        setPixel(&grid, x: 10, y: 3, color: orange)
        setPixel(&grid, x: 5, y: 3, color: black)
        setPixel(&grid, x: 10, y: 3, color: black)
        setPixel(&grid, x: 5, y: 3, color: white)
        setPixel(&grid, x: 10, y: 3, color: white)

        // === CLAWS (animated snipping!) ===
        let clawPhase = frame % 4
        if clawPhase == 0 {
            setPixel(&grid, x: 2, y: 4, color: purple)
            setPixel(&grid, x: 1, y: 4, color: purple)
            setPixel(&grid, x: 2, y: 5, color: darkPurple)
            setPixel(&grid, x: 13, y: 4, color: purple)
            setPixel(&grid, x: 14, y: 4, color: purple)
            setPixel(&grid, x: 13, y: 5, color: darkPurple)
        } else if clawPhase == 1 {
            setPixel(&grid, x: 2, y: 4, color: brightPurple)
            setPixel(&grid, x: 1, y: 4, color: brightPurple)
            setPixel(&grid, x: 13, y: 4, color: brightPurple)
            setPixel(&grid, x: 14, y: 4, color: brightPurple)
        } else if clawPhase == 2 {
            setPixel(&grid, x: 2, y: 5, color: purple)
            setPixel(&grid, x: 1, y: 5, color: purple)
            setPixel(&grid, x: 13, y: 5, color: purple)
            setPixel(&grid, x: 14, y: 5, color: purple)
        } else {
            setPixel(&grid, x: 2, y: 4, color: darkPurple)
            setPixel(&grid, x: 13, y: 4, color: darkPurple)
        }

        // === LEGS (crab legs, animated) ===
        let legPhase = frame % 4
        if legPhase == 0 || legPhase == 2 {
            setPixel(&grid, x: 4, y: 8, color: purple)
            setPixel(&grid, x: 5, y: 8, color: purple)
            setPixel(&grid, x: 10, y: 8, color: purple)
            setPixel(&grid, x: 11, y: 8, color: purple)
        } else {
            setPixel(&grid, x: 5, y: 8, color: purple)
            setPixel(&grid, x: 4, y: 8, color: darkPurple)
            setPixel(&grid, x: 11, y: 8, color: purple)
            setPixel(&grid, x: 10, y: 8, color: darkPurple)
        }
    }

    private func drawMSCrab(grid: inout [[NSColor]], frame: Int) {
        // Crab-Tank: alien crab mech with energy cannons
        let red = NSColor(red: 0.9, green: 0.2, blue: 0.15, alpha: 1.0)
        let darkRed = NSColor(red: 0.7, green: 0.1, blue: 0.1, alpha: 1.0)
        let brightRed = NSColor(red: 0.95, green: 0.3, blue: 0.2, alpha: 1.0)
        let yellow = NSColor(red: 1.0, green: 0.85, blue: 0.2, alpha: 1.0)
        let black = NSColor.black
        let white = NSColor.white
        let blue = NSColor(red: 0.2, green: 0.5, blue: 0.9, alpha: 1.0)

        // === SHELL (armored, ridged) ===
        for x in 5...10 { setPixel(&grid, x: x, y: 1, color: red) }
        for x in 4...11 { setPixel(&grid, x: x, y: 2, color: red) }
        for x in 4...11 { setPixel(&grid, x: x, y: 3, color: darkRed) }
        for x in 5...10 { setPixel(&grid, x: x, y: 4, color: red) }

        // Shell ridges
        setPixel(&grid, x: 6, y: 1, color: brightRed)
        setPixel(&grid, x: 9, y: 1, color: brightRed)
        setPixel(&grid, x: 5, y: 2, color: brightRed)
        setPixel(&grid, x: 10, y: 2, color: brightRed)
        setPixel(&grid, x: 7, y: 1, color: yellow)
        setPixel(&grid, x: 8, y: 1, color: yellow)

        // === EYES ON STALKS ===
        setPixel(&grid, x: 5, y: 0, color: yellow)
        setPixel(&grid, x: 10, y: 0, color: yellow)
        setPixel(&grid, x: 5, y: 0, color: black)
        setPixel(&grid, x: 10, y: 0, color: black)
        setPixel(&grid, x: 5, y: 0, color: white)
        setPixel(&grid, x: 10, y: 0, color: white)

        // === CANNONS (blue energy) ===
        setPixel(&grid, x: 6, y: 0, color: blue)
        setPixel(&grid, x: 9, y: 0, color: blue)

        // === CLAWS (massive, animated snipping!) ===
        let clawPhase = frame % 4
        if clawPhase == 0 {
            setPixel(&grid, x: 2, y: 2, color: red)
            setPixel(&grid, x: 1, y: 2, color: red)
            setPixel(&grid, x: 2, y: 3, color: darkRed)
            setPixel(&grid, x: 1, y: 1, color: brightRed)
            setPixel(&grid, x: 13, y: 2, color: red)
            setPixel(&grid, x: 14, y: 2, color: red)
            setPixel(&grid, x: 13, y: 3, color: darkRed)
            setPixel(&grid, x: 14, y: 1, color: brightRed)
        } else if clawPhase == 1 {
            setPixel(&grid, x: 2, y: 2, color: red)
            setPixel(&grid, x: 1, y: 2, color: brightRed)
            setPixel(&grid, x: 2, y: 3, color: red)
            setPixel(&grid, x: 13, y: 2, color: red)
            setPixel(&grid, x: 14, y: 2, color: brightRed)
            setPixel(&grid, x: 13, y: 3, color: red)
        } else if clawPhase == 2 {
            setPixel(&grid, x: 2, y: 2, color: brightRed)
            setPixel(&grid, x: 1, y: 2, color: red)
            setPixel(&grid, x: 2, y: 1, color: red)
            setPixel(&grid, x: 13, y: 2, color: brightRed)
            setPixel(&grid, x: 14, y: 2, color: red)
            setPixel(&grid, x: 13, y: 1, color: red)
        } else {
            setPixel(&grid, x: 2, y: 2, color: red)
            setPixel(&grid, x: 1, y: 2, color: red)
            setPixel(&grid, x: 1, y: 1, color: brightRed)
            setPixel(&grid, x: 13, y: 2, color: red)
            setPixel(&grid, x: 14, y: 2, color: red)
            setPixel(&grid, x: 14, y: 1, color: brightRed)
        }

        // === LEGS (6 legs, animated!) ===
        let legPhase = frame % 4
        if legPhase == 0 || legPhase == 2 {
            setPixel(&grid, x: 4, y: 5, color: red)
            setPixel(&grid, x: 5, y: 5, color: red)
            setPixel(&grid, x: 10, y: 5, color: red)
            setPixel(&grid, x: 11, y: 5, color: red)
            setPixel(&grid, x: 4, y: 6, color: darkRed)
            setPixel(&grid, x: 11, y: 6, color: darkRed)
        } else {
            setPixel(&grid, x: 5, y: 5, color: red)
            setPixel(&grid, x: 4, y: 5, color: red)
            setPixel(&grid, x: 11, y: 5, color: red)
            setPixel(&grid, x: 10, y: 5, color: red)
            setPixel(&grid, x: 5, y: 6, color: darkRed)
            setPixel(&grid, x: 10, y: 6, color: darkRed)
        }

        // === ENERGY BOLT (animated!) ===
        let boltPhase = frame % 4
        if boltPhase == 0 {
            setPixel(&grid, x: 15, y: 0, color: blue)
            setPixel(&grid, x: 15, y: 1, color: blue)
        } else if boltPhase == 1 {
            setPixel(&grid, x: 15, y: 0, color: white)
            setPixel(&grid, x: 15, y: 1, color: blue)
        } else if boltPhase == 2 {
            setPixel(&grid, x: 15, y: 1, color: blue)
        }
    }


    // MARK: - Overwatch Characters

    private func drawOWTracer(grid: inout [[NSColor]], frame: Int) {
        let orange = NSColor(red: 1.0, green: 0.6, blue: 0.1, alpha: 1.0)
        let brown = NSColor(red: 0.55, green: 0.35, blue: 0.15, alpha: 1.0)
        let skin = NSColor(red: 1.0, green: 0.8, blue: 0.6, alpha: 1.0)
        let black = NSColor.black
        let blue = NSColor(red: 0.2, green: 0.6, blue: 1.0, alpha: 1.0)

        // Spiky hair
        setPixel(&grid, x: 6, y: 0, color: brown)
        setPixel(&grid, x: 8, y: 0, color: brown)
        setPixel(&grid, x: 7, y: 0, color: brown)

        // Head
        for x in 5...10 { setPixel(&grid, x: x, y: 1, color: brown) }
        for x in 5...10 { setPixel(&grid, x: x, y: 2, color: skin) }

        // Eyes
        setPixel(&grid, x: 6, y: 2, color: black)
        setPixel(&grid, x: 9, y: 2, color: black)

        // Chronal accelerator (glowing blue)
        for x in 5...10 { setPixel(&grid, x: x, y: 3, color: orange) }
        for x in 4...11 { setPixel(&grid, x: x, y: 4, color: orange) }
        for x in 5...10 { setPixel(&grid, x: x, y: 5, color: blue) }

        // Pulse pistols
        setPixel(&grid, x: 3, y: 4, color: NSColor(red: 0.8, green: 0.8, blue: 0.85, alpha: 1.0))
        setPixel(&grid, x: 12, y: 4, color: NSColor(red: 0.8, green: 0.8, blue: 0.85, alpha: 1.0))

        // Legs (running)
        if frame % 2 == 0 {
            setPixel(&grid, x: 5, y: 6, color: orange)
            setPixel(&grid, x: 10, y: 6, color: orange)
        } else {
            setPixel(&grid, x: 6, y: 6, color: orange)
            setPixel(&grid, x: 9, y: 6, color: orange)
        }
    }

    private func drawOWGenji(grid: inout [[NSColor]], frame: Int) {
        let green = NSColor(red: 0.2, green: 0.8, blue: 0.4, alpha: 1.0)
        let darkGreen = NSColor(red: 0.1, green: 0.6, blue: 0.3, alpha: 1.0)
        let silver = NSColor(red: 0.75, green: 0.75, blue: 0.8, alpha: 1.0)
        let black = NSColor.black

        // Head (helmet)
        for x in 5...10 { setPixel(&grid, x: x, y: 0, color: green) }
        for x in 5...10 { setPixel(&grid, x: x, y: 1, color: green) }

        // Visor
        setPixel(&grid, x: 6, y: 0, color: black)
        setPixel(&grid, x: 7, y: 0, color: black)
        setPixel(&grid, x: 9, y: 0, color: black)

        // Body (cyborg)
        for x in 4...11 { setPixel(&grid, x: x, y: 2, color: green) }
        for x in 3...12 { setPixel(&grid, x: x, y: 3, color: darkGreen) }
        for x in 3...12 { setPixel(&grid, x: x, y: 4, color: green) }
        for x in 4...11 { setPixel(&grid, x: x, y: 5, color: darkGreen) }

        // Dragon blade
        setPixel(&grid, x: 13, y: 2, color: silver)
        setPixel(&grid, x: 14, y: 1, color: silver)
        setPixel(&grid, x: 14, y: 2, color: silver)

        // Shuriken
        if frame % 2 == 0 {
            setPixel(&grid, x: 2, y: 3, color: silver)
        }

        // Legs
        setPixel(&grid, x: 5, y: 6, color: green)
        setPixel(&grid, x: 10, y: 6, color: green)
    }

    private func drawOWMercy(grid: inout [[NSColor]], frame: Int) {
        let yellow = NSColor(red: 1.0, green: 0.85, blue: 0.2, alpha: 1.0)
        let white = NSColor.white
        let skin = NSColor(red: 1.0, green: 0.8, blue: 0.6, alpha: 1.0)
        let black = NSColor.black
        let blue = NSColor(red: 0.2, green: 0.6, blue: 1.0, alpha: 1.0)

        // Halo
        setPixel(&grid, x: 7, y: 0, color: yellow)
        setPixel(&grid, x: 8, y: 0, color: yellow)

        // Hair
        for x in 5...10 { setPixel(&grid, x: x, y: 1, color: yellow) }

        // Head
        for x in 5...10 { setPixel(&grid, x: x, y: 2, color: skin) }

        // Eyes
        setPixel(&grid, x: 6, y: 2, color: blue)
        setPixel(&grid, x: 9, y: 2, color: blue)

        // Valkyrie suit
        for x in 5...10 { setPixel(&grid, x: x, y: 3, color: white) }
        for x in 4...11 { setPixel(&grid, x: x, y: 4, color: white) }
        for x in 4...11 { setPixel(&grid, x: x, y: 5, color: white) }

        // Wings (animated)
        if frame % 2 == 0 {
            setPixel(&grid, x: 3, y: 3, color: yellow)
            setPixel(&grid, x: 2, y: 2, color: yellow)
            setPixel(&grid, x: 12, y: 3, color: yellow)
            setPixel(&grid, x: 13, y: 2, color: yellow)
        } else {
            setPixel(&grid, x: 3, y: 4, color: yellow)
            setPixel(&grid, x: 2, y: 3, color: yellow)
            setPixel(&grid, x: 12, y: 4, color: yellow)
            setPixel(&grid, x: 13, y: 3, color: yellow)
        }

        // Caduceus staff
        setPixel(&grid, x: 1, y: 4, color: yellow)
        setPixel(&grid, x: 1, y: 5, color: yellow)

        // Legs
        setPixel(&grid, x: 5, y: 6, color: white)
        setPixel(&grid, x: 10, y: 6, color: white)
    }

    private func drawOWReinhardt(grid: inout [[NSColor]], frame: Int) {
        let gray = NSColor(red: 0.5, green: 0.5, blue: 0.55, alpha: 1.0)
        let yellow = NSColor(red: 1.0, green: 0.85, blue: 0.2, alpha: 1.0)
        let orange = NSColor(red: 1.0, green: 0.6, blue: 0.1, alpha: 1.0)
        let black = NSColor.black
        let blue = NSColor(red: 0.2, green: 0.6, blue: 1.0, alpha: 1.0)

        // Helmet
        for x in 5...10 { setPixel(&grid, x: x, y: 0, color: gray) }
        for x in 4...11 { setPixel(&grid, x: x, y: 1, color: gray) }

        // Visor
        setPixel(&grid, x: 6, y: 0, color: black)
        setPixel(&grid, x: 7, y: 0, color: black)
        setPixel(&grid, x: 9, y: 0, color: black)

        // Massive armor
        for x in 3...12 { setPixel(&grid, x: x, y: 2, color: gray) }
        for x in 2...13 { setPixel(&grid, x: x, y: 3, color: yellow) }
        for x in 2...13 { setPixel(&grid, x: x, y: 4, color: gray) }
        for x in 3...12 { setPixel(&grid, x: x, y: 5, color: gray) }
        for x in 3...12 { setPixel(&grid, x: x, y: 6, color: gray) }

        // Shield (flashing)
        if frame % 2 == 0 {
            for x in 1...2 { setPixel(&grid, x: x, y: 3, color: blue) }
            for x in 1...2 { setPixel(&grid, x: x, y: 4, color: blue) }
        }

        // Rocket hammer
        setPixel(&grid, x: 13, y: 3, color: orange)
        setPixel(&grid, x: 14, y: 2, color: orange)
        setPixel(&grid, x: 14, y: 3, color: orange)

        // Legs
        setPixel(&grid, x: 4, y: 7, color: gray)
        setPixel(&grid, x: 11, y: 7, color: gray)
    }

    private func drawOWDva(grid: inout [[NSColor]], frame: Int) {
        let pink = NSColor(red: 0.85, green: 0.35, blue: 0.6, alpha: 1.0)
        let hotPink = NSColor(red: 0.9, green: 0.2, blue: 0.5, alpha: 1.0)
        let darkPink = NSColor(red: 0.6, green: 0.15, blue: 0.4, alpha: 1.0)
        let green = NSColor(red: 0.2, green: 0.75, blue: 0.5, alpha: 1.0)
        let brightGreen = NSColor(red: 0.3, green: 0.9, blue: 0.6, alpha: 1.0)
        let darkGreen = NSColor(red: 0.1, green: 0.5, blue: 0.35, alpha: 1.0)
        let gray = NSColor(red: 0.6, green: 0.6, blue: 0.65, alpha: 1.0)
        let darkGray = NSColor(red: 0.35, green: 0.35, blue: 0.4, alpha: 1.0)
        let cyan = NSColor(red: 0.3, green: 0.8, blue: 0.9, alpha: 1.0)
        let brightCyan = NSColor(red: 0.4, green: 0.95, blue: 1.0, alpha: 1.0)
        let orange = NSColor(red: 1.0, green: 0.6, blue: 0.1, alpha: 1.0)
        let white = NSColor.white
        let black = NSColor.black

        // Animation offsets
        let armBob = frame % 2 == 0 ? 0 : 1
        let visorGlow = frame % 4 < 2

        // Row 0 - Horn tips
        setPixel(&grid, x: 4, y: 0, color: pink)
        setPixel(&grid, x: 5, y: 0, color: pink)
        setPixel(&grid, x: 10, y: 0, color: pink)
        setPixel(&grid, x: 11, y: 0, color: pink)

        // Row 1 - Horns and head top
        setPixel(&grid, x: 3, y: 1, color: black)
        setPixel(&grid, x: 4, y: 1, color: hotPink)
        setPixel(&grid, x: 5, y: 1, color: hotPink)
        setPixel(&grid, x: 6, y: 1, color: pink)
        setPixel(&grid, x: 7, y: 1, color: pink)
        setPixel(&grid, x: 8, y: 1, color: pink)
        setPixel(&grid, x: 9, y: 1, color: pink)
        setPixel(&grid, x: 10, y: 1, color: hotPink)
        setPixel(&grid, x: 11, y: 1, color: hotPink)
        setPixel(&grid, x: 12, y: 1, color: black)

        // Row 2 - Head with ears
        setPixel(&grid, x: 2, y: 2, color: black)
        setPixel(&grid, x: 3, y: 2, color: hotPink)
        setPixel(&grid, x: 4, y: 2, color: hotPink)
        setPixel(&grid, x: 5, y: 2, color: pink)
        setPixel(&grid, x: 6, y: 2, color: pink)
        setPixel(&grid, x: 7, y: 2, color: pink)
        setPixel(&grid, x: 8, y: 2, color: pink)
        setPixel(&grid, x: 9, y: 2, color: pink)
        setPixel(&grid, x: 10, y: 2, color: hotPink)
        setPixel(&grid, x: 11, y: 2, color: hotPink)
        setPixel(&grid, x: 12, y: 2, color: black)

        // Row 3 - Cockpit visor (glowing)
        let vColor3 = visorGlow ? brightGreen : green
        setPixel(&grid, x: 1, y: 3, color: black)
        setPixel(&grid, x: 2, y: 3, color: hotPink)
        setPixel(&grid, x: 3, y: 3, color: hotPink)
        setPixel(&grid, x: 4, y: 3, color: vColor3)
        setPixel(&grid, x: 5, y: 3, color: vColor3)
        setPixel(&grid, x: 6, y: 3, color: vColor3)
        setPixel(&grid, x: 7, y: 3, color: vColor3)
        setPixel(&grid, x: 8, y: 3, color: vColor3)
        setPixel(&grid, x: 9, y: 3, color: vColor3)
        setPixel(&grid, x: 10, y: 3, color: vColor3)
        setPixel(&grid, x: 11, y: 3, color: hotPink)
        setPixel(&grid, x: 12, y: 3, color: hotPink)
        setPixel(&grid, x: 13, y: 3, color: black)

        // Row 4 - Visor widest (dark green center, glowing edges)
        let vColor4 = visorGlow ? brightGreen : green
        setPixel(&grid, x: 1, y: 4, color: black)
        setPixel(&grid, x: 2, y: 4, color: hotPink)
        setPixel(&grid, x: 3, y: 4, color: vColor4)
        setPixel(&grid, x: 4, y: 4, color: vColor4)
        setPixel(&grid, x: 5, y: 4, color: darkGreen)
        setPixel(&grid, x: 6, y: 4, color: darkGreen)
        setPixel(&grid, x: 7, y: 4, color: darkGreen)
        setPixel(&grid, x: 8, y: 4, color: darkGreen)
        setPixel(&grid, x: 9, y: 4, color: darkGreen)
        setPixel(&grid, x: 10, y: 4, color: vColor4)
        setPixel(&grid, x: 11, y: 4, color: vColor4)
        setPixel(&grid, x: 12, y: 4, color: hotPink)
        setPixel(&grid, x: 13, y: 4, color: black)

        // Row 5 - Lower visor
        let vColor5 = visorGlow ? brightGreen : green
        setPixel(&grid, x: 1, y: 5, color: black)
        setPixel(&grid, x: 2, y: 5, color: hotPink)
        setPixel(&grid, x: 3, y: 5, color: vColor5)
        setPixel(&grid, x: 4, y: 5, color: vColor5)
        setPixel(&grid, x: 5, y: 5, color: vColor5)
        setPixel(&grid, x: 6, y: 5, color: vColor5)
        setPixel(&grid, x: 7, y: 5, color: vColor5)
        setPixel(&grid, x: 8, y: 5, color: vColor5)
        setPixel(&grid, x: 9, y: 5, color: vColor5)
        setPixel(&grid, x: 10, y: 5, color: vColor5)
        setPixel(&grid, x: 11, y: 5, color: vColor5)
        setPixel(&grid, x: 12, y: 5, color: hotPink)
        setPixel(&grid, x: 13, y: 5, color: black)

        // Row 6 - Body
        setPixel(&grid, x: 1, y: 6, color: black)
        setPixel(&grid, x: 2, y: 6, color: pink)
        setPixel(&grid, x: 3, y: 6, color: pink)
        setPixel(&grid, x: 4, y: 6, color: pink)
        setPixel(&grid, x: 5, y: 6, color: pink)
        setPixel(&grid, x: 6, y: 6, color: pink)
        setPixel(&grid, x: 7, y: 6, color: pink)
        setPixel(&grid, x: 8, y: 6, color: pink)
        setPixel(&grid, x: 9, y: 6, color: pink)
        setPixel(&grid, x: 10, y: 6, color: pink)
        setPixel(&grid, x: 11, y: 6, color: pink)
        setPixel(&grid, x: 12, y: 6, color: pink)
        setPixel(&grid, x: 13, y: 6, color: black)

        // Row 7 - Arms with weapons (bobbing)
        let leftArmColor = frame % 4 < 2 ? cyan : brightCyan
        let rightArmColor = frame % 4 >= 2 ? cyan : brightCyan
        setPixel(&grid, x: 0, y: 7 - armBob, color: black)
        setPixel(&grid, x: 1, y: 7 - armBob, color: leftArmColor)
        setPixel(&grid, x: 2, y: 7, color: gray)
        setPixel(&grid, x: 3, y: 7, color: pink)
        setPixel(&grid, x: 4, y: 7, color: pink)
        setPixel(&grid, x: 5, y: 7, color: pink)
        setPixel(&grid, x: 6, y: 7, color: pink)
        setPixel(&grid, x: 7, y: 7, color: pink)
        setPixel(&grid, x: 8, y: 7, color: pink)
        setPixel(&grid, x: 9, y: 7, color: pink)
        setPixel(&grid, x: 10, y: 7, color: pink)
        setPixel(&grid, x: 11, y: 7, color: white)
        setPixel(&grid, x: 12, y: 7, color: gray)
        setPixel(&grid, x: 13, y: 7 - armBob, color: rightArmColor)
        setPixel(&grid, x: 14, y: 7 - armBob, color: black)

        // Row 8 - Lower arms (bobbing)
        setPixel(&grid, x: 0, y: 8 - armBob, color: black)
        setPixel(&grid, x: 1, y: 8 - armBob, color: leftArmColor)
        setPixel(&grid, x: 2, y: 8, color: gray)
        setPixel(&grid, x: 3, y: 8, color: pink)
        setPixel(&grid, x: 4, y: 8, color: pink)
        setPixel(&grid, x: 5, y: 8, color: pink)
        setPixel(&grid, x: 6, y: 8, color: pink)
        setPixel(&grid, x: 7, y: 8, color: pink)
        setPixel(&grid, x: 8, y: 8, color: pink)
        setPixel(&grid, x: 9, y: 8, color: pink)
        setPixel(&grid, x: 10, y: 8, color: white)
        setPixel(&grid, x: 11, y: 8, color: white)
        setPixel(&grid, x: 12, y: 8, color: gray)
        setPixel(&grid, x: 13, y: 8 - armBob, color: rightArmColor)
        setPixel(&grid, x: 14, y: 8 - armBob, color: black)

        // Row 9 - Waist
        setPixel(&grid, x: 1, y: 9, color: black)
        setPixel(&grid, x: 2, y: 9, color: darkPink)
        setPixel(&grid, x: 3, y: 9, color: pink)
        setPixel(&grid, x: 4, y: 9, color: pink)
        setPixel(&grid, x: 5, y: 9, color: pink)
        setPixel(&grid, x: 6, y: 9, color: pink)
        setPixel(&grid, x: 7, y: 9, color: pink)
        setPixel(&grid, x: 8, y: 9, color: pink)
        setPixel(&grid, x: 9, y: 9, color: pink)
        setPixel(&grid, x: 10, y: 9, color: pink)
        setPixel(&grid, x: 11, y: 9, color: pink)
        setPixel(&grid, x: 12, y: 9, color: darkPink)
        setPixel(&grid, x: 13, y: 9, color: black)

        // Row 10 - Upper legs (walking)
        let legShift = frame % 2 == 0 ? 0 : 1
        setPixel(&grid, x: 2 + legShift, y: 10, color: black)
        setPixel(&grid, x: 3 + legShift, y: 10, color: gray)
        setPixel(&grid, x: 4 + legShift, y: 10, color: pink)
        setPixel(&grid, x: 5, y: 10, color: pink)
        setPixel(&grid, x: 6, y: 10, color: darkPink)
        setPixel(&grid, x: 7, y: 10, color: darkPink)
        setPixel(&grid, x: 8, y: 10, color: pink)
        setPixel(&grid, x: 9, y: 10, color: pink)
        setPixel(&grid, x: 10 - legShift, y: 10, color: gray)
        setPixel(&grid, x: 11 - legShift, y: 10, color: black)

        // Row 11 - Knees (walking)
        setPixel(&grid, x: 2 + legShift, y: 11, color: black)
        setPixel(&grid, x: 3 + legShift, y: 11, color: gray)
        setPixel(&grid, x: 4 + legShift, y: 11, color: darkGray)
        setPixel(&grid, x: 5, y: 11, color: darkPink)
        setPixel(&grid, x: 6, y: 11, color: darkPink)
        setPixel(&grid, x: 7, y: 11, color: darkPink)
        setPixel(&grid, x: 8, y: 11, color: darkPink)
        setPixel(&grid, x: 9 - legShift, y: 11, color: darkGray)
        setPixel(&grid, x: 10 - legShift, y: 11, color: gray)
        setPixel(&grid, x: 11 - legShift, y: 11, color: black)

        // Row 12 - Lower legs (walking)
        setPixel(&grid, x: 2 + legShift, y: 12, color: black)
        setPixel(&grid, x: 3 + legShift, y: 12, color: pink)
        setPixel(&grid, x: 4 + legShift, y: 12, color: pink)
        setPixel(&grid, x: 5, y: 12, color: darkPink)
        setPixel(&grid, x: 6, y: 12, color: pink)
        setPixel(&grid, x: 7, y: 12, color: pink)
        setPixel(&grid, x: 8, y: 12, color: darkPink)
        setPixel(&grid, x: 9 - legShift, y: 12, color: pink)
        setPixel(&grid, x: 10 - legShift, y: 12, color: black)

        // Row 13 - Feet (walking)
        setPixel(&grid, x: 1 + legShift, y: 13, color: black)
        setPixel(&grid, x: 2 + legShift, y: 13, color: darkGray)
        setPixel(&grid, x: 3 + legShift, y: 13, color: gray)
        setPixel(&grid, x: 4 + legShift, y: 13, color: gray)
        setPixel(&grid, x: 5, y: 13, color: black)
        setPixel(&grid, x: 8, y: 13, color: black)
        setPixel(&grid, x: 9 - legShift, y: 13, color: gray)
        setPixel(&grid, x: 10 - legShift, y: 13, color: gray)
        setPixel(&grid, x: 11 - legShift, y: 13, color: darkGray)
        setPixel(&grid, x: 12 - legShift, y: 13, color: black)
    }

    private func drawOWWinston(grid: inout [[NSColor]], frame: Int) {
        let gray = NSColor(red: 0.55, green: 0.55, blue: 0.6, alpha: 1.0)
        let darkGray = NSColor(red: 0.35, green: 0.35, blue: 0.4, alpha: 1.0)
        let blue = NSColor(red: 0.2, green: 0.6, blue: 1.0, alpha: 1.0)
        let black = NSColor.black
        let yellow = NSColor(red: 1.0, green: 0.85, blue: 0.2, alpha: 1.0)

        // Head (gorilla)
        for x in 4...11 { setPixel(&grid, x: x, y: 0, color: gray) }
        for x in 4...11 { setPixel(&grid, x: x, y: 1, color: gray) }

        // Eyes
        setPixel(&grid, x: 6, y: 0, color: yellow)
        setPixel(&grid, x: 9, y: 0, color: yellow)
        setPixel(&grid, x: 6, y: 0, color: black)
        setPixel(&grid, x: 9, y: 0, color: black)

        // Glasses
        setPixel(&grid, x: 5, y: 0, color: blue)
        setPixel(&grid, x: 10, y: 0, color: blue)

        // Massive body
        for x in 3...12 { setPixel(&grid, x: x, y: 2, color: gray) }
        for x in 2...13 { setPixel(&grid, x: x, y: 3, color: gray) }
        for x in 2...13 { setPixel(&grid, x: x, y: 4, color: darkGray) }
        for x in 3...12 { setPixel(&grid, x: x, y: 5, color: gray) }

        // Armor
        for x in 5...10 { setPixel(&grid, x: x, y: 3, color: blue) }

        // Jump pack
        setPixel(&grid, x: 7, y: 2, color: blue)
        setPixel(&grid, x: 8, y: 2, color: blue)

        // Arms (massive)
        setPixel(&grid, x: 1, y: 3, color: gray)
        setPixel(&grid, x: 14, y: 3, color: gray)

        // Legs
        setPixel(&grid, x: 4, y: 6, color: gray)
        setPixel(&grid, x: 11, y: 6, color: gray)
    }

    private func drawOWSoldier76(grid: inout [[NSColor]], frame: Int) {
        let gray = NSColor(red: 0.4, green: 0.4, blue: 0.45, alpha: 1.0)
        let blue = NSColor(red: 0.15, green: 0.3, blue: 0.85, alpha: 1.0)
        let skin = NSColor(red: 1.0, green: 0.8, blue: 0.6, alpha: 1.0)
        let black = NSColor.black
        let red = NSColor(red: 0.9, green: 0.15, blue: 0.15, alpha: 1.0)

        // Gray hair
        for x in 5...10 { setPixel(&grid, x: x, y: 0, color: gray) }

        // Head
        for x in 5...10 { setPixel(&grid, x: x, y: 1, color: skin) }

        // Visor
        setPixel(&grid, x: 6, y: 1, color: red)
        setPixel(&grid, x: 7, y: 1, color: red)
        setPixel(&grid, x: 8, y: 1, color: red)
        setPixel(&grid, x: 9, y: 1, color: red)

        // Tactical vest
        for x in 4...11 { setPixel(&grid, x: x, y: 2, color: blue) }
        for x in 3...12 { setPixel(&grid, x: x, y: 3, color: gray) }
        for x in 3...12 { setPixel(&grid, x: x, y: 4, color: gray) }
        for x in 4...11 { setPixel(&grid, x: x, y: 5, color: blue) }

        // Heavy pulse rifle
        setPixel(&grid, x: 13, y: 3, color: gray)
        setPixel(&grid, x: 14, y: 3, color: gray)

        // Sprinting
        if frame % 2 == 0 {
            setPixel(&grid, x: 4, y: 6, color: blue)
            setPixel(&grid, x: 11, y: 6, color: blue)
        } else {
            setPixel(&grid, x: 5, y: 6, color: blue)
            setPixel(&grid, x: 10, y: 6, color: blue)
        }
    }

    private func drawOWReaper(grid: inout [[NSColor]], frame: Int) {
        let black = NSColor(red: 0.1, green: 0.1, blue: 0.12, alpha: 1.0)
        let darkGray = NSColor(red: 0.25, green: 0.25, blue: 0.28, alpha: 1.0)
        let red = NSColor(red: 0.9, green: 0.15, blue: 0.15, alpha: 1.0)
        let white = NSColor.white

        // Hood
        for x in 4...11 { setPixel(&grid, x: x, y: 0, color: black) }
        for x in 4...11 { setPixel(&grid, x: x, y: 1, color: black) }

        // Mask
        setPixel(&grid, x: 6, y: 1, color: white)
        setPixel(&grid, x: 9, y: 1, color: white)
        setPixel(&grid, x: 6, y: 1, color: black)
        setPixel(&grid, x: 9, y: 1, color: black)

        // Body (coat)
        for x in 3...12 { setPixel(&grid, x: x, y: 2, color: black) }
        for x in 2...13 { setPixel(&grid, x: x, y: 3, color: darkGray) }
        for x in 2...13 { setPixel(&grid, x: x, y: 4, color: black) }
        for x in 3...12 { setPixel(&grid, x: x, y: 5, color: darkGray) }

        // Shotguns
        setPixel(&grid, x: 1, y: 3, color: darkGray)
        setPixel(&grid, x: 14, y: 3, color: darkGray)

        // Wraith form (smoke effect)
        if frame % 2 == 0 {
            setPixel(&grid, x: 3, y: 6, color: darkGray)
            setPixel(&grid, x: 12, y: 6, color: darkGray)
        }

        // Legs
        setPixel(&grid, x: 5, y: 6, color: black)
        setPixel(&grid, x: 10, y: 6, color: black)
    }

    private func drawOWWidowmaker(grid: inout [[NSColor]], frame: Int) {
        let purple = NSColor(red: 0.4, green: 0.2, blue: 0.6, alpha: 1.0)
        let blue = NSColor(red: 0.3, green: 0.5, blue: 0.8, alpha: 1.0)
        let skin = NSColor(red: 0.6, green: 0.6, blue: 0.75, alpha: 1.0)
        let black = NSColor.black
        let red = NSColor(red: 0.9, green: 0.15, blue: 0.15, alpha: 1.0)

        // Hair
        for x in 5...10 { setPixel(&grid, x: x, y: 0, color: purple) }

        // Head
        for x in 5...10 { setPixel(&grid, x: x, y: 1, color: skin) }

        // Eye (one eye)
        setPixel(&grid, x: 7, y: 1, color: red)
        setPixel(&grid, x: 8, y: 1, color: black)

        // Body suit
        for x in 4...11 { setPixel(&grid, x: x, y: 2, color: purple) }
        for x in 3...12 { setPixel(&grid, x: x, y: 3, color: purple) }
        for x in 3...12 { setPixel(&grid, x: x, y: 4, color: blue) }
        for x in 4...11 { setPixel(&grid, x: x, y: 5, color: purple) }

        // Sniper rifle
        setPixel(&grid, x: 13, y: 2, color: black)
        setPixel(&grid, x: 14, y: 1, color: black)
        setPixel(&grid, x: 14, y: 2, color: black)

        // Legs
        setPixel(&grid, x: 5, y: 6, color: purple)
        setPixel(&grid, x: 10, y: 6, color: purple)
    }

    private func drawOWCassidy(grid: inout [[NSColor]], frame: Int) {
        let brown = NSColor(red: 0.55, green: 0.35, blue: 0.15, alpha: 1.0)
        let darkBrown = NSColor(red: 0.4, green: 0.25, blue: 0.1, alpha: 1.0)
        let skin = NSColor(red: 1.0, green: 0.8, blue: 0.6, alpha: 1.0)
        let black = NSColor.black
        let gray = NSColor(red: 0.5, green: 0.5, blue: 0.55, alpha: 1.0)
        let red = NSColor(red: 0.9, green: 0.15, blue: 0.15, alpha: 1.0)

        // Hat
        for x in 4...11 { setPixel(&grid, x: x, y: 0, color: brown) }
        for x in 3...12 { setPixel(&grid, x: x, y: 1, color: brown) }

        // Head
        for x in 5...10 { setPixel(&grid, x: x, y: 2, color: skin) }

        // Eyes
        setPixel(&grid, x: 6, y: 2, color: black)
        setPixel(&grid, x: 9, y: 2, color: black)

        // Scarf
        for x in 5...10 { setPixel(&grid, x: x, y: 3, color: red) }

        // Jacket
        for x in 4...11 { setPixel(&grid, x: x, y: 4, color: brown) }
        for x in 3...12 { setPixel(&grid, x: x, y: 5, color: darkBrown) }

        // Peacekeeper
        setPixel(&grid, x: 13, y: 4, color: gray)

        // Legs
        setPixel(&grid, x: 5, y: 6, color: brown)
        setPixel(&grid, x: 10, y: 6, color: brown)
    }

    private func drawOWPharah(grid: inout [[NSColor]], frame: Int) {
        let blue = NSColor(red: 0.15, green: 0.3, blue: 0.85, alpha: 1.0)
        let darkBlue = NSColor(red: 0.1, green: 0.2, blue: 0.6, alpha: 1.0)
        let gold = NSColor(red: 1.0, green: 0.85, blue: 0.2, alpha: 1.0)
        let skin = NSColor(red: 1.0, green: 0.8, blue: 0.6, alpha: 1.0)
        let black = NSColor.black
        let gray = NSColor(red: 0.5, green: 0.5, blue: 0.55, alpha: 1.0)

        // Helmet
        for x in 5...10 { setPixel(&grid, x: x, y: 0, color: blue) }
        for x in 5...10 { setPixel(&grid, x: x, y: 1, color: blue) }

        // Visor
        setPixel(&grid, x: 6, y: 0, color: gold)
        setPixel(&grid, x: 7, y: 0, color: gold)
        setPixel(&grid, x: 9, y: 0, color: gold)

        // Raptora suit
        for x in 3...12 { setPixel(&grid, x: x, y: 2, color: blue) }
        for x in 2...13 { setPixel(&grid, x: x, y: 3, color: darkBlue) }
        for x in 2...13 { setPixel(&grid, x: x, y: 4, color: blue) }
        for x in 3...12 { setPixel(&grid, x: x, y: 5, color: darkBlue) }

        // Jump jet (flying)
        if frame % 2 == 0 {
            setPixel(&grid, x: 4, y: 6, color: gold)
            setPixel(&grid, x: 11, y: 6, color: gold)
        } else {
            setPixel(&grid, x: 3, y: 6, color: gold)
            setPixel(&grid, x: 12, y: 6, color: gold)
        }

        // Rocket launcher
        setPixel(&grid, x: 14, y: 3, color: gray)
    }

    private func drawOWLucio(grid: inout [[NSColor]], frame: Int) {
        let green = NSColor(red: 0.2, green: 0.8, blue: 0.4, alpha: 1.0)
        let yellow = NSColor(red: 1.0, green: 0.85, blue: 0.2, alpha: 1.0)
        let skin = NSColor(red: 0.6, green: 0.4, blue: 0.2, alpha: 1.0)
        let black = NSColor.black
        let brown = NSColor(red: 0.55, green: 0.35, blue: 0.15, alpha: 1.0)

        // Hair
        for x in 4...11 { setPixel(&grid, x: x, y: 0, color: brown) }
        for x in 4...11 { setPixel(&grid, x: x, y: 1, color: brown) }

        // Head
        for x in 5...10 { setPixel(&grid, x: x, y: 2, color: skin) }

        // Eyes
        setPixel(&grid, x: 6, y: 2, color: green)
        setPixel(&grid, x: 9, y: 2, color: green)

        // Headphones
        setPixel(&grid, x: 4, y: 1, color: green)
        setPixel(&grid, x: 11, y: 1, color: green)

        // Body
        for x in 4...11 { setPixel(&grid, x: x, y: 3, color: green) }
        for x in 3...12 { setPixel(&grid, x: x, y: 4, color: green) }
        for x in 3...12 { setPixel(&grid, x: x, y: 5, color: yellow) }
        for x in 4...11 { setPixel(&grid, x: x, y: 6, color: green) }

        // Sound wave (animated)
        if frame % 2 == 0 {
            setPixel(&grid, x: 1, y: 3, color: green)
            setPixel(&grid, x: 14, y: 3, color: green)
        }

        // Legs
        setPixel(&grid, x: 5, y: 7, color: green)
        setPixel(&grid, x: 10, y: 7, color: green)
    }

    private func drawOWAna(grid: inout [[NSColor]], frame: Int) {
        let blue = NSColor(red: 0.15, green: 0.3, blue: 0.85, alpha: 1.0)
        let white = NSColor.white
        let skin = NSColor(red: 1.0, green: 0.8, blue: 0.6, alpha: 1.0)
        let black = NSColor.black
        let brown = NSColor(red: 0.55, green: 0.35, blue: 0.15, alpha: 1.0)

        // Hair
        for x in 5...10 { setPixel(&grid, x: x, y: 0, color: white) }

        // Head
        for x in 5...10 { setPixel(&grid, x: x, y: 1, color: skin) }

        // Eye patch
        setPixel(&grid, x: 9, y: 1, color: black)

        // Eye
        setPixel(&grid, x: 6, y: 1, color: blue)

        // Body
        for x in 4...11 { setPixel(&grid, x: x, y: 2, color: blue) }
        for x in 3...12 { setPixel(&grid, x: x, y: 3, color: blue) }
        for x in 3...12 { setPixel(&grid, x: x, y: 4, color: white) }
        for x in 4...11 { setPixel(&grid, x: x, y: 5, color: blue) }

        // Biotic rifle
        setPixel(&grid, x: 13, y: 3, color: brown)
        setPixel(&grid, x: 14, y: 2, color: brown)

        // Sleep dart (animation)
        if frame % 2 == 0 {
            setPixel(&grid, x: 14, y: 3, color: blue)
        }

        // Legs
        setPixel(&grid, x: 5, y: 6, color: blue)
        setPixel(&grid, x: 10, y: 6, color: blue)
    }

    private func drawOWZarya(grid: inout [[NSColor]], frame: Int) {
        let pink = NSColor(red: 1.0, green: 0.4, blue: 0.6, alpha: 1.0)
        let darkPink = NSColor(red: 0.8, green: 0.2, blue: 0.4, alpha: 1.0)
        let skin = NSColor(red: 1.0, green: 0.8, blue: 0.6, alpha: 1.0)
        let black = NSColor.black
        let gray = NSColor(red: 0.5, green: 0.5, blue: 0.55, alpha: 1.0)

        // Short pink hair
        for x in 5...10 { setPixel(&grid, x: x, y: 0, color: pink) }

        // Head
        for x in 5...10 { setPixel(&grid, x: x, y: 1, color: skin) }

        // Eyes
        setPixel(&grid, x: 6, y: 1, color: black)
        setPixel(&grid, x: 9, y: 1, color: black)

        // Massive armor
        for x in 2...13 { setPixel(&grid, x: x, y: 2, color: gray) }
        for x in 1...14 { setPixel(&grid, x: x, y: 3, color: gray) }
        for x in 1...14 { setPixel(&grid, x: x, y: 4, color: pink) }
        for x in 2...13 { setPixel(&grid, x: x, y: 5, color: gray) }

        // Particle cannon
        setPixel(&grid, x: 0, y: 3, color: pink)
        setPixel(&grid, x: 15, y: 3, color: pink)

        // Legs
        setPixel(&grid, x: 4, y: 6, color: gray)
        setPixel(&grid, x: 11, y: 6, color: gray)
    }

    private func drawOWMei(grid: inout [[NSColor]], frame: Int) {
        let blue = NSColor(red: 0.2, green: 0.5, blue: 0.9, alpha: 1.0)
        let darkBlue = NSColor(red: 0.1, green: 0.3, blue: 0.7, alpha: 1.0)
        let skin = NSColor(red: 1.0, green: 0.8, blue: 0.6, alpha: 1.0)
        let black = NSColor.black
        let brown = NSColor(red: 0.55, green: 0.35, blue: 0.15, alpha: 1.0)

        // Hair
        for x in 4...11 { setPixel(&grid, x: x, y: 0, color: brown) }
        for x in 4...11 { setPixel(&grid, x: x, y: 1, color: brown) }

        // Head
        for x in 5...10 { setPixel(&grid, x: x, y: 2, color: skin) }

        // Glasses
        setPixel(&grid, x: 6, y: 2, color: black)
        setPixel(&grid, x: 7, y: 2, color: black)
        setPixel(&grid, x: 9, y: 2, color: black)

        // Coat
        for x in 4...11 { setPixel(&grid, x: x, y: 3, color: blue) }
        for x in 3...12 { setPixel(&grid, x: x, y: 4, color: darkBlue) }
        for x in 3...12 { setPixel(&grid, x: x, y: 5, color: blue) }
        for x in 4...11 { setPixel(&grid, x: x, y: 6, color: darkBlue) }

        // Endothermic blaster
        setPixel(&grid, x: 13, y: 4, color: NSColor(red: 0.5, green: 0.8, blue: 1.0, alpha: 1.0))

        // Ice wall (animation)
        if frame % 2 == 0 {
            setPixel(&grid, x: 14, y: 3, color: NSColor(red: 0.7, green: 0.9, blue: 1.0, alpha: 1.0))
        }

        // Legs
        setPixel(&grid, x: 5, y: 7, color: blue)
        setPixel(&grid, x: 10, y: 7, color: blue)
    }

    private func drawOWSymmetra(grid: inout [[NSColor]], frame: Int) {
        let blue = NSColor(red: 0.2, green: 0.6, blue: 1.0, alpha: 1.0)
        let white = NSColor.white
        let skin = NSColor(red: 0.8, green: 0.6, blue: 0.4, alpha: 1.0)
        let black = NSColor.black
        let yellow = NSColor(red: 1.0, green: 0.85, blue: 0.2, alpha: 1.0)

        // Hair
        for x in 5...10 { setPixel(&grid, x: x, y: 0, color: blue) }

        // Head
        for x in 5...10 { setPixel(&grid, x: x, y: 1, color: skin) }

        // Eyes
        setPixel(&grid, x: 6, y: 1, color: blue)
        setPixel(&grid, x: 9, y: 1, color: blue)

        // Dress
        for x in 4...11 { setPixel(&grid, x: x, y: 2, color: white) }
        for x in 3...12 { setPixel(&grid, x: x, y: 3, color: white) }
        for x in 3...12 { setPixel(&grid, x: x, y: 4, color: blue) }
        for x in 4...11 { setPixel(&grid, x: x, y: 5, color: white) }

        // Hard-light projector
        setPixel(&grid, x: 13, y: 3, color: yellow)
        setPixel(&grid, x: 14, y: 2, color: yellow)

        // Turret (animation)
        if frame % 2 == 0 {
            setPixel(&grid, x: 14, y: 3, color: blue)
        }

        // Legs
        setPixel(&grid, x: 5, y: 6, color: white)
        setPixel(&grid, x: 10, y: 6, color: white)
    }

    // MARK: - Kirby Characters

    private func drawKirbyKirby(grid: inout [[NSColor]], frame: Int) {
        let pink = NSColor(red: 1.0, green: 0.55, blue: 0.65, alpha: 1.0)
        let darkPink = NSColor(red: 0.9, green: 0.35, blue: 0.5, alpha: 1.0)
        let red = NSColor(red: 0.9, green: 0.15, blue: 0.15, alpha: 1.0)
        let black = NSColor.black
        let white = NSColor.white
        let anim = frame % 2

        // Round body (pink with black outline)
        for x in 5...10 { setPixel(&grid, x: x, y: 1, color: black) }
        for x in 4...11 { setPixel(&grid, x: x, y: 2, color: black) }
        for x in 3...12 { setPixel(&grid, x: x, y: 3, color: black) }
        for x in 3...12 { setPixel(&grid, x: x, y: 4, color: black) }
        for x in 4...11 { setPixel(&grid, x: x, y: 5, color: black) }
        for x in 5...10 { setPixel(&grid, x: x, y: 6, color: black) }
        // Fill
        for x in 5...10 { setPixel(&grid, x: x, y: 1, color: pink) }
        for x in 5...10 { setPixel(&grid, x: x, y: 2, color: pink) }
        for x in 4...11 { setPixel(&grid, x: x, y: 2, color: pink) }
        for x in 4...11 { setPixel(&grid, x: x, y: 3, color: pink) }
        for x in 4...11 { setPixel(&grid, x: x, y: 4, color: pink) }
        for x in 4...11 { setPixel(&grid, x: x, y: 5, color: pink) }
        for x in 5...10 { setPixel(&grid, x: x, y: 6, color: pink) }

        // Eyes (big, black with white highlight)
        setPixel(&grid, x: 6, y: 3, color: black); setPixel(&grid, x: 6, y: 4, color: black)
        setPixel(&grid, x: 9, y: 3, color: black); setPixel(&grid, x: 9, y: 4, color: black)
        setPixel(&grid, x: 6, y: 3, color: white); setPixel(&grid, x: 9, y: 3, color: white)

        // Cheeks (pink, subtle)
        setPixel(&grid, x: 5, y: 4, color: darkPink)
        setPixel(&grid, x: 10, y: 4, color: darkPink)

        // Mouth (small smile)
        setPixel(&grid, x: 7, y: 5, color: black); setPixel(&grid, x: 8, y: 5, color: black)

        // Feet (red, animated)
        if anim == 0 {
            setPixel(&grid, x: 4, y: 7, color: red); setPixel(&grid, x: 5, y: 7, color: red)
            setPixel(&grid, x: 10, y: 7, color: red); setPixel(&grid, x: 11, y: 7, color: red)
        } else {
            setPixel(&grid, x: 3, y: 7, color: red); setPixel(&grid, x: 4, y: 7, color: red)
            setPixel(&grid, x: 11, y: 7, color: red); setPixel(&grid, x: 12, y: 7, color: red)
        }
    }

    private func drawKirbyKingDedede(grid: inout [[NSColor]], frame: Int) {
        // King Dedede - exact perler bead pixel art: large, round, black outlines
        let blue = NSColor(red: 0.15, green: 0.35, blue: 0.85, alpha: 1.0)
        let darkBlue = NSColor(red: 0.1, green: 0.25, blue: 0.65, alpha: 1.0)
        let red = NSColor(red: 0.9, green: 0.15, blue: 0.12, alpha: 1.0)
        let darkRed = NSColor(red: 0.7, green: 0.08, blue: 0.08, alpha: 1.0)
        let yellow = NSColor(red: 1.0, green: 0.85, blue: 0.2, alpha: 1.0)
        let darkYellow = NSColor(red: 0.85, green: 0.7, blue: 0.15, alpha: 1.0)
        let white = NSColor.white
        let offWhite = NSColor(red: 0.92, green: 0.92, blue: 0.92, alpha: 1.0)
        let black = NSColor.black
        let orange = NSColor(red: 1.0, green: 0.65, blue: 0.15, alpha: 1.0)

        // ====== CROWN (gold with red jewel) ======
        // Row 0 - crown top
        setPixel(&grid, x: 8, y: 0, color: black)
        setPixel(&grid, x: 9, y: 0, color: black)
        setPixel(&grid, x: 10, y: 0, color: yellow)
        setPixel(&grid, x: 11, y: 0, color: yellow)
        setPixel(&grid, x: 12, y: 0, color: yellow)
        setPixel(&grid, x: 13, y: 0, color: black)
        // Row 1 - crown middle
        setPixel(&grid, x: 7, y: 1, color: black)
        setPixel(&grid, x: 8, y: 1, color: yellow)
        setPixel(&grid, x: 9, y: 1, color: yellow)
        setPixel(&grid, x: 10, y: 1, color: red)
        setPixel(&grid, x: 11, y: 1, color: red)
        setPixel(&grid, x: 12, y: 1, color: yellow)
        setPixel(&grid, x: 13, y: 1, color: yellow)
        setPixel(&grid, x: 14, y: 1, color: black)
        // Row 2 - crown base
        setPixel(&grid, x: 6, y: 2, color: black)
        setPixel(&grid, x: 7, y: 2, color: yellow)
        setPixel(&grid, x: 8, y: 2, color: yellow)
        setPixel(&grid, x: 9, y: 2, color: yellow)
        setPixel(&grid, x: 10, y: 2, color: yellow)
        setPixel(&grid, x: 11, y: 2, color: yellow)
        setPixel(&grid, x: 12, y: 2, color: yellow)
        setPixel(&grid, x: 13, y: 2, color: yellow)
        setPixel(&grid, x: 14, y: 2, color: yellow)
        setPixel(&grid, x: 15, y: 2, color: black)

        // ====== WHITE FACE (with black outlines) ======
        // Row 3 - face top
        setPixel(&grid, x: 5, y: 3, color: black)
        setPixel(&grid, x: 6, y: 3, color: white)
        setPixel(&grid, x: 7, y: 3, color: white)
        setPixel(&grid, x: 8, y: 3, color: white)
        setPixel(&grid, x: 9, y: 3, color: white)
        setPixel(&grid, x: 10, y: 3, color: white)
        setPixel(&grid, x: 11, y: 3, color: white)
        setPixel(&grid, x: 12, y: 3, color: white)
        setPixel(&grid, x: 13, y: 3, color: white)
        setPixel(&grid, x: 14, y: 3, color: white)
        setPixel(&grid, x: 15, y: 3, color: white)
        setPixel(&grid, x: 16, y: 3, color: black)
        // Row 4 - face with eyes
        setPixel(&grid, x: 4, y: 4, color: black)
        setPixel(&grid, x: 5, y: 4, color: white)
        setPixel(&grid, x: 6, y: 4, color: white)
        setPixel(&grid, x: 7, y: 4, color: blue)
        setPixel(&grid, x: 8, y: 4, color: white)
        setPixel(&grid, x: 9, y: 4, color: white)
        setPixel(&grid, x: 10, y: 4, color: white)
        setPixel(&grid, x: 11, y: 4, color: white)
        setPixel(&grid, x: 12, y: 4, color: blue)
        setPixel(&grid, x: 13, y: 4, color: white)
        setPixel(&grid, x: 14, y: 4, color: white)
        setPixel(&grid, x: 15, y: 4, color: white)
        setPixel(&grid, x: 16, y: 4, color: black)
        // Row 5 - face with beak
        setPixel(&grid, x: 4, y: 5, color: black)
        setPixel(&grid, x: 5, y: 5, color: white)
        setPixel(&grid, x: 6, y: 5, color: white)
        setPixel(&grid, x: 7, y: 5, color: orange)
        setPixel(&grid, x: 8, y: 5, color: orange)
        setPixel(&grid, x: 9, y: 5, color: orange)
        setPixel(&grid, x: 10, y: 5, color: orange)
        setPixel(&grid, x: 11, y: 5, color: orange)
        setPixel(&grid, x: 12, y: 5, color: orange)
        setPixel(&grid, x: 13, y: 5, color: white)
        setPixel(&grid, x: 14, y: 5, color: white)
        setPixel(&grid, x: 15, y: 5, color: white)
        setPixel(&grid, x: 16, y: 5, color: black)
        // Row 6 - beak bottom
        setPixel(&grid, x: 4, y: 6, color: black)
        setPixel(&grid, x: 5, y: 6, color: white)
        setPixel(&grid, x: 6, y: 6, color: orange)
        setPixel(&grid, x: 7, y: 6, color: orange)
        setPixel(&grid, x: 8, y: 6, color: orange)
        setPixel(&grid, x: 9, y: 6, color: orange)
        setPixel(&grid, x: 10, y: 6, color: orange)
        setPixel(&grid, x: 11, y: 6, color: orange)
        setPixel(&grid, x: 12, y: 6, color: orange)
        setPixel(&grid, x: 13, y: 6, color: orange)
        setPixel(&grid, x: 14, y: 6, color: white)
        setPixel(&grid, x: 15, y: 6, color: white)
        setPixel(&grid, x: 16, y: 6, color: black)

        // ====== WHITE FUR COLLAR ======
        // Row 7 - fur collar
        setPixel(&grid, x: 3, y: 7, color: black)
        setPixel(&grid, x: 4, y: 7, color: white)
        setPixel(&grid, x: 5, y: 7, color: white)
        setPixel(&grid, x: 6, y: 7, color: white)
        setPixel(&grid, x: 7, y: 7, color: white)
        setPixel(&grid, x: 8, y: 7, color: white)
        setPixel(&grid, x: 9, y: 7, color: white)
        setPixel(&grid, x: 10, y: 7, color: white)
        setPixel(&grid, x: 11, y: 7, color: white)
        setPixel(&grid, x: 12, y: 7, color: white)
        setPixel(&grid, x: 13, y: 7, color: white)
        setPixel(&grid, x: 14, y: 7, color: white)
        setPixel(&grid, x: 15, y: 7, color: white)
        setPixel(&grid, x: 16, y: 7, color: white)
        setPixel(&grid, x: 17, y: 7, color: black)

        // ====== RED ROBE with BLUE BELLY ======
        // Row 8 - robe top
        setPixel(&grid, x: 3, y: 8, color: black)
        setPixel(&grid, x: 4, y: 8, color: red)
        setPixel(&grid, x: 5, y: 8, color: red)
        setPixel(&grid, x: 6, y: 8, color: red)
        setPixel(&grid, x: 7, y: 8, color: blue)
        setPixel(&grid, x: 8, y: 8, color: blue)
        setPixel(&grid, x: 9, y: 8, color: blue)
        setPixel(&grid, x: 10, y: 8, color: blue)
        setPixel(&grid, x: 11, y: 8, color: blue)
        setPixel(&grid, x: 12, y: 8, color: red)
        setPixel(&grid, x: 13, y: 8, color: red)
        setPixel(&grid, x: 14, y: 8, color: red)
        setPixel(&grid, x: 15, y: 8, color: red)
        setPixel(&grid, x: 16, y: 8, color: red)
        setPixel(&grid, x: 17, y: 8, color: black)
        // Row 9
        setPixel(&grid, x: 2, y: 9, color: black)
        setPixel(&grid, x: 3, y: 9, color: red)
        setPixel(&grid, x: 4, y: 9, color: red)
        setPixel(&grid, x: 5, y: 9, color: red)
        setPixel(&grid, x: 6, y: 9, color: blue)
        setPixel(&grid, x: 7, y: 9, color: blue)
        setPixel(&grid, x: 8, y: 9, color: blue)
        setPixel(&grid, x: 9, y: 9, color: blue)
        setPixel(&grid, x: 10, y: 9, color: blue)
        setPixel(&grid, x: 11, y: 9, color: blue)
        setPixel(&grid, x: 12, y: 9, color: blue)
        setPixel(&grid, x: 13, y: 9, color: red)
        setPixel(&grid, x: 14, y: 9, color: red)
        setPixel(&grid, x: 15, y: 9, color: red)
        setPixel(&grid, x: 16, y: 9, color: red)
        setPixel(&grid, x: 17, y: 9, color: red)
        setPixel(&grid, x: 18, y: 9, color: black)
        // Row 10
        setPixel(&grid, x: 2, y: 10, color: black)
        setPixel(&grid, x: 3, y: 10, color: red)
        setPixel(&grid, x: 4, y: 10, color: red)
        setPixel(&grid, x: 5, y: 10, color: blue)
        setPixel(&grid, x: 6, y: 10, color: blue)
        setPixel(&grid, x: 7, y: 10, color: blue)
        setPixel(&grid, x: 8, y: 10, color: blue)
        setPixel(&grid, x: 9, y: 10, color: blue)
        setPixel(&grid, x: 10, y: 10, color: blue)
        setPixel(&grid, x: 11, y: 10, color: blue)
        setPixel(&grid, x: 12, y: 10, color: blue)
        setPixel(&grid, x: 13, y: 10, color: blue)
        setPixel(&grid, x: 14, y: 10, color: red)
        setPixel(&grid, x: 15, y: 10, color: red)
        setPixel(&grid, x: 16, y: 10, color: red)
        setPixel(&grid, x: 17, y: 10, color: red)
        setPixel(&grid, x: 18, y: 10, color: black)
        // Row 11
        setPixel(&grid, x: 2, y: 11, color: black)
        setPixel(&grid, x: 3, y: 11, color: red)
        setPixel(&grid, x: 4, y: 11, color: red)
        setPixel(&grid, x: 5, y: 11, color: blue)
        setPixel(&grid, x: 6, y: 11, color: blue)
        setPixel(&grid, x: 7, y: 11, color: blue)
        setPixel(&grid, x: 8, y: 11, color: blue)
        setPixel(&grid, x: 9, y: 11, color: blue)
        setPixel(&grid, x: 10, y: 11, color: blue)
        setPixel(&grid, x: 11, y: 11, color: blue)
        setPixel(&grid, x: 12, y: 11, color: blue)
        setPixel(&grid, x: 13, y: 11, color: blue)
        setPixel(&grid, x: 14, y: 11, color: red)
        setPixel(&grid, x: 15, y: 11, color: red)
        setPixel(&grid, x: 16, y: 11, color: red)
        setPixel(&grid, x: 17, y: 11, color: red)
        setPixel(&grid, x: 18, y: 11, color: black)

        // ====== YELLOW GLOVES/HANDS (on sides) ======
        // Left hand
        setPixel(&grid, x: 1, y: 8, color: black)
        setPixel(&grid, x: 1, y: 9, color: yellow)
        setPixel(&grid, x: 1, y: 10, color: yellow)
        setPixel(&grid, x: 1, y: 11, color: yellow)
        setPixel(&grid, x: 2, y: 8, color: yellow)
        setPixel(&grid, x: 2, y: 9, color: yellow)
        setPixel(&grid, x: 2, y: 10, color: yellow)
        // Right hand
        setPixel(&grid, x: 18, y: 8, color: yellow)
        setPixel(&grid, x: 19, y: 8, color: black)
        setPixel(&grid, x: 19, y: 9, color: yellow)
        setPixel(&grid, x: 19, y: 10, color: yellow)
        setPixel(&grid, x: 19, y: 11, color: yellow)
        setPixel(&grid, x: 18, y: 9, color: yellow)
        setPixel(&grid, x: 18, y: 10, color: yellow)

        // ====== ROBE BOTTOM with WHITE FUR TRIM ======
        // Row 12
        setPixel(&grid, x: 2, y: 12, color: black)
        setPixel(&grid, x: 3, y: 12, color: red)
        setPixel(&grid, x: 4, y: 12, color: red)
        setPixel(&grid, x: 5, y: 12, color: red)
        setPixel(&grid, x: 6, y: 12, color: red)
        setPixel(&grid, x: 7, y: 12, color: red)
        setPixel(&grid, x: 8, y: 12, color: red)
        setPixel(&grid, x: 9, y: 12, color: red)
        setPixel(&grid, x: 10, y: 12, color: red)
        setPixel(&grid, x: 11, y: 12, color: red)
        setPixel(&grid, x: 12, y: 12, color: red)
        setPixel(&grid, x: 13, y: 12, color: red)
        setPixel(&grid, x: 14, y: 12, color: red)
        setPixel(&grid, x: 15, y: 12, color: red)
        setPixel(&grid, x: 16, y: 12, color: red)
        setPixel(&grid, x: 17, y: 12, color: red)
        setPixel(&grid, x: 18, y: 12, color: black)
        // Row 13 - white fur trim
        setPixel(&grid, x: 2, y: 13, color: black)
        setPixel(&grid, x: 3, y: 13, color: white)
        setPixel(&grid, x: 4, y: 13, color: white)
        setPixel(&grid, x: 5, y: 13, color: white)
        setPixel(&grid, x: 6, y: 13, color: white)
        setPixel(&grid, x: 7, y: 13, color: white)
        setPixel(&grid, x: 8, y: 13, color: white)
        setPixel(&grid, x: 9, y: 13, color: white)
        setPixel(&grid, x: 10, y: 13, color: white)
        setPixel(&grid, x: 11, y: 13, color: white)
        setPixel(&grid, x: 12, y: 13, color: white)
        setPixel(&grid, x: 13, y: 13, color: white)
        setPixel(&grid, x: 14, y: 13, color: white)
        setPixel(&grid, x: 15, y: 13, color: white)
        setPixel(&grid, x: 16, y: 13, color: white)
        setPixel(&grid, x: 17, y: 13, color: white)
        setPixel(&grid, x: 18, y: 13, color: black)

        // ====== RED BOOTS ======
        // Row 14
        setPixel(&grid, x: 3, y: 14, color: black)
        setPixel(&grid, x: 4, y: 14, color: red)
        setPixel(&grid, x: 5, y: 14, color: red)
        setPixel(&grid, x: 6, y: 14, color: red)
        setPixel(&grid, x: 7, y: 14, color: black)
        setPixel(&grid, x: 8, y: 14, color: black)
        setPixel(&grid, x: 9, y: 14, color: black)
        setPixel(&grid, x: 10, y: 14, color: black)
        setPixel(&grid, x: 11, y: 14, color: black)
        setPixel(&grid, x: 12, y: 14, color: red)
        setPixel(&grid, x: 13, y: 14, color: red)
        setPixel(&grid, x: 14, y: 14, color: red)
        setPixel(&grid, x: 15, y: 14, color: black)
        // Row 15 - boot soles
        setPixel(&grid, x: 3, y: 15, color: black)
        setPixel(&grid, x: 4, y: 15, color: darkRed)
        setPixel(&grid, x: 5, y: 15, color: darkRed)
        setPixel(&grid, x: 6, y: 15, color: darkRed)
        setPixel(&grid, x: 7, y: 15, color: black)
        setPixel(&grid, x: 8, y: 15, color: black)
        setPixel(&grid, x: 9, y: 15, color: black)
        setPixel(&grid, x: 10, y: 15, color: black)
        setPixel(&grid, x: 11, y: 15, color: black)
        setPixel(&grid, x: 12, y: 15, color: darkRed)
        setPixel(&grid, x: 13, y: 15, color: darkRed)
        setPixel(&grid, x: 14, y: 15, color: darkRed)
        setPixel(&grid, x: 15, y: 15, color: black)
    }


    private func drawKirbyMetaKnight(grid: inout [[NSColor]], frame: Int) {
        let darkBlue = NSColor(red: 0.1, green: 0.2, blue: 0.6, alpha: 1.0)
        let silver = NSColor(red: 0.75, green: 0.75, blue: 0.8, alpha: 1.0)
        let yellow = NSColor(red: 1.0, green: 0.85, blue: 0.2, alpha: 1.0)
        let black = NSColor.black
        let white = NSColor.white

        // Mask
        for x in 5...10 { setPixel(&grid, x: x, y: 0, color: silver) }
        for x in 5...10 { setPixel(&grid, x: x, y: 1, color: darkBlue) }

        // Eyes (glowing yellow)
        setPixel(&grid, x: 6, y: 0, color: yellow)
        setPixel(&grid, x: 9, y: 0, color: yellow)

        // Round body
        for x in 4...11 { setPixel(&grid, x: x, y: 2, color: darkBlue) }
        for x in 3...12 { setPixel(&grid, x: x, y: 3, color: darkBlue) }
        for x in 3...12 { setPixel(&grid, x: x, y: 4, color: darkBlue) }
        for x in 4...11 { setPixel(&grid, x: x, y: 5, color: darkBlue) }

        // Wings
        if frame % 2 == 0 {
            setPixel(&grid, x: 1, y: 3, color: white)
            setPixel(&grid, x: 14, y: 3, color: white)
        } else {
            setPixel(&grid, x: 1, y: 2, color: white)
            setPixel(&grid, x: 14, y: 2, color: white)
        }

        // Sword
        setPixel(&grid, x: 13, y: 2, color: silver)
        setPixel(&grid, x: 13, y: 3, color: silver)

        // Feet
        setPixel(&grid, x: 5, y: 6, color: yellow)
        setPixel(&grid, x: 10, y: 6, color: yellow)
    }

    private func drawKirbyBandanaWaddleDee(grid: inout [[NSColor]], frame: Int) {
        let orange = NSColor(red: 1.0, green: 0.6, blue: 0.2, alpha: 1.0)
        let blue = NSColor(red: 0.2, green: 0.5, blue: 0.9, alpha: 1.0)
        let skin = NSColor(red: 1.0, green: 0.8, blue: 0.6, alpha: 1.0)
        let black = NSColor.black

        // Head
        for x in 5...10 { setPixel(&grid, x: x, y: 1, color: orange) }
        for x in 4...11 { setPixel(&grid, x: x, y: 2, color: orange) }
        for x in 3...12 { setPixel(&grid, x: x, y: 3, color: orange) }

        // Bandana
        for x in 5...10 { setPixel(&grid, x: x, y: 1, color: blue) }

        // Eyes
        setPixel(&grid, x: 6, y: 2, color: black)
        setPixel(&grid, x: 9, y: 2, color: black)

        // Body
        for x in 4...11 { setPixel(&grid, x: x, y: 4, color: orange) }
        for x in 5...10 { setPixel(&grid, x: x, y: 5, color: orange) }

        // Feet
        setPixel(&grid, x: 5, y: 6, color: blue)
        setPixel(&grid, x: 10, y: 6, color: blue)
    }

    private func drawKirbyWaddleDee(grid: inout [[NSColor]], frame: Int) {
        let orange = NSColor(red: 1.0, green: 0.6, blue: 0.2, alpha: 1.0)
        let skin = NSColor(red: 1.0, green: 0.8, blue: 0.6, alpha: 1.0)
        let black = NSColor.black

        // Head
        for x in 5...10 { setPixel(&grid, x: x, y: 1, color: orange) }
        for x in 4...11 { setPixel(&grid, x: x, y: 2, color: orange) }
        for x in 3...12 { setPixel(&grid, x: x, y: 3, color: orange) }

        // Eyes
        setPixel(&grid, x: 6, y: 2, color: black)
        setPixel(&grid, x: 9, y: 2, color: black)

        // Body
        for x in 4...11 { setPixel(&grid, x: x, y: 4, color: orange) }
        for x in 5...10 { setPixel(&grid, x: x, y: 5, color: orange) }

        // Feet
        setPixel(&grid, x: 5, y: 6, color: orange)
        setPixel(&grid, x: 10, y: 6, color: orange)
    }

    private func drawKirbyWaddleDoo(grid: inout [[NSColor]], frame: Int) {
        let orange = NSColor(red: 1.0, green: 0.6, blue: 0.2, alpha: 1.0)
        let black = NSColor.black
        let white = NSColor.white
        let red = NSColor(red: 0.9, green: 0.15, blue: 0.15, alpha: 1.0)

        // Head
        for x in 5...10 { setPixel(&grid, x: x, y: 1, color: orange) }
        for x in 4...11 { setPixel(&grid, x: x, y: 2, color: orange) }
        for x in 3...12 { setPixel(&grid, x: x, y: 3, color: orange) }

        // Big eye (single)
        setPixel(&grid, x: 7, y: 2, color: white)
        setPixel(&grid, x: 8, y: 2, color: white)
        setPixel(&grid, x: 7, y: 2, color: black)

        // Body
        for x in 4...11 { setPixel(&grid, x: x, y: 4, color: orange) }
        for x in 5...10 { setPixel(&grid, x: x, y: 5, color: orange) }

        // Feet
        setPixel(&grid, x: 5, y: 6, color: red)
        setPixel(&grid, x: 10, y: 6, color: red)
    }

    private func drawKirbyGordo(grid: inout [[NSColor]], frame: Int) {
        let black = NSColor.black
        let white = NSColor.white
        let spikes = NSColor(red: 0.3, green: 0.3, blue: 0.35, alpha: 1.0)

        // Spiky ball
        for x in 5...10 { setPixel(&grid, x: x, y: 1, color: black) }
        for x in 4...11 { setPixel(&grid, x: x, y: 2, color: black) }
        for x in 3...12 { setPixel(&grid, x: x, y: 3, color: black) }
        for x in 4...11 { setPixel(&grid, x: x, y: 4, color: black) }
        for x in 5...10 { setPixel(&grid, x: x, y: 5, color: black) }

        // Spikes
        setPixel(&grid, x: 4, y: 1, color: spikes)
        setPixel(&grid, x: 11, y: 1, color: spikes)
        setPixel(&grid, x: 3, y: 2, color: spikes)
        setPixel(&grid, x: 12, y: 2, color: spikes)
        setPixel(&grid, x: 3, y: 4, color: spikes)
        setPixel(&grid, x: 12, y: 4, color: spikes)
        setPixel(&grid, x: 4, y: 5, color: spikes)
        setPixel(&grid, x: 11, y: 5, color: spikes)

        // Eyes
        setPixel(&grid, x: 6, y: 3, color: white)
        setPixel(&grid, x: 9, y: 3, color: white)
        setPixel(&grid, x: 6, y: 3, color: black)
        setPixel(&grid, x: 9, y: 3, color: black)
    }

    private func drawKirbyBrontoBurt(grid: inout [[NSColor]], frame: Int) {
        let purple = NSColor(red: 0.5, green: 0.15, blue: 0.65, alpha: 1.0)
        let pink = NSColor(red: 1.0, green: 0.5, blue: 0.6, alpha: 1.0)
        let black = NSColor.black
        let yellow = NSColor(red: 1.0, green: 0.85, blue: 0.2, alpha: 1.0)

        // Head
        for x in 5...10 { setPixel(&grid, x: x, y: 1, color: purple) }
        for x in 4...11 { setPixel(&grid, x: x, y: 2, color: purple) }

        // Eyes
        setPixel(&grid, x: 6, y: 1, color: black)
        setPixel(&grid, x: 9, y: 1, color: black)

        // Beak
        for x in 7...8 { setPixel(&grid, x: x, y: 2, color: yellow) }

        // Wings (flapping)
        if frame % 2 == 0 {
            setPixel(&grid, x: 3, y: 1, color: purple)
            setPixel(&grid, x: 12, y: 1, color: purple)
        } else {
            setPixel(&grid, x: 3, y: 2, color: purple)
            setPixel(&grid, x: 12, y: 2, color: purple)
        }

        // Body
        for x in 5...10 { setPixel(&grid, x: x, y: 3, color: purple) }
        for x in 5...10 { setPixel(&grid, x: x, y: 4, color: pink) }
    }

    private func drawKirbyBonkers(grid: inout [[NSColor]], frame: Int) {
        let brown = NSColor(red: 0.55, green: 0.35, blue: 0.15, alpha: 1.0)
        let darkBrown = NSColor(red: 0.4, green: 0.25, blue: 0.1, alpha: 1.0)
        let yellow = NSColor(red: 1.0, green: 0.85, blue: 0.2, alpha: 1.0)
        let black = NSColor.black

        // Head
        for x in 4...11 { setPixel(&grid, x: x, y: 1, color: brown) }
        for x in 3...12 { setPixel(&grid, x: x, y: 2, color: brown) }

        // Eyes
        setPixel(&grid, x: 6, y: 1, color: black)
        setPixel(&grid, x: 9, y: 1, color: black)

        // Body
        for x in 3...12 { setPixel(&grid, x: x, y: 3, color: brown) }
        for x in 2...13 { setPixel(&grid, x: x, y: 4, color: darkBrown) }
        for x in 3...12 { setPixel(&grid, x: x, y: 5, color: brown) }

        // Coconut hammer
        setPixel(&grid, x: 13, y: 3, color: yellow)
        setPixel(&grid, x: 14, y: 2, color: yellow)
        setPixel(&grid, x: 14, y: 3, color: yellow)

        // Feet
        setPixel(&grid, x: 4, y: 6, color: brown)
        setPixel(&grid, x: 11, y: 6, color: brown)
    }

    private func drawKirbyKingDededeBoss(grid: inout [[NSColor]], frame: Int) {
        let blue = NSColor(red: 0.15, green: 0.3, blue: 0.85, alpha: 1.0)
        let red = NSColor(red: 0.9, green: 0.15, blue: 0.15, alpha: 1.0)
        let yellow = NSColor(red: 1.0, green: 0.85, blue: 0.2, alpha: 1.0)
        let black = NSColor.black

        // Crown
        for x in 6...9 { setPixel(&grid, x: x, y: 0, color: yellow) }
        setPixel(&grid, x: 7, y: 0, color: red)
        setPixel(&grid, x: 8, y: 0, color: red)

        // Head
        for x in 4...11 { setPixel(&grid, x: x, y: 1, color: blue) }
        for x in 3...12 { setPixel(&grid, x: x, y: 2, color: blue) }

        // Eyes (angry)
        setPixel(&grid, x: 6, y: 1, color: black)
        setPixel(&grid, x: 9, y: 1, color: black)

        // Beak (open)
        for x in 7...8 { setPixel(&grid, x: x, y: 2, color: yellow) }
        setPixel(&grid, x: 7, y: 2, color: red)
        setPixel(&grid, x: 8, y: 2, color: red)

        // Body (robe)
        for x in 2...13 { setPixel(&grid, x: x, y: 3, color: red) }
        for x in 1...14 { setPixel(&grid, x: x, y: 4, color: red) }
        for x in 1...14 { setPixel(&grid, x: x, y: 5, color: blue) }
        for x in 2...13 { setPixel(&grid, x: x, y: 6, color: red) }

        // Giant hammer
        setPixel(&grid, x: 14, y: 2, color: yellow)
        setPixel(&grid, x: 15, y: 1, color: yellow)
        setPixel(&grid, x: 15, y: 2, color: yellow)
        setPixel(&grid, x: 15, y: 3, color: yellow)

        // Feet
        setPixel(&grid, x: 4, y: 7, color: yellow)
        setPixel(&grid, x: 11, y: 7, color: yellow)
    }

    // MARK: - Legend of Zelda Characters

    private func drawZeldaLink(grid: inout [[NSColor]], frame: Int) {
        let darkGreen = NSColor(red: 0.1, green: 0.4, blue: 0.15, alpha: 1.0)
        let green = NSColor(red: 0.3, green: 0.6, blue: 0.2, alpha: 1.0)
        let brown = NSColor(red: 0.55, green: 0.3, blue: 0.1, alpha: 1.0)
        let yellow = NSColor(red: 1.0, green: 0.9, blue: 0.3, alpha: 1.0)
        let skin = NSColor(red: 1.0, green: 0.8, blue: 0.6, alpha: 1.0)
        let black = NSColor.black

        func b(_ bx: Int, _ by: Int, _ c: NSColor) {
            setPixel(&grid, x: bx*2, y: by*2, color: c)
            setPixel(&grid, x: bx*2+1, y: by*2, color: c)
            setPixel(&grid, x: bx*2, y: by*2+1, color: c)
            setPixel(&grid, x: bx*2+1, y: by*2+1, color: c)
        }

        // Row 0: Hat tip
        b(7, 0, darkGreen); b(8, 0, darkGreen)

        // Row 1: Hat
        for x in 6...9 { b(x, 1, darkGreen) }

        // Row 2: Hat wider
        for x in 5...10 { b(x, 2, darkGreen) }

        // Row 3: Hat brim with black outline
        b(4, 3, black)
        for x in 5...10 { b(x, 3, darkGreen) }
        b(11, 3, black)

        // Row 4: Hair top with outline + bangs on forehead
        b(3, 4, black)
        for x in 4...11 { b(x, 4, yellow) }
        b(12, 4, black)
        // Bangs hanging down over forehead
        b(5, 4, yellow); b(6, 4, yellow); b(9, 4, yellow); b(10, 4, yellow)

        // Row 5: Hair wider + pointy ears (base)
        b(2, 5, black)
        for x in 3...12 { b(x, 5, yellow) }
        b(13, 5, black)
        // Pointy ears base (2 blocks wide)
        b(0, 5, skin); b(1, 5, skin)
        b(14, 5, skin); b(15, 5, skin)

        // Row 6: Hair widest + ear tips (pointy)
        b(1, 6, black)
        for x in 2...13 { b(x, 6, yellow) }
        b(14, 6, black)
        // Pointy ear tips (1 block wide - triangular)
        b(0, 6, skin); b(15, 6, skin)

        // Row 7: Hair sides + face center + bangs
        b(1, 7, black); b(2, 7, yellow); b(3, 7, yellow)
        for x in 4...11 { b(x, 7, skin) }
        b(12, 7, yellow); b(13, 7, yellow)
        b(14, 7, black)
        // Bangs continuing down
        b(4, 7, yellow); b(11, 7, yellow)

        // Row 8: Full face with eyes + bangs
        b(1, 8, black)
        for x in 2...13 { b(x, 8, skin) }
        b(14, 8, black)
        b(5, 8, black); b(10, 8, black)
        // Bangs ending
        b(3, 8, yellow); b(12, 8, yellow)

        // Row 9: Face
        b(1, 9, black)
        for x in 2...13 { b(x, 9, skin) }
        b(14, 9, black)

        // Row 10: Chin narrower
        b(2, 10, black)
        for x in 3...12 { b(x, 10, skin) }
        b(13, 10, black)

        // Row 11: Neck
        b(3, 11, black)
        for x in 4...11 { b(x, 11, skin) }
        b(12, 11, black)

        // Row 12: Arms + tunic
        b(1, 12, black); b(2, 12, skin); b(3, 12, skin)
        for x in 4...11 { b(x, 12, green) }
        b(12, 12, skin); b(13, 12, skin)
        b(14, 12, black)

        // Row 13: Arms + tunic + belt
        b(1, 13, black); b(2, 13, skin); b(3, 13, skin)
        for x in 4...11 { b(x, 13, green) }
        b(12, 13, skin); b(13, 13, skin)
        b(14, 13, black)
        b(7, 13, yellow); b(8, 13, yellow)

        // Row 14: Tunic narrower
        b(2, 14, black)
        for x in 3...12 { b(x, 14, green) }
        b(13, 14, black)

        // Row 15: Boots
        b(3, 15, black); b(4, 15, brown); b(5, 15, brown); b(6, 15, black)
        b(9, 15, black); b(10, 15, brown); b(11, 15, brown); b(12, 15, black)
    }

    private func drawZeldaPrincess(grid: inout [[NSColor]], frame: Int) {
        let orange = NSColor(red: 0.85, green: 0.45, blue: 0.15, alpha: 1.0)
        let gold = NSColor(red: 1.0, green: 0.85, blue: 0.2, alpha: 1.0)
        let skin = NSColor(red: 1.0, green: 0.8, blue: 0.6, alpha: 1.0)
        let black = NSColor.black
        let blue = NSColor(red: 0.6, green: 0.75, blue: 1.0, alpha: 1.0)
        let lightBlue = NSColor(red: 0.75, green: 0.85, blue: 1.0, alpha: 1.0)

        // Crown
        setPixel(&grid, x: 7, y: 0, color: gold)
        setPixel(&grid, x: 8, y: 0, color: gold)

        // Hair top
        for x in 6...9 { setPixel(&grid, x: x, y: 1, color: orange) }

        // Hair wider
        for x in 5...10 { setPixel(&grid, x: x, y: 2, color: orange) }

        // Hair sides + face
        setPixel(&grid, x: 4, y: 3, color: orange)
        setPixel(&grid, x: 5, y: 3, color: orange)
        setPixel(&grid, x: 6, y: 3, color: skin)
        setPixel(&grid, x: 7, y: 3, color: skin)
        setPixel(&grid, x: 8, y: 3, color: skin)
        setPixel(&grid, x: 9, y: 3, color: skin)
        setPixel(&grid, x: 10, y: 3, color: orange)
        setPixel(&grid, x: 11, y: 3, color: orange)

        // Eyes
        setPixel(&grid, x: 4, y: 4, color: orange)
        setPixel(&grid, x: 5, y: 4, color: skin)
        setPixel(&grid, x: 6, y: 4, color: black)
        setPixel(&grid, x: 7, y: 4, color: skin)
        setPixel(&grid, x: 8, y: 4, color: skin)
        setPixel(&grid, x: 9, y: 4, color: black)
        setPixel(&grid, x: 10, y: 4, color: skin)
        setPixel(&grid, x: 11, y: 4, color: orange)

        // Mouth
        setPixel(&grid, x: 5, y: 5, color: skin)
        setPixel(&grid, x: 6, y: 5, color: skin)
        setPixel(&grid, x: 7, y: 5, color: skin)
        setPixel(&grid, x: 8, y: 5, color: skin)
        setPixel(&grid, x: 9, y: 5, color: skin)

        // Neck
        setPixel(&grid, x: 6, y: 6, color: skin)
        setPixel(&grid, x: 7, y: 6, color: skin)
        setPixel(&grid, x: 8, y: 6, color: skin)
        setPixel(&grid, x: 9, y: 6, color: skin)

        // Arms + dress top
        setPixel(&grid, x: 2, y: 7, color: orange)
        setPixel(&grid, x: 3, y: 7, color: orange)
        setPixel(&grid, x: 4, y: 7, color: blue)
        setPixel(&grid, x: 5, y: 7, color: blue)
        setPixel(&grid, x: 6, y: 7, color: blue)
        setPixel(&grid, x: 7, y: 7, color: blue)
        setPixel(&grid, x: 8, y: 7, color: blue)
        setPixel(&grid, x: 9, y: 7, color: blue)
        setPixel(&grid, x: 10, y: 7, color: blue)
        setPixel(&grid, x: 11, y: 7, color: blue)
        setPixel(&grid, x: 12, y: 7, color: orange)
        setPixel(&grid, x: 13, y: 7, color: orange)

        // Dress middle
        setPixel(&grid, x: 2, y: 8, color: orange)
        setPixel(&grid, x: 3, y: 8, color: orange)
        setPixel(&grid, x: 4, y: 8, color: blue)
        setPixel(&grid, x: 5, y: 8, color: lightBlue)
        setPixel(&grid, x: 6, y: 8, color: lightBlue)
        setPixel(&grid, x: 7, y: 8, color: lightBlue)
        setPixel(&grid, x: 8, y: 8, color: lightBlue)
        setPixel(&grid, x: 9, y: 8, color: lightBlue)
        setPixel(&grid, x: 10, y: 8, color: lightBlue)
        setPixel(&grid, x: 11, y: 8, color: blue)
        setPixel(&grid, x: 12, y: 8, color: orange)
        setPixel(&grid, x: 13, y: 8, color: orange)

        // Dress lower
        setPixel(&grid, x: 3, y: 9, color: orange)
        setPixel(&grid, x: 4, y: 9, color: blue)
        setPixel(&grid, x: 5, y: 9, color: lightBlue)
        setPixel(&grid, x: 6, y: 9, color: lightBlue)
        setPixel(&grid, x: 7, y: 9, color: lightBlue)
        setPixel(&grid, x: 8, y: 9, color: lightBlue)
        setPixel(&grid, x: 9, y: 9, color: lightBlue)
        setPixel(&grid, x: 10, y: 9, color: lightBlue)
        setPixel(&grid, x: 11, y: 9, color: blue)
        setPixel(&grid, x: 12, y: 9, color: orange)

        // Dress bottom
        setPixel(&grid, x: 3, y: 10, color: orange)
        setPixel(&grid, x: 4, y: 10, color: blue)
        setPixel(&grid, x: 5, y: 10, color: blue)
        setPixel(&grid, x: 6, y: 10, color: lightBlue)
        setPixel(&grid, x: 7, y: 10, color: lightBlue)
        setPixel(&grid, x: 8, y: 10, color: lightBlue)
        setPixel(&grid, x: 9, y: 10, color: lightBlue)
        setPixel(&grid, x: 10, y: 10, color: blue)
        setPixel(&grid, x: 11, y: 10, color: blue)
        setPixel(&grid, x: 12, y: 10, color: orange)

        // Dress hem
        setPixel(&grid, x: 4, y: 11, color: orange)
        setPixel(&grid, x: 5, y: 11, color: blue)
        setPixel(&grid, x: 6, y: 11, color: blue)
        setPixel(&grid, x: 7, y: 11, color: blue)
        setPixel(&grid, x: 8, y: 11, color: blue)
        setPixel(&grid, x: 9, y: 11, color: blue)
        setPixel(&grid, x: 10, y: 11, color: blue)
        setPixel(&grid, x: 11, y: 11, color: orange)
    }

    private func drawZeldaGanon(grid: inout [[NSColor]], frame: Int) {
        let purple = NSColor(red: 0.5, green: 0.15, blue: 0.65, alpha: 1.0)
        let darkPurple = NSColor(red: 0.35, green: 0.1, blue: 0.5, alpha: 1.0)
        let red = NSColor(red: 0.9, green: 0.15, blue: 0.15, alpha: 1.0)
        let black = NSColor.black
        let yellow = NSColor(red: 1.0, green: 0.85, blue: 0.2, alpha: 1.0)

        // Horns
        setPixel(&grid, x: 5, y: 0, color: darkPurple)
        setPixel(&grid, x: 10, y: 0, color: darkPurple)

        // Head (pig-like)
        for x in 4...11 { setPixel(&grid, x: x, y: 1, color: purple) }
        for x in 4...11 { setPixel(&grid, x: x, y: 2, color: purple) }

        // Eyes
        setPixel(&grid, x: 6, y: 1, color: red)
        setPixel(&grid, x: 9, y: 1, color: red)
        setPixel(&grid, x: 6, y: 1, color: black)
        setPixel(&grid, x: 9, y: 1, color: black)

        // Snout
        for x in 7...8 { setPixel(&grid, x: x, y: 2, color: darkPurple) }

        // Body (massive armor)
        for x in 3...12 { setPixel(&grid, x: x, y: 3, color: purple) }
        for x in 2...13 { setPixel(&grid, x: x, y: 4, color: darkPurple) }
        for x in 2...13 { setPixel(&grid, x: x, y: 5, color: purple) }
        for x in 3...12 { setPixel(&grid, x: x, y: 6, color: darkPurple) }

        // Triforce of Power
        setPixel(&grid, x: 7, y: 4, color: yellow)
        setPixel(&grid, x: 8, y: 4, color: yellow)

        // Sword
        setPixel(&grid, x: 14, y: 3, color: NSColor(red: 0.8, green: 0.8, blue: 0.85, alpha: 1.0))

        // Legs
        setPixel(&grid, x: 4, y: 7, color: purple)
        setPixel(&grid, x: 11, y: 7, color: purple)
    }

    private func drawZeldaNavi(grid: inout [[NSColor]], frame: Int) {
        let blue = NSColor(red: 0.2, green: 0.6, blue: 1.0, alpha: 1.0)
        let lightBlue = NSColor(red: 0.4, green: 0.8, blue: 1.0, alpha: 1.0)
        let white = NSColor.white
        let yellow = NSColor(red: 1.0, green: 0.85, blue: 0.2, alpha: 1.0)

        // Wings (animated)
        if frame % 2 == 0 {
            setPixel(&grid, x: 3, y: 2, color: lightBlue)
            setPixel(&grid, x: 12, y: 2, color: lightBlue)
        } else {
            setPixel(&grid, x: 3, y: 3, color: lightBlue)
            setPixel(&grid, x: 12, y: 3, color: lightBlue)
        }

        // Body (glowing orb)
        for x in 6...9 { setPixel(&grid, x: x, y: 3, color: blue) }
        for x in 5...10 { setPixel(&grid, x: x, y: 4, color: blue) }
        for x in 6...9 { setPixel(&grid, x: x, y: 5, color: lightBlue) }

        // Eyes
        setPixel(&grid, x: 7, y: 4, color: yellow)
        setPixel(&grid, x: 9, y: 4, color: yellow)
        setPixel(&grid, x: 7, y: 4, color: white)
        setPixel(&grid, x: 9, y: 4, color: white)

        // Glow effect
        setPixel(&grid, x: 6, y: 3, color: white)
        setPixel(&grid, x: 9, y: 3, color: white)
    }

    private func drawZeldaMidna(grid: inout [[NSColor]], frame: Int) {
        let orange = NSColor(red: 1.0, green: 0.5, blue: 0.1, alpha: 1.0)
        let darkOrange = NSColor(red: 0.8, green: 0.3, blue: 0.05, alpha: 1.0)
        let blue = NSColor(red: 0.2, green: 0.5, blue: 0.9, alpha: 1.0)
        let black = NSColor.black

        // Hair (wild, flowing)
        for x in 3...12 { setPixel(&grid, x: x, y: 0, color: orange) }
        for x in 2...13 { setPixel(&grid, x: x, y: 1, color: orange) }

        // Head
        for x in 5...10 { setPixel(&grid, x: x, y: 2, color: darkOrange) }

        // Eyes (glowing)
        setPixel(&grid, x: 6, y: 2, color: blue)
        setPixel(&grid, x: 9, y: 2, color: blue)
        setPixel(&grid, x: 6, y: 2, color: black)
        setPixel(&grid, x: 9, y: 2, color: black)

        // Mask markings
        setPixel(&grid, x: 7, y: 2, color: blue)
        setPixel(&grid, x: 8, y: 2, color: blue)

        // Body (small, imp-like)
        for x in 5...10 { setPixel(&grid, x: x, y: 3, color: darkOrange) }
        for x in 6...9 { setPixel(&grid, x: x, y: 4, color: darkOrange) }

        // Hair tail (long)
        setPixel(&grid, x: 11, y: 3, color: orange)
        setPixel(&grid, x: 12, y: 4, color: orange)
        setPixel(&grid, x: 13, y: 5, color: orange)
        setPixel(&grid, x: 14, y: 6, color: orange)

        // Legs
        setPixel(&grid, x: 6, y: 5, color: darkOrange)
        setPixel(&grid, x: 9, y: 5, color: darkOrange)
    }

    private func drawZeldaImpa(grid: inout [[NSColor]], frame: Int) {
        let gray = NSColor(red: 0.4, green: 0.4, blue: 0.45, alpha: 1.0)
        let silver = NSColor(red: 0.75, green: 0.75, blue: 0.8, alpha: 1.0)
        let skin = NSColor(red: 0.8, green: 0.6, blue: 0.4, alpha: 1.0)
        let black = NSColor.black
        let pink = NSColor(red: 1.0, green: 0.6, blue: 0.7, alpha: 1.0)

        // Hair (long, dark)
        for x in 4...11 { setPixel(&grid, x: x, y: 0, color: black) }
        for x in 4...11 { setPixel(&grid, x: x, y: 1, color: black) }
        for x in 4...11 { setPixel(&grid, x: x, y: 2, color: black) }

        // Head
        for x in 5...10 { setPixel(&grid, x: x, y: 3, color: skin) }

        // Eyes
        setPixel(&grid, x: 6, y: 3, color: black)
        setPixel(&grid, x: 9, y: 3, color: black)

        // Sheikah armor
        for x in 4...11 { setPixel(&grid, x: x, y: 4, color: gray) }
        for x in 3...12 { setPixel(&grid, x: x, y: 5, color: gray) }
        for x in 3...12 { setPixel(&grid, x: x, y: 6, color: gray) }

        // Eye symbol
        setPixel(&grid, x: 7, y: 4, color: pink)
        setPixel(&grid, x: 8, y: 4, color: pink)

        // Blade
        setPixel(&grid, x: 13, y: 4, color: silver)
        setPixel(&grid, x: 14, y: 3, color: silver)

        // Legs
        setPixel(&grid, x: 5, y: 7, color: gray)
        setPixel(&grid, x: 10, y: 7, color: gray)
    }

    private func drawZeldaSkullKid(grid: inout [[NSColor]], frame: Int) {
        let brown = NSColor(red: 0.55, green: 0.35, blue: 0.15, alpha: 1.0)
        let orange = NSColor(red: 1.0, green: 0.6, blue: 0.1, alpha: 1.0)
        let red = NSColor(red: 0.9, green: 0.15, blue: 0.15, alpha: 1.0)
        let black = NSColor.black
        let yellow = NSColor(red: 1.0, green: 0.85, blue: 0.2, alpha: 1.0)
        let blue = NSColor(red: 0.2, green: 0.5, blue: 0.9, alpha: 1.0)

        // Hat
        for x in 5...10 { setPixel(&grid, x: x, y: 0, color: orange) }
        setPixel(&grid, x: 5, y: 1, color: orange)
        setPixel(&grid, x: 10, y: 1, color: orange)

        // Head (mask)
        for x in 5...10 { setPixel(&grid, x: x, y: 1, color: brown) }
        for x in 5...10 { setPixel(&grid, x: x, y: 2, color: brown) }

        // Eyes (glowing)
        setPixel(&grid, x: 6, y: 1, color: yellow)
        setPixel(&grid, x: 9, y: 1, color: yellow)
        setPixel(&grid, x: 6, y: 1, color: black)
        setPixel(&grid, x: 9, y: 1, color: black)

        // Mask markings
        setPixel(&grid, x: 7, y: 2, color: red)
        setPixel(&grid, x: 8, y: 2, color: red)

        // Body
        for x in 5...10 { setPixel(&grid, x: x, y: 3, color: brown) }
        for x in 4...11 { setPixel(&grid, x: x, y: 4, color: brown) }
        for x in 4...11 { setPixel(&grid, x: x, y: 5, color: orange) }

        // Ocarina
        setPixel(&grid, x: 12, y: 3, color: blue)

        // Legs
        setPixel(&grid, x: 5, y: 6, color: brown)
        setPixel(&grid, x: 10, y: 6, color: brown)
    }

    private func drawZeldaGreatFairy(grid: inout [[NSColor]], frame: Int) {
        let pink = NSColor(red: 1.0, green: 0.5, blue: 0.6, alpha: 1.0)
        let lightPink = NSColor(red: 1.0, green: 0.7, blue: 0.8, alpha: 1.0)
        let skin = NSColor(red: 1.0, green: 0.8, blue: 0.6, alpha: 1.0)
        let blue = NSColor(red: 0.2, green: 0.6, blue: 1.0, alpha: 1.0)
        let yellow = NSColor(red: 1.0, green: 0.85, blue: 0.2, alpha: 1.0)

        // Wings (large, animated)
        if frame % 2 == 0 {
            for x in 1...4 { setPixel(&grid, x: x, y: 2, color: lightPink) }
            for x in 11...14 { setPixel(&grid, x: x, y: 2, color: lightPink) }
        } else {
            for x in 1...4 { setPixel(&grid, x: x, y: 3, color: lightPink) }
            for x in 11...14 { setPixel(&grid, x: x, y: 3, color: lightPink) }
        }

        // Hair (flowing)
        for x in 5...10 { setPixel(&grid, x: x, y: 0, color: yellow) }
        for x in 4...11 { setPixel(&grid, x: x, y: 1, color: yellow) }

        // Head
        for x in 5...10 { setPixel(&grid, x: x, y: 2, color: skin) }

        // Eyes
        setPixel(&grid, x: 6, y: 2, color: blue)
        setPixel(&grid, x: 9, y: 2, color: blue)

        // Body
        for x in 5...10 { setPixel(&grid, x: x, y: 3, color: pink) }
        for x in 4...11 { setPixel(&grid, x: x, y: 4, color: pink) }
        for x in 5...10 { setPixel(&grid, x: x, y: 5, color: lightPink) }

        // Magic sparkles
        if frame % 2 == 0 {
            setPixel(&grid, x: 3, y: 1, color: yellow)
            setPixel(&grid, x: 12, y: 1, color: yellow)
        }

        // Legs
        setPixel(&grid, x: 6, y: 6, color: pink)
        setPixel(&grid, x: 9, y: 6, color: pink)
    }

    private func drawZeldaOctorok(grid: inout [[NSColor]], frame: Int) {
        let red = NSColor(red: 0.9, green: 0.2, blue: 0.15, alpha: 1.0)
        let darkRed = NSColor(red: 0.7, green: 0.1, blue: 0.1, alpha: 1.0)
        let black = NSColor.black
        let white = NSColor.white

        // Body (round)
        for x in 5...10 { setPixel(&grid, x: x, y: 2, color: red) }
        for x in 4...11 { setPixel(&grid, x: x, y: 3, color: red) }
        for x in 4...11 { setPixel(&grid, x: x, y: 4, color: darkRed) }
        for x in 5...10 { setPixel(&grid, x: x, y: 5, color: red) }

        // Eyes
        setPixel(&grid, x: 6, y: 3, color: white)
        setPixel(&grid, x: 9, y: 3, color: white)
        setPixel(&grid, x: 6, y: 3, color: black)
        setPixel(&grid, x: 9, y: 3, color: black)

        // Snout
        setPixel(&grid, x: 7, y: 4, color: darkRed)
        setPixel(&grid, x: 8, y: 4, color: darkRed)

        // Tentacles
        if frame % 2 == 0 {
            setPixel(&grid, x: 4, y: 6, color: red)
            setPixel(&grid, x: 5, y: 7, color: red)
            setPixel(&grid, x: 10, y: 7, color: red)
            setPixel(&grid, x: 11, y: 6, color: red)
        } else {
            setPixel(&grid, x: 5, y: 6, color: red)
            setPixel(&grid, x: 4, y: 7, color: red)
            setPixel(&grid, x: 11, y: 7, color: red)
            setPixel(&grid, x: 10, y: 6, color: red)
        }
    }

    private func drawZeldaMoblin(grid: inout [[NSColor]], frame: Int) {
        let green = NSColor(red: 0.3, green: 0.5, blue: 0.2, alpha: 1.0)
        let darkGreen = NSColor(red: 0.2, green: 0.35, blue: 0.15, alpha: 1.0)
        let brown = NSColor(red: 0.55, green: 0.35, blue: 0.15, alpha: 1.0)
        let black = NSColor.black
        let red = NSColor(red: 0.9, green: 0.15, blue: 0.15, alpha: 1.0)

        // Snout (pig-like)
        for x in 6...9 { setPixel(&grid, x: x, y: 0, color: green) }

        // Head
        for x in 4...11 { setPixel(&grid, x: x, y: 1, color: green) }
        for x in 4...11 { setPixel(&grid, x: x, y: 2, color: green) }

        // Eyes
        setPixel(&grid, x: 6, y: 1, color: red)
        setPixel(&grid, x: 9, y: 1, color: red)
        setPixel(&grid, x: 6, y: 1, color: black)
        setPixel(&grid, x: 9, y: 1, color: black)

        // Tusks
        setPixel(&grid, x: 5, y: 2, color: NSColor.white)
        setPixel(&grid, x: 10, y: 2, color: NSColor.white)

        // Body (bulky)
        for x in 3...12 { setPixel(&grid, x: x, y: 3, color: green) }
        for x in 2...13 { setPixel(&grid, x: x, y: 4, color: darkGreen) }
        for x in 2...13 { setPixel(&grid, x: x, y: 5, color: green) }
        for x in 3...12 { setPixel(&grid, x: x, y: 6, color: darkGreen) }

        // Spear
        setPixel(&grid, x: 14, y: 3, color: brown)
        setPixel(&grid, x: 14, y: 2, color: brown)

        // Legs
        setPixel(&grid, x: 4, y: 7, color: green)
        setPixel(&grid, x: 11, y: 7, color: green)
    }

    private func drawZeldaKeese(grid: inout [[NSColor]], frame: Int) {
        let purple = NSColor(red: 0.3, green: 0.15, blue: 0.45, alpha: 1.0)
        let darkPurple = NSColor(red: 0.2, green: 0.1, blue: 0.3, alpha: 1.0)
        let red = NSColor(red: 0.9, green: 0.15, blue: 0.15, alpha: 1.0)
        let black = NSColor.black

        // Wings (flapping)
        if frame % 2 == 0 {
            setPixel(&grid, x: 2, y: 2, color: purple)
            setPixel(&grid, x: 3, y: 1, color: purple)
            setPixel(&grid, x: 12, y: 2, color: purple)
            setPixel(&grid, x: 13, y: 1, color: purple)
        } else {
            setPixel(&grid, x: 2, y: 3, color: purple)
            setPixel(&grid, x: 3, y: 4, color: purple)
            setPixel(&grid, x: 12, y: 3, color: purple)
            setPixel(&grid, x: 13, y: 4, color: purple)
        }

        // Body
        for x in 6...9 { setPixel(&grid, x: x, y: 3, color: purple) }
        for x in 5...10 { setPixel(&grid, x: x, y: 4, color: darkPurple) }

        // Eyes
        setPixel(&grid, x: 7, y: 3, color: red)
        setPixel(&grid, x: 9, y: 3, color: red)
        setPixel(&grid, x: 7, y: 3, color: black)
        setPixel(&grid, x: 9, y: 3, color: black)

        // Ears
        setPixel(&grid, x: 6, y: 2, color: purple)
        setPixel(&grid, x: 9, y: 2, color: purple)
    }

    private func drawZeldaDarkLink(grid: inout [[NSColor]], frame: Int) {
        let black = NSColor(red: 0.1, green: 0.1, blue: 0.12, alpha: 1.0)
        let darkGray = NSColor(red: 0.25, green: 0.25, blue: 0.28, alpha: 1.0)
        let red = NSColor(red: 0.9, green: 0.15, blue: 0.15, alpha: 1.0)

        // Pointy hat (dark)
        setPixel(&grid, x: 7, y: 0, color: black)
        setPixel(&grid, x: 7, y: 1, color: black)
        for x in 6...8 { setPixel(&grid, x: x, y: 2, color: black) }

        // Head
        for x in 5...10 { setPixel(&grid, x: x, y: 3, color: darkGray) }

        // Eyes (glowing red)
        setPixel(&grid, x: 6, y: 3, color: red)
        setPixel(&grid, x: 9, y: 3, color: red)

        // Tunic (dark)
        for x in 5...10 { setPixel(&grid, x: x, y: 4, color: black) }
        for x in 4...11 { setPixel(&grid, x: x, y: 5, color: black) }
        for x in 4...11 { setPixel(&grid, x: x, y: 6, color: darkGray) }

        // Sword (dark)
        setPixel(&grid, x: 12, y: 3, color: darkGray)
        setPixel(&grid, x: 13, y: 2, color: darkGray)

        // Shadow aura
        if frame % 2 == 0 {
            setPixel(&grid, x: 3, y: 4, color: darkGray)
            setPixel(&grid, x: 12, y: 4, color: darkGray)
        }

        // Legs
        if frame % 2 == 0 {
            setPixel(&grid, x: 5, y: 7, color: black)
            setPixel(&grid, x: 10, y: 7, color: black)
        } else {
            setPixel(&grid, x: 6, y: 7, color: black)
            setPixel(&grid, x: 9, y: 7, color: black)
        }
    }

    // MARK: - Labubu (Pop Mart character - mischievous elf with pointy ears, big eyes, sharp teeth)
    private func drawLabubu(grid: inout [[NSColor]], frame: Int, colorScheme: Int) {
        let outlineColor: NSColor
        let suitColor: NSColor
        let zipperColor: NSColor
        let eyeIrisColor: NSColor

        switch colorScheme {
        case 1: // Pink Labubu
            outlineColor = NSColor(red: 0.75, green: 0.29, blue: 0.45, alpha: 1.0)
            suitColor = NSColor(red: 0.97, green: 0.65, blue: 0.75, alpha: 1.0)
            zipperColor = NSColor(red: 0.65, green: 0.22, blue: 0.37, alpha: 1.0)
            eyeIrisColor = NSColor(red: 0.78, green: 0.27, blue: 0.47, alpha: 1.0)
        case 2: // Gray Labubu
            outlineColor = NSColor(red: 0.37, green: 0.41, blue: 0.45, alpha: 1.0)
            suitColor = NSColor(red: 0.75, green: 0.78, blue: 0.80, alpha: 1.0)
            zipperColor = NSColor(red: 0.29, green: 0.33, blue: 0.37, alpha: 1.0)
            eyeIrisColor = NSColor(red: 0.31, green: 0.55, blue: 0.51, alpha: 1.0)
        case 3: // Brown Labubu
            outlineColor = NSColor(red: 0.45, green: 0.29, blue: 0.18, alpha: 1.0)
            suitColor = NSColor(red: 0.80, green: 0.61, blue: 0.37, alpha: 1.0)
            zipperColor = NSColor(red: 0.35, green: 0.22, blue: 0.12, alpha: 1.0)
            eyeIrisColor = NSColor(red: 0.51, green: 0.61, blue: 0.24, alpha: 1.0)
        case 4: // White Labubu
            outlineColor = NSColor(red: 0.61, green: 0.64, blue: 0.67, alpha: 1.0)
            suitColor = NSColor(red: 0.97, green: 0.97, blue: 0.99, alpha: 1.0)
            zipperColor = NSColor(red: 0.49, green: 0.52, blue: 0.55, alpha: 1.0)
            eyeIrisColor = NSColor(red: 0.33, green: 0.59, blue: 0.88, alpha: 1.0)
        case 5: // Golden Labubu
            outlineColor = NSColor(red: 0.69, green: 0.51, blue: 0.10, alpha: 1.0)
            suitColor = NSColor(red: 1.00, green: 0.83, blue: 0.24, alpha: 1.0)
            zipperColor = NSColor(red: 0.55, green: 0.39, blue: 0.06, alpha: 1.0)
            eyeIrisColor = NSColor(red: 0.25, green: 0.63, blue: 0.35, alpha: 1.0)
        default: // Classic Green Labubu
            outlineColor = NSColor(red: 0.29, green: 0.62, blue: 0.25, alpha: 1.0)
            suitColor = NSColor(red: 0.72, green: 0.87, blue: 0.29, alpha: 1.0)
            zipperColor = NSColor(red: 0.21, green: 0.49, blue: 0.16, alpha: 1.0)
            eyeIrisColor = NSColor(red: 0.30, green: 0.63, blue: 0.24, alpha: 1.0)
        }

        let skinLight = NSColor(red: 0.93, green: 0.85, blue: 0.73, alpha: 1.0)
        let skinTan = NSColor(red: 0.87, green: 0.71, blue: 0.53, alpha: 1.0)
        let blushPink = NSColor(red: 0.90, green: 0.60, blue: 0.69, alpha: 1.0)
        let noseLight = NSColor(red: 0.92, green: 0.79, blue: 0.83, alpha: 1.0)
        let noseDark = NSColor(red: 0.84, green: 0.45, blue: 0.42, alpha: 1.0)
        let eyeBlack = NSColor(red: 0.15, green: 0.15, blue: 0.15, alpha: 1.0)
        let eyeDarkGray = NSColor(red: 0.32, green: 0.32, blue: 0.32, alpha: 1.0)
        let white = NSColor.white

        let anim = frame % 4
        let ox = 4
        let oy = 2

        let rows: [String] = [
            "......OO.......OO......", // 00
            ".....OSSO.....OSSO.....", // 01
            ".....OStSO...OStSO.....", // 02
            "....OSStSO...OStSSO....", // 03
            "....OSttSSO.OSSttSO....", // 04
            "....OStOsSO.OSsOtSO....", // 05
            "....OStOsSO.OSsOtSO....", // 06
            "....OStOsSO.OSsOtSO....", // 07
            "....OSSSSOOOOOSSSSO....", // 08
            "....OOSSSSSSSSSSSOO....", // 09
            "...OSSSSSSSSSSSSSSSO...", // 10
            "..OSSSSSSSSSSSSSSSSSO..", // 11
            ".OSSSStttSSSSStttSSSSO.", // 12
            ".OSSStssstttttssstSSSO.", // 13
            ".OSStssssssssssssstSSO.", // 14
            "OSSStstsstssstsststSSSO", // 15
            "OSStssswtssssstwssstSSO", // 16
            "OSStsssKwsspsswKssstSSO", // 17
            "OSStsssKEspppsKEssstSSO", // 18
            "OSStbssKKsPPPsKKssbtSSO", // 19
            "OSStwsskkssPsskksswtSSO", // 20
            "OSStssssssssssssssstSSO", // 21
            ".OSStswssssssssswstSSO.", // 22
            ".OSSStsswswswswsstSSSO.", // 23
            "..OOSSttsssssssttSSOO..", // 24
            "....OOSStttttttSSOO....", // 25
            "...OSSOSSSSSSSSSOSSO...", // 26
            "..OSSOSOOOOZOOOOSOSSO..", // 27
            ".OSSSOSSSSSZSSSSSOSSSO.", // 28
            ".OSSOSSSSSSZSSSSSSOSSO.", // 29
            ".OSSOSSSSSSZSSSSSSOSSO.", // 30
            ".HhSOSSSSSSZSSSSSSOShH.", // 31
            ".h.OSSSSSSSZSSSSSSSO.h.", // 32
            "...OSSSSSSSZSSSSSSSO...", // 33
            "...OSSSSSSSZSSSSSSSO...", // 34
            "...OSSSSSSSZSSSSSSSO...", // 35
            "...OSSSSSSSSSSSSSSSO...", // 36
            "....OSSSSSOOOSSSSSO....", // 37
            "....OSSSSO...OSSSSO....", // 38
            ".....OOOO.....OOOO.....", // 39
            ".....hHh.......hHh.....", // 40
        ]

        for (rIdx, row) in rows.enumerated() {
            var rowChars = Array(row)
            let y = oy + rIdx

            // Eye glance & ear tip animations
            if anim == 1 && rIdx == 17 {
                rowChars[7] = "w"; rowChars[8] = "K"; rowChars[14] = "w"; rowChars[15] = "K"
            } else if anim == 1 && rIdx == 18 {
                rowChars[7] = "E"; rowChars[8] = "K"; rowChars[14] = "E"; rowChars[15] = "K"
            } else if anim == 3 && rIdx == 17 {
                rowChars[7] = "K"; rowChars[8] = "w"; rowChars[14] = "K"; rowChars[15] = "w"
            } else if anim == 3 && rIdx == 18 {
                rowChars[7] = "K"; rowChars[8] = "E"; rowChars[14] = "K"; rowChars[15] = "E"
            } else if anim == 2 && rIdx == 0 {
                rowChars[5] = "O"; rowChars[17] = "O"
            }

            for (cIdx, ch) in rowChars.enumerated() {
                let x = ox + cIdx
                switch ch {
                case "O": setPixel(&grid, x: x, y: y, color: outlineColor)
                case "S": setPixel(&grid, x: x, y: y, color: suitColor)
                case "Z": setPixel(&grid, x: x, y: y, color: zipperColor)
                case "s", "h": setPixel(&grid, x: x, y: y, color: skinLight)
                case "t", "H": setPixel(&grid, x: x, y: y, color: skinTan)
                case "b": setPixel(&grid, x: x, y: y, color: blushPink)
                case "w": setPixel(&grid, x: x, y: y, color: white)
                case "p": setPixel(&grid, x: x, y: y, color: noseLight)
                case "P": setPixel(&grid, x: x, y: y, color: noseDark)
                case "K": setPixel(&grid, x: x, y: y, color: eyeBlack)
                case "k": setPixel(&grid, x: x, y: y, color: eyeDarkGray)
                case "E": setPixel(&grid, x: x, y: y, color: eyeIrisColor)
                default: break
                }
            }
        }
    }

    // MARK: - Batman Characters
    private func drawBatmanJoker(grid: inout [[NSColor]], frame: Int) {
        let green = NSColor(red: 0.2, green: 0.7, blue: 0.2, alpha: 1.0)
        let purple = NSColor(red: 0.55, green: 0.15, blue: 0.65, alpha: 1.0)
        let white = NSColor.white
        let red = NSColor(red: 0.85, green: 0.1, blue: 0.1, alpha: 1.0)
        let black = NSColor.black
        let skin = NSColor(red: 0.95, green: 0.85, blue: 0.75, alpha: 1.0)
        let anim = frame % 2

        for x in 5...10 { setPixel(&grid, x: x, y: 0, color: green) }
        for x in 4...11 { setPixel(&grid, x: x, y: 1, color: green) }
        for x in 4...11 { setPixel(&grid, x: x, y: 2, color: white) }
        for x in 5...10 { setPixel(&grid, x: x, y: 3, color: white) }
        setPixel(&grid, x: 6, y: 2, color: black); setPixel(&grid, x: 9, y: 2, color: black)
        setPixel(&grid, x: 6, y: 3, color: red); setPixel(&grid, x: 7, y: 3, color: red)
        setPixel(&grid, x: 8, y: 3, color: red); setPixel(&grid, x: 9, y: 3, color: red)
        for x in 4...11 { setPixel(&grid, x: x, y: 4, color: purple) }
        for x in 4...11 { setPixel(&grid, x: x, y: 5, color: purple) }
        setPixel(&grid, x: 7, y: 4, color: green); setPixel(&grid, x: 8, y: 4, color: green)
        if anim == 0 {
            setPixel(&grid, x: 5, y: 6, color: purple); setPixel(&grid, x: 10, y: 6, color: purple)
        } else {
            setPixel(&grid, x: 4, y: 6, color: purple); setPixel(&grid, x: 11, y: 6, color: purple)
        }
    }

    private func drawBatmanBane(grid: inout [[NSColor]], frame: Int) {
        let green = NSColor(red: 0.3, green: 0.55, blue: 0.25, alpha: 1.0)
        let brown = NSColor(red: 0.5, green: 0.3, blue: 0.15, alpha: 1.0)
        let black = NSColor.black
        let darkGreen = NSColor(red: 0.2, green: 0.4, blue: 0.15, alpha: 1.0)
        let anim = frame % 2

        for x in 4...11 { setPixel(&grid, x: x, y: 0, color: brown) }
        for x in 3...12 { setPixel(&grid, x: x, y: 1, color: brown) }
        for x in 3...12 { setPixel(&grid, x: x, y: 2, color: green) }
        for x in 4...11 { setPixel(&grid, x: x, y: 3, color: green) }
        setPixel(&grid, x: 5, y: 1, color: black); setPixel(&grid, x: 10, y: 1, color: black)
        setPixel(&grid, x: 6, y: 2, color: black); setPixel(&grid, x: 9, y: 2, color: black)
        for x in 3...12 { setPixel(&grid, x: x, y: 4, color: green) }
        for x in 3...12 { setPixel(&grid, x: x, y: 5, color: darkGreen) }
        if anim == 0 {
            setPixel(&grid, x: 5, y: 6, color: darkGreen); setPixel(&grid, x: 10, y: 6, color: darkGreen)
        } else {
            setPixel(&grid, x: 4, y: 6, color: darkGreen); setPixel(&grid, x: 11, y: 6, color: darkGreen)
        }
    }

    private func drawBatmanRiddler(grid: inout [[NSColor]], frame: Int) {
        let green = NSColor(red: 0.2, green: 0.6, blue: 0.25, alpha: 1.0)
        let yellow = NSColor(red: 0.92, green: 0.82, blue: 0.2, alpha: 1.0)
        let skin = NSColor(red: 0.95, green: 0.8, blue: 0.65, alpha: 1.0)
        let black = NSColor.black
        let anim = frame % 2

        for x in 5...10 { setPixel(&grid, x: x, y: 0, color: green) }
        for x in 4...11 { setPixel(&grid, x: x, y: 1, color: green) }
        for x in 4...11 { setPixel(&grid, x: x, y: 2, color: skin) }
        for x in 5...10 { setPixel(&grid, x: x, y: 3, color: skin) }
        setPixel(&grid, x: 6, y: 2, color: black); setPixel(&grid, x: 9, y: 2, color: black)
        setPixel(&grid, x: 7, y: 0, color: yellow); setPixel(&grid, x: 8, y: 0, color: yellow)
        for x in 4...11 { setPixel(&grid, x: x, y: 4, color: green) }
        for x in 4...11 { setPixel(&grid, x: x, y: 5, color: green) }
        setPixel(&grid, x: 7, y: 4, color: yellow); setPixel(&grid, x: 8, y: 5, color: yellow)
        if anim == 0 {
            setPixel(&grid, x: 5, y: 6, color: green); setPixel(&grid, x: 10, y: 6, color: green)
        } else {
            setPixel(&grid, x: 4, y: 6, color: green); setPixel(&grid, x: 11, y: 6, color: green)
        }
    }

    private func drawBatmanPenguin(grid: inout [[NSColor]], frame: Int) {
        let black = NSColor.black
        let white = NSColor.white
        let skin = NSColor(red: 0.95, green: 0.8, blue: 0.65, alpha: 1.0)
        let gray = NSColor(red: 0.5, green: 0.5, blue: 0.55, alpha: 1.0)
        let anim = frame % 2

        for x in 5...10 { setPixel(&grid, x: x, y: 0, color: black) }
        for x in 4...11 { setPixel(&grid, x: x, y: 1, color: black) }
        for x in 4...11 { setPixel(&grid, x: x, y: 2, color: skin) }
        for x in 5...10 { setPixel(&grid, x: x, y: 3, color: skin) }
        setPixel(&grid, x: 6, y: 2, color: black); setPixel(&grid, x: 9, y: 2, color: black)
        for x in 4...11 { setPixel(&grid, x: x, y: 4, color: black) }
        for x in 4...11 { setPixel(&grid, x: x, y: 5, color: black) }
        setPixel(&grid, x: 7, y: 4, color: white); setPixel(&grid, x: 8, y: 4, color: white)
        setPixel(&grid, x: 3, y: 5, color: gray); setPixel(&grid, x: 12, y: 5, color: gray)
        if anim == 0 {
            setPixel(&grid, x: 5, y: 6, color: black); setPixel(&grid, x: 10, y: 6, color: black)
        } else {
            setPixel(&grid, x: 4, y: 6, color: black); setPixel(&grid, x: 11, y: 6, color: black)
        }
    }

    private func drawBatmanHarleyQuinn(grid: inout [[NSColor]], frame: Int) {
        let red = NSColor(red: 0.85, green: 0.1, blue: 0.1, alpha: 1.0)
        let black = NSColor.black
        let white = NSColor.white
        let skin = NSColor(red: 0.95, green: 0.85, blue: 0.75, alpha: 1.0)
        let pink = NSColor(red: 0.95, green: 0.4, blue: 0.55, alpha: 1.0)
        let anim = frame % 2

        for x in 5...10 { setPixel(&grid, x: x, y: 0, color: black) }
        for x in 4...11 { setPixel(&grid, x: x, y: 1, color: red) }
        for x in 4...11 { setPixel(&grid, x: x, y: 2, color: skin) }
        for x in 5...10 { setPixel(&grid, x: x, y: 3, color: skin) }
        setPixel(&grid, x: 4, y: 1, color: black); setPixel(&grid, x: 11, y: 1, color: black)
        setPixel(&grid, x: 6, y: 2, color: black); setPixel(&grid, x: 9, y: 2, color: black)
        setPixel(&grid, x: 7, y: 3, color: red); setPixel(&grid, x: 8, y: 3, color: red)
        for x in 4...11 { setPixel(&grid, x: x, y: 4, color: red) }
        for x in 4...11 { setPixel(&grid, x: x, y: 5, color: black) }
        if anim == 0 {
            setPixel(&grid, x: 5, y: 6, color: black); setPixel(&grid, x: 10, y: 6, color: red)
        } else {
            setPixel(&grid, x: 4, y: 6, color: red); setPixel(&grid, x: 11, y: 6, color: black)
        }
    }

    private func drawBatmanScarecrow(grid: inout [[NSColor]], frame: Int) {
        let brown = NSColor(red: 0.45, green: 0.28, blue: 0.12, alpha: 1.0)
        let darkBrown = NSColor(red: 0.3, green: 0.18, blue: 0.08, alpha: 1.0)
        let skin = NSColor(red: 0.85, green: 0.7, blue: 0.55, alpha: 1.0)
        let black = NSColor.black
        let anim = frame % 2

        for x in 4...11 { setPixel(&grid, x: x, y: 0, color: brown) }
        for x in 3...12 { setPixel(&grid, x: x, y: 1, color: brown) }
        for x in 4...11 { setPixel(&grid, x: x, y: 2, color: skin) }
        for x in 5...10 { setPixel(&grid, x: x, y: 3, color: skin) }
        setPixel(&grid, x: 5, y: 1, color: darkBrown); setPixel(&grid, x: 10, y: 1, color: darkBrown)
        setPixel(&grid, x: 6, y: 2, color: black); setPixel(&grid, x: 9, y: 2, color: black)
        for x in 4...11 { setPixel(&grid, x: x, y: 4, color: brown) }
        for x in 4...11 { setPixel(&grid, x: x, y: 5, color: darkBrown) }
        if anim == 0 {
            setPixel(&grid, x: 5, y: 6, color: brown); setPixel(&grid, x: 10, y: 6, color: brown)
        } else {
            setPixel(&grid, x: 4, y: 6, color: brown); setPixel(&grid, x: 11, y: 6, color: brown)
        }
    }

    private func drawBatmanKillerCroc(grid: inout [[NSColor]], frame: Int) {
        let green = NSColor(red: 0.35, green: 0.55, blue: 0.3, alpha: 1.0)
        let darkGreen = NSColor(red: 0.25, green: 0.4, blue: 0.2, alpha: 1.0)
        let brown = NSColor(red: 0.4, green: 0.25, blue: 0.1, alpha: 1.0)
        let black = NSColor.black
        let anim = frame % 2

        for x in 4...11 { setPixel(&grid, x: x, y: 0, color: green) }
        for x in 3...12 { setPixel(&grid, x: x, y: 1, color: green) }
        for x in 3...12 { setPixel(&grid, x: x, y: 2, color: green) }
        for x in 4...11 { setPixel(&grid, x: x, y: 3, color: green) }
        setPixel(&grid, x: 5, y: 1, color: darkGreen); setPixel(&grid, x: 10, y: 1, color: darkGreen)
        setPixel(&grid, x: 6, y: 2, color: black); setPixel(&grid, x: 9, y: 2, color: black)
        for x in 3...12 { setPixel(&grid, x: x, y: 4, color: brown) }
        for x in 3...12 { setPixel(&grid, x: x, y: 5, color: brown) }
        if anim == 0 {
            setPixel(&grid, x: 5, y: 6, color: darkGreen); setPixel(&grid, x: 10, y: 6, color: darkGreen)
        } else {
            setPixel(&grid, x: 4, y: 6, color: darkGreen); setPixel(&grid, x: 11, y: 6, color: darkGreen)
        }
    }

    private func drawBatmanPoisonIvy(grid: inout [[NSColor]], frame: Int) {
        let green = NSColor(red: 0.2, green: 0.65, blue: 0.25, alpha: 1.0)
        let red = NSColor(red: 0.8, green: 0.15, blue: 0.1, alpha: 1.0)
        let skin = NSColor(red: 0.95, green: 0.8, blue: 0.65, alpha: 1.0)
        let black = NSColor.black
        let anim = frame % 2

        for x in 5...10 { setPixel(&grid, x: x, y: 0, color: red) }
        for x in 4...11 { setPixel(&grid, x: x, y: 1, color: red) }
        for x in 4...11 { setPixel(&grid, x: x, y: 2, color: skin) }
        for x in 5...10 { setPixel(&grid, x: x, y: 3, color: skin) }
        setPixel(&grid, x: 4, y: 1, color: green); setPixel(&grid, x: 11, y: 1, color: green)
        setPixel(&grid, x: 6, y: 2, color: NSColor(red: 0.2, green: 0.5, blue: 0.2, alpha: 1.0))
        setPixel(&grid, x: 9, y: 2, color: NSColor(red: 0.2, green: 0.5, blue: 0.2, alpha: 1.0))
        for x in 4...11 { setPixel(&grid, x: x, y: 4, color: green) }
        for x in 4...11 { setPixel(&grid, x: x, y: 5, color: green) }
        if anim == 0 {
            setPixel(&grid, x: 5, y: 6, color: green); setPixel(&grid, x: 10, y: 6, color: green)
        } else {
            setPixel(&grid, x: 4, y: 6, color: green); setPixel(&grid, x: 11, y: 6, color: green)
        }
    }

    private func drawBatmanCatwoman(grid: inout [[NSColor]], frame: Int) {
        let black = NSColor.black
        let darkGray = NSColor(red: 0.25, green: 0.25, blue: 0.28, alpha: 1.0)
        let brown = NSColor(red: 0.45, green: 0.25, blue: 0.1, alpha: 1.0)
        let skin = NSColor(red: 0.95, green: 0.8, blue: 0.65, alpha: 1.0)
        let anim = frame % 2

        setPixel(&grid, x: 4, y: 0, color: black); setPixel(&grid, x: 11, y: 0, color: black)
        for x in 5...10 { setPixel(&grid, x: x, y: 0, color: black) }
        for x in 4...11 { setPixel(&grid, x: x, y: 1, color: brown) }
        for x in 4...11 { setPixel(&grid, x: x, y: 2, color: skin) }
        for x in 5...10 { setPixel(&grid, x: x, y: 3, color: skin) }
        setPixel(&grid, x: 6, y: 2, color: NSColor(red: 0.2, green: 0.6, blue: 0.3, alpha: 1.0))
        setPixel(&grid, x: 9, y: 2, color: NSColor(red: 0.2, green: 0.6, blue: 0.3, alpha: 1.0))
        for x in 4...11 { setPixel(&grid, x: x, y: 4, color: black) }
        for x in 4...11 { setPixel(&grid, x: x, y: 5, color: darkGray) }
        if anim == 0 {
            setPixel(&grid, x: 5, y: 6, color: black); setPixel(&grid, x: 10, y: 6, color: black)
        } else {
            setPixel(&grid, x: 4, y: 6, color: black); setPixel(&grid, x: 11, y: 6, color: black)
        }
    }

    private func drawBatmanTwoFace(grid: inout [[NSColor]], frame: Int) {
        let skin = NSColor(red: 0.95, green: 0.8, blue: 0.65, alpha: 1.0)
        let purple = NSColor(red: 0.55, green: 0.15, blue: 0.65, alpha: 1.0)
        let blue = NSColor(red: 0.15, green: 0.3, blue: 0.7, alpha: 1.0)
        let black = NSColor.black
        let red = NSColor(red: 0.8, green: 0.1, blue: 0.1, alpha: 1.0)
        let anim = frame % 2

        for x in 5...10 { setPixel(&grid, x: x, y: 0, color: black) }
        for x in 4...11 { setPixel(&grid, x: x, y: 1, color: black) }
        for x in 4...11 { setPixel(&grid, x: x, y: 2, color: skin) }
        for x in 5...10 { setPixel(&grid, x: x, y: 3, color: skin) }
        setPixel(&grid, x: 5, y: 2, color: skin); setPixel(&grid, x: 6, y: 2, color: skin)
        setPixel(&grid, x: 7, y: 2, color: red); setPixel(&grid, x: 8, y: 2, color: red)
        setPixel(&grid, x: 9, y: 2, color: red); setPixel(&grid, x: 10, y: 2, color: red)
        for x in 4...7 { setPixel(&grid, x: x, y: 4, color: blue) }
        for x in 8...11 { setPixel(&grid, x: x, y: 4, color: purple) }
        for x in 4...7 { setPixel(&grid, x: x, y: 5, color: blue) }
        for x in 8...11 { setPixel(&grid, x: x, y: 5, color: purple) }
        if anim == 0 {
            setPixel(&grid, x: 5, y: 6, color: blue); setPixel(&grid, x: 10, y: 6, color: purple)
        } else {
            setPixel(&grid, x: 4, y: 6, color: blue); setPixel(&grid, x: 11, y: 6, color: purple)
        }
    }

    private func drawBatmanMrFreeze(grid: inout [[NSColor]], frame: Int) {
        let blue = NSColor(red: 0.3, green: 0.5, blue: 0.85, alpha: 1.0)
        let lightBlue = NSColor(red: 0.5, green: 0.7, blue: 0.95, alpha: 1.0)
        let silver = NSColor(red: 0.75, green: 0.75, blue: 0.8, alpha: 1.0)
        let black = NSColor.black
        let red = NSColor(red: 0.85, green: 0.12, blue: 0.1, alpha: 1.0)
        let anim = frame % 2

        for x in 5...10 { setPixel(&grid, x: x, y: 0, color: lightBlue) }
        for x in 4...11 { setPixel(&grid, x: x, y: 1, color: lightBlue) }
        for x in 4...11 { setPixel(&grid, x: x, y: 2, color: blue) }
        for x in 5...10 { setPixel(&grid, x: x, y: 3, color: blue) }
        setPixel(&grid, x: 6, y: 2, color: red); setPixel(&grid, x: 9, y: 2, color: red)
        for x in 4...11 { setPixel(&grid, x: x, y: 4, color: silver) }
        for x in 4...11 { setPixel(&grid, x: x, y: 5, color: silver) }
        if anim == 0 {
            setPixel(&grid, x: 5, y: 6, color: blue); setPixel(&grid, x: 10, y: 6, color: blue)
        } else {
            setPixel(&grid, x: 4, y: 6, color: blue); setPixel(&grid, x: 11, y: 6, color: blue)
        }
    }

    private func drawBatmanRedHood(grid: inout [[NSColor]], frame: Int) {
        let red = NSColor(red: 0.85, green: 0.12, blue: 0.1, alpha: 1.0)
        let black = NSColor.black
        let darkGray = NSColor(red: 0.2, green: 0.2, blue: 0.22, alpha: 1.0)
        let brown = NSColor(red: 0.45, green: 0.25, blue: 0.1, alpha: 1.0)
        let anim = frame % 2

        for x in 5...10 { setPixel(&grid, x: x, y: 0, color: red) }
        for x in 4...11 { setPixel(&grid, x: x, y: 1, color: red) }
        for x in 4...11 { setPixel(&grid, x: x, y: 2, color: black) }
        for x in 5...10 { setPixel(&grid, x: x, y: 3, color: black) }
        setPixel(&grid, x: 6, y: 2, color: red); setPixel(&grid, x: 9, y: 2, color: red)
        for x in 4...11 { setPixel(&grid, x: x, y: 4, color: darkGray) }
        for x in 4...11 { setPixel(&grid, x: x, y: 5, color: darkGray) }
        if anim == 0 {
            setPixel(&grid, x: 5, y: 6, color: darkGray); setPixel(&grid, x: 10, y: 6, color: darkGray)
        } else {
            setPixel(&grid, x: 4, y: 6, color: darkGray); setPixel(&grid, x: 11, y: 6, color: darkGray)
        }
    }

    private func drawBatmanRasAlGhul(grid: inout [[NSColor]], frame: Int) {
        let white = NSColor.white
        let black = NSColor.black
        let skin = NSColor(red: 0.95, green: 0.8, blue: 0.65, alpha: 1.0)
        let green = NSColor(red: 0.15, green: 0.45, blue: 0.2, alpha: 1.0)
        let anim = frame % 2

        for x in 5...10 { setPixel(&grid, x: x, y: 0, color: black) }
        for x in 4...11 { setPixel(&grid, x: x, y: 1, color: black) }
        for x in 4...11 { setPixel(&grid, x: x, y: 2, color: skin) }
        for x in 5...10 { setPixel(&grid, x: x, y: 3, color: skin) }
        setPixel(&grid, x: 5, y: 1, color: white); setPixel(&grid, x: 10, y: 1, color: white)
        setPixel(&grid, x: 6, y: 2, color: black); setPixel(&grid, x: 9, y: 2, color: black)
        setPixel(&grid, x: 7, y: 3, color: white); setPixel(&grid, x: 8, y: 3, color: white)
        for x in 4...11 { setPixel(&grid, x: x, y: 4, color: green) }
        for x in 4...11 { setPixel(&grid, x: x, y: 5, color: green) }
        if anim == 0 {
            setPixel(&grid, x: 5, y: 6, color: green); setPixel(&grid, x: 10, y: 6, color: green)
        } else {
            setPixel(&grid, x: 4, y: 6, color: green); setPixel(&grid, x: 11, y: 6, color: green)
        }
    }

    private func drawBatmanDeathstroke(grid: inout [[NSColor]], frame: Int) {
        let orange = NSColor(red: 0.9, green: 0.55, blue: 0.1, alpha: 1.0)
        let black = NSColor.black
        let darkGray = NSColor(red: 0.2, green: 0.2, blue: 0.22, alpha: 1.0)
        let anim = frame % 2

        for x in 5...10 { setPixel(&grid, x: x, y: 0, color: orange) }
        for x in 4...11 { setPixel(&grid, x: x, y: 1, color: orange) }
        for x in 4...11 { setPixel(&grid, x: x, y: 2, color: black) }
        for x in 5...10 { setPixel(&grid, x: x, y: 3, color: black) }
        setPixel(&grid, x: 6, y: 2, color: orange); setPixel(&grid, x: 9, y: 2, color: orange)
        for x in 4...11 { setPixel(&grid, x: x, y: 4, color: orange) }
        for x in 4...11 { setPixel(&grid, x: x, y: 5, color: darkGray) }
        if anim == 0 {
            setPixel(&grid, x: 5, y: 6, color: darkGray); setPixel(&grid, x: 10, y: 6, color: darkGray)
        } else {
            setPixel(&grid, x: 4, y: 6, color: darkGray); setPixel(&grid, x: 11, y: 6, color: darkGray)
        }
    }

    // MARK: - Futurama Characters
    private func drawFuturamaFry(grid: inout [[NSColor]], frame: Int) {
        let red = NSColor(red: 0.85, green: 0.2, blue: 0.15, alpha: 1.0)
        let brown = NSColor(red: 0.55, green: 0.3, blue: 0.1, alpha: 1.0)
        let skin = NSColor(red: 0.95, green: 0.8, blue: 0.65, alpha: 1.0)
        let black = NSColor.black
        let white = NSColor.white
        let blue = NSColor(red: 0.2, green: 0.4, blue: 0.8, alpha: 1.0)
        let anim = frame % 2
        // Hair
        for x in 6...9 { setPixel(&grid, x: x, y: 1, color: brown) }
        for x in 5...10 { setPixel(&grid, x: x, y: 2, color: brown) }
        // Head
        for x in 6...9 { setPixel(&grid, x: x, y: 3, color: skin) }
        for x in 5...10 { setPixel(&grid, x: x, y: 4, color: skin) }
        // Eyes
        setPixel(&grid, x: 6, y: 3, color: white); setPixel(&grid, x: 9, y: 3, color: white)
        setPixel(&grid, x: 6, y: 3, color: black); setPixel(&grid, x: 9, y: 3, color: black)
        // Jacket
        for x in 4...11 { setPixel(&grid, x: x, y: 5, color: red) }
        for x in 4...11 { setPixel(&grid, x: x, y: 6, color: red) }
        // Shirt
        for x in 6...9 { setPixel(&grid, x: x, y: 6, color: white) }
        // Pants
        for x in 5...10 { setPixel(&grid, x: x, y: 7, color: blue) }
        // Legs
        if anim == 0 {
            setPixel(&grid, x: 6, y: 8, color: blue); setPixel(&grid, x: 9, y: 8, color: blue)
        } else {
            setPixel(&grid, x: 5, y: 8, color: blue); setPixel(&grid, x: 10, y: 8, color: blue)
        }
    }

    private func drawFuturamaLeela(grid: inout [[NSColor]], frame: Int) {
        let pink = NSColor(red: 0.95, green: 0.7, blue: 0.8, alpha: 1.0)
        let skin = NSColor(red: 0.95, green: 0.8, blue: 0.65, alpha: 1.0)
        let black = NSColor.black
        let white = NSColor.white
        let purple = NSColor(red: 0.6, green: 0.3, blue: 0.7, alpha: 1.0)
        let anim = frame % 2
        // Hair (ponytail)
        setPixel(&grid, x: 10, y: 1, color: pink); setPixel(&grid, x: 10, y: 2, color: pink)
        for x in 6...9 { setPixel(&grid, x: x, y: 2, color: pink) }
        // Head
        for x in 5...10 { setPixel(&grid, x: x, y: 3, color: skin) }
        for x in 5...10 { setPixel(&grid, x: x, y: 4, color: skin) }
        // Big single eye
        setPixel(&grid, x: 7, y: 3, color: white); setPixel(&grid, x: 8, y: 3, color: white)
        setPixel(&grid, x: 7, y: 4, color: white); setPixel(&grid, x: 8, y: 4, color: white)
        setPixel(&grid, x: 7, y: 3, color: black); setPixel(&grid, x: 8, y: 4, color: black)
        // Outfit
        for x in 5...10 { setPixel(&grid, x: x, y: 5, color: purple) }
        for x in 5...10 { setPixel(&grid, x: x, y: 6, color: purple) }
        // Legs
        if anim == 0 {
            setPixel(&grid, x: 6, y: 7, color: purple); setPixel(&grid, x: 9, y: 7, color: purple)
        } else {
            setPixel(&grid, x: 5, y: 7, color: purple); setPixel(&grid, x: 10, y: 7, color: purple)
        }
    }

    private func drawFuturamaBender(grid: inout [[NSColor]], frame: Int) {
        let gray = NSColor(red: 0.7, green: 0.7, blue: 0.72, alpha: 1.0)
        let darkGray = NSColor(red: 0.5, green: 0.5, blue: 0.52, alpha: 1.0)
        let black = NSColor.black
        let white = NSColor.white
        let red = NSColor(red: 0.85, green: 0.2, blue: 0.15, alpha: 1.0)
        let anim = frame % 2
        // Antenna
        setPixel(&grid, x: 7, y: 0, color: gray); setPixel(&grid, x: 8, y: 0, color: gray)
        // Head
        for x in 5...10 { setPixel(&grid, x: x, y: 1, color: gray) }
        for x in 5...10 { setPixel(&grid, x: x, y: 2, color: gray) }
        // Eyes
        setPixel(&grid, x: 6, y: 1, color: white); setPixel(&grid, x: 9, y: 1, color: white)
        setPixel(&grid, x: 6, y: 1, color: black); setPixel(&grid, x: 9, y: 1, color: black)
        // Mouth
        setPixel(&grid, x: 6, y: 2, color: black); setPixel(&grid, x: 7, y: 2, color: black)
        setPixel(&grid, x: 8, y: 2, color: black); setPixel(&grid, x: 9, y: 2, color: black)
        // Body
        for x in 5...10 { setPixel(&grid, x: x, y: 3, color: gray) }
        for x in 5...10 { setPixel(&grid, x: x, y: 4, color: gray) }
        // Door
        setPixel(&grid, x: 7, y: 3, color: darkGray); setPixel(&grid, x: 8, y: 3, color: darkGray)
        // Legs
        if anim == 0 {
            setPixel(&grid, x: 6, y: 5, color: gray); setPixel(&grid, x: 9, y: 5, color: gray)
        } else {
            setPixel(&grid, x: 5, y: 5, color: gray); setPixel(&grid, x: 10, y: 5, color: gray)
        }
    }

    private func drawFuturamaAmy(grid: inout [[NSColor]], frame: Int) {
        let pink = NSColor(red: 0.95, green: 0.6, blue: 0.7, alpha: 1.0)
        let skin = NSColor(red: 0.95, green: 0.8, blue: 0.65, alpha: 1.0)
        let black = NSColor.black
        let red = NSColor(red: 0.85, green: 0.2, blue: 0.15, alpha: 1.0)
        let anim = frame % 2
        // Hair
        for x in 5...10 { setPixel(&grid, x: x, y: 1, color: pink) }
        for x in 5...10 { setPixel(&grid, x: x, y: 2, color: pink) }
        // Head
        for x in 6...9 { setPixel(&grid, x: x, y: 3, color: skin) }
        for x in 5...10 { setPixel(&grid, x: x, y: 4, color: skin) }
        // Eyes
        setPixel(&grid, x: 6, y: 3, color: black); setPixel(&grid, x: 9, y: 3, color: black)
        // Glasses
        setPixel(&grid, x: 5, y: 3, color: red); setPixel(&grid, x: 10, y: 3, color: red)
        // Outfit
        for x in 5...10 { setPixel(&grid, x: x, y: 5, color: red) }
        for x in 5...10 { setPixel(&grid, x: x, y: 6, color: red) }
        // Legs
        if anim == 0 {
            setPixel(&grid, x: 6, y: 7, color: skin); setPixel(&grid, x: 9, y: 7, color: skin)
        } else {
            setPixel(&grid, x: 5, y: 7, color: skin); setPixel(&grid, x: 10, y: 7, color: skin)
        }
    }

    private func drawFuturamaFarnsworth(grid: inout [[NSColor]], frame: Int) {
        let yellow = NSColor(red: 0.95, green: 0.85, blue: 0.4, alpha: 1.0)
        let white = NSColor.white
        let black = NSColor.black
        let gray = NSColor(red: 0.7, green: 0.7, blue: 0.72, alpha: 1.0)
        let anim = frame % 2
        // Glasses
        for x in 5...10 { setPixel(&grid, x: x, y: 1, color: yellow) }
        setPixel(&grid, x: 6, y: 1, color: white); setPixel(&grid, x: 9, y: 1, color: white)
        setPixel(&grid, x: 6, y: 1, color: black); setPixel(&grid, x: 9, y: 1, color: black)
        // Head
        for x in 6...9 { setPixel(&grid, x: x, y: 2, color: yellow) }
        for x in 5...10 { setPixel(&grid, x: x, y: 3, color: yellow) }
        // Lab coat
        for x in 4...11 { setPixel(&grid, x: x, y: 4, color: white) }
        for x in 4...11 { setPixel(&grid, x: x, y: 5, color: white) }
        // Legs
        if anim == 0 {
            setPixel(&grid, x: 6, y: 6, color: gray); setPixel(&grid, x: 9, y: 6, color: gray)
        } else {
            setPixel(&grid, x: 5, y: 6, color: gray); setPixel(&grid, x: 10, y: 6, color: gray)
        }
    }

    private func drawFuturamaHermes(grid: inout [[NSColor]], frame: Int) {
        let brown = NSColor(red: 0.55, green: 0.3, blue: 0.1, alpha: 1.0)
        let skin = NSColor(red: 0.65, green: 0.45, blue: 0.25, alpha: 1.0)
        let black = NSColor.black
        let white = NSColor.white
        let green = NSColor(red: 0.2, green: 0.6, blue: 0.3, alpha: 1.0)
        let anim = frame % 2
        // Hair
        for x in 6...9 { setPixel(&grid, x: x, y: 1, color: brown) }
        // Head
        for x in 5...10 { setPixel(&grid, x: x, y: 2, color: skin) }
        for x in 5...10 { setPixel(&grid, x: x, y: 3, color: skin) }
        // Eyes
        setPixel(&grid, x: 6, y: 2, color: white); setPixel(&grid, x: 9, y: 2, color: white)
        setPixel(&grid, x: 6, y: 2, color: black); setPixel(&grid, x: 9, y: 2, color: black)
        // Shirt
        for x in 5...10 { setPixel(&grid, x: x, y: 4, color: green) }
        for x in 5...10 { setPixel(&grid, x: x, y: 5, color: green) }
        // Legs
        if anim == 0 {
            setPixel(&grid, x: 6, y: 6, color: green); setPixel(&grid, x: 9, y: 6, color: green)
        } else {
            setPixel(&grid, x: 5, y: 6, color: green); setPixel(&grid, x: 10, y: 6, color: green)
        }
    }

    private func drawFuturamaZoidberg(grid: inout [[NSColor]], frame: Int) {
        let red = NSColor(red: 0.85, green: 0.3, blue: 0.25, alpha: 1.0)
        let white = NSColor.white
        let black = NSColor.black
        let pink = NSColor(red: 0.95, green: 0.6, blue: 0.65, alpha: 1.0)
        let anim = frame % 2
        // Head (tentacles)
        for x in 5...10 { setPixel(&grid, x: x, y: 1, color: red) }
        setPixel(&grid, x: 5, y: 0, color: red); setPixel(&grid, x: 10, y: 0, color: red)
        // Body
        for x in 5...10 { setPixel(&grid, x: x, y: 2, color: red) }
        for x in 5...10 { setPixel(&grid, x: x, y: 3, color: red) }
        // Eyes
        setPixel(&grid, x: 6, y: 1, color: white); setPixel(&grid, x: 9, y: 1, color: white)
        setPixel(&grid, x: 6, y: 1, color: black); setPixel(&grid, x: 9, y: 1, color: black)
        // Coat
        for x in 4...11 { setPixel(&grid, x: x, y: 4, color: white) }
        for x in 4...11 { setPixel(&grid, x: x, y: 5, color: white) }
        // Claws
        if anim == 0 {
            setPixel(&grid, x: 4, y: 4, color: pink); setPixel(&grid, x: 11, y: 4, color: pink)
        } else {
            setPixel(&grid, x: 3, y: 4, color: pink); setPixel(&grid, x: 12, y: 4, color: pink)
        }
    }

    private func drawFuturamaCubert(grid: inout [[NSColor]], frame: Int) {
        let skin = NSColor(red: 0.95, green: 0.8, blue: 0.65, alpha: 1.0)
        let black = NSColor.black
        let gray = NSColor(red: 0.6, green: 0.6, blue: 0.62, alpha: 1.0)
        let anim = frame % 2
        // Glasses
        for x in 5...10 { setPixel(&grid, x: x, y: 1, color: gray) }
        setPixel(&grid, x: 6, y: 1, color: black); setPixel(&grid, x: 9, y: 1, color: black)
        // Head
        for x in 6...9 { setPixel(&grid, x: x, y: 2, color: skin) }
        for x in 5...10 { setPixel(&grid, x: x, y: 3, color: skin) }
        // Body
        for x in 5...10 { setPixel(&grid, x: x, y: 4, color: gray) }
        for x in 5...10 { setPixel(&grid, x: x, y: 5, color: gray) }
        // Legs
        if anim == 0 {
            setPixel(&grid, x: 6, y: 6, color: gray); setPixel(&grid, x: 9, y: 6, color: gray)
        } else {
            setPixel(&grid, x: 5, y: 6, color: gray); setPixel(&grid, x: 10, y: 6, color: gray)
        }
    }

    private func drawFuturamaNdnd(grid: inout [[NSColor]], frame: Int) {
        let green = NSColor(red: 0.3, green: 0.7, blue: 0.3, alpha: 1.0)
        let black = NSColor.black
        let white = NSColor.white
        let anim = frame % 2
        // Antenna
        setPixel(&grid, x: 7, y: 0, color: green); setPixel(&grid, x: 8, y: 0, color: green)
        // Head
        for x in 5...10 { setPixel(&grid, x: x, y: 1, color: green) }
        for x in 5...10 { setPixel(&grid, x: x, y: 2, color: green) }
        // Eyes
        setPixel(&grid, x: 6, y: 1, color: white); setPixel(&grid, x: 9, y: 1, color: white)
        setPixel(&grid, x: 6, y: 1, color: black); setPixel(&grid, x: 9, y: 1, color: black)
        // Body
        for x in 4...11 { setPixel(&grid, x: x, y: 3, color: green) }
        for x in 4...11 { setPixel(&grid, x: x, y: 4, color: green) }
        // Legs
        if anim == 0 {
            setPixel(&grid, x: 5, y: 5, color: green); setPixel(&grid, x: 10, y: 5, color: green)
        } else {
            setPixel(&grid, x: 4, y: 5, color: green); setPixel(&grid, x: 11, y: 5, color: green)
        }
    }

    private func drawFuturamaZapp(grid: inout [[NSColor]], frame: Int) {
        let beige = NSColor(red: 0.85, green: 0.75, blue: 0.55, alpha: 1.0)
        let skin = NSColor(red: 0.95, green: 0.8, blue: 0.65, alpha: 1.0)
        let black = NSColor.black
        let white = NSColor.white
        let gold = NSColor(red: 0.9, green: 0.8, blue: 0.2, alpha: 1.0)
        let anim = frame % 2
        // Chest hair
        for x in 5...10 { setPixel(&grid, x: x, y: 1, color: beige) }
        // Head
        for x in 5...10 { setPixel(&grid, x: x, y: 2, color: skin) }
        for x in 5...10 { setPixel(&grid, x: x, y: 3, color: skin) }
        // Eyes
        setPixel(&grid, x: 6, y: 2, color: white); setPixel(&grid, x: 9, y: 2, color: white)
        setPixel(&grid, x: 6, y: 2, color: black); setPixel(&grid, x: 9, y: 2, color: black)
        // Uniform
        for x in 4...11 { setPixel(&grid, x: x, y: 4, color: beige) }
        for x in 4...11 { setPixel(&grid, x: x, y: 5, color: beige) }
        // Medal
        setPixel(&grid, x: 7, y: 4, color: gold); setPixel(&grid, x: 8, y: 4, color: gold)
        // Legs
        if anim == 0 {
            setPixel(&grid, x: 6, y: 6, color: beige); setPixel(&grid, x: 9, y: 6, color: beige)
        } else {
            setPixel(&grid, x: 5, y: 6, color: beige); setPixel(&grid, x: 10, y: 6, color: beige)
        }
    }

    func setPixel(_ grid: inout [[NSColor]], x: Int, y: Int, color: NSColor) {
        guard y >= 0 && y < grid.count && x >= 0 && x < grid[0].count else { return }
        grid[y][x] = color
    }
}
