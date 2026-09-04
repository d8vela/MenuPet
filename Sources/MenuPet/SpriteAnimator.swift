import AppKit

class SpriteAnimator {
    private let cpuMonitor: CPUMonitor
    private let spriteRenderer = SpriteRenderer()
    private var currentFrameIndex = 0
    private var frameTimer: Timer?
    private var animationSpeed: TimeInterval = 0.5
    private var rotationTimer: Timer?
    private var onPokemonChanged: (() -> Void)?
    private(set) var rotationEnabled = UserDefaults.standard.bool(forKey: "rotationEnabled")
    private(set) var smartRotationEnabled = UserDefaults.standard.bool(forKey: "smartRotationEnabled")
    private var selectionCounts: [SelectableCharacter: Int] = [:]
    private(set) var characterHistory: [SelectableCharacter] = []
    private let maxHistorySize = 20

    var currentPokemon: SelectableCharacter = {
        if let saved = UserDefaults.standard.string(forKey: "lastSelectedCharacter"),
           let character = SelectableCharacter.from(identifier: saved) {
            return character
        }
        return .pokemon(.jigglypuff)
    }()
    var speedLabel: String = "Idle"

    var currentFrame: NSImage {
        return spriteRenderer.renderFrame(character: currentPokemon, frame: currentFrameIndex)
    }

    init(cpuMonitor: CPUMonitor) {
        self.cpuMonitor = cpuMonitor
        loadHistory()
        startAnimation()
        if rotationEnabled {
            startRotation()
        }
    }

    func setPokemon(_ pokemon: SelectableCharacter) {
        currentPokemon = pokemon
        selectionCounts[pokemon, default: 0] += 1
        addToHistory(pokemon)
        UserDefaults.standard.set(pokemon.identifier, forKey: "lastSelectedCharacter")
    }

    func setOnPokemonChanged(_ handler: @escaping () -> Void) {
        onPokemonChanged = handler
    }

    private func addToHistory(_ character: SelectableCharacter) {
        characterHistory.removeAll { $0 == character }
        characterHistory.insert(character, at: 0)
        if characterHistory.count > maxHistorySize {
            characterHistory = Array(characterHistory.prefix(maxHistorySize))
        }
        saveHistory()
    }

    private func saveHistory() {
        let identifiers = characterHistory.map { $0.identifier }
        UserDefaults.standard.set(identifiers, forKey: "characterHistory")
    }

    private func loadHistory() {
        if let saved = UserDefaults.standard.stringArray(forKey: "characterHistory") {
            characterHistory = saved.compactMap { SelectableCharacter.from(identifier: $0) }
        }
    }

    func toggleRotation() {
        rotationEnabled.toggle()
        UserDefaults.standard.set(rotationEnabled, forKey: "rotationEnabled")
        if rotationEnabled {
            startRotation()
        } else {
            rotationTimer?.invalidate()
            rotationTimer = nil
        }
    }

    func toggleSmartRotation() {
        smartRotationEnabled.toggle()
        UserDefaults.standard.set(smartRotationEnabled, forKey: "smartRotationEnabled")
    }

    private func startRotation() {
        let allCharacters: [SelectableCharacter] =
            PokemonCharacter.allCases.map { .pokemon($0) } +
            MarioItem.allCases.map { .marioItem($0) } +
            MarioKartCharacter.allCases.map { .marioKart($0) } +
            ContraCharacter.allCases.map { .contra($0) } +
            TMNTCharacter.allCases.map { .tmnt($0) } +
            StreetFighterCharacter.allCases.map { .streetFighter($0) } +
            MetalSlugCharacter.allCases.map { .metalSlug($0) } +
            OverwatchCharacter.allCases.map { .overwatch($0) } +
            KirbyCharacter.allCases.map { .kirby($0) } +
            ZeldaCharacter.allCases.map { .zelda($0) } +
            MegaManCharacter.allCases.map { .megaMan($0) } +
            MarvelCharacter.allCases.map { .marvel($0) } +
            DCCharacter.allCases.map { .dc($0) } +
            NarutoCharacter.allCases.map { .naruto($0) } +
            SimpsonsCharacter.allCases.map { .simpsons($0) } +
            MortalKombatCharacter.allCases.map { .mortalKombat($0) } +
            MinionsCharacter.allCases.map { .minions($0) } +
            DragonBallCharacter.allCases.map { .dragonBall($0) } +
            GhibliCharacter.allCases.map { .ghibli($0) } +
            GundamCharacter.allCases.map { .gundam($0) } +
            StarWarsCharacter.allCases.map { .starWars($0) } +
            LabubuCharacter.allCases.map { .labubu($0) } +
            KingOfTheHillCharacter.allCases.map { .kingOfTheHill($0) } +
            FamilyGuyCharacter.allCases.map { .familyGuy($0) } +
            FuturamaCharacter.allCases.map { .futurama($0) }

        rotationTimer = Timer.scheduledTimer(withTimeInterval: 600, repeats: true) { [weak self] _ in
            guard let self = self else { return }
            var next = self.currentPokemon
            var attempts = 0
            while next == self.currentPokemon && attempts < 10 {
                if self.smartRotationEnabled && !self.selectionCounts.isEmpty {
                    next = self.weightedRandom(from: allCharacters)
                } else {
                    next = allCharacters.randomElement() ?? .pokemon(.jigglypuff)
                }
                attempts += 1
            }
            self.selectionCounts.removeAll()
            self.currentPokemon = next
            self.addToHistory(next)
            UserDefaults.standard.set(next.identifier, forKey: "lastSelectedCharacter")
            self.onPokemonChanged?()
        }
    }

    private func weightedRandom(from characters: [SelectableCharacter]) -> SelectableCharacter {
        var weighted: [(SelectableCharacter, Int)] = []
        for char in characters {
            let count = selectionCounts[char, default: 0]
            let weight = count > 0 ? count + 1 : 1
            weighted.append((char, weight))
        }
        let totalWeight = weighted.reduce(0) { $0 + $1.1 }
        guard totalWeight > 0 else { return characters.randomElement() ?? .pokemon(.jigglypuff) }
        var random = Int.random(in: 0..<totalWeight)
        for (char, weight) in weighted {
            random -= weight
            if random < 0 {
                return char
            }
        }
        return weighted.last?.0 ?? .pokemon(.jigglypuff)
    }

    func updateSpeed(cpuUsage: Double) {
        let newSpeed: TimeInterval
        let newLabel: String

        switch cpuUsage {
        case 0..<10:
            newSpeed = 1.0
            newLabel = "Sleeping 💤"
        case 10..<25:
            newSpeed = 0.7
            newLabel = "Walking 🚶"
        case 25..<50:
            newSpeed = 0.4
            newLabel = "Jogging 🏃"
        case 50..<75:
            newSpeed = 0.2
            newLabel = "Running 🏃‍♂️💨"
        case 75..<90:
            newSpeed = 0.1
            newLabel = "Sprinting ⚡🏃‍♂️💨"
        default:
            newSpeed = 0.05
            newLabel = "Overdrive 🔥⚡🏃‍♂️💨"
        }

        speedLabel = newLabel
        if abs(animationSpeed - newSpeed) > 0.001 {
            animationSpeed = newSpeed
            restartAnimation()
        }
    }

    private func startAnimation() {
        frameTimer = Timer.scheduledTimer(withTimeInterval: animationSpeed, repeats: true) { [weak self] _ in
            self?.advanceFrame()
        }
    }

    private func restartAnimation() {
        frameTimer?.invalidate()
        startAnimation()
    }

    private func advanceFrame() {
        currentFrameIndex = (currentFrameIndex + 1) % 4
    }
}
