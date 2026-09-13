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
    private(set) var categoryOnlyEnabled = UserDefaults.standard.bool(forKey: "categoryOnlyEnabled")
    private(set) var rotationInterval: TimeInterval = {
        let saved = UserDefaults.standard.double(forKey: "rotationInterval")
        return saved > 0 ? max(saved, 0.01) : 600
    }()
    private var selectionCounts: [SelectableCharacter: Int] = [:]
    private(set) var characterHistory: [SelectableCharacter] = []
    private let maxHistorySize = 20

    // Transformer transformation state
    private var transformTimer: Timer?
    private var transformHoldTimer: Timer?
    private var transformFrameIndex = 0
    private var isTransformingToVehicle = false
    private var isTransformingToRobot = false
    private var isInVehicleMode = false

    var currentPokemon: SelectableCharacter = {
        if let saved = UserDefaults.standard.string(forKey: "lastSelectedCharacter"),
           let character = SelectableCharacter.from(identifier: saved) {
            return character
        }
        return .pokemon(.jigglypuff)
    }()
    var llmStatus: String?
    var speedLabel: String = "Idle"

    var currentFrame: NSImage {
        if isTransformerCharacter(currentPokemon) && (isTransformingToVehicle || isTransformingToRobot || isInVehicleMode) {
            return spriteRenderer.renderFrame(character: currentPokemon, frame: transformFrameIndex, sparkleFrame: currentFrameIndex)
        }
        if isTransformerCharacter(currentPokemon) {
            return spriteRenderer.renderFrame(character: currentPokemon, frame: currentFrameIndex % 2, sparkleFrame: currentFrameIndex)
        }
        return spriteRenderer.renderFrame(character: currentPokemon, frame: currentFrameIndex)
    }

    private func isTransformerCharacter(_ character: SelectableCharacter) -> Bool {
        if case .transformers(_) = character { return true }
        return false
    }

    init(cpuMonitor: CPUMonitor) {
        self.cpuMonitor = cpuMonitor
        loadHistory()
        startAnimation()
        if rotationEnabled {
            startRotation()
        }
        if isTransformerCharacter(currentPokemon) {
            scheduleNextTransformation()
        }
    }

    func setPokemon(_ pokemon: SelectableCharacter) {
        let wasTransformer = isTransformerCharacter(currentPokemon)
        let isNowTransformer = isTransformerCharacter(pokemon)

        currentPokemon = pokemon
        selectionCounts[pokemon, default: 0] += 1
        addToHistory(pokemon)
        UserDefaults.standard.set(pokemon.identifier, forKey: "lastSelectedCharacter")

        if wasTransformer && !isNowTransformer {
            resetTransformationState()
        } else if isNowTransformer {
            resetTransformationState()
            scheduleNextTransformation()
        }
    }

    private func resetTransformationState() {
        transformTimer?.invalidate()
        transformTimer = nil
        transformHoldTimer?.invalidate()
        transformHoldTimer = nil
        isTransformingToVehicle = false
        isTransformingToRobot = false
        isInVehicleMode = false
        transformFrameIndex = 0
    }

    private func scheduleNextTransformation() {
        transformTimer?.invalidate()
        let half = transformInterval / 2
        let delay = TimeInterval.random(in: half...(transformInterval + half))
        transformTimer = Timer.scheduledTimer(withTimeInterval: delay, repeats: false) { [weak self] _ in
            self?.startTransformation()
        }
    }

    private func startTransformation() {
        guard isTransformerCharacter(currentPokemon) else { return }
        isTransformingToVehicle = true
        transformFrameIndex = 0

        var forwardSteps = 0
        let transformTimer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { [weak self] timer in
            guard let self = self else { timer.invalidate(); return }
            if self.isTransformingToVehicle {
                forwardSteps += 1
                if forwardSteps == 1 {
                    self.transformFrameIndex = 2
                } else if forwardSteps >= 2 {
                    self.transformFrameIndex = 3
                    timer.invalidate()
                    self.isTransformingToVehicle = false
                    self.isInVehicleMode = true
                    self.startVehicleHold()
                    self.onTransformStateChanged?()
                }
                self.onFrameAdvanced?()
            }
        }
        self.transformTimer = transformTimer
    }

    private func startVehicleHold() {
        transformHoldTimer?.invalidate()
        let delay = TimeInterval.random(in: 60...180)
        transformHoldTimer = Timer.scheduledTimer(withTimeInterval: delay, repeats: false) { [weak self] _ in
            self?.startReverseTransformation()
        }
    }

    private func startReverseTransformation() {
        guard isTransformerCharacter(currentPokemon) else { return }
        isInVehicleMode = false
        isTransformingToRobot = true
        transformFrameIndex = 3

        var reverseSteps = 0
        let reverseTimer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { [weak self] timer in
            guard let self = self else { timer.invalidate(); return }
            if self.isTransformingToRobot {
                reverseSteps += 1
                if reverseSteps == 1 {
                    self.transformFrameIndex = 4
                } else if reverseSteps >= 2 {
                    self.transformFrameIndex = 0
                    timer.invalidate()
                    self.isTransformingToRobot = false
                    self.scheduleNextTransformation()
                    self.onTransformStateChanged?()
                }
                self.onFrameAdvanced?()
            }
        }
        self.transformTimer = reverseTimer
    }

    func setOnPokemonChanged(_ handler: @escaping () -> Void) {
        onPokemonChanged = handler
    }

    func manualTransformToVehicle() {
        guard isTransformerCharacter(currentPokemon) else { return }
        transformTimer?.invalidate()
        transformHoldTimer?.invalidate()
        if isInVehicleMode { return }
        startTransformation()
    }

    func manualTransformToRobot() {
        guard isTransformerCharacter(currentPokemon) else { return }
        transformTimer?.invalidate()
        transformHoldTimer?.invalidate()
        if !isInVehicleMode && !isTransformingToVehicle { return }
        isTransformingToVehicle = false
        isInVehicleMode = true
        startReverseTransformation()
    }

    func toggleTransform() {
        guard isTransformerCharacter(currentPokemon) else { return }
        transformTimer?.invalidate()
        transformHoldTimer?.invalidate()
        if isInVehicleMode || isTransformingToVehicle {
            isTransformingToVehicle = false
            isInVehicleMode = true
            startReverseTransformation()
        } else {
            startTransformation()
        }
    }

    var isCurrentlyInVehicleMode: Bool { isInVehicleMode }

    private(set) var transformInterval: TimeInterval = {
        let saved = UserDefaults.standard.double(forKey: "transformInterval")
        return saved > 0 ? saved : 120
    }()

    func setTransformInterval(_ interval: TimeInterval) {
        transformInterval = max(10, interval)
        UserDefaults.standard.set(transformInterval, forKey: "transformInterval")
        if isTransformerCharacter(currentPokemon) {
            scheduleNextTransformation()
        }
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

    func resetRotationTimer() {
        guard rotationEnabled else { return }
        rotationTimer?.invalidate()
        startRotation()
    }

    func toggleSmartRotation() {
        smartRotationEnabled.toggle()
        UserDefaults.standard.set(smartRotationEnabled, forKey: "smartRotationEnabled")
    }

    func toggleCategoryOnly() {
        categoryOnlyEnabled.toggle()
        UserDefaults.standard.set(categoryOnlyEnabled, forKey: "categoryOnlyEnabled")
    }

    func setRotationInterval(_ interval: TimeInterval) {
        let clamped = max(interval, 1.0)
        rotationInterval = clamped
        UserDefaults.standard.set(clamped, forKey: "rotationInterval")
        if rotationEnabled {
            rotationTimer?.invalidate()
            startRotation()
        }
    }

    var rotationIntervalLabel: String {
        let minutes = Int(rotationInterval) / 60
        if minutes < 1 {
            return "\(Int(rotationInterval)) sec"
        } else if minutes == 1 {
            return "1 min"
        } else {
            return "\(minutes) min"
        }
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
            FuturamaCharacter.allCases.map { .futurama($0) } +
            BatmanCharacter.allCases.map { .batman($0) } +
            TransformersCharacter.allCases.map { .transformers($0) }

        rotationTimer = Timer.scheduledTimer(withTimeInterval: rotationInterval, repeats: true) { [weak self] _ in
            guard let self = self else { return }
            let pool: [SelectableCharacter]
            if self.categoryOnlyEnabled {
                pool = allCharacters.filter { $0.category == self.currentPokemon.category }
            } else {
                pool = allCharacters
            }
            var next = self.currentPokemon
            var attempts = 0
            while next == self.currentPokemon && attempts < 10 {
                if self.smartRotationEnabled && !self.selectionCounts.isEmpty {
                    next = self.weightedRandom(from: pool)
                } else {
                    next = pool.randomElement() ?? .pokemon(.jigglypuff)
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

    var onFrameAdvanced: (() -> Void)?
    var onTransformStateChanged: (() -> Void)?

    func renderAllFrames() -> [NSImage] {
        if isTransformerCharacter(currentPokemon) && (isTransformingToVehicle || isTransformingToRobot || isInVehicleMode) {
            return (0..<5).map { spriteRenderer.renderFrame(character: currentPokemon, frame: $0, sparkleFrame: currentFrameIndex) }
        }
        if isTransformerCharacter(currentPokemon) {
            return (0..<2).map { spriteRenderer.renderFrame(character: currentPokemon, frame: $0, sparkleFrame: currentFrameIndex) }
        }
        return (0..<4).map { spriteRenderer.renderFrame(character: currentPokemon, frame: $0, sparkleFrame: $0) }
    }

    func renderAllFramesHighRes(targetHeight: CGFloat = 160) -> [NSImage] {
        if isTransformerCharacter(currentPokemon) && (isTransformingToVehicle || isTransformingToRobot || isInVehicleMode) {
            return (0..<5).map { spriteRenderer.renderFrameHighRes(character: currentPokemon, frame: $0, targetHeight: targetHeight, sparkleFrame: currentFrameIndex) }
        }
        if isTransformerCharacter(currentPokemon) {
            return (0..<2).map { spriteRenderer.renderFrameHighRes(character: currentPokemon, frame: $0, targetHeight: targetHeight, sparkleFrame: currentFrameIndex) }
        }
        return (0..<4).map { spriteRenderer.renderFrameHighRes(character: currentPokemon, frame: $0, targetHeight: targetHeight, sparkleFrame: $0) }
    }

    private func advanceFrame() {
        currentFrameIndex = (currentFrameIndex + 1) % 4
        DispatchQueue.main.async {
            self.onFrameAdvanced?()
        }
    }
}
