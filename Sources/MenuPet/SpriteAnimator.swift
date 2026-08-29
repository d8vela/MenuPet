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

    var currentPokemon: PokemonCharacter = .jigglypuff
    var speedLabel: String = "Idle"

    var currentFrame: NSImage {
        return spriteRenderer.renderFrame(pokemon: currentPokemon, frame: currentFrameIndex)
    }

    init(cpuMonitor: CPUMonitor) {
        self.cpuMonitor = cpuMonitor
        startAnimation()
        if rotationEnabled {
            startRotation()
        }
    }

    func setPokemon(_ pokemon: PokemonCharacter) {
        currentPokemon = pokemon
    }

    func setOnPokemonChanged(_ handler: @escaping () -> Void) {
        onPokemonChanged = handler
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

    private func startRotation() {
        rotationTimer = Timer.scheduledTimer(withTimeInterval: 600, repeats: true) { [weak self] _ in
            guard let self = self else { return }
            var next = self.currentPokemon
            while next == self.currentPokemon {
                next = PokemonCharacter.allCases.randomElement()!
            }
            self.currentPokemon = next
            self.onPokemonChanged?()
        }
    }

    func updateSpeed(cpuUsage: Double) {
        // Map CPU usage to animation speed
        // Low CPU (0-25%): slow animation (0.8s per frame)
        // Medium CPU (25-50%): medium animation (0.4s per frame)
        // High CPU (50-75%): fast animation (0.2s per frame)
        // Very high CPU (75-100%): very fast animation (0.1s per frame)

        switch cpuUsage {
        case 0..<10:
            animationSpeed = 1.0
            speedLabel = "Sleeping 💤"
        case 10..<25:
            animationSpeed = 0.7
            speedLabel = "Walking 🚶"
        case 25..<50:
            animationSpeed = 0.4
            speedLabel = "Jogging 🏃"
        case 50..<75:
            animationSpeed = 0.2
            speedLabel = "Running 🏃‍♂️💨"
        case 75..<90:
            animationSpeed = 0.1
            speedLabel = "Sprinting ⚡🏃‍♂️💨"
        default:
            animationSpeed = 0.05
            speedLabel = "Overdrive 🔥⚡🏃‍♂️💨"
        }

        restartAnimation()
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
