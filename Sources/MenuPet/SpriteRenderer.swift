import AppKit

class SpriteRenderer {
    let pixelSize: CGFloat = 2
    let frameWidth = 16
    let frameHeight = 16

    func renderFrame(pokemon: PokemonCharacter, frame: Int) -> NSImage {
        let pixels = getPixels(pokemon: pokemon, frame: frame)

        var minY = frameHeight, maxY = 0, minX = frameWidth, maxX = 0
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

        let contentRows = CGFloat(maxY - minY + 1)
        let contentCols = CGFloat(maxX - minX + 1)
        let ps: CGFloat = 2
        let barHeight: CGFloat = 22
        let scale = barHeight / (contentRows * ps)
        let targetW = contentCols * ps * scale

        let img = NSImage(size: NSSize(width: targetW, height: barHeight))
        img.lockFocus()

        let ctx = NSGraphicsContext.current!.cgContext
        ctx.saveGState()

        let offsetX = (targetW - contentCols * ps * scale) / 2 - 7
        let offsetY = -(CGFloat(frameHeight - 1 - maxY)) * ps
        ctx.concatenate(CGAffineTransform(scaleX: scale, y: scale))
        ctx.concatenate(CGAffineTransform(translationX: offsetX / scale, y: offsetY))

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

    private func getPixels(pokemon: PokemonCharacter, frame: Int) -> [[NSColor]] {
        var grid = Array(repeating: Array(repeating: NSColor.clear, count: frameWidth), count: frameHeight)

        switch pokemon {
        case .pikachu:
            drawPikachu(grid: &grid, frame: frame)
        case .psyduck:
            drawPsyduck(grid: &grid, frame: frame)
        case .snorlax:
            drawSnorlax(grid: &grid, frame: frame)
        case .charmander:
            drawCharmander(grid: &grid, frame: frame)
        case .bulbasaur:
            drawBulbasaur(grid: &grid, frame: frame)
        case .squirtle:
            drawSquirtle(grid: &grid, frame: frame)
        case .jigglypuff:
            drawJigglypuff(grid: &grid, frame: frame)
        case .meowth:
            drawMeowth(grid: &grid, frame: frame)
        case .eevee:
            drawEevee(grid: &grid, frame: frame)
        case .mew:
            drawMew(grid: &grid, frame: frame)
        case .gengar:
            drawGengar(grid: &grid, frame: frame)
        case .dragonite:
            drawDragonite(grid: &grid, frame: frame)
        case .gyarados:
            drawGyarados(grid: &grid, frame: frame)
        case .arcanine:
            drawArcanine(grid: &grid, frame: frame)
        case .alakazam:
            drawAlakazam(grid: &grid, frame: frame)
        case .machamp:
            drawMachamp(grid: &grid, frame: frame)
        case .golem:
            drawGolem(grid: &grid, frame: frame)
        case .onix:
            drawOnix(grid: &grid, frame: frame)
        case .jolteon:
            drawJolteon(grid: &grid, frame: frame)
        case .flareon:
            drawFlareon(grid: &grid, frame: frame)
        case .vaporeon:
            drawVaporeon(grid: &grid, frame: frame)
        case .porygon:
            drawPorygon(grid: &grid, frame: frame)
        case .ditto:
            drawDitto(grid: &grid, frame: frame)
        case .lapras:
            drawLapras(grid: &grid, frame: frame)
        case .marill:
            drawMarill(grid: &grid, frame: frame)
        case .umbreon:
            drawUmbreon(grid: &grid, frame: frame)
        }

        return grid
    }

    // MARK: - Pikachu (yellow body, red cheeks, pointy ears, running legs)
    private func drawPikachu(grid: inout [[NSColor]], frame: Int) {
        let yellow = NSColor(red: 1.0, green: 0.85, blue: 0.0, alpha: 1.0)
        let darkYellow = NSColor(red: 0.85, green: 0.7, blue: 0.0, alpha: 1.0)
        let red = NSColor(red: 1.0, green: 0.2, blue: 0.2, alpha: 1.0)
        let black = NSColor.black
        let brown = NSColor(red: 0.55, green: 0.3, blue: 0.1, alpha: 1.0)

        // Ears
        setPixel(&grid, x: 5, y: 1, color: yellow)
        setPixel(&grid, x: 6, y: 0, color: yellow)
        setPixel(&grid, x: 10, y: 1, color: yellow)
        setPixel(&grid, x: 9, y: 0, color: yellow)
        setPixel(&grid, x: 6, y: 1, color: darkYellow)
        setPixel(&grid, x: 9, y: 1, color: darkYellow)

        // Head
        for x in 5...10 { setPixel(&grid, x: x, y: 2, color: yellow) }
        for x in 4...11 { setPixel(&grid, x: x, y: 3, color: yellow) }
        for x in 4...11 { setPixel(&grid, x: x, y: 4, color: yellow) }

        // Eyes
        setPixel(&grid, x: 6, y: 3, color: black)
        setPixel(&grid, x: 9, y: 3, color: black)

        // Cheeks
        setPixel(&grid, x: 5, y: 4, color: red)
        setPixel(&grid, x: 10, y: 4, color: red)

        // Mouth
        setPixel(&grid, x: 7, y: 4, color: black)
        setPixel(&grid, x: 8, y: 4, color: black)

        // Body
        for x in 5...10 { setPixel(&grid, x: x, y: 5, color: yellow) }
        for x in 5...10 { setPixel(&grid, x: x, y: 6, color: yellow) }
        for x in 5...10 { setPixel(&grid, x: x, y: 7, color: yellow) }

        // Tail (lightning bolt shape)
        setPixel(&grid, x: 11, y: 4, color: yellow)
        setPixel(&grid, x: 12, y: 3, color: yellow)
        setPixel(&grid, x: 12, y: 2, color: darkYellow)
        setPixel(&grid, x: 13, y: 1, color: yellow)
        setPixel(&grid, x: 14, y: 0, color: yellow)

        // Legs (running animation)
        if frame % 2 == 0 {
            setPixel(&grid, x: 6, y: 8, color: brown)
            setPixel(&grid, x: 9, y: 8, color: brown)
            setPixel(&grid, x: 5, y: 9, color: brown)
            setPixel(&grid, x: 10, y: 7, color: brown)
        } else {
            setPixel(&grid, x: 6, y: 7, color: brown)
            setPixel(&grid, x: 9, y: 9, color: brown)
            setPixel(&grid, x: 10, y: 8, color: brown)
            setPixel(&grid, x: 5, y: 8, color: brown)
        }
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
        let orange = NSColor(red: 1.0, green: 0.5, blue: 0.1, alpha: 1.0)
        let yellow = NSColor(red: 1.0, green: 0.85, blue: 0.3, alpha: 1.0)
        let blue = NSColor(red: 0.4, green: 0.6, blue: 1.0, alpha: 1.0)
        let red = NSColor(red: 1.0, green: 0.3, blue: 0.1, alpha: 1.0)

        // Head
        for x in 6...9 { setPixel(&grid, x: x, y: 2, color: orange) }
        for x in 5...10 { setPixel(&grid, x: x, y: 3, color: orange) }

        // Eyes
        setPixel(&grid, x: 6, y: 2, color: blue)
        setPixel(&grid, x: 9, y: 2, color: blue)

        // Body
        for x in 5...10 { setPixel(&grid, x: x, y: 4, color: orange) }
        for x in 4...11 { setPixel(&grid, x: x, y: 5, color: orange) }
        for x in 4...11 { setPixel(&grid, x: x, y: 6, color: orange) }
        for x in 4...11 { setPixel(&grid, x: x, y: 7, color: orange) }

        // Belly
        for x in 6...9 { setPixel(&grid, x: x, y: 5, color: yellow) }
        for x in 6...9 { setPixel(&grid, x: x, y: 6, color: yellow) }

        // Tail flame
        setPixel(&grid, x: 12, y: 5, color: red)
        setPixel(&grid, x: 13, y: 4, color: yellow)
        setPixel(&grid, x: 13, y: 5, color: red)

        // Legs
        if frame % 2 == 0 {
            setPixel(&grid, x: 5, y: 8, color: orange)
            setPixel(&grid, x: 10, y: 8, color: orange)
        } else {
            setPixel(&grid, x: 6, y: 8, color: orange)
            setPixel(&grid, x: 9, y: 8, color: orange)
        }
    }

    // MARK: - Bulbasaur
    private func drawBulbasaur(grid: inout [[NSColor]], frame: Int) {
        let teal = NSColor(red: 0.35, green: 0.65, blue: 0.55, alpha: 1.0)
        let green = NSColor(red: 0.3, green: 0.75, blue: 0.2, alpha: 1.0)
        let red = NSColor(red: 0.8, green: 0.2, blue: 0.15, alpha: 1.0)

        // Bulb on back
        for x in 6...9 { setPixel(&grid, x: x, y: 1, color: green) }
        for x in 5...10 { setPixel(&grid, x: x, y: 2, color: green) }

        // Head
        for x in 5...10 { setPixel(&grid, x: x, y: 3, color: teal) }
        for x in 4...11 { setPixel(&grid, x: x, y: 4, color: teal) }

        // Eyes
        setPixel(&grid, x: 6, y: 3, color: red)
        setPixel(&grid, x: 9, y: 3, color: red)

        // Body
        for x in 4...11 { setPixel(&grid, x: x, y: 5, color: teal) }
        for x in 3...12 { setPixel(&grid, x: x, y: 6, color: teal) }
        for x in 3...12 { setPixel(&grid, x: x, y: 7, color: teal) }

        // Spots
        setPixel(&grid, x: 5, y: 5, color: green)
        setPixel(&grid, x: 8, y: 6, color: green)
        setPixel(&grid, x: 10, y: 5, color: green)

        // Legs
        if frame % 2 == 0 {
            setPixel(&grid, x: 4, y: 8, color: teal)
            setPixel(&grid, x: 11, y: 8, color: teal)
        } else {
            setPixel(&grid, x: 5, y: 8, color: teal)
            setPixel(&grid, x: 10, y: 8, color: teal)
        }
    }

    // MARK: - Squirtle
    private func drawSquirtle(grid: inout [[NSColor]], frame: Int) {
        let blue = NSColor(red: 0.3, green: 0.55, blue: 0.85, alpha: 1.0)
        let brown = NSColor(red: 0.65, green: 0.45, blue: 0.2, alpha: 1.0)
        let yellow = NSColor(red: 0.95, green: 0.85, blue: 0.3, alpha: 1.0)
        let black = NSColor.black

        // Head
        for x in 5...10 { setPixel(&grid, x: x, y: 2, color: blue) }
        for x in 5...10 { setPixel(&grid, x: x, y: 3, color: blue) }

        // Eyes
        setPixel(&grid, x: 6, y: 2, color: black)
        setPixel(&grid, x: 9, y: 2, color: black)

        // Shell
        for x in 4...11 { setPixel(&grid, x: x, y: 4, color: brown) }
        for x in 3...12 { setPixel(&grid, x: x, y: 5, color: brown) }
        for x in 3...12 { setPixel(&grid, x: x, y: 6, color: brown) }
        for x in 3...12 { setPixel(&grid, x: x, y: 7, color: brown) }

        // Shell pattern
        for x in 5...10 { setPixel(&grid, x: x, y: 5, color: yellow) }
        for x in 5...10 { setPixel(&grid, x: x, y: 6, color: yellow) }

        // Body edges
        setPixel(&grid, x: 4, y: 5, color: blue)
        setPixel(&grid, x: 11, y: 5, color: blue)

        // Legs
        if frame % 2 == 0 {
            setPixel(&grid, x: 4, y: 8, color: blue)
            setPixel(&grid, x: 11, y: 8, color: blue)
        } else {
            setPixel(&grid, x: 5, y: 8, color: blue)
            setPixel(&grid, x: 10, y: 8, color: blue)
        }

        // Tail
        setPixel(&grid, x: 12, y: 6, color: blue)
        setPixel(&grid, x: 13, y: 5, color: blue)
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

        // Tail (zigzag with ball)
        setPixel(&grid, x: 12, y: 5, color: blue)
        setPixel(&grid, x: 13, y: 4, color: blue)
        setPixel(&grid, x: 14, y: 4, color: yellow)
        setPixel(&grid, x: 14, y: 3, color: yellow)
        setPixel(&grid, x: 15, y: 3, color: yellow)

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
    }

    // MARK: - Umbreon (black body, yellow rings, red eyes)
    private func drawUmbreon(grid: inout [[NSColor]], frame: Int) {
        let black = NSColor(red: 0.1, green: 0.1, blue: 0.12, alpha: 1.0)
        let darkGray = NSColor(red: 0.2, green: 0.2, blue: 0.22, alpha: 1.0)
        let yellow = NSColor(red: 1.0, green: 0.85, blue: 0.0, alpha: 1.0)
        let red = NSColor(red: 0.9, green: 0.15, blue: 0.15, alpha: 1.0)

        // Ears
        setPixel(&grid, x: 4, y: 0, color: black)
        setPixel(&grid, x: 5, y: 1, color: black)
        setPixel(&grid, x: 11, y: 1, color: black)
        setPixel(&grid, x: 12, y: 0, color: black)
        // Ear rings
        setPixel(&grid, x: 4, y: 1, color: yellow)
        setPixel(&grid, x: 12, y: 1, color: yellow)

        // Head
        for x in 5...11 { setPixel(&grid, x: x, y: 2, color: black) }
        for x in 4...12 { setPixel(&grid, x: x, y: 3, color: black) }

        // Eyes
        setPixel(&grid, x: 6, y: 3, color: red)
        setPixel(&grid, x: 10, y: 3, color: red)
        setPixel(&grid, x: 6, y: 2, color: red)
        setPixel(&grid, x: 10, y: 2, color: red)

        // Head ring
        setPixel(&grid, x: 5, y: 2, color: yellow)
        setPixel(&grid, x: 11, y: 2, color: yellow)

        // Body
        for y in 4...7 {
            for x in 5...11 { setPixel(&grid, x: x, y: y, color: black) }
        }

        // Body rings
        setPixel(&grid, x: 5, y: 5, color: yellow)
        setPixel(&grid, x: 11, y: 5, color: yellow)
        setPixel(&grid, x: 8, y: 6, color: yellow)

        // Tail
        setPixel(&grid, x: 12, y: 5, color: black)
        setPixel(&grid, x: 13, y: 4, color: black)
        setPixel(&grid, x: 14, y: 4, color: yellow)

        // Legs
        if frame % 2 == 0 {
            setPixel(&grid, x: 6, y: 8, color: black)
            setPixel(&grid, x: 10, y: 8, color: black)
            setPixel(&grid, x: 6, y: 9, color: darkGray)
            setPixel(&grid, x: 10, y: 9, color: darkGray)
        } else {
            setPixel(&grid, x: 5, y: 8, color: black)
            setPixel(&grid, x: 11, y: 8, color: black)
            setPixel(&grid, x: 5, y: 9, color: darkGray)
            setPixel(&grid, x: 11, y: 9, color: darkGray)
        }
    }

    private func setPixel(_ grid: inout [[NSColor]], x: Int, y: Int, color: NSColor) {
        guard y >= 0 && y < grid.count && x >= 0 && x < grid[0].count else { return }
        grid[y][x] = color
    }
}
