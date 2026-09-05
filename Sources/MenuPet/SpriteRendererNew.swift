import AppKit

extension SpriteRenderer {
    // MARK: - MarioKart Items
    func drawKartRedShell(grid: inout [[NSColor]], frame: Int) {
        let red = NSColor(red: 0.85, green: 0.15, blue: 0.1, alpha: 1.0)
        let darkRed = NSColor(red: 0.6, green: 0.08, blue: 0.05, alpha: 1.0)
        let brightRed = NSColor(red: 0.95, green: 0.3, blue: 0.15, alpha: 1.0)
        let orange = NSColor(red: 0.95, green: 0.45, blue: 0.15, alpha: 1.0)
        let white = NSColor.white
        let lightGray = NSColor(red: 0.85, green: 0.85, blue: 0.88, alpha: 1.0)
        let black = NSColor.black
        let shift = (frame % 2 == 0) ? 0 : 1
        let highlightLeft = (frame % 4 < 2)
        // Shell dome
        setPixel(&grid, x: 7+shift, y: 1, color: black)
        setPixel(&grid, x: 8+shift, y: 1, color: black)
        for x in 6...9 { setPixel(&grid, x: x+shift, y: 2, color: red) }
        setPixel(&grid, x: 7+shift, y: 2, color: highlightLeft ? brightRed : red)
        setPixel(&grid, x: 8+shift, y: 2, color: highlightLeft ? red : orange)
        setPixel(&grid, x: 6+shift, y: 2, color: black)
        setPixel(&grid, x: 9+shift, y: 2, color: black)
        for x in 5...10 { setPixel(&grid, x: x+shift, y: 3, color: red) }
        setPixel(&grid, x: 6+shift, y: 3, color: highlightLeft ? orange : brightRed)
        setPixel(&grid, x: 7+shift, y: 3, color: highlightLeft ? brightRed : orange)
        setPixel(&grid, x: 8+shift, y: 3, color: highlightLeft ? red : brightRed)
        setPixel(&grid, x: 5+shift, y: 3, color: black)
        setPixel(&grid, x: 10+shift, y: 3, color: black)
        for x in 4...11 { setPixel(&grid, x: x+shift, y: 4, color: red) }
        setPixel(&grid, x: 5+shift, y: 4, color: highlightLeft ? brightRed : orange)
        setPixel(&grid, x: 6+shift, y: 4, color: highlightLeft ? orange : red)
        setPixel(&grid, x: 4+shift, y: 4, color: black)
        setPixel(&grid, x: 11+shift, y: 4, color: black)
        for x in 4...11 { setPixel(&grid, x: x+shift, y: 5, color: darkRed) }
        setPixel(&grid, x: 5+shift, y: 5, color: red)
        setPixel(&grid, x: 4+shift, y: 5, color: black)
        setPixel(&grid, x: 11+shift, y: 5, color: black)
        // White base
        for x in 5...10 { setPixel(&grid, x: x+shift, y: 6, color: white) }
        setPixel(&grid, x: 5+shift, y: 6, color: lightGray)
        setPixel(&grid, x: 10+shift, y: 6, color: lightGray)
        setPixel(&grid, x: 4+shift, y: 6, color: black)
        setPixel(&grid, x: 11+shift, y: 6, color: black)
        // Feet (alternating)
        if frame % 2 == 0 {
            setPixel(&grid, x: 5+shift, y: 7, color: lightGray)
            setPixel(&grid, x: 6+shift, y: 7, color: white)
            setPixel(&grid, x: 9+shift, y: 7, color: white)
            setPixel(&grid, x: 10+shift, y: 7, color: lightGray)
        } else {
            setPixel(&grid, x: 6+shift, y: 7, color: white)
            setPixel(&grid, x: 7+shift, y: 7, color: lightGray)
            setPixel(&grid, x: 8+shift, y: 7, color: lightGray)
            setPixel(&grid, x: 9+shift, y: 7, color: white)
        }
        setPixel(&grid, x: 4+shift, y: 7, color: black)
        setPixel(&grid, x: 11+shift, y: 7, color: black)
    }

    func drawKartGreenShell(grid: inout [[NSColor]], frame: Int) {
        let green = NSColor(red: 0.15, green: 0.7, blue: 0.15, alpha: 1.0)
        let darkGreen = NSColor(red: 0.08, green: 0.45, blue: 0.08, alpha: 1.0)
        let brightGreen = NSColor(red: 0.3, green: 0.9, blue: 0.3, alpha: 1.0)
        let lime = NSColor(red: 0.5, green: 0.9, blue: 0.15, alpha: 1.0)
        let white = NSColor.white
        let lightGray = NSColor(red: 0.85, green: 0.85, blue: 0.88, alpha: 1.0)
        let black = NSColor.black
        let shift = (frame % 2 == 0) ? 0 : 1
        let highlightLeft = (frame % 4 < 2)
        // Shell dome
        setPixel(&grid, x: 7+shift, y: 1, color: black)
        setPixel(&grid, x: 8+shift, y: 1, color: black)
        for x in 6...9 { setPixel(&grid, x: x+shift, y: 2, color: green) }
        setPixel(&grid, x: 7+shift, y: 2, color: highlightLeft ? brightGreen : green)
        setPixel(&grid, x: 8+shift, y: 2, color: highlightLeft ? green : lime)
        setPixel(&grid, x: 6+shift, y: 2, color: black)
        setPixel(&grid, x: 9+shift, y: 2, color: black)
        for x in 5...10 { setPixel(&grid, x: x+shift, y: 3, color: green) }
        setPixel(&grid, x: 6+shift, y: 3, color: highlightLeft ? lime : brightGreen)
        setPixel(&grid, x: 7+shift, y: 3, color: highlightLeft ? brightGreen : lime)
        setPixel(&grid, x: 8+shift, y: 3, color: highlightLeft ? green : brightGreen)
        setPixel(&grid, x: 5+shift, y: 3, color: black)
        setPixel(&grid, x: 10+shift, y: 3, color: black)
        for x in 4...11 { setPixel(&grid, x: x+shift, y: 4, color: green) }
        setPixel(&grid, x: 5+shift, y: 4, color: highlightLeft ? brightGreen : lime)
        setPixel(&grid, x: 6+shift, y: 4, color: highlightLeft ? lime : green)
        setPixel(&grid, x: 4+shift, y: 4, color: black)
        setPixel(&grid, x: 11+shift, y: 4, color: black)
        for x in 4...11 { setPixel(&grid, x: x+shift, y: 5, color: darkGreen) }
        setPixel(&grid, x: 5+shift, y: 5, color: green)
        setPixel(&grid, x: 4+shift, y: 5, color: black)
        setPixel(&grid, x: 11+shift, y: 5, color: black)
        // White base
        for x in 5...10 { setPixel(&grid, x: x+shift, y: 6, color: white) }
        setPixel(&grid, x: 5+shift, y: 6, color: lightGray)
        setPixel(&grid, x: 10+shift, y: 6, color: lightGray)
        setPixel(&grid, x: 4+shift, y: 6, color: black)
        setPixel(&grid, x: 11+shift, y: 6, color: black)
        // Feet (alternating)
        if frame % 2 == 0 {
            setPixel(&grid, x: 5+shift, y: 7, color: lightGray)
            setPixel(&grid, x: 6+shift, y: 7, color: white)
            setPixel(&grid, x: 9+shift, y: 7, color: white)
            setPixel(&grid, x: 10+shift, y: 7, color: lightGray)
        } else {
            setPixel(&grid, x: 6+shift, y: 7, color: white)
            setPixel(&grid, x: 7+shift, y: 7, color: lightGray)
            setPixel(&grid, x: 8+shift, y: 7, color: lightGray)
            setPixel(&grid, x: 9+shift, y: 7, color: white)
        }
        setPixel(&grid, x: 4+shift, y: 7, color: black)
        setPixel(&grid, x: 11+shift, y: 7, color: black)
    }

    func drawKartBananaPeel(grid: inout [[NSColor]], frame: Int) {
        let yellow = NSColor(red: 1.0, green: 0.88, blue: 0.05, alpha: 1.0)
        let darkYellow = NSColor(red: 0.82, green: 0.68, blue: 0.0, alpha: 1.0)
        let gold = NSColor(red: 0.92, green: 0.78, blue: 0.0, alpha: 1.0)
        let brightYellow = NSColor(red: 1.0, green: 0.95, blue: 0.3, alpha: 1.0)
        let white = NSColor.white
        let black = NSColor.black
        let shift = (frame % 2 == 0) ? 0 : 1
        // Stem tip (white highlight)
        setPixel(&grid, x: 7+shift, y: 0, color: white)
        setPixel(&grid, x: 8+shift, y: 0, color: white)
        // Stem
        setPixel(&grid, x: 7+shift, y: 1, color: darkYellow)
        setPixel(&grid, x: 8+shift, y: 1, color: darkYellow)
        setPixel(&grid, x: 6+shift, y: 1, color: black)
        setPixel(&grid, x: 9+shift, y: 1, color: black)
        // Upper body (narrow)
        setPixel(&grid, x: 6+shift, y: 2, color: black)
        setPixel(&grid, x: 7+shift, y: 2, color: yellow)
        setPixel(&grid, x: 8+shift, y: 2, color: yellow)
        setPixel(&grid, x: 9+shift, y: 2, color: black)
        // Body widening
        for x in 5...10 { setPixel(&grid, x: x+shift, y: 3, color: black) }
        setPixel(&grid, x: 6+shift, y: 3, color: yellow)
        setPixel(&grid, x: 7+shift, y: 3, color: brightYellow)
        setPixel(&grid, x: 8+shift, y: 3, color: yellow)
        setPixel(&grid, x: 9+shift, y: 3, color: gold)
        // Main body with vertical stripes
        for x in 5...10 { setPixel(&grid, x: x+shift, y: 4, color: black) }
        setPixel(&grid, x: 6+shift, y: 4, color: gold)
        setPixel(&grid, x: 7+shift, y: 4, color: yellow)
        setPixel(&grid, x: 8+shift, y: 4, color: gold)
        setPixel(&grid, x: 9+shift, y: 4, color: yellow)
        for x in 4...11 { setPixel(&grid, x: x+shift, y: 5, color: black) }
        setPixel(&grid, x: 5+shift, y: 5, color: yellow)
        setPixel(&grid, x: 6+shift, y: 5, color: yellow)
        setPixel(&grid, x: 7+shift, y: 5, color: darkYellow)
        setPixel(&grid, x: 8+shift, y: 5, color: yellow)
        setPixel(&grid, x: 9+shift, y: 5, color: yellow)
        setPixel(&grid, x: 10+shift, y: 5, color: darkYellow)
        for x in 4...11 { setPixel(&grid, x: x+shift, y: 6, color: black) }
        setPixel(&grid, x: 5+shift, y: 6, color: gold)
        setPixel(&grid, x: 6+shift, y: 6, color: yellow)
        setPixel(&grid, x: 7+shift, y: 6, color: gold)
        setPixel(&grid, x: 8+shift, y: 6, color: yellow)
        setPixel(&grid, x: 9+shift, y: 6, color: gold)
        setPixel(&grid, x: 10+shift, y: 6, color: yellow)
        // Peeled flaps (wider, spreading out)
        for x in 3...12 { setPixel(&grid, x: x+shift, y: 7, color: black) }
        setPixel(&grid, x: 4+shift, y: 7, color: darkYellow)
        setPixel(&grid, x: 5+shift, y: 7, color: yellow)
        setPixel(&grid, x: 6+shift, y: 7, color: yellow)
        setPixel(&grid, x: 7+shift, y: 7, color: darkYellow)
        setPixel(&grid, x: 8+shift, y: 7, color: yellow)
        setPixel(&grid, x: 9+shift, y: 7, color: yellow)
        setPixel(&grid, x: 10+shift, y: 7, color: darkYellow)
        setPixel(&grid, x: 11+shift, y: 7, color: yellow)
        setPixel(&grid, x: 12+shift, y: 7, color: darkYellow)
        for x in 3...12 { setPixel(&grid, x: x+shift, y: 8, color: black) }
        setPixel(&grid, x: 4+shift, y: 8, color: yellow)
        setPixel(&grid, x: 5+shift, y: 8, color: gold)
        setPixel(&grid, x: 6+shift, y: 8, color: brightYellow)
        setPixel(&grid, x: 7+shift, y: 8, color: white)
        setPixel(&grid, x: 8+shift, y: 8, color: brightYellow)
        setPixel(&grid, x: 9+shift, y: 8, color: gold)
        setPixel(&grid, x: 10+shift, y: 8, color: yellow)
        setPixel(&grid, x: 11+shift, y: 8, color: gold)
        setPixel(&grid, x: 12+shift, y: 8, color: darkYellow)
        // Bottom edge (wider spread)
        for x in 2...13 { setPixel(&grid, x: x+shift, y: 9, color: black) }
        setPixel(&grid, x: 3+shift, y: 9, color: darkYellow)
        setPixel(&grid, x: 4+shift, y: 9, color: yellow)
        setPixel(&grid, x: 5+shift, y: 9, color: yellow)
        setPixel(&grid, x: 6+shift, y: 9, color: darkYellow)
        setPixel(&grid, x: 7+shift, y: 9, color: yellow)
        setPixel(&grid, x: 8+shift, y: 9, color: yellow)
        setPixel(&grid, x: 9+shift, y: 9, color: darkYellow)
        setPixel(&grid, x: 10+shift, y: 9, color: yellow)
        setPixel(&grid, x: 11+shift, y: 9, color: yellow)
        setPixel(&grid, x: 12+shift, y: 9, color: yellow)
        setPixel(&grid, x: 13+shift, y: 9, color: darkYellow)
        // Feet (bottom)
        setPixel(&grid, x: 3+shift, y: 10, color: black)
        setPixel(&grid, x: 4+shift, y: 10, color: black)
        setPixel(&grid, x: 5+shift, y: 10, color: darkYellow)
        setPixel(&grid, x: 10+shift, y: 10, color: darkYellow)
        setPixel(&grid, x: 11+shift, y: 10, color: black)
        setPixel(&grid, x: 12+shift, y: 10, color: black)
    }

    // MARK: - Dragon Ball
    func drawDBGoku(grid: inout [[NSColor]], frame: Int) {
        let orange = NSColor(red: 0.95, green: 0.55, blue: 0.1, alpha: 1.0)
        let blue = NSColor(red: 0.1, green: 0.3, blue: 0.75, alpha: 1.0)
        let skin = NSColor(red: 0.95, green: 0.8, blue: 0.65, alpha: 1.0)
        let black = NSColor.black
        let hairBlack = NSColor(red: 0.05, green: 0.05, blue: 0.08, alpha: 1.0)

        // Spiky hair (pointed up)
        setPixel(&grid, x: 6, y: 0, color: hairBlack)
        setPixel(&grid, x: 8, y: 0, color: hairBlack)
        setPixel(&grid, x: 10, y: 0, color: hairBlack)
        for x in 5...10 { setPixel(&grid, x: x, y: 1, color: hairBlack) }
        for x in 5...10 { setPixel(&grid, x: x, y: 2, color: hairBlack) }

        // Head
        for x in 5...10 { setPixel(&grid, x: x, y: 3, color: skin) }
        setPixel(&grid, x: 6, y: 3, color: black)
        setPixel(&grid, x: 9, y: 3, color: black)
        for x in 5...10 { setPixel(&grid, x: x, y: 4, color: skin) }
        setPixel(&grid, x: 7, y: 4, color: black)
        setPixel(&grid, x: 8, y: 4, color: black)

        // Body (orange gi with blue undershirt)
        for x in 4...11 { setPixel(&grid, x: x, y: 5, color: orange) }
        setPixel(&grid, x: 7, y: 5, color: blue)
        setPixel(&grid, x: 8, y: 5, color: blue)
        for x in 4...11 { setPixel(&grid, x: x, y: 6, color: orange) }

        // Belt
        for x in 5...10 { setPixel(&grid, x: x, y: 7, color: blue) }

        // Legs
        if frame % 2 == 0 {
            setPixel(&grid, x: 5, y: 8, color: orange)
            setPixel(&grid, x: 10, y: 8, color: orange)
        } else {
            setPixel(&grid, x: 6, y: 8, color: orange)
            setPixel(&grid, x: 9, y: 8, color: orange)
        }
    }

    func drawDBVegeta(grid: inout [[NSColor]], frame: Int) {
        let blue = NSColor(red: 0.1, green: 0.25, blue: 0.7, alpha: 1.0)
        let darkBlue = NSColor(red: 0.05, green: 0.15, blue: 0.5, alpha: 1.0)
        let skin = NSColor(red: 0.95, green: 0.8, blue: 0.65, alpha: 1.0)
        let black = NSColor.black
        let hairBlack = NSColor(red: 0.05, green: 0.05, blue: 0.08, alpha: 1.0)
        let yellow = NSColor(red: 1.0, green: 0.85, blue: 0.0, alpha: 1.0)
        // Spiky hair (pointed up)
        setPixel(&grid, x: 6, y: 0, color: hairBlack)
        setPixel(&grid, x: 8, y: 0, color: hairBlack)
        setPixel(&grid, x: 10, y: 0, color: hairBlack)
        for x in 5...10 { setPixel(&grid, x: x, y: 1, color: hairBlack) }
        for x in 5...10 { setPixel(&grid, x: x, y: 2, color: hairBlack) }
        // Head
        for x in 5...10 { setPixel(&grid, x: x, y: 3, color: skin) }
        setPixel(&grid, x: 6, y: 3, color: black)
        setPixel(&grid, x: 9, y: 3, color: black)
        for x in 5...10 { setPixel(&grid, x: x, y: 4, color: skin) }
        setPixel(&grid, x: 7, y: 4, color: black)
        setPixel(&grid, x: 8, y: 4, color: black)
        // Body (blue suit with yellow gloves)
        for x in 4...11 { setPixel(&grid, x: x, y: 5, color: blue) }
        setPixel(&grid, x: 4, y: 5, color: yellow)
        setPixel(&grid, x: 11, y: 5, color: yellow)
        for x in 4...11 { setPixel(&grid, x: x, y: 6, color: blue) }
        for x in 5...10 { setPixel(&grid, x: x, y: 7, color: darkBlue) }
        if frame % 2 == 0 {
            setPixel(&grid, x: 5, y: 8, color: darkBlue)
            setPixel(&grid, x: 10, y: 8, color: darkBlue)
        } else {
            setPixel(&grid, x: 6, y: 8, color: darkBlue)
            setPixel(&grid, x: 9, y: 8, color: darkBlue)
        }
    }

    func drawDBGohan(grid: inout [[NSColor]], frame: Int) {
        let purple = NSColor(red: 0.45, green: 0.15, blue: 0.6, alpha: 1.0)
        let darkPurple = NSColor(red: 0.3, green: 0.1, blue: 0.4, alpha: 1.0)
        let skin = NSColor(red: 0.95, green: 0.8, blue: 0.65, alpha: 1.0)
        let black = NSColor.black
        let hairBlack = NSColor(red: 0.05, green: 0.05, blue: 0.08, alpha: 1.0)
        // Spiky hair
        setPixel(&grid, x: 6, y: 0, color: hairBlack)
        setPixel(&grid, x: 8, y: 0, color: hairBlack)
        for x in 5...10 { setPixel(&grid, x: x, y: 1, color: hairBlack) }
        for x in 5...10 { setPixel(&grid, x: x, y: 2, color: hairBlack) }
        // Head
        for x in 5...10 { setPixel(&grid, x: x, y: 3, color: skin) }
        setPixel(&grid, x: 6, y: 3, color: black)
        setPixel(&grid, x: 9, y: 3, color: black)
        for x in 5...10 { setPixel(&grid, x: x, y: 4, color: skin) }
        setPixel(&grid, x: 7, y: 4, color: black)
        setPixel(&grid, x: 8, y: 4, color: black)
        // Body (purple outfit)
        for x in 4...11 { setPixel(&grid, x: x, y: 5, color: purple) }
        for x in 4...11 { setPixel(&grid, x: x, y: 6, color: purple) }
        for x in 5...10 { setPixel(&grid, x: x, y: 7, color: darkPurple) }
        if frame % 2 == 0 {
            setPixel(&grid, x: 5, y: 8, color: darkPurple)
            setPixel(&grid, x: 10, y: 8, color: darkPurple)
        } else {
            setPixel(&grid, x: 6, y: 8, color: darkPurple)
            setPixel(&grid, x: 9, y: 8, color: darkPurple)
        }
    }

    func drawDBPiccolo(grid: inout [[NSColor]], frame: Int) {
        let green = NSColor(red: 0.15, green: 0.6, blue: 0.2, alpha: 1.0)
        let darkGreen = NSColor(red: 0.08, green: 0.4, blue: 0.1, alpha: 1.0)
        let white = NSColor.white
        let black = NSColor.black
        let purple = NSColor(red: 0.5, green: 0.15, blue: 0.55, alpha: 1.0)
        // Antennae
        setPixel(&grid, x: 6, y: 0, color: green)
        setPixel(&grid, x: 9, y: 0, color: green)
        // Head (green with turban)
        for x in 5...10 { setPixel(&grid, x: x, y: 1, color: white) }
        for x in 5...10 { setPixel(&grid, x: x, y: 2, color: green) }
        for x in 5...10 { setPixel(&grid, x: x, y: 3, color: green) }
        setPixel(&grid, x: 6, y: 3, color: white)
        setPixel(&grid, x: 9, y: 3, color: white)
        setPixel(&grid, x: 7, y: 3, color: black)
        setPixel(&grid, x: 8, y: 3, color: black)
        for x in 5...10 { setPixel(&grid, x: x, y: 4, color: green) }
        // Body (purple outfit)
        for x in 4...11 { setPixel(&grid, x: x, y: 5, color: purple) }
        for x in 4...11 { setPixel(&grid, x: x, y: 6, color: purple) }
        for x in 5...10 { setPixel(&grid, x: x, y: 7, color: darkGreen) }
        if frame % 2 == 0 {
            setPixel(&grid, x: 5, y: 8, color: darkGreen)
            setPixel(&grid, x: 10, y: 8, color: darkGreen)
        } else {
            setPixel(&grid, x: 6, y: 8, color: darkGreen)
            setPixel(&grid, x: 9, y: 8, color: darkGreen)
        }
    }

    func drawDBFrieza(grid: inout [[NSColor]], frame: Int) {
        let white = NSColor.white
        let purple = NSColor(red: 0.6, green: 0.15, blue: 0.65, alpha: 1.0)
        let pink = NSColor(red: 0.9, green: 0.5, blue: 0.6, alpha: 1.0)
        let black = NSColor.black
        let gray = NSColor(red: 0.7, green: 0.7, blue: 0.73, alpha: 1.0)
        // Head (white with purple dome)
        for x in 5...10 { setPixel(&grid, x: x, y: 1, color: purple) }
        for x in 5...10 { setPixel(&grid, x: x, y: 2, color: white) }
        for x in 5...10 { setPixel(&grid, x: x, y: 3, color: white) }
        setPixel(&grid, x: 6, y: 3, color: black)
        setPixel(&grid, x: 9, y: 3, color: black)
        setPixel(&grid, x: 7, y: 3, color: pink)
        setPixel(&grid, x: 8, y: 3, color: pink)
        for x in 5...10 { setPixel(&grid, x: x, y: 4, color: white) }
        // Body (white with purple accents)
        for x in 4...11 { setPixel(&grid, x: x, y: 5, color: white) }
        setPixel(&grid, x: 7, y: 5, color: purple)
        setPixel(&grid, x: 8, y: 5, color: purple)
        for x in 4...11 { setPixel(&grid, x: x, y: 6, color: gray) }
        for x in 5...10 { setPixel(&grid, x: x, y: 7, color: purple) }
        if frame % 2 == 0 {
            setPixel(&grid, x: 5, y: 8, color: purple)
            setPixel(&grid, x: 10, y: 8, color: purple)
        } else {
            setPixel(&grid, x: 6, y: 8, color: purple)
            setPixel(&grid, x: 9, y: 8, color: purple)
        }
    }

    func drawDBCell(grid: inout [[NSColor]], frame: Int) {
        let green = NSColor(red: 0.2, green: 0.65, blue: 0.25, alpha: 1.0)
        let darkGreen = NSColor(red: 0.1, green: 0.45, blue: 0.12, alpha: 1.0)
        let purple = NSColor(red: 0.55, green: 0.15, blue: 0.6, alpha: 1.0)
        let black = NSColor.black
        let white = NSColor.white
        // Crown/head
        setPixel(&grid, x: 6, y: 0, color: purple)
        setPixel(&grid, x: 8, y: 0, color: purple)
        for x in 5...10 { setPixel(&grid, x: x, y: 1, color: green) }
        for x in 5...10 { setPixel(&grid, x: x, y: 2, color: green) }
        for x in 5...10 { setPixel(&grid, x: x, y: 3, color: green) }
        setPixel(&grid, x: 6, y: 3, color: purple)
        setPixel(&grid, x: 9, y: 3, color: purple)
        setPixel(&grid, x: 7, y: 3, color: black)
        setPixel(&grid, x: 8, y: 3, color: black)
        for x in 5...10 { setPixel(&grid, x: x, y: 4, color: darkGreen) }
        // Body (green with spots)
        for x in 4...11 { setPixel(&grid, x: x, y: 5, color: green) }
        setPixel(&grid, x: 6, y: 5, color: purple)
        setPixel(&grid, x: 9, y: 5, color: purple)
        for x in 4...11 { setPixel(&grid, x: x, y: 6, color: darkGreen) }
        for x in 5...10 { setPixel(&grid, x: x, y: 7, color: green) }
        if frame % 2 == 0 {
            setPixel(&grid, x: 5, y: 8, color: darkGreen)
            setPixel(&grid, x: 10, y: 8, color: darkGreen)
        } else {
            setPixel(&grid, x: 6, y: 8, color: darkGreen)
            setPixel(&grid, x: 9, y: 8, color: darkGreen)
        }
    }

    func drawDBMajinBuu(grid: inout [[NSColor]], frame: Int) {
        let pink = NSColor(red: 0.95, green: 0.55, blue: 0.65, alpha: 1.0)
        let darkPink = NSColor(red: 0.8, green: 0.4, blue: 0.5, alpha: 1.0)
        let yellow = NSColor(red: 1.0, green: 0.85, blue: 0.0, alpha: 1.0)
        let black = NSColor.black
        let white = NSColor.white
        // Head (round pink)
        for x in 5...10 { setPixel(&grid, x: x, y: 1, color: pink) }
        setPixel(&grid, x: 7, y: 0, color: pink)
        setPixel(&grid, x: 8, y: 0, color: pink)
        for x in 5...10 { setPixel(&grid, x: x, y: 2, color: pink) }
        for x in 5...10 { setPixel(&grid, x: x, y: 3, color: pink) }
        setPixel(&grid, x: 6, y: 3, color: black)
        setPixel(&grid, x: 9, y: 3, color: black)
        setPixel(&grid, x: 7, y: 3, color: white)
        setPixel(&grid, x: 8, y: 3, color: white)
        for x in 5...10 { setPixel(&grid, x: x, y: 4, color: pink) }
        setPixel(&grid, x: 7, y: 4, color: black)
        setPixel(&grid, x: 8, y: 4, color: black)
        // Body (pink with yellow cape)
        for x in 4...11 { setPixel(&grid, x: x, y: 5, color: yellow) }
        for x in 4...11 { setPixel(&grid, x: x, y: 6, color: pink) }
        for x in 5...10 { setPixel(&grid, x: x, y: 7, color: darkPink) }
        if frame % 2 == 0 {
            setPixel(&grid, x: 5, y: 8, color: darkPink)
            setPixel(&grid, x: 10, y: 8, color: darkPink)
        } else {
            setPixel(&grid, x: 6, y: 8, color: darkPink)
            setPixel(&grid, x: 9, y: 8, color: darkPink)
        }
    }

    func drawDBKrillin(grid: inout [[NSColor]], frame: Int) {
        let orange = NSColor(red: 0.95, green: 0.55, blue: 0.1, alpha: 1.0)
        let skin = NSColor(red: 0.95, green: 0.8, blue: 0.65, alpha: 1.0)
        let black = NSColor.black
        let yellow = NSColor(red: 1.0, green: 0.85, blue: 0.0, alpha: 1.0)
        // Bald head
        for x in 6...9 { setPixel(&grid, x: x, y: 1, color: skin) }
        for x in 5...10 { setPixel(&grid, x: x, y: 2, color: skin) }
        for x in 5...10 { setPixel(&grid, x: x, y: 3, color: skin) }
        setPixel(&grid, x: 6, y: 3, color: black)
        setPixel(&grid, x: 9, y: 3, color: black)
        for x in 5...10 { setPixel(&grid, x: x, y: 4, color: skin) }
        setPixel(&grid, x: 7, y: 4, color: black)
        setPixel(&grid, x: 8, y: 4, color: black)
        // Body (orange gi)
        for x in 4...11 { setPixel(&grid, x: x, y: 5, color: orange) }
        for x in 4...11 { setPixel(&grid, x: x, y: 6, color: orange) }
        for x in 5...10 { setPixel(&grid, x: x, y: 7, color: yellow) }
        if frame % 2 == 0 {
            setPixel(&grid, x: 5, y: 8, color: yellow)
            setPixel(&grid, x: 10, y: 8, color: yellow)
        } else {
            setPixel(&grid, x: 6, y: 8, color: yellow)
            setPixel(&grid, x: 9, y: 8, color: yellow)
        }
    }

    func drawDBTrunks(grid: inout [[NSColor]], frame: Int) {
        let purple = NSColor(red: 0.45, green: 0.15, blue: 0.6, alpha: 1.0)
        let lavender = NSColor(red: 0.65, green: 0.45, blue: 0.8, alpha: 1.0)
        let skin = NSColor(red: 0.95, green: 0.8, blue: 0.65, alpha: 1.0)
        let black = NSColor.black
        let blue = NSColor(red: 0.1, green: 0.3, blue: 0.7, alpha: 1.0)
        // Lavender hair
        for x in 6...9 { setPixel(&grid, x: x, y: 0, color: lavender) }
        for x in 5...10 { setPixel(&grid, x: x, y: 1, color: lavender) }
        for x in 5...10 { setPixel(&grid, x: x, y: 2, color: lavender) }
        // Head
        for x in 5...10 { setPixel(&grid, x: x, y: 3, color: skin) }
        setPixel(&grid, x: 6, y: 3, color: black)
        setPixel(&grid, x: 9, y: 3, color: black)
        for x in 5...10 { setPixel(&grid, x: x, y: 4, color: skin) }
        setPixel(&grid, x: 7, y: 4, color: black)
        setPixel(&grid, x: 8, y: 4, color: black)
        // Body (blue jacket)
        for x in 4...11 { setPixel(&grid, x: x, y: 5, color: blue) }
        for x in 4...11 { setPixel(&grid, x: x, y: 6, color: blue) }
        for x in 5...10 { setPixel(&grid, x: x, y: 7, color: purple) }
        if frame % 2 == 0 {
            setPixel(&grid, x: 5, y: 8, color: purple)
            setPixel(&grid, x: 10, y: 8, color: purple)
        } else {
            setPixel(&grid, x: 6, y: 8, color: purple)
            setPixel(&grid, x: 9, y: 8, color: purple)
        }
    }

    func drawDBGoten(grid: inout [[NSColor]], frame: Int) {
        let orange = NSColor(red: 0.95, green: 0.55, blue: 0.1, alpha: 1.0)
        let skin = NSColor(red: 0.95, green: 0.8, blue: 0.65, alpha: 1.0)
        let black = NSColor.black
        let hairBlack = NSColor(red: 0.05, green: 0.05, blue: 0.08, alpha: 1.0)
        // Spiky hair (kid version)
        setPixel(&grid, x: 6, y: 0, color: hairBlack)
        setPixel(&grid, x: 8, y: 0, color: hairBlack)
        for x in 5...10 { setPixel(&grid, x: x, y: 1, color: hairBlack) }
        for x in 5...10 { setPixel(&grid, x: x, y: 2, color: hairBlack) }
        // Head
        for x in 5...10 { setPixel(&grid, x: x, y: 3, color: skin) }
        setPixel(&grid, x: 6, y: 3, color: black)
        setPixel(&grid, x: 9, y: 3, color: black)
        for x in 5...10 { setPixel(&grid, x: x, y: 4, color: skin) }
        setPixel(&grid, x: 7, y: 4, color: black)
        setPixel(&grid, x: 8, y: 4, color: black)
        // Body (orange gi, smaller)
        for x in 5...10 { setPixel(&grid, x: x, y: 5, color: orange) }
        for x in 5...10 { setPixel(&grid, x: x, y: 6, color: orange) }
        for x in 5...10 { setPixel(&grid, x: x, y: 7, color: orange) }
        if frame % 2 == 0 {
            setPixel(&grid, x: 5, y: 8, color: orange)
            setPixel(&grid, x: 10, y: 8, color: orange)
        } else {
            setPixel(&grid, x: 6, y: 8, color: orange)
            setPixel(&grid, x: 9, y: 8, color: orange)
        }
    }

    func drawDBBeerus(grid: inout [[NSColor]], frame: Int) {
        let blue = NSColor(red: 0.3, green: 0.35, blue: 0.65, alpha: 1.0)
        let darkBlue = NSColor(red: 0.2, green: 0.25, blue: 0.5, alpha: 1.0)
        let black = NSColor.black
        let yellow = NSColor(red: 1.0, green: 0.85, blue: 0.0, alpha: 1.0)
        // Cat ears
        setPixel(&grid, x: 5, y: 0, color: blue)
        setPixel(&grid, x: 10, y: 0, color: blue)
        for x in 5...10 { setPixel(&grid, x: x, y: 1, color: blue) }
        for x in 5...10 { setPixel(&grid, x: x, y: 2, color: blue) }
        for x in 5...10 { setPixel(&grid, x: x, y: 3, color: blue) }
        setPixel(&grid, x: 6, y: 3, color: yellow)
        setPixel(&grid, x: 9, y: 3, color: yellow)
        setPixel(&grid, x: 7, y: 3, color: black)
        setPixel(&grid, x: 8, y: 3, color: black)
        for x in 5...10 { setPixel(&grid, x: x, y: 4, color: darkBlue) }
        // Body (slim, blue)
        for x in 5...10 { setPixel(&grid, x: x, y: 5, color: blue) }
        for x in 5...10 { setPixel(&grid, x: x, y: 6, color: darkBlue) }
        for x in 5...10 { setPixel(&grid, x: x, y: 7, color: blue) }
        if frame % 2 == 0 {
            setPixel(&grid, x: 5, y: 8, color: darkBlue)
            setPixel(&grid, x: 10, y: 8, color: darkBlue)
        } else {
            setPixel(&grid, x: 6, y: 8, color: darkBlue)
            setPixel(&grid, x: 9, y: 8, color: darkBlue)
        }
    }

    func drawDBWhis(grid: inout [[NSColor]], frame: Int) {
        let blue = NSColor(red: 0.3, green: 0.5, blue: 0.85, alpha: 1.0)
        let lightBlue = NSColor(red: 0.5, green: 0.7, blue: 0.95, alpha: 1.0)
        let white = NSColor.white
        let black = NSColor.black
        let gold = NSColor(red: 1.0, green: 0.8, blue: 0.0, alpha: 1.0)
        // Tall head/hair
        for x in 7...8 { setPixel(&grid, x: x, y: 0, color: lightBlue) }
        for x in 6...9 { setPixel(&grid, x: x, y: 1, color: lightBlue) }
        for x in 5...10 { setPixel(&grid, x: x, y: 2, color: lightBlue) }
        // Head
        for x in 5...10 { setPixel(&grid, x: x, y: 3, color: white) }
        setPixel(&grid, x: 6, y: 3, color: black)
        setPixel(&grid, x: 9, y: 3, color: black)
        for x in 5...10 { setPixel(&grid, x: x, y: 4, color: white) }
        setPixel(&grid, x: 7, y: 4, color: black)
        setPixel(&grid, x: 8, y: 4, color: black)
        // Body (blue robe with gold)
        for x in 4...11 { setPixel(&grid, x: x, y: 5, color: blue) }
        setPixel(&grid, x: 7, y: 5, color: gold)
        setPixel(&grid, x: 8, y: 5, color: gold)
        for x in 4...11 { setPixel(&grid, x: x, y: 6, color: blue) }
        for x in 5...10 { setPixel(&grid, x: x, y: 7, color: lightBlue) }
        if frame % 2 == 0 {
            setPixel(&grid, x: 5, y: 8, color: lightBlue)
            setPixel(&grid, x: 10, y: 8, color: lightBlue)
        } else {
            setPixel(&grid, x: 6, y: 8, color: lightBlue)
            setPixel(&grid, x: 9, y: 8, color: lightBlue)
        }
    }

    // MARK: - Studio Ghibli
    func drawGhibliTotoro(grid: inout [[NSColor]], frame: Int) {
        let gray = NSColor(red: 0.6, green: 0.58, blue: 0.55, alpha: 1.0)
        let darkGray = NSColor(red: 0.4, green: 0.38, blue: 0.35, alpha: 1.0)
        let white = NSColor.white
        let black = NSColor.black
        let belly = NSColor(red: 0.8, green: 0.78, blue: 0.72, alpha: 1.0)
        // Ears
        setPixel(&grid, x: 5, y: 0, color: gray)
        setPixel(&grid, x: 10, y: 0, color: gray)
        for x in 5...10 { setPixel(&grid, x: x, y: 1, color: gray) }
        for x in 4...11 { setPixel(&grid, x: x, y: 2, color: gray) }
        for x in 4...11 { setPixel(&grid, x: x, y: 3, color: gray) }
        setPixel(&grid, x: 6, y: 3, color: black)
        setPixel(&grid, x: 9, y: 3, color: black)
        // Big belly
        for x in 3...12 { setPixel(&grid, x: x, y: 4, color: gray) }
        setPixel(&grid, x: 7, y: 4, color: belly)
        setPixel(&grid, x: 8, y: 4, color: belly)
        for x in 3...12 { setPixel(&grid, x: x, y: 5, color: gray) }
        setPixel(&grid, x: 6, y: 5, color: belly)
        setPixel(&grid, x: 7, y: 5, color: belly)
        setPixel(&grid, x: 8, y: 5, color: belly)
        setPixel(&grid, x: 9, y: 5, color: belly)
        for x in 3...12 { setPixel(&grid, x: x, y: 6, color: darkGray) }
        setPixel(&grid, x: 6, y: 6, color: belly)
        setPixel(&grid, x: 7, y: 6, color: belly)
        setPixel(&grid, x: 8, y: 6, color: belly)
        setPixel(&grid, x: 9, y: 6, color: belly)
        // Chest marks
        setPixel(&grid, x: 6, y: 5, color: darkGray)
        setPixel(&grid, x: 9, y: 5, color: darkGray)
        if frame % 2 == 0 {
            setPixel(&grid, x: 4, y: 7, color: darkGray)
            setPixel(&grid, x: 11, y: 7, color: darkGray)
        } else {
            setPixel(&grid, x: 5, y: 7, color: darkGray)
            setPixel(&grid, x: 10, y: 7, color: darkGray)
        }
    }

    func drawGhibliNoFace(grid: inout [[NSColor]], frame: Int) {
        let black = NSColor.black
        let darkGray = NSColor(red: 0.2, green: 0.2, blue: 0.22, alpha: 1.0)
        let gold = NSColor(red: 1.0, green: 0.85, blue: 0.0, alpha: 1.0)
        let white = NSColor.white
        let purple = NSColor(red: 0.45, green: 0.15, blue: 0.5, alpha: 1.0)
        // Mask (white oval)
        for x in 6...9 { setPixel(&grid, x: x, y: 1, color: darkGray) }
        for x in 5...10 { setPixel(&grid, x: x, y: 2, color: darkGray) }
        for x in 5...10 { setPixel(&grid, x: x, y: 3, color: white) }
        setPixel(&grid, x: 6, y: 3, color: black)
        setPixel(&grid, x: 9, y: 3, color: black)
        for x in 5...10 { setPixel(&grid, x: x, y: 4, color: darkGray) }
        setPixel(&grid, x: 7, y: 4, color: black)
        setPixel(&grid, x: 8, y: 4, color: black)
        // Body (dark with gold mask details)
        for x in 4...11 { setPixel(&grid, x: x, y: 5, color: black) }
        setPixel(&grid, x: 5, y: 5, color: gold)
        setPixel(&grid, x: 10, y: 5, color: gold)
        for x in 4...11 { setPixel(&grid, x: x, y: 6, color: darkGray) }
        for x in 5...10 { setPixel(&grid, x: x, y: 7, color: black) }
        if frame % 2 == 0 {
            setPixel(&grid, x: 5, y: 8, color: purple)
            setPixel(&grid, x: 10, y: 8, color: purple)
        } else {
            setPixel(&grid, x: 6, y: 8, color: purple)
            setPixel(&grid, x: 9, y: 8, color: purple)
        }
    }

    func drawGhibliKiki(grid: inout [[NSColor]], frame: Int) {
        let black = NSColor.black
        let darkBlue = NSColor(red: 0.1, green: 0.15, blue: 0.4, alpha: 1.0)
        let skin = NSColor(red: 0.95, green: 0.8, blue: 0.65, alpha: 1.0)
        let red = NSColor(red: 0.85, green: 0.15, blue: 0.1, alpha: 1.0)
        let brown = NSColor(red: 0.45, green: 0.3, blue: 0.15, alpha: 1.0)
        // Hair (black, short)
        for x in 5...10 { setPixel(&grid, x: x, y: 0, color: black) }
        for x in 5...10 { setPixel(&grid, x: x, y: 1, color: black) }
        for x in 5...10 { setPixel(&grid, x: x, y: 2, color: black) }
        // Head
        for x in 5...10 { setPixel(&grid, x: x, y: 3, color: skin) }
        setPixel(&grid, x: 6, y: 3, color: black)
        setPixel(&grid, x: 9, y: 3, color: black)
        for x in 5...10 { setPixel(&grid, x: x, y: 4, color: skin) }
        setPixel(&grid, x: 7, y: 4, color: black)
        setPixel(&grid, x: 8, y: 4, color: black)
        // Body (dark blue dress)
        for x in 4...11 { setPixel(&grid, x: x, y: 5, color: darkBlue) }
        setPixel(&grid, x: 7, y: 5, color: red)
        setPixel(&grid, x: 8, y: 5, color: red)
        for x in 4...11 { setPixel(&grid, x: x, y: 6, color: darkBlue) }
        for x in 5...10 { setPixel(&grid, x: x, y: 7, color: darkBlue) }
        if frame % 2 == 0 {
            setPixel(&grid, x: 5, y: 8, color: brown)
            setPixel(&grid, x: 10, y: 8, color: brown)
        } else {
            setPixel(&grid, x: 6, y: 8, color: brown)
            setPixel(&grid, x: 9, y: 8, color: brown)
        }
    }

    func drawGhibliCalcifer(grid: inout [[NSColor]], frame: Int) {
        let orange = NSColor(red: 0.95, green: 0.5, blue: 0.1, alpha: 1.0)
        let red = NSColor(red: 0.9, green: 0.15, blue: 0.1, alpha: 1.0)
        let yellow = NSColor(red: 1.0, green: 0.9, blue: 0.2, alpha: 1.0)
        let black = NSColor.black
        let white = NSColor.white
        let flicker = (frame % 2 == 0)
        // Flame body
        setPixel(&grid, x: 7, y: 0, color: yellow)
        setPixel(&grid, x: 8, y: 0, color: yellow)
        setPixel(&grid, x: 6, y: 1, color: orange)
        setPixel(&grid, x: 7, y: 1, color: yellow)
        setPixel(&grid, x: 8, y: 1, color: yellow)
        setPixel(&grid, x: 9, y: 1, color: orange)
        for x in 5...10 { setPixel(&grid, x: x, y: 2, color: orange) }
        setPixel(&grid, x: 6, y: 2, color: red)
        setPixel(&grid, x: 9, y: 2, color: red)
        for x in 5...10 { setPixel(&grid, x: x, y: 3, color: red) }
        setPixel(&grid, x: 6, y: 3, color: white)
        setPixel(&grid, x: 9, y: 3, color: white)
        setPixel(&grid, x: 7, y: 3, color: black)
        setPixel(&grid, x: 8, y: 3, color: black)
        for x in 5...10 { setPixel(&grid, x: x, y: 4, color: orange) }
        setPixel(&grid, x: 7, y: 4, color: black)
        setPixel(&grid, x: 8, y: 4, color: black)
        for x in 6...9 { setPixel(&grid, x: x, y: 5, color: red) }
        if flicker {
            setPixel(&grid, x: 5, y: 5, color: orange)
            setPixel(&grid, x: 10, y: 5, color: orange)
        }
        if frame % 2 == 0 {
            setPixel(&grid, x: 6, y: 6, color: orange)
            setPixel(&grid, x: 9, y: 6, color: orange)
        }
    }

    func drawGhibliPonyo(grid: inout [[NSColor]], frame: Int) {
        let pink = NSColor(red: 0.95, green: 0.55, blue: 0.6, alpha: 1.0)
        let orange = NSColor(red: 0.95, green: 0.6, blue: 0.2, alpha: 1.0)
        let skin = NSColor(red: 0.95, green: 0.8, blue: 0.65, alpha: 1.0)
        let black = NSColor.black
        let white = NSColor.white
        // Hair (orange/red)
        for x in 5...10 { setPixel(&grid, x: x, y: 0, color: orange) }
        for x in 5...10 { setPixel(&grid, x: x, y: 1, color: orange) }
        for x in 5...10 { setPixel(&grid, x: x, y: 2, color: orange) }
        // Head
        for x in 5...10 { setPixel(&grid, x: x, y: 3, color: skin) }
        setPixel(&grid, x: 6, y: 3, color: black)
        setPixel(&grid, x: 9, y: 3, color: black)
        for x in 5...10 { setPixel(&grid, x: x, y: 4, color: skin) }
        setPixel(&grid, x: 7, y: 4, color: pink)
        setPixel(&grid, x: 8, y: 4, color: pink)
        // Body (pink dress/fish tail)
        for x in 5...10 { setPixel(&grid, x: x, y: 5, color: pink) }
        for x in 4...11 { setPixel(&grid, x: x, y: 6, color: pink) }
        for x in 4...11 { setPixel(&grid, x: x, y: 7, color: orange) }
        if frame % 2 == 0 {
            setPixel(&grid, x: 4, y: 8, color: orange)
            setPixel(&grid, x: 11, y: 8, color: orange)
        } else {
            setPixel(&grid, x: 5, y: 8, color: orange)
            setPixel(&grid, x: 10, y: 8, color: orange)
        }
    }

    func drawGhibliSatsuki(grid: inout [[NSColor]], frame: Int) {
        let blue = NSColor(red: 0.15, green: 0.35, blue: 0.75, alpha: 1.0)
        let skin = NSColor(red: 0.95, green: 0.8, blue: 0.65, alpha: 1.0)
        let black = NSColor.black
        let white = NSColor.white
        let brown = NSColor(red: 0.5, green: 0.3, blue: 0.1, alpha: 1.0)
        // Hair (brown, short)
        for x in 5...10 { setPixel(&grid, x: x, y: 0, color: brown) }
        for x in 5...10 { setPixel(&grid, x: x, y: 1, color: brown) }
        for x in 5...10 { setPixel(&grid, x: x, y: 2, color: brown) }
        // Head
        for x in 5...10 { setPixel(&grid, x: x, y: 3, color: skin) }
        setPixel(&grid, x: 6, y: 3, color: black)
        setPixel(&grid, x: 9, y: 3, color: black)
        for x in 5...10 { setPixel(&grid, x: x, y: 4, color: skin) }
        setPixel(&grid, x: 7, y: 4, color: black)
        setPixel(&grid, x: 8, y: 4, color: black)
        // Body (blue outfit)
        for x in 4...11 { setPixel(&grid, x: x, y: 5, color: blue) }
        for x in 4...11 { setPixel(&grid, x: x, y: 6, color: blue) }
        for x in 5...10 { setPixel(&grid, x: x, y: 7, color: white) }
        if frame % 2 == 0 {
            setPixel(&grid, x: 5, y: 8, color: blue)
            setPixel(&grid, x: 10, y: 8, color: blue)
        } else {
            setPixel(&grid, x: 6, y: 8, color: blue)
            setPixel(&grid, x: 9, y: 8, color: blue)
        }
    }

    func drawGhibliMei(grid: inout [[NSColor]], frame: Int) {
        let yellow = NSColor(red: 1.0, green: 0.88, blue: 0.2, alpha: 1.0)
        let skin = NSColor(red: 0.95, green: 0.8, blue: 0.65, alpha: 1.0)
        let black = NSColor.black
        let pink = NSColor(red: 0.9, green: 0.5, blue: 0.55, alpha: 1.0)
        let orange = NSColor(red: 0.9, green: 0.5, blue: 0.1, alpha: 1.0)
        // Hair (dark, pigtails)
        setPixel(&grid, x: 4, y: 0, color: black)
        setPixel(&grid, x: 11, y: 0, color: black)
        for x in 5...10 { setPixel(&grid, x: x, y: 0, color: black) }
        for x in 5...10 { setPixel(&grid, x: x, y: 1, color: black) }
        for x in 5...10 { setPixel(&grid, x: x, y: 2, color: black) }
        // Head
        for x in 5...10 { setPixel(&grid, x: x, y: 3, color: skin) }
        setPixel(&grid, x: 6, y: 3, color: black)
        setPixel(&grid, x: 9, y: 3, color: black)
        for x in 5...10 { setPixel(&grid, x: x, y: 4, color: skin) }
        setPixel(&grid, x: 7, y: 4, color: pink)
        setPixel(&grid, x: 8, y: 4, color: pink)
        // Body (yellow dress)
        for x in 4...11 { setPixel(&grid, x: x, y: 5, color: yellow) }
        setPixel(&grid, x: 7, y: 5, color: orange)
        setPixel(&grid, x: 8, y: 5, color: orange)
        for x in 4...11 { setPixel(&grid, x: x, y: 6, color: yellow) }
        for x in 5...10 { setPixel(&grid, x: x, y: 7, color: yellow) }
        if frame % 2 == 0 {
            setPixel(&grid, x: 5, y: 8, color: orange)
            setPixel(&grid, x: 10, y: 8, color: orange)
        } else {
            setPixel(&grid, x: 6, y: 8, color: orange)
            setPixel(&grid, x: 9, y: 8, color: orange)
        }
    }

    func drawGhibliHowl(grid: inout [[NSColor]], frame: Int) {
        let blue = NSColor(red: 0.2, green: 0.35, blue: 0.7, alpha: 1.0)
        let skin = NSColor(red: 0.95, green: 0.8, blue: 0.65, alpha: 1.0)
        let black = NSColor.black
        let gold = NSColor(red: 1.0, green: 0.8, blue: 0.0, alpha: 1.0)
        let purple = NSColor(red: 0.5, green: 0.2, blue: 0.6, alpha: 1.0)
        // Hair (blonde/gold)
        for x in 5...10 { setPixel(&grid, x: x, y: 0, color: gold) }
        for x in 5...10 { setPixel(&grid, x: x, y: 1, color: gold) }
        for x in 5...10 { setPixel(&grid, x: x, y: 2, color: gold) }
        // Head
        for x in 5...10 { setPixel(&grid, x: x, y: 3, color: skin) }
        setPixel(&grid, x: 6, y: 3, color: black)
        setPixel(&grid, x: 9, y: 3, color: black)
        for x in 5...10 { setPixel(&grid, x: x, y: 4, color: skin) }
        setPixel(&grid, x: 7, y: 4, color: black)
        setPixel(&grid, x: 8, y: 4, color: black)
        // Body (blue/purple robe)
        for x in 4...11 { setPixel(&grid, x: x, y: 5, color: blue) }
        setPixel(&grid, x: 7, y: 5, color: purple)
        setPixel(&grid, x: 8, y: 5, color: purple)
        for x in 4...11 { setPixel(&grid, x: x, y: 6, color: purple) }
        for x in 5...10 { setPixel(&grid, x: x, y: 7, color: blue) }
        if frame % 2 == 0 {
            setPixel(&grid, x: 5, y: 8, color: purple)
            setPixel(&grid, x: 10, y: 8, color: purple)
        } else {
            setPixel(&grid, x: 6, y: 8, color: purple)
            setPixel(&grid, x: 9, y: 8, color: purple)
        }
    }

    func drawGhibliSophie(grid: inout [[NSColor]], frame: Int) {
        let gray = NSColor(red: 0.6, green: 0.6, blue: 0.63, alpha: 1.0)
        let skin = NSColor(red: 0.95, green: 0.8, blue: 0.65, alpha: 1.0)
        let black = NSColor.black
        let brown = NSColor(red: 0.5, green: 0.35, blue: 0.15, alpha: 1.0)
        let green = NSColor(red: 0.2, green: 0.5, blue: 0.25, alpha: 1.0)
        // Hair (gray/aged)
        for x in 5...10 { setPixel(&grid, x: x, y: 0, color: gray) }
        for x in 5...10 { setPixel(&grid, x: x, y: 1, color: gray) }
        for x in 5...10 { setPixel(&grid, x: x, y: 2, color: gray) }
        // Head
        for x in 5...10 { setPixel(&grid, x: x, y: 3, color: skin) }
        setPixel(&grid, x: 6, y: 3, color: black)
        setPixel(&grid, x: 9, y: 3, color: black)
        for x in 5...10 { setPixel(&grid, x: x, y: 4, color: skin) }
        setPixel(&grid, x: 7, y: 4, color: black)
        setPixel(&grid, x: 8, y: 4, color: black)
        // Body (green dress)
        for x in 4...11 { setPixel(&grid, x: x, y: 5, color: green) }
        for x in 4...11 { setPixel(&grid, x: x, y: 6, color: green) }
        for x in 5...10 { setPixel(&grid, x: x, y: 7, color: gray) }
        if frame % 2 == 0 {
            setPixel(&grid, x: 5, y: 8, color: gray)
            setPixel(&grid, x: 10, y: 8, color: gray)
        } else {
            setPixel(&grid, x: 6, y: 8, color: gray)
            setPixel(&grid, x: 9, y: 8, color: gray)
        }
    }

    func drawGhibliAppend(grid: inout [[NSColor]], frame: Int) {
        let silver = NSColor(red: 0.75, green: 0.75, blue: 0.78, alpha: 1.0)
        let darkSilver = NSColor(red: 0.55, green: 0.55, blue: 0.58, alpha: 1.0)
        let green = NSColor(red: 0.2, green: 0.65, blue: 0.25, alpha: 1.0)
        let black = NSColor.black
        // Robot head
        for x in 5...10 { setPixel(&grid, x: x, y: 1, color: silver) }
        for x in 5...10 { setPixel(&grid, x: x, y: 2, color: silver) }
        for x in 5...10 { setPixel(&grid, x: x, y: 3, color: silver) }
        setPixel(&grid, x: 6, y: 3, color: green)
        setPixel(&grid, x: 9, y: 3, color: green)
        setPixel(&grid, x: 7, y: 3, color: black)
        setPixel(&grid, x: 8, y: 3, color: black)
        for x in 5...10 { setPixel(&grid, x: x, y: 4, color: darkSilver) }
        // Body (robot)
        for x in 4...11 { setPixel(&grid, x: x, y: 5, color: silver) }
        setPixel(&grid, x: 7, y: 5, color: green)
        setPixel(&grid, x: 8, y: 5, color: green)
        for x in 4...11 { setPixel(&grid, x: x, y: 6, color: darkSilver) }
        for x in 5...10 { setPixel(&grid, x: x, y: 7, color: silver) }
        if frame % 2 == 0 {
            setPixel(&grid, x: 5, y: 8, color: darkSilver)
            setPixel(&grid, x: 10, y: 8, color: darkSilver)
        } else {
            setPixel(&grid, x: 6, y: 8, color: darkSilver)
            setPixel(&grid, x: 9, y: 8, color: darkSilver)
        }
    }

    func drawGhibliJiro(grid: inout [[NSColor]], frame: Int) {
        let green = NSColor(red: 0.2, green: 0.45, blue: 0.2, alpha: 1.0)
        let skin = NSColor(red: 0.95, green: 0.8, blue: 0.65, alpha: 1.0)
        let black = NSColor.black
        let brown = NSColor(red: 0.45, green: 0.3, blue: 0.1, alpha: 1.0)
        let gray = NSColor(red: 0.55, green: 0.55, blue: 0.58, alpha: 1.0)
        // Hair (brown)
        for x in 5...10 { setPixel(&grid, x: x, y: 0, color: brown) }
        for x in 5...10 { setPixel(&grid, x: x, y: 1, color: brown) }
        for x in 5...10 { setPixel(&grid, x: x, y: 2, color: brown) }
        // Head
        for x in 5...10 { setPixel(&grid, x: x, y: 3, color: skin) }
        setPixel(&grid, x: 6, y: 3, color: black)
        setPixel(&grid, x: 9, y: 3, color: black)
        for x in 5...10 { setPixel(&grid, x: x, y: 4, color: skin) }
        setPixel(&grid, x: 7, y: 4, color: black)
        setPixel(&grid, x: 8, y: 4, color: black)
        // Body (green flight suit)
        for x in 4...11 { setPixel(&grid, x: x, y: 5, color: green) }
        for x in 4...11 { setPixel(&grid, x: x, y: 6, color: green) }
        for x in 5...10 { setPixel(&grid, x: x, y: 7, color: gray) }
        if frame % 2 == 0 {
            setPixel(&grid, x: 5, y: 8, color: gray)
            setPixel(&grid, x: 10, y: 8, color: gray)
        } else {
            setPixel(&grid, x: 6, y: 8, color: gray)
            setPixel(&grid, x: 9, y: 8, color: gray)
        }
    }

    func drawGhibliChihiro(grid: inout [[NSColor]], frame: Int) {
        let pink = NSColor(red: 0.9, green: 0.5, blue: 0.55, alpha: 1.0)
        let skin = NSColor(red: 0.95, green: 0.8, blue: 0.65, alpha: 1.0)
        let black = NSColor.black
        let brown = NSColor(red: 0.5, green: 0.3, blue: 0.1, alpha: 1.0)
        let white = NSColor.white
        // Hair (brown, ponytail)
        setPixel(&grid, x: 10, y: 0, color: brown)
        setPixel(&grid, x: 10, y: 1, color: brown)
        for x in 5...10 { setPixel(&grid, x: x, y: 0, color: brown) }
        for x in 5...10 { setPixel(&grid, x: x, y: 1, color: brown) }
        for x in 5...10 { setPixel(&grid, x: x, y: 2, color: brown) }
        // Head
        for x in 5...10 { setPixel(&grid, x: x, y: 3, color: skin) }
        setPixel(&grid, x: 6, y: 3, color: black)
        setPixel(&grid, x: 9, y: 3, color: black)
        for x in 5...10 { setPixel(&grid, x: x, y: 4, color: skin) }
        setPixel(&grid, x: 7, y: 4, color: black)
        setPixel(&grid, x: 8, y: 4, color: black)
        // Body (pink/white outfit)
        for x in 4...11 { setPixel(&grid, x: x, y: 5, color: white) }
        setPixel(&grid, x: 7, y: 5, color: pink)
        setPixel(&grid, x: 8, y: 5, color: pink)
        for x in 4...11 { setPixel(&grid, x: x, y: 6, color: pink) }
        for x in 5...10 { setPixel(&grid, x: x, y: 7, color: white) }
        if frame % 2 == 0 {
            setPixel(&grid, x: 5, y: 8, color: brown)
            setPixel(&grid, x: 10, y: 8, color: brown)
        } else {
            setPixel(&grid, x: 6, y: 8, color: brown)
            setPixel(&grid, x: 9, y: 8, color: brown)
        }
    }

    func drawKartBomb(grid: inout [[NSColor]], frame: Int) {
        let darkGray = NSColor(red: 0.3, green: 0.3, blue: 0.3, alpha: 1.0)
        let white = NSColor.white
        let fuse = NSColor(red: 0.6, green: 0.5, blue: 0.3, alpha: 1.0)
        let spark = NSColor(red: 1.0, green: 0.8, blue: 0.0, alpha: 1.0)
        for x in 5...10 { setPixel(&grid, x: x, y: 3, color: darkGray) }
        for x in 4...11 { setPixel(&grid, x: x, y: 4, color: darkGray) }
        for x in 4...11 { setPixel(&grid, x: x, y: 5, color: darkGray) }
        for x in 5...10 { setPixel(&grid, x: x, y: 6, color: darkGray) }
        setPixel(&grid, x: 8, y: 2, color: fuse)
        setPixel(&grid, x: 8, y: 1, color: fuse)
        let sparkColor: NSColor
        switch frame % 3 {
        case 0: sparkColor = NSColor(red: 1.0, green: 0.8, blue: 0.0, alpha: 1.0)
        case 1: sparkColor = NSColor(red: 1.0, green: 0.5, blue: 0.0, alpha: 1.0)
        default: sparkColor = NSColor(red: 0.9, green: 0.15, blue: 0.15, alpha: 1.0)
        }
        setPixel(&grid, x: 7, y: 0, color: sparkColor)
        setPixel(&grid, x: 8, y: 0, color: sparkColor)
        setPixel(&grid, x: 6, y: 4, color: white)
        setPixel(&grid, x: 9, y: 4, color: white)
    }

    func drawKartBulletBill(grid: inout [[NSColor]], frame: Int) {
        let darkGray = NSColor(red: 0.3, green: 0.3, blue: 0.3, alpha: 1.0)
        let gray = NSColor(red: 0.45, green: 0.45, blue: 0.45, alpha: 1.0)
        let white = NSColor.white
        let red = NSColor(red: 0.9, green: 0.15, blue: 0.15, alpha: 1.0)
        for x in 4...10 { setPixel(&grid, x: x, y: 3, color: darkGray) }
        for x in 3...10 { setPixel(&grid, x: x, y: 4, color: darkGray) }
        for x in 3...10 { setPixel(&grid, x: x, y: 5, color: darkGray) }
        for x in 4...10 { setPixel(&grid, x: x, y: 6, color: darkGray) }
        setPixel(&grid, x: 11, y: 4, color: gray)
        setPixel(&grid, x: 11, y: 5, color: gray)
        setPixel(&grid, x: 5, y: 4, color: white)
        setPixel(&grid, x: 5, y: 5, color: red)
        if frame % 2 == 0 {
            setPixel(&grid, x: 2, y: 4, color: gray)
            setPixel(&grid, x: 2, y: 5, color: gray)
            setPixel(&grid, x: 1, y: 4, color: NSColor(red: 0.6, green: 0.6, blue: 0.6, alpha: 0.5))
        }
    }

    func drawKartBlueShell(grid: inout [[NSColor]], frame: Int) {
        let blue = NSColor(red: 0.15, green: 0.3, blue: 0.85, alpha: 1.0)
        let darkBlue = NSColor(red: 0.1, green: 0.15, blue: 0.55, alpha: 1.0)
        let brightBlue = NSColor(red: 0.3, green: 0.55, blue: 1.0, alpha: 1.0)
        let cyan = NSColor(red: 0.2, green: 0.75, blue: 0.95, alpha: 1.0)
        let purple = NSColor(red: 0.45, green: 0.15, blue: 0.65, alpha: 1.0)
        let white = NSColor.white
        let lightGray = NSColor(red: 0.85, green: 0.85, blue: 0.88, alpha: 1.0)
        let black = NSColor.black
        let shift = (frame % 2 == 0) ? 0 : 1
        let highlightLeft = (frame % 4 < 2)
        let wingUp = (frame % 2 == 0)
        // Wings/spikes on top (animate up/down)
        if wingUp {
            setPixel(&grid, x: 5+shift, y: 0, color: black)
            setPixel(&grid, x: 10+shift, y: 0, color: black)
            setPixel(&grid, x: 4+shift, y: 1, color: black)
            setPixel(&grid, x: 5+shift, y: 1, color: white)
            setPixel(&grid, x: 10+shift, y: 1, color: white)
            setPixel(&grid, x: 11+shift, y: 1, color: black)
            setPixel(&grid, x: 4+shift, y: 2, color: black)
            setPixel(&grid, x: 5+shift, y: 2, color: lightGray)
            setPixel(&grid, x: 10+shift, y: 2, color: lightGray)
            setPixel(&grid, x: 11+shift, y: 2, color: black)
        } else {
            setPixel(&grid, x: 5+shift, y: 1, color: black)
            setPixel(&grid, x: 10+shift, y: 1, color: black)
            setPixel(&grid, x: 5+shift, y: 2, color: white)
            setPixel(&grid, x: 10+shift, y: 2, color: white)
        }
        // Shell dome
        setPixel(&grid, x: 7+shift, y: 1, color: black)
        setPixel(&grid, x: 8+shift, y: 1, color: black)
        for x in 6...9 { setPixel(&grid, x: x+shift, y: 2, color: blue) }
        setPixel(&grid, x: 7+shift, y: 2, color: highlightLeft ? brightBlue : blue)
        setPixel(&grid, x: 8+shift, y: 2, color: highlightLeft ? blue : cyan)
        setPixel(&grid, x: 6+shift, y: 2, color: black)
        setPixel(&grid, x: 9+shift, y: 2, color: black)
        for x in 5...10 { setPixel(&grid, x: x+shift, y: 3, color: blue) }
        setPixel(&grid, x: 6+shift, y: 3, color: highlightLeft ? cyan : brightBlue)
        setPixel(&grid, x: 7+shift, y: 3, color: highlightLeft ? brightBlue : cyan)
        setPixel(&grid, x: 8+shift, y: 3, color: highlightLeft ? blue : brightBlue)
        setPixel(&grid, x: 5+shift, y: 3, color: black)
        setPixel(&grid, x: 10+shift, y: 3, color: black)
        for x in 4...11 { setPixel(&grid, x: x+shift, y: 4, color: blue) }
        setPixel(&grid, x: 5+shift, y: 4, color: highlightLeft ? brightBlue : cyan)
        setPixel(&grid, x: 6+shift, y: 4, color: highlightLeft ? cyan : blue)
        setPixel(&grid, x: 4+shift, y: 4, color: black)
        setPixel(&grid, x: 11+shift, y: 4, color: black)
        for x in 4...11 { setPixel(&grid, x: x+shift, y: 5, color: purple) }
        setPixel(&grid, x: 5+shift, y: 5, color: blue)
        setPixel(&grid, x: 4+shift, y: 5, color: black)
        setPixel(&grid, x: 11+shift, y: 5, color: black)
        // White base
        for x in 5...10 { setPixel(&grid, x: x+shift, y: 6, color: white) }
        setPixel(&grid, x: 5+shift, y: 6, color: lightGray)
        setPixel(&grid, x: 10+shift, y: 6, color: lightGray)
        setPixel(&grid, x: 4+shift, y: 6, color: black)
        setPixel(&grid, x: 11+shift, y: 6, color: black)
        // Feet (alternating)
        if frame % 2 == 0 {
            setPixel(&grid, x: 5+shift, y: 7, color: lightGray)
            setPixel(&grid, x: 6+shift, y: 7, color: white)
            setPixel(&grid, x: 9+shift, y: 7, color: white)
            setPixel(&grid, x: 10+shift, y: 7, color: lightGray)
        } else {
            setPixel(&grid, x: 6+shift, y: 7, color: white)
            setPixel(&grid, x: 7+shift, y: 7, color: lightGray)
            setPixel(&grid, x: 8+shift, y: 7, color: lightGray)
            setPixel(&grid, x: 9+shift, y: 7, color: white)
        }
        setPixel(&grid, x: 4+shift, y: 7, color: black)
        setPixel(&grid, x: 11+shift, y: 7, color: black)
    }

    func drawKartStar(grid: inout [[NSColor]], frame: Int) {
        let yellow = NSColor(red: 1.0, green: 0.9, blue: 0.0, alpha: 1.0)
        let brightYellow = NSColor(red: 1.0, green: 1.0, blue: 0.4, alpha: 1.0)
        let white = NSColor.white
        let blink = frame % 2 == 0
        setPixel(&grid, x: 7, y: 0, color: yellow)
        setPixel(&grid, x: 8, y: 0, color: yellow)
        for x in 6...9 { setPixel(&grid, x: x, y: 1, color: yellow) }
        for x in 3...12 { setPixel(&grid, x: x, y: 2, color: yellow) }
        for x in 4...11 { setPixel(&grid, x: x, y: 3, color: yellow) }
        for x in 5...10 { setPixel(&grid, x: x, y: 4, color: yellow) }
        setPixel(&grid, x: 4, y: 5, color: yellow)
        setPixel(&grid, x: 5, y: 5, color: yellow)
        setPixel(&grid, x: 9, y: 5, color: yellow)
        setPixel(&grid, x: 10, y: 5, color: yellow)
        setPixel(&grid, x: 3, y: 6, color: yellow)
        setPixel(&grid, x: 4, y: 6, color: yellow)
        setPixel(&grid, x: 10, y: 6, color: yellow)
        setPixel(&grid, x: 11, y: 6, color: yellow)
        if blink {
            setPixel(&grid, x: 7, y: 3, color: white)
            setPixel(&grid, x: 8, y: 3, color: white)
        } else {
            setPixel(&grid, x: 7, y: 3, color: brightYellow)
            setPixel(&grid, x: 8, y: 3, color: brightYellow)
        }
    }

    func drawKartLightning(grid: inout [[NSColor]], frame: Int) {
        let yellow = NSColor(red: 1.0, green: 0.85, blue: 0.0, alpha: 1.0)
        let brightYellow = NSColor(red: 1.0, green: 1.0, blue: 0.4, alpha: 1.0)
        let darkYellow = NSColor(red: 0.8, green: 0.65, blue: 0.0, alpha: 1.0)

        // Top diagonal: goes from top-right down to center-left
        for x in 6...11 { setPixel(&grid, x: x, y: 0, color: yellow) }
        for x in 5...10 { setPixel(&grid, x: x, y: 1, color: yellow) }
        for x in 4...9  { setPixel(&grid, x: x, y: 2, color: yellow) }
        for x in 3...8  { setPixel(&grid, x: x, y: 3, color: yellow) }

        // Wide middle bar — the zigzag kink
        for x in 2...12 { setPixel(&grid, x: x, y: 4, color: yellow) }
        for x in 2...12 { setPixel(&grid, x: x, y: 5, color: yellow) }

        // Bottom diagonal: goes from center-right down to bottom-right point
        for x in 7...12 { setPixel(&grid, x: x, y: 6,  color: yellow) }
        for x in 8...12 { setPixel(&grid, x: x, y: 7,  color: yellow) }
        for x in 9...12 { setPixel(&grid, x: x, y: 8,  color: yellow) }
        for x in 10...12 { setPixel(&grid, x: x, y: 9, color: yellow) }
        for x in 11...12 { setPixel(&grid, x: x, y: 10, color: yellow) }
        setPixel(&grid, x: 12, y: 11, color: yellow)  // tip

        // Dark shading on right/bottom edges
        setPixel(&grid, x: 11, y: 0,  color: darkYellow)
        setPixel(&grid, x: 10, y: 1,  color: darkYellow)
        setPixel(&grid, x: 9,  y: 2,  color: darkYellow)
        setPixel(&grid, x: 8,  y: 3,  color: darkYellow)
        setPixel(&grid, x: 12, y: 4,  color: darkYellow)
        setPixel(&grid, x: 12, y: 5,  color: darkYellow)
        setPixel(&grid, x: 12, y: 6,  color: darkYellow)
        setPixel(&grid, x: 12, y: 7,  color: darkYellow)
        setPixel(&grid, x: 12, y: 8,  color: darkYellow)
        setPixel(&grid, x: 12, y: 9,  color: darkYellow)
        setPixel(&grid, x: 12, y: 10, color: darkYellow)
        setPixel(&grid, x: 12, y: 11, color: darkYellow)

        // Bright highlights (animated pulse)
        if frame % 2 == 0 {
            setPixel(&grid, x: 6, y: 0, color: brightYellow)
            setPixel(&grid, x: 5, y: 1, color: brightYellow)
            setPixel(&grid, x: 2, y: 4, color: brightYellow)
            setPixel(&grid, x: 2, y: 5, color: brightYellow)
        } else {
            setPixel(&grid, x: 7, y: 0, color: brightYellow)
            setPixel(&grid, x: 6, y: 1, color: brightYellow)
            setPixel(&grid, x: 3, y: 4, color: brightYellow)
            setPixel(&grid, x: 3, y: 5, color: brightYellow)
        }
    }

    func drawKartMushroom(grid: inout [[NSColor]], frame: Int) {
        let red = NSColor(red: 0.9, green: 0.15, blue: 0.15, alpha: 1.0)
        let white = NSColor.white
        let tan = NSColor(red: 0.9, green: 0.8, blue: 0.6, alpha: 1.0)
        for x in 5...10 { setPixel(&grid, x: x, y: 2, color: red) }
        for x in 4...11 { setPixel(&grid, x: x, y: 3, color: red) }
        for x in 4...11 { setPixel(&grid, x: x, y: 4, color: red) }
        setPixel(&grid, x: 6, y: 3, color: white)
        setPixel(&grid, x: 9, y: 3, color: white)
        setPixel(&grid, x: 7, y: 2, color: white)
        for x in 6...9 { setPixel(&grid, x: x, y: 5, color: tan) }
        for x in 6...9 { setPixel(&grid, x: x, y: 6, color: tan) }
        setPixel(&grid, x: 7, y: 7, color: tan)
        setPixel(&grid, x: 8, y: 7, color: tan)
    }

    func drawKartTripleMushroom(grid: inout [[NSColor]], frame: Int) {
        let red = NSColor(red: 0.9, green: 0.15, blue: 0.15, alpha: 1.0)
        let white = NSColor.white
        let tan = NSColor(red: 0.9, green: 0.8, blue: 0.6, alpha: 1.0)
        // Left mushroom
        setPixel(&grid, x: 2, y: 3, color: red)
        setPixel(&grid, x: 3, y: 3, color: red)
        setPixel(&grid, x: 2, y: 4, color: red)
        setPixel(&grid, x: 3, y: 4, color: red)
        setPixel(&grid, x: 2, y: 5, color: tan)
        setPixel(&grid, x: 3, y: 5, color: tan)
        // Center mushroom
        for x in 6...9 { setPixel(&grid, x: x, y: 2, color: red) }
        for x in 6...9 { setPixel(&grid, x: x, y: 3, color: red) }
        setPixel(&grid, x: 7, y: 2, color: white)
        setPixel(&grid, x: 8, y: 2, color: white)
        for x in 7...8 { setPixel(&grid, x: x, y: 4, color: tan) }
        for x in 7...8 { setPixel(&grid, x: x, y: 5, color: tan) }
        // Right mushroom
        setPixel(&grid, x: 12, y: 3, color: red)
        setPixel(&grid, x: 13, y: 3, color: red)
        setPixel(&grid, x: 12, y: 4, color: red)
        setPixel(&grid, x: 13, y: 4, color: red)
        setPixel(&grid, x: 12, y: 5, color: tan)
        setPixel(&grid, x: 13, y: 5, color: tan)
    }

    func drawKartGoldenMushroom(grid: inout [[NSColor]], frame: Int) {
        let gold = NSColor(red: 1.0, green: 0.85, blue: 0.0, alpha: 1.0)
        let brightGold = NSColor(red: 1.0, green: 1.0, blue: 0.4, alpha: 1.0)
        let tan = NSColor(red: 0.9, green: 0.8, blue: 0.6, alpha: 1.0)
        for x in 5...10 { setPixel(&grid, x: x, y: 2, color: gold) }
        for x in 4...11 { setPixel(&grid, x: x, y: 3, color: gold) }
        for x in 4...11 { setPixel(&grid, x: x, y: 4, color: gold) }
        setPixel(&grid, x: 6, y: 3, color: brightGold)
        setPixel(&grid, x: 9, y: 3, color: brightGold)
        setPixel(&grid, x: 7, y: 2, color: brightGold)
        for x in 6...9 { setPixel(&grid, x: x, y: 5, color: tan) }
        for x in 6...9 { setPixel(&grid, x: x, y: 6, color: tan) }
        setPixel(&grid, x: 7, y: 7, color: tan)
        setPixel(&grid, x: 8, y: 7, color: tan)
        if frame % 2 == 0 {
            setPixel(&grid, x: 5, y: 1, color: brightGold)
            setPixel(&grid, x: 10, y: 1, color: brightGold)
        }
    }

    // MARK: - Mega Man
    func drawMMMegaMan(grid: inout [[NSColor]], frame: Int) {
        let darkBlue = NSColor(red: 0.00, green: 0.45, blue: 0.94, alpha: 1.0)
        let cyan = NSColor(red: 0.00, green: 0.90, blue: 0.94, alpha: 1.0)
        let skin = NSColor(red: 1.00, green: 0.81, blue: 0.61, alpha: 1.0)
        let white = NSColor.white
        let black = NSColor.black

        let anim = frame % 4
        let rows: [String] = [
            "..........KKK........", // 00
            "........KKKCCK.......", // 01
            ".......KDDDKCCK......", // 02
            "......KDDDDDKKKK.....", // 03
            "......KDDDDDKCCDK....", // 04
            ".....KCDDDDDDKKDK....", // 05
            ".....KCDDSWWWDDWK....", // 06
            ".....KCDSWWKKSKWK....", // 07
            "......KDSWWKKSKWK....", // 08
            ".....KKDSSWWWSWSK....", // 09
            "...KKCCKDSKKKKSKKK...", // 10
            "..KDCCCCKSSSSSKCCDK..", // 11
            "..KDDCCCCKKKKKCCDDK..", // 12
            ".KDDDCKCCCCCCCKCDDDK.", // 13
            ".KDDKKKCCCCCCCKKKDDK.", // 14
            ".KDDDKKCCCCCCCKKDDDK.", // 15
            ".KDDDKKDDDDDDDKKDDDK.", // 16
            "..KKK.KDDDDDDDK.KKK..", // 17
            ".....KCCDDDDCCCK.....", // 18
            "....KDDCCCKCCCCDK....", // 19
            "...KKDDDCK.KCDDDKK...", // 20
            ".KKDDDDDK...KDDDDDKK.", // 21
            "KDDDDDDDK...KDDDDDDDK", // 22
            "KKKKKKKKK...KKKKKKKKK", // 23
        ]

        for (rIdx, row) in rows.enumerated() {
            var rowChars = Array(row)

            // Blinking animation
            if anim == 3 {
                if rIdx == 6 {
                    rowChars[8] = "S"; rowChars[9] = "S"; rowChars[10] = "S"; rowChars[15] = "S"
                } else if rIdx == 7 {
                    rowChars[8] = "S"; rowChars[9] = "K"; rowChars[10] = "K"; rowChars[11] = "S"; rowChars[12] = "S"; rowChars[13] = "K"; rowChars[15] = "S"
                } else if rIdx == 8 {
                    rowChars[7] = "S"; rowChars[8] = "S"; rowChars[9] = "S"; rowChars[10] = "S"; rowChars[11] = "S"; rowChars[12] = "S"; rowChars[14] = "S"
                } else if rIdx == 9 {
                    rowChars[8] = "S"; rowChars[9] = "S"; rowChars[10] = "S"; rowChars[12] = "S"
                }
            }

            for (cIdx, ch) in rowChars.enumerated() {
                switch ch {
                case "K": setPixel(&grid, x: cIdx, y: rIdx, color: black)
                case "D": setPixel(&grid, x: cIdx, y: rIdx, color: darkBlue)
                case "C": setPixel(&grid, x: cIdx, y: rIdx, color: cyan)
                case "S": setPixel(&grid, x: cIdx, y: rIdx, color: skin)
                case "W": setPixel(&grid, x: cIdx, y: rIdx, color: white)
                default: break
                }
            }
        }
    }

    func drawMMProtoMan(grid: inout [[NSColor]], frame: Int) {
        let yellow = NSColor(red: 1.0, green: 0.85, blue: 0.0, alpha: 1.0)
        let red = NSColor(red: 0.85, green: 0.2, blue: 0.2, alpha: 1.0)
        let gray = NSColor(red: 0.6, green: 0.6, blue: 0.6, alpha: 1.0)
        let white = NSColor.white
        for x in 6...9 { setPixel(&grid, x: x, y: 1, color: yellow) }
        for x in 5...10 { setPixel(&grid, x: x, y: 2, color: yellow) }
        for x in 5...10 { setPixel(&grid, x: x, y: 3, color: gray) }
        setPixel(&grid, x: 6, y: 3, color: white)
        setPixel(&grid, x: 9, y: 3, color: white)
        for x in 5...10 { setPixel(&grid, x: x, y: 4, color: red) }
        for x in 4...11 { setPixel(&grid, x: x, y: 5, color: red) }
        for x in 4...11 { setPixel(&grid, x: x, y: 6, color: red) }
        if frame % 2 == 0 {
            setPixel(&grid, x: 5, y: 7, color: red)
            setPixel(&grid, x: 10, y: 7, color: red)
        } else {
            setPixel(&grid, x: 6, y: 7, color: red)
            setPixel(&grid, x: 9, y: 7, color: red)
        }
    }

    func drawMMBass(grid: inout [[NSColor]], frame: Int) {
        let black = NSColor(red: 0.15, green: 0.15, blue: 0.15, alpha: 1.0)
        let red = NSColor(red: 0.85, green: 0.2, blue: 0.2, alpha: 1.0)
        let skin = NSColor(red: 0.95, green: 0.8, blue: 0.65, alpha: 1.0)
        let white = NSColor.white
        for x in 5...10 { setPixel(&grid, x: x, y: 1, color: black) }
        for x in 4...11 { setPixel(&grid, x: x, y: 2, color: black) }
        for x in 5...10 { setPixel(&grid, x: x, y: 3, color: skin) }
        setPixel(&grid, x: 6, y: 3, color: white)
        setPixel(&grid, x: 9, y: 3, color: white)
        for x in 5...10 { setPixel(&grid, x: x, y: 4, color: black) }
        for x in 4...11 { setPixel(&grid, x: x, y: 5, color: red) }
        for x in 4...11 { setPixel(&grid, x: x, y: 6, color: black) }
        if frame % 2 == 0 {
            setPixel(&grid, x: 5, y: 7, color: red)
            setPixel(&grid, x: 10, y: 7, color: red)
        } else {
            setPixel(&grid, x: 6, y: 7, color: red)
            setPixel(&grid, x: 9, y: 7, color: red)
        }
    }

    func drawMMRoll(grid: inout [[NSColor]], frame: Int) {
        let blue = NSColor(red: 0.2, green: 0.45, blue: 0.9, alpha: 1.0)
        let white = NSColor.white
        let skin = NSColor(red: 0.95, green: 0.8, blue: 0.65, alpha: 1.0)
        let red = NSColor(red: 0.85, green: 0.2, blue: 0.2, alpha: 1.0)
        for x in 6...9 { setPixel(&grid, x: x, y: 1, color: red) }
        for x in 5...10 { setPixel(&grid, x: x, y: 2, color: white) }
        for x in 5...10 { setPixel(&grid, x: x, y: 3, color: skin) }
        setPixel(&grid, x: 6, y: 3, color: NSColor.black)
        setPixel(&grid, x: 9, y: 3, color: NSColor.black)
        for x in 5...10 { setPixel(&grid, x: x, y: 4, color: white) }
        for x in 4...11 { setPixel(&grid, x: x, y: 5, color: blue) }
        for x in 4...11 { setPixel(&grid, x: x, y: 6, color: blue) }
        if frame % 2 == 0 {
            setPixel(&grid, x: 5, y: 7, color: blue)
            setPixel(&grid, x: 10, y: 7, color: blue)
        } else {
            setPixel(&grid, x: 6, y: 7, color: blue)
            setPixel(&grid, x: 9, y: 7, color: blue)
        }
    }

    func drawMMRush(grid: inout [[NSColor]], frame: Int) {
        let red = NSColor(red: 0.85, green: 0.2, blue: 0.2, alpha: 1.0)
        let white = NSColor.white
        let black = NSColor.black
        for x in 6...9 { setPixel(&grid, x: x, y: 2, color: red) }
        for x in 5...10 { setPixel(&grid, x: x, y: 3, color: red) }
        setPixel(&grid, x: 6, y: 3, color: white)
        setPixel(&grid, x: 9, y: 3, color: white)
        setPixel(&grid, x: 7, y: 3, color: black)
        setPixel(&grid, x: 8, y: 3, color: black)
        for x in 4...11 { setPixel(&grid, x: x, y: 4, color: red) }
        for x in 5...10 { setPixel(&grid, x: x, y: 5, color: red) }
        if frame % 2 == 0 {
            setPixel(&grid, x: 5, y: 6, color: red)
            setPixel(&grid, x: 10, y: 6, color: red)
        } else {
            setPixel(&grid, x: 6, y: 6, color: red)
            setPixel(&grid, x: 9, y: 6, color: red)
        }
    }

    func drawMMCutMan(grid: inout [[NSColor]], frame: Int) {
        let gray = NSColor(red: 0.7, green: 0.7, blue: 0.7, alpha: 1.0)
        let darkGray = NSColor(red: 0.5, green: 0.5, blue: 0.5, alpha: 1.0)
        let skin = NSColor(red: 0.95, green: 0.8, blue: 0.65, alpha: 1.0)
        for x in 5...10 { setPixel(&grid, x: x, y: 1, color: gray) }
        setPixel(&grid, x: 5, y: 0, color: darkGray)
        setPixel(&grid, x: 10, y: 0, color: darkGray)
        for x in 5...10 { setPixel(&grid, x: x, y: 2, color: gray) }
        for x in 5...10 { setPixel(&grid, x: x, y: 3, color: skin) }
        setPixel(&grid, x: 6, y: 3, color: NSColor.black)
        setPixel(&grid, x: 9, y: 3, color: NSColor.black)
        for x in 5...10 { setPixel(&grid, x: x, y: 4, color: gray) }
        for x in 4...11 { setPixel(&grid, x: x, y: 5, color: darkGray) }
        for x in 4...11 { setPixel(&grid, x: x, y: 6, color: gray) }
        if frame % 2 == 0 {
            setPixel(&grid, x: 5, y: 7, color: darkGray)
            setPixel(&grid, x: 10, y: 7, color: darkGray)
        } else {
            setPixel(&grid, x: 6, y: 7, color: darkGray)
            setPixel(&grid, x: 9, y: 7, color: darkGray)
        }
    }

    func drawMMGutsMan(grid: inout [[NSColor]], frame: Int) {
        let red = NSColor(red: 0.85, green: 0.2, blue: 0.2, alpha: 1.0)
        let brown = NSColor(red: 0.6, green: 0.35, blue: 0.15, alpha: 1.0)
        let skin = NSColor(red: 0.95, green: 0.8, blue: 0.65, alpha: 1.0)
        for x in 5...10 { setPixel(&grid, x: x, y: 1, color: red) }
        for x in 4...11 { setPixel(&grid, x: x, y: 2, color: red) }
        for x in 5...10 { setPixel(&grid, x: x, y: 3, color: skin) }
        setPixel(&grid, x: 6, y: 3, color: NSColor.black)
        setPixel(&grid, x: 9, y: 3, color: NSColor.black)
        for x in 3...12 { setPixel(&grid, x: x, y: 4, color: brown) }
        for x in 3...12 { setPixel(&grid, x: x, y: 5, color: red) }
        for x in 4...11 { setPixel(&grid, x: x, y: 6, color: brown) }
        if frame % 2 == 0 {
            setPixel(&grid, x: 5, y: 7, color: brown)
            setPixel(&grid, x: 10, y: 7, color: brown)
        } else {
            setPixel(&grid, x: 6, y: 7, color: brown)
            setPixel(&grid, x: 9, y: 7, color: brown)
        }
    }

    func drawMMIceMan(grid: inout [[NSColor]], frame: Int) {
        let ice = NSColor(red: 0.6, green: 0.85, blue: 1.0, alpha: 1.0)
        let white = NSColor.white
        let lightBlue = NSColor(red: 0.8, green: 0.95, blue: 1.0, alpha: 1.0)
        for x in 6...9 { setPixel(&grid, x: x, y: 1, color: ice) }
        for x in 5...10 { setPixel(&grid, x: x, y: 2, color: ice) }
        for x in 5...10 { setPixel(&grid, x: x, y: 3, color: ice) }
        setPixel(&grid, x: 6, y: 3, color: white)
        setPixel(&grid, x: 9, y: 3, color: white)
        for x in 5...10 { setPixel(&grid, x: x, y: 4, color: lightBlue) }
        for x in 4...11 { setPixel(&grid, x: x, y: 5, color: ice) }
        for x in 4...11 { setPixel(&grid, x: x, y: 6, color: lightBlue) }
        if frame % 2 == 0 {
            setPixel(&grid, x: 5, y: 7, color: ice)
            setPixel(&grid, x: 10, y: 7, color: ice)
        } else {
            setPixel(&grid, x: 6, y: 7, color: ice)
            setPixel(&grid, x: 9, y: 7, color: ice)
        }
    }

    func drawMMBombMan(grid: inout [[NSColor]], frame: Int) {
        let black = NSColor(red: 0.15, green: 0.15, blue: 0.15, alpha: 1.0)
        let orange = NSColor(red: 0.9, green: 0.5, blue: 0.1, alpha: 1.0)
        let skin = NSColor(red: 0.95, green: 0.8, blue: 0.65, alpha: 1.0)
        let white = NSColor.white
        for x in 5...10 { setPixel(&grid, x: x, y: 1, color: orange) }
        for x in 4...11 { setPixel(&grid, x: x, y: 2, color: orange) }
        for x in 5...10 { setPixel(&grid, x: x, y: 3, color: skin) }
        setPixel(&grid, x: 6, y: 3, color: white)
        setPixel(&grid, x: 9, y: 3, color: white)
        for x in 5...10 { setPixel(&grid, x: x, y: 4, color: black) }
        for x in 4...11 { setPixel(&grid, x: x, y: 5, color: black) }
        for x in 4...11 { setPixel(&grid, x: x, y: 6, color: orange) }
        if frame % 2 == 0 {
            setPixel(&grid, x: 5, y: 7, color: orange)
            setPixel(&grid, x: 10, y: 7, color: orange)
        } else {
            setPixel(&grid, x: 6, y: 7, color: orange)
            setPixel(&grid, x: 9, y: 7, color: orange)
        }
    }

    func drawMMFireMan(grid: inout [[NSColor]], frame: Int) {
        let red = NSColor(red: 0.85, green: 0.2, blue: 0.2, alpha: 1.0)
        let orange = NSColor(red: 0.95, green: 0.55, blue: 0.1, alpha: 1.0)
        let yellow = NSColor(red: 1.0, green: 0.9, blue: 0.0, alpha: 1.0)
        let skin = NSColor(red: 0.95, green: 0.8, blue: 0.65, alpha: 1.0)
        for x in 6...9 { setPixel(&grid, x: x, y: 1, color: orange) }
        setPixel(&grid, x: 7, y: 0, color: yellow)
        setPixel(&grid, x: 8, y: 0, color: yellow)
        for x in 5...10 { setPixel(&grid, x: x, y: 2, color: red) }
        for x in 5...10 { setPixel(&grid, x: x, y: 3, color: skin) }
        setPixel(&grid, x: 6, y: 3, color: NSColor.black)
        setPixel(&grid, x: 9, y: 3, color: NSColor.black)
        for x in 5...10 { setPixel(&grid, x: x, y: 4, color: red) }
        for x in 4...11 { setPixel(&grid, x: x, y: 5, color: orange) }
        for x in 4...11 { setPixel(&grid, x: x, y: 6, color: red) }
        if frame % 2 == 0 {
            setPixel(&grid, x: 5, y: 7, color: orange)
            setPixel(&grid, x: 10, y: 7, color: orange)
        } else {
            setPixel(&grid, x: 6, y: 7, color: orange)
            setPixel(&grid, x: 9, y: 7, color: orange)
        }
    }

    func drawMMElecMan(grid: inout [[NSColor]], frame: Int) {
        let yellow = NSColor(red: 1.0, green: 0.85, blue: 0.0, alpha: 1.0)
        let red = NSColor(red: 0.85, green: 0.2, blue: 0.2, alpha: 1.0)
        let skin = NSColor(red: 0.95, green: 0.8, blue: 0.65, alpha: 1.0)
        for x in 6...9 { setPixel(&grid, x: x, y: 1, color: yellow) }
        for x in 5...10 { setPixel(&grid, x: x, y: 2, color: yellow) }
        for x in 5...10 { setPixel(&grid, x: x, y: 3, color: skin) }
        setPixel(&grid, x: 6, y: 3, color: NSColor.black)
        setPixel(&grid, x: 9, y: 3, color: NSColor.black)
        for x in 5...10 { setPixel(&grid, x: x, y: 4, color: yellow) }
        for x in 4...11 { setPixel(&grid, x: x, y: 5, color: red) }
        for x in 4...11 { setPixel(&grid, x: x, y: 6, color: yellow) }
        if frame % 2 == 0 {
            setPixel(&grid, x: 5, y: 7, color: yellow)
            setPixel(&grid, x: 10, y: 7, color: yellow)
        } else {
            setPixel(&grid, x: 6, y: 7, color: yellow)
            setPixel(&grid, x: 9, y: 7, color: yellow)
        }
    }

    func drawMMMetalMan(grid: inout [[NSColor]], frame: Int) {
        let silver = NSColor(red: 0.75, green: 0.75, blue: 0.78, alpha: 1.0)
        let darkSilver = NSColor(red: 0.55, green: 0.55, blue: 0.58, alpha: 1.0)
        let skin = NSColor(red: 0.95, green: 0.8, blue: 0.65, alpha: 1.0)
        let white = NSColor.white
        for x in 5...10 { setPixel(&grid, x: x, y: 1, color: silver) }
        for x in 4...11 { setPixel(&grid, x: x, y: 2, color: silver) }
        for x in 5...10 { setPixel(&grid, x: x, y: 3, color: skin) }
        setPixel(&grid, x: 6, y: 3, color: white)
        setPixel(&grid, x: 9, y: 3, color: white)
        for x in 5...10 { setPixel(&grid, x: x, y: 4, color: silver) }
        for x in 4...11 { setPixel(&grid, x: x, y: 5, color: darkSilver) }
        for x in 4...11 { setPixel(&grid, x: x, y: 6, color: silver) }
        if frame % 2 == 0 {
            setPixel(&grid, x: 5, y: 7, color: darkSilver)
            setPixel(&grid, x: 10, y: 7, color: darkSilver)
        } else {
            setPixel(&grid, x: 6, y: 7, color: darkSilver)
            setPixel(&grid, x: 9, y: 7, color: darkSilver)
        }
    }

    func drawMMCrashMan(grid: inout [[NSColor]], frame: Int) {
        let red = NSColor(red: 0.85, green: 0.2, blue: 0.2, alpha: 1.0)
        let orange = NSColor(red: 0.95, green: 0.55, blue: 0.1, alpha: 1.0)
        let skin = NSColor(red: 0.95, green: 0.8, blue: 0.65, alpha: 1.0)
        for x in 5...10 { setPixel(&grid, x: x, y: 1, color: orange) }
        for x in 4...11 { setPixel(&grid, x: x, y: 2, color: orange) }
        for x in 5...10 { setPixel(&grid, x: x, y: 3, color: skin) }
        setPixel(&grid, x: 6, y: 3, color: NSColor.black)
        setPixel(&grid, x: 9, y: 3, color: NSColor.black)
        for x in 5...10 { setPixel(&grid, x: x, y: 4, color: red) }
        for x in 4...11 { setPixel(&grid, x: x, y: 5, color: orange) }
        for x in 4...11 { setPixel(&grid, x: x, y: 6, color: red) }
        if frame % 2 == 0 {
            setPixel(&grid, x: 5, y: 7, color: red)
            setPixel(&grid, x: 10, y: 7, color: red)
        } else {
            setPixel(&grid, x: 6, y: 7, color: red)
            setPixel(&grid, x: 9, y: 7, color: red)
        }
    }

    func drawMMHardMan(grid: inout [[NSColor]], frame: Int) {
        let steel = NSColor(red: 0.5, green: 0.55, blue: 0.6, alpha: 1.0)
        let darkSteel = NSColor(red: 0.35, green: 0.4, blue: 0.45, alpha: 1.0)
        let skin = NSColor(red: 0.95, green: 0.8, blue: 0.65, alpha: 1.0)
        for x in 5...10 { setPixel(&grid, x: x, y: 1, color: steel) }
        for x in 4...11 { setPixel(&grid, x: x, y: 2, color: steel) }
        for x in 5...10 { setPixel(&grid, x: x, y: 3, color: skin) }
        setPixel(&grid, x: 6, y: 3, color: NSColor.black)
        setPixel(&grid, x: 9, y: 3, color: NSColor.black)
        for x in 3...12 { setPixel(&grid, x: x, y: 4, color: steel) }
        for x in 3...12 { setPixel(&grid, x: x, y: 5, color: darkSteel) }
        for x in 4...11 { setPixel(&grid, x: x, y: 6, color: steel) }
        if frame % 2 == 0 {
            setPixel(&grid, x: 5, y: 7, color: darkSteel)
            setPixel(&grid, x: 10, y: 7, color: darkSteel)
        } else {
            setPixel(&grid, x: 6, y: 7, color: darkSteel)
            setPixel(&grid, x: 9, y: 7, color: darkSteel)
        }
    }

    func drawMMTornadoMan(grid: inout [[NSColor]], frame: Int) {
        let blue = NSColor(red: 0.3, green: 0.55, blue: 0.85, alpha: 1.0)
        let lightBlue = NSColor(red: 0.6, green: 0.8, blue: 1.0, alpha: 1.0)
        let skin = NSColor(red: 0.95, green: 0.8, blue: 0.65, alpha: 1.0)
        let white = NSColor.white
        for x in 5...10 { setPixel(&grid, x: x, y: 1, color: lightBlue) }
        for x in 4...11 { setPixel(&grid, x: x, y: 2, color: blue) }
        for x in 5...10 { setPixel(&grid, x: x, y: 3, color: skin) }
        setPixel(&grid, x: 6, y: 3, color: white)
        setPixel(&grid, x: 9, y: 3, color: white)
        for x in 5...10 { setPixel(&grid, x: x, y: 4, color: blue) }
        for x in 4...11 { setPixel(&grid, x: x, y: 5, color: lightBlue) }
        for x in 4...11 { setPixel(&grid, x: x, y: 6, color: blue) }
        if frame % 2 == 0 {
            setPixel(&grid, x: 5, y: 7, color: lightBlue)
            setPixel(&grid, x: 10, y: 7, color: lightBlue)
        } else {
            setPixel(&grid, x: 6, y: 7, color: lightBlue)
            setPixel(&grid, x: 9, y: 7, color: lightBlue)
        }
    }

    func drawMMStoneMan(grid: inout [[NSColor]], frame: Int) {
        let gray = NSColor(red: 0.55, green: 0.5, blue: 0.45, alpha: 1.0)
        let darkGray = NSColor(red: 0.4, green: 0.35, blue: 0.3, alpha: 1.0)
        let skin = NSColor(red: 0.95, green: 0.8, blue: 0.65, alpha: 1.0)
        for x in 5...10 { setPixel(&grid, x: x, y: 1, color: gray) }
        for x in 4...11 { setPixel(&grid, x: x, y: 2, color: gray) }
        for x in 5...10 { setPixel(&grid, x: x, y: 3, color: skin) }
        setPixel(&grid, x: 6, y: 3, color: NSColor.black)
        setPixel(&grid, x: 9, y: 3, color: NSColor.black)
        for x in 3...12 { setPixel(&grid, x: x, y: 4, color: gray) }
        for x in 3...12 { setPixel(&grid, x: x, y: 5, color: darkGray) }
        for x in 4...11 { setPixel(&grid, x: x, y: 6, color: gray) }
        if frame % 2 == 0 {
            setPixel(&grid, x: 5, y: 7, color: darkGray)
            setPixel(&grid, x: 10, y: 7, color: darkGray)
        } else {
            setPixel(&grid, x: 6, y: 7, color: darkGray)
            setPixel(&grid, x: 9, y: 7, color: darkGray)
        }
    }

    // MARK: - Marvel
    func drawMVIronMan(grid: inout [[NSColor]], frame: Int) {
        let red = NSColor(red: 0.85, green: 0.12, blue: 0.1, alpha: 1.0)
        let gold = NSColor(red: 0.92, green: 0.78, blue: 0.22, alpha: 1.0)
        let white = NSColor.white
        let black = NSColor.black
        let darkRed = NSColor(red: 0.55, green: 0.05, blue: 0.05, alpha: 1.0)
        let arcGlow = NSColor(red: 0.5, green: 0.85, blue: 1.0, alpha: 1.0)
        let anim = frame % 2

        for x in 5...10 { setPixel(&grid, x: x, y: 0, color: red) }
        for x in 4...11 { setPixel(&grid, x: x, y: 1, color: red) }
        for x in 4...11 { setPixel(&grid, x: x, y: 2, color: gold) }
        for x in 5...10 { setPixel(&grid, x: x, y: 3, color: gold) }
        setPixel(&grid, x: 5, y: 1, color: darkRed); setPixel(&grid, x: 10, y: 1, color: darkRed)
        setPixel(&grid, x: 6, y: 2, color: white); setPixel(&grid, x: 7, y: 2, color: white)
        setPixel(&grid, x: 8, y: 2, color: white); setPixel(&grid, x: 9, y: 2, color: white)
        for x in 4...11 { setPixel(&grid, x: x, y: 4, color: red) }
        for x in 4...11 { setPixel(&grid, x: x, y: 5, color: red) }
        setPixel(&grid, x: 7, y: 4, color: arcGlow); setPixel(&grid, x: 8, y: 4, color: arcGlow)
        setPixel(&grid, x: 3, y: 4, color: gold); setPixel(&grid, x: 12, y: 4, color: gold)
        setPixel(&grid, x: 3, y: 5, color: gold); setPixel(&grid, x: 12, y: 5, color: gold)
        if anim == 0 {
            setPixel(&grid, x: 5, y: 6, color: gold); setPixel(&grid, x: 10, y: 6, color: gold)
        } else {
            setPixel(&grid, x: 4, y: 6, color: gold); setPixel(&grid, x: 11, y: 6, color: gold)
        }
    }

    func drawMVCaptainAmerica(grid: inout [[NSColor]], frame: Int) {
        let blue = NSColor(red: 0.15, green: 0.3, blue: 0.8, alpha: 1.0)
        let red = NSColor(red: 0.85, green: 0.12, blue: 0.1, alpha: 1.0)
        let white = NSColor.white
        let skin = NSColor(red: 0.95, green: 0.8, blue: 0.65, alpha: 1.0)
        let darkBlue = NSColor(red: 0.1, green: 0.18, blue: 0.5, alpha: 1.0)
        let black = NSColor.black
        let anim = frame % 2

        for x in 5...10 { setPixel(&grid, x: x, y: 0, color: blue) }
        for x in 4...11 { setPixel(&grid, x: x, y: 1, color: blue) }
        for x in 4...11 { setPixel(&grid, x: x, y: 2, color: skin) }
        for x in 5...10 { setPixel(&grid, x: x, y: 3, color: skin) }
        setPixel(&grid, x: 7, y: 0, color: white); setPixel(&grid, x: 8, y: 0, color: white)
        setPixel(&grid, x: 4, y: 1, color: darkBlue); setPixel(&grid, x: 11, y: 1, color: darkBlue)
        setPixel(&grid, x: 6, y: 2, color: black); setPixel(&grid, x: 9, y: 2, color: black)
        for x in 4...11 { setPixel(&grid, x: x, y: 4, color: blue) }
        for x in 4...11 { setPixel(&grid, x: x, y: 5, color: red) }
        setPixel(&grid, x: 7, y: 4, color: white); setPixel(&grid, x: 8, y: 4, color: white)
        setPixel(&grid, x: 3, y: 4, color: red); setPixel(&grid, x: 3, y: 5, color: white)
        setPixel(&grid, x: 3, y: 6, color: blue)
        if anim == 0 {
            setPixel(&grid, x: 5, y: 6, color: red); setPixel(&grid, x: 10, y: 6, color: red)
        } else {
            setPixel(&grid, x: 4, y: 6, color: red); setPixel(&grid, x: 11, y: 6, color: red)
        }
    }

    func drawMVHawkeye(grid: inout [[NSColor]], frame: Int) {
        let purple = NSColor(red: 0.5, green: 0.15, blue: 0.6, alpha: 1.0)
        let darkPurple = NSColor(red: 0.3, green: 0.1, blue: 0.4, alpha: 1.0)
        let skin = NSColor(red: 0.95, green: 0.8, blue: 0.65, alpha: 1.0)
        let black = NSColor.black
        let brown = NSColor(red: 0.5, green: 0.3, blue: 0.1, alpha: 1.0)
        let anim = frame % 2

        for x in 5...10 { setPixel(&grid, x: x, y: 0, color: purple) }
        for x in 4...11 { setPixel(&grid, x: x, y: 1, color: purple) }
        for x in 4...11 { setPixel(&grid, x: x, y: 2, color: skin) }
        for x in 5...10 { setPixel(&grid, x: x, y: 3, color: skin) }
        setPixel(&grid, x: 6, y: 0, color: brown); setPixel(&grid, x: 7, y: 0, color: brown)
        setPixel(&grid, x: 8, y: 0, color: brown); setPixel(&grid, x: 9, y: 0, color: brown)
        setPixel(&grid, x: 5, y: 1, color: darkPurple); setPixel(&grid, x: 10, y: 1, color: darkPurple)
        setPixel(&grid, x: 6, y: 2, color: black); setPixel(&grid, x: 9, y: 2, color: black)
        for x in 4...11 { setPixel(&grid, x: x, y: 4, color: purple) }
        for x in 4...11 { setPixel(&grid, x: x, y: 5, color: darkPurple) }
        setPixel(&grid, x: 12, y: 4, color: brown); setPixel(&grid, x: 12, y: 5, color: brown)
        setPixel(&grid, x: 13, y: 3, color: brown)
        if anim == 0 {
            setPixel(&grid, x: 5, y: 6, color: purple); setPixel(&grid, x: 10, y: 6, color: purple)
        } else {
            setPixel(&grid, x: 4, y: 6, color: purple); setPixel(&grid, x: 11, y: 6, color: purple)
        }
    }

    func drawMVThor(grid: inout [[NSColor]], frame: Int) {
        let silver = NSColor(red: 0.78, green: 0.78, blue: 0.82, alpha: 1.0)
        let red = NSColor(red: 0.82, green: 0.12, blue: 0.1, alpha: 1.0)
        let skin = NSColor(red: 0.95, green: 0.8, blue: 0.65, alpha: 1.0)
        let black = NSColor.black
        let gray = NSColor(red: 0.5, green: 0.5, blue: 0.55, alpha: 1.0)
        let anim = frame % 2

        setPixel(&grid, x: 3, y: 0, color: silver); setPixel(&grid, x: 12, y: 0, color: silver)
        setPixel(&grid, x: 4, y: 1, color: silver); setPixel(&grid, x: 11, y: 1, color: silver)
        for x in 5...10 { setPixel(&grid, x: x, y: 0, color: silver) }
        for x in 4...11 { setPixel(&grid, x: x, y: 1, color: silver) }
        for x in 4...11 { setPixel(&grid, x: x, y: 2, color: skin) }
        for x in 5...10 { setPixel(&grid, x: x, y: 3, color: skin) }
        setPixel(&grid, x: 6, y: 2, color: NSColor(red: 0.2, green: 0.4, blue: 0.9, alpha: 1.0))
        setPixel(&grid, x: 9, y: 2, color: NSColor(red: 0.2, green: 0.4, blue: 0.9, alpha: 1.0))
        for x in 4...11 { setPixel(&grid, x: x, y: 4, color: silver) }
        for x in 4...11 { setPixel(&grid, x: x, y: 5, color: gray) }
        setPixel(&grid, x: 3, y: 4, color: red); setPixel(&grid, x: 3, y: 5, color: red)
        setPixel(&grid, x: 12, y: 4, color: gray); setPixel(&grid, x: 12, y: 5, color: gray)
        if anim == 0 {
            setPixel(&grid, x: 5, y: 6, color: gray); setPixel(&grid, x: 10, y: 6, color: gray)
        } else {
            setPixel(&grid, x: 4, y: 6, color: gray); setPixel(&grid, x: 11, y: 6, color: gray)
        }
    }

    func drawMVBlackWidow(grid: inout [[NSColor]], frame: Int) {
        let orange = NSColor(red: 0.85, green: 0.4, blue: 0.1, alpha: 1.0)
        let black = NSColor.black
        let darkGray = NSColor(red: 0.2, green: 0.2, blue: 0.2, alpha: 1.0)
        let skin = NSColor(red: 0.95, green: 0.8, blue: 0.65, alpha: 1.0)
        let red = NSColor(red: 0.8, green: 0.1, blue: 0.1, alpha: 1.0)
        let anim = frame % 2

        for x in 5...10 { setPixel(&grid, x: x, y: 0, color: orange) }
        for x in 4...11 { setPixel(&grid, x: x, y: 1, color: orange) }
        for x in 4...11 { setPixel(&grid, x: x, y: 2, color: skin) }
        for x in 5...10 { setPixel(&grid, x: x, y: 3, color: skin) }
        setPixel(&grid, x: 4, y: 2, color: orange); setPixel(&grid, x: 11, y: 2, color: orange)
        setPixel(&grid, x: 6, y: 2, color: NSColor(red: 0.2, green: 0.5, blue: 0.8, alpha: 1.0))
        setPixel(&grid, x: 9, y: 2, color: NSColor(red: 0.2, green: 0.5, blue: 0.8, alpha: 1.0))
        for x in 4...11 { setPixel(&grid, x: x, y: 4, color: black) }
        for x in 4...11 { setPixel(&grid, x: x, y: 5, color: darkGray) }
        setPixel(&grid, x: 7, y: 4, color: red); setPixel(&grid, x: 8, y: 4, color: red)
        if anim == 0 {
            setPixel(&grid, x: 5, y: 6, color: black); setPixel(&grid, x: 10, y: 6, color: black)
        } else {
            setPixel(&grid, x: 4, y: 6, color: black); setPixel(&grid, x: 11, y: 6, color: black)
        }
    }

    func drawMVDaredevil(grid: inout [[NSColor]], frame: Int) {
        let red = NSColor(red: 0.8, green: 0.1, blue: 0.1, alpha: 1.0)
        let darkRed = NSColor(red: 0.5, green: 0.05, blue: 0.05, alpha: 1.0)
        let skin = NSColor(red: 0.95, green: 0.8, blue: 0.65, alpha: 1.0)
        let black = NSColor.black
        let anim = frame % 2

        setPixel(&grid, x: 4, y: 0, color: red); setPixel(&grid, x: 11, y: 0, color: red)
        setPixel(&grid, x: 5, y: 1, color: red); setPixel(&grid, x: 10, y: 1, color: red)
        for x in 5...10 { setPixel(&grid, x: x, y: 0, color: red) }
        for x in 4...11 { setPixel(&grid, x: x, y: 1, color: red) }
        for x in 4...11 { setPixel(&grid, x: x, y: 2, color: skin) }
        for x in 5...10 { setPixel(&grid, x: x, y: 3, color: skin) }
        setPixel(&grid, x: 5, y: 1, color: darkRed); setPixel(&grid, x: 10, y: 1, color: darkRed)
        setPixel(&grid, x: 6, y: 2, color: black); setPixel(&grid, x: 7, y: 2, color: black)
        setPixel(&grid, x: 8, y: 2, color: black); setPixel(&grid, x: 9, y: 2, color: black)
        for x in 4...11 { setPixel(&grid, x: x, y: 4, color: red) }
        for x in 4...11 { setPixel(&grid, x: x, y: 5, color: darkRed) }
        setPixel(&grid, x: 7, y: 4, color: black); setPixel(&grid, x: 8, y: 4, color: black)
        if anim == 0 {
            setPixel(&grid, x: 5, y: 6, color: red); setPixel(&grid, x: 10, y: 6, color: red)
        } else {
            setPixel(&grid, x: 4, y: 6, color: red); setPixel(&grid, x: 11, y: 6, color: red)
        }
    }

    func drawMVSpiderMan(grid: inout [[NSColor]], frame: Int) {
        let red = NSColor(red: 0.9, green: 0.1, blue: 0.1, alpha: 1.0)
        let blue = NSColor(red: 0.15, green: 0.3, blue: 0.8, alpha: 1.0)
        let white = NSColor.white
        let black = NSColor.black
        let darkRed = NSColor(red: 0.6, green: 0.05, blue: 0.05, alpha: 1.0)
        let anim = frame % 2

        for x in 5...10 { setPixel(&grid, x: x, y: 0, color: red) }
        for x in 4...11 { setPixel(&grid, x: x, y: 1, color: red) }
        for x in 4...11 { setPixel(&grid, x: x, y: 2, color: red) }
        for x in 5...10 { setPixel(&grid, x: x, y: 3, color: red) }
        setPixel(&grid, x: 7, y: 0, color: darkRed); setPixel(&grid, x: 8, y: 0, color: darkRed)
        setPixel(&grid, x: 6, y: 1, color: white); setPixel(&grid, x: 6, y: 2, color: white)
        setPixel(&grid, x: 9, y: 1, color: white); setPixel(&grid, x: 9, y: 2, color: white)
        setPixel(&grid, x: 6, y: 1, color: black); setPixel(&grid, x: 9, y: 1, color: black)
        for x in 4...11 { setPixel(&grid, x: x, y: 4, color: red) }
        for x in 4...11 { setPixel(&grid, x: x, y: 5, color: blue) }
        setPixel(&grid, x: 3, y: 4, color: red); setPixel(&grid, x: 12, y: 4, color: red)
        if anim == 0 {
            setPixel(&grid, x: 5, y: 6, color: blue); setPixel(&grid, x: 10, y: 6, color: blue)
        } else {
            setPixel(&grid, x: 4, y: 6, color: blue); setPixel(&grid, x: 11, y: 6, color: blue)
        }
    }

    func drawMVWolverine(grid: inout [[NSColor]], frame: Int) {
        let yellow = NSColor(red: 0.95, green: 0.85, blue: 0.15, alpha: 1.0)
        let blue = NSColor(red: 0.1, green: 0.3, blue: 0.8, alpha: 1.0)
        let black = NSColor.black
        let white = NSColor.white
        let skin = NSColor(red: 0.95, green: 0.8, blue: 0.65, alpha: 1.0)
        let red = NSColor(red: 0.85, green: 0.15, blue: 0.15, alpha: 1.0)
        let silver = NSColor(red: 0.78, green: 0.78, blue: 0.82, alpha: 1.0)
        let anim = frame % 2

        // Mask wings (big, pointed, black)
        setPixel(&grid, x: 3, y: 1, color: black); setPixel(&grid, x: 18, y: 1, color: black)
        setPixel(&grid, x: 3, y: 2, color: black); setPixel(&grid, x: 18, y: 2, color: black)
        setPixel(&grid, x: 4, y: 2, color: black); setPixel(&grid, x: 17, y: 2, color: black)
        setPixel(&grid, x: 4, y: 3, color: black); setPixel(&grid, x: 17, y: 3, color: black)
        setPixel(&grid, x: 5, y: 3, color: black); setPixel(&grid, x: 16, y: 3, color: black)

        // Head (yellow with black mask)
        for x in 6...15 { setPixel(&grid, x: x, y: 0, color: yellow) }
        for x in 5...16 { setPixel(&grid, x: x, y: 1, color: yellow) }
        for x in 5...16 { setPixel(&grid, x: x, y: 2, color: yellow) }
        for x in 5...16 { setPixel(&grid, x: x, y: 3, color: yellow) }
        for x in 6...15 { setPixel(&grid, x: x, y: 4, color: yellow) }

        // Black mask around eyes
        for x in 6...15 { setPixel(&grid, x: x, y: 4, color: black) }
        setPixel(&grid, x: 6, y: 3, color: black); setPixel(&grid, x: 15, y: 3, color: black)

        // Eyes (white)
        setPixel(&grid, x: 8, y: 4, color: white); setPixel(&grid, x: 9, y: 4, color: white)
        setPixel(&grid, x: 12, y: 4, color: white); setPixel(&grid, x: 13, y: 4, color: white)

        // Face (skin)
        for x in 7...14 { setPixel(&grid, x: x, y: 5, color: skin) }
        for x in 7...14 { setPixel(&grid, x: x, y: 6, color: skin) }
        setPixel(&grid, x: 7, y: 5, color: black); setPixel(&grid, x: 14, y: 5, color: black)

        // Body (yellow and blue)
        for x in 6...15 { setPixel(&grid, x: x, y: 7, color: yellow) }
        for x in 6...15 { setPixel(&grid, x: x, y: 8, color: yellow) }
        for x in 6...15 { setPixel(&grid, x: x, y: 9, color: blue) }
        for x in 6...15 { setPixel(&grid, x: x, y: 10, color: blue) }

        // Belt (red)
        for x in 7...14 { setPixel(&grid, x: x, y: 9, color: red) }

        // Arms (skin with claws)
        setPixel(&grid, x: 5, y: 7, color: skin); setPixel(&grid, x: 5, y: 8, color: skin)
        setPixel(&grid, x: 16, y: 7, color: skin); setPixel(&grid, x: 16, y: 8, color: skin)

        // Claws (silver, animated)
        if anim == 0 {
            setPixel(&grid, x: 4, y: 7, color: silver); setPixel(&grid, x: 4, y: 8, color: silver); setPixel(&grid, x: 4, y: 9, color: silver)
            setPixel(&grid, x: 17, y: 7, color: silver); setPixel(&grid, x: 17, y: 8, color: silver); setPixel(&grid, x: 17, y: 9, color: silver)
        } else {
            setPixel(&grid, x: 3, y: 7, color: silver); setPixel(&grid, x: 3, y: 8, color: silver); setPixel(&grid, x: 3, y: 9, color: silver)
            setPixel(&grid, x: 18, y: 7, color: silver); setPixel(&grid, x: 18, y: 8, color: silver); setPixel(&grid, x: 18, y: 9, color: silver)
        }

        // Legs (blue)
        if anim == 0 {
            setPixel(&grid, x: 7, y: 11, color: blue); setPixel(&grid, x: 8, y: 11, color: blue)
            setPixel(&grid, x: 13, y: 11, color: blue); setPixel(&grid, x: 14, y: 11, color: blue)
        } else {
            setPixel(&grid, x: 6, y: 11, color: blue); setPixel(&grid, x: 7, y: 11, color: blue)
            setPixel(&grid, x: 14, y: 11, color: blue); setPixel(&grid, x: 15, y: 11, color: blue)
        }
    }

    func drawMVBlackPanther(grid: inout [[NSColor]], frame: Int) {
        let black = NSColor.black
        let darkGray = NSColor(red: 0.25, green: 0.25, blue: 0.28, alpha: 1.0)
        let silver = NSColor(red: 0.75, green: 0.75, blue: 0.8, alpha: 1.0)
        let purple = NSColor(red: 0.5, green: 0.15, blue: 0.7, alpha: 1.0)
        let anim = frame % 2

        setPixel(&grid, x: 4, y: 0, color: black); setPixel(&grid, x: 11, y: 0, color: black)
        for x in 5...10 { setPixel(&grid, x: x, y: 0, color: black) }
        for x in 4...11 { setPixel(&grid, x: x, y: 1, color: black) }
        for x in 4...11 { setPixel(&grid, x: x, y: 2, color: black) }
        for x in 5...10 { setPixel(&grid, x: x, y: 3, color: black) }
        setPixel(&grid, x: 5, y: 0, color: silver); setPixel(&grid, x: 10, y: 0, color: silver)
        setPixel(&grid, x: 6, y: 1, color: purple); setPixel(&grid, x: 9, y: 1, color: purple)
        setPixel(&grid, x: 6, y: 2, color: purple); setPixel(&grid, x: 9, y: 2, color: purple)
        for x in 4...11 { setPixel(&grid, x: x, y: 4, color: black) }
        for x in 4...11 { setPixel(&grid, x: x, y: 5, color: darkGray) }
        setPixel(&grid, x: 7, y: 4, color: silver); setPixel(&grid, x: 8, y: 4, color: silver)
        if anim == 0 {
            setPixel(&grid, x: 5, y: 6, color: black); setPixel(&grid, x: 10, y: 6, color: black)
        } else {
            setPixel(&grid, x: 4, y: 6, color: black); setPixel(&grid, x: 11, y: 6, color: black)
        }
    }

    func drawMVHulk(grid: inout [[NSColor]], frame: Int) {
        let green = NSColor(red: 0.3, green: 0.72, blue: 0.3, alpha: 1.0)
        let darkGreen = NSColor(red: 0.2, green: 0.5, blue: 0.2, alpha: 1.0)
        let purple = NSColor(red: 0.5, green: 0.2, blue: 0.6, alpha: 1.0)
        let black = NSColor.black
        let anim = frame % 2

        for x in 4...11 { setPixel(&grid, x: x, y: 0, color: green) }
        for x in 3...12 { setPixel(&grid, x: x, y: 1, color: green) }
        for x in 3...12 { setPixel(&grid, x: x, y: 2, color: green) }
        for x in 4...11 { setPixel(&grid, x: x, y: 3, color: green) }
        setPixel(&grid, x: 5, y: 1, color: black); setPixel(&grid, x: 10, y: 1, color: black)
        setPixel(&grid, x: 6, y: 2, color: black); setPixel(&grid, x: 9, y: 2, color: black)
        setPixel(&grid, x: 7, y: 3, color: black); setPixel(&grid, x: 8, y: 3, color: black)
        for x in 3...12 { setPixel(&grid, x: x, y: 4, color: green) }
        for x in 3...12 { setPixel(&grid, x: x, y: 5, color: green) }
        for x in 4...11 { setPixel(&grid, x: x, y: 6, color: purple) }
        if anim == 0 {
            setPixel(&grid, x: 5, y: 7, color: purple); setPixel(&grid, x: 10, y: 7, color: purple)
        } else {
            setPixel(&grid, x: 4, y: 7, color: purple); setPixel(&grid, x: 11, y: 7, color: purple)
        }
    }

    func drawMVVision(grid: inout [[NSColor]], frame: Int) {
        let green = NSColor(red: 0.3, green: 0.7, blue: 0.35, alpha: 1.0)
        let yellow = NSColor(red: 0.92, green: 0.8, blue: 0.2, alpha: 1.0)
        let red = NSColor(red: 0.85, green: 0.12, blue: 0.1, alpha: 1.0)
        let skin = NSColor(red: 0.95, green: 0.8, blue: 0.65, alpha: 1.0)
        let black = NSColor.black
        let anim = frame % 2

        for x in 5...10 { setPixel(&grid, x: x, y: 0, color: red) }
        for x in 4...11 { setPixel(&grid, x: x, y: 1, color: red) }
        for x in 4...11 { setPixel(&grid, x: x, y: 2, color: green) }
        for x in 5...10 { setPixel(&grid, x: x, y: 3, color: green) }
        setPixel(&grid, x: 6, y: 2, color: yellow); setPixel(&grid, x: 9, y: 2, color: yellow)
        for x in 4...11 { setPixel(&grid, x: x, y: 4, color: green) }
        for x in 4...11 { setPixel(&grid, x: x, y: 5, color: green) }
        setPixel(&grid, x: 7, y: 4, color: yellow); setPixel(&grid, x: 8, y: 4, color: yellow)
        setPixel(&grid, x: 3, y: 4, color: yellow); setPixel(&grid, x: 12, y: 4, color: yellow)
        if anim == 0 {
            setPixel(&grid, x: 5, y: 6, color: yellow); setPixel(&grid, x: 10, y: 6, color: yellow)
        } else {
            setPixel(&grid, x: 4, y: 6, color: yellow); setPixel(&grid, x: 11, y: 6, color: yellow)
        }
    }

    func drawMVScarletWitch(grid: inout [[NSColor]], frame: Int) {
        let red = NSColor(red: 0.8, green: 0.1, blue: 0.15, alpha: 1.0)
        let darkRed = NSColor(red: 0.5, green: 0.05, blue: 0.08, alpha: 1.0)
        let skin = NSColor(red: 0.95, green: 0.8, blue: 0.65, alpha: 1.0)
        let brown = NSColor(red: 0.55, green: 0.25, blue: 0.1, alpha: 1.0)
        let black = NSColor.black
        let anim = frame % 2

        for x in 5...10 { setPixel(&grid, x: x, y: 0, color: red) }
        for x in 4...11 { setPixel(&grid, x: x, y: 1, color: red) }
        for x in 4...11 { setPixel(&grid, x: x, y: 2, color: skin) }
        for x in 5...10 { setPixel(&grid, x: x, y: 3, color: skin) }
        setPixel(&grid, x: 4, y: 1, color: brown); setPixel(&grid, x: 11, y: 1, color: brown)
        setPixel(&grid, x: 4, y: 2, color: brown); setPixel(&grid, x: 11, y: 2, color: brown)
        setPixel(&grid, x: 6, y: 2, color: NSColor(red: 0.2, green: 0.6, blue: 0.3, alpha: 1.0))
        setPixel(&grid, x: 9, y: 2, color: NSColor(red: 0.2, green: 0.6, blue: 0.3, alpha: 1.0))
        for x in 4...11 { setPixel(&grid, x: x, y: 4, color: red) }
        for x in 4...11 { setPixel(&grid, x: x, y: 5, color: darkRed) }
        setPixel(&grid, x: 3, y: 4, color: red); setPixel(&grid, x: 12, y: 4, color: red)
        if anim == 0 {
            setPixel(&grid, x: 5, y: 6, color: darkRed); setPixel(&grid, x: 10, y: 6, color: darkRed)
        } else {
            setPixel(&grid, x: 4, y: 6, color: darkRed); setPixel(&grid, x: 11, y: 6, color: darkRed)
        }
    }

    func drawMVWarMachine(grid: inout [[NSColor]], frame: Int) {
        let gray = NSColor(red: 0.5, green: 0.5, blue: 0.55, alpha: 1.0)
        let darkGray = NSColor(red: 0.3, green: 0.3, blue: 0.33, alpha: 1.0)
        let silver = NSColor(red: 0.78, green: 0.78, blue: 0.82, alpha: 1.0)
        let white = NSColor.white
        let black = NSColor.black
        let anim = frame % 2

        for x in 5...10 { setPixel(&grid, x: x, y: 0, color: gray) }
        for x in 4...11 { setPixel(&grid, x: x, y: 1, color: gray) }
        for x in 4...11 { setPixel(&grid, x: x, y: 2, color: darkGray) }
        for x in 5...10 { setPixel(&grid, x: x, y: 3, color: darkGray) }
        setPixel(&grid, x: 5, y: 1, color: silver); setPixel(&grid, x: 10, y: 1, color: silver)
        setPixel(&grid, x: 6, y: 2, color: white); setPixel(&grid, x: 7, y: 2, color: white)
        setPixel(&grid, x: 8, y: 2, color: white); setPixel(&grid, x: 9, y: 2, color: white)
        for x in 4...11 { setPixel(&grid, x: x, y: 4, color: gray) }
        for x in 4...11 { setPixel(&grid, x: x, y: 5, color: darkGray) }
        setPixel(&grid, x: 3, y: 4, color: silver); setPixel(&grid, x: 12, y: 4, color: silver)
        setPixel(&grid, x: 12, y: 3, color: silver)
        if anim == 0 {
            setPixel(&grid, x: 5, y: 6, color: darkGray); setPixel(&grid, x: 10, y: 6, color: darkGray)
        } else {
            setPixel(&grid, x: 4, y: 6, color: darkGray); setPixel(&grid, x: 11, y: 6, color: darkGray)
        }
    }

    func drawMVSpiderWoman(grid: inout [[NSColor]], frame: Int) {
        let red = NSColor(red: 0.85, green: 0.1, blue: 0.1, alpha: 1.0)
        let yellow = NSColor(red: 0.92, green: 0.8, blue: 0.2, alpha: 1.0)
        let skin = NSColor(red: 0.95, green: 0.8, blue: 0.65, alpha: 1.0)
        let black = NSColor.black
        let brown = NSColor(red: 0.55, green: 0.25, blue: 0.1, alpha: 1.0)
        let anim = frame % 2

        for x in 5...10 { setPixel(&grid, x: x, y: 0, color: brown) }
        for x in 4...11 { setPixel(&grid, x: x, y: 1, color: brown) }
        for x in 4...11 { setPixel(&grid, x: x, y: 2, color: skin) }
        for x in 5...10 { setPixel(&grid, x: x, y: 3, color: skin) }
        setPixel(&grid, x: 4, y: 1, color: red); setPixel(&grid, x: 11, y: 1, color: red)
        setPixel(&grid, x: 6, y: 2, color: black); setPixel(&grid, x: 9, y: 2, color: black)
        for x in 4...11 { setPixel(&grid, x: x, y: 4, color: red) }
        for x in 4...11 { setPixel(&grid, x: x, y: 5, color: yellow) }
        setPixel(&grid, x: 3, y: 4, color: red); setPixel(&grid, x: 12, y: 4, color: red)
        setPixel(&grid, x: 3, y: 5, color: yellow); setPixel(&grid, x: 12, y: 5, color: yellow)
        if anim == 0 {
            setPixel(&grid, x: 5, y: 6, color: red); setPixel(&grid, x: 10, y: 6, color: red)
        } else {
            setPixel(&grid, x: 4, y: 6, color: red); setPixel(&grid, x: 11, y: 6, color: red)
        }
    }

    func drawMVCyclops(grid: inout [[NSColor]], frame: Int) {
        let blue = NSColor(red: 0.1, green: 0.2, blue: 0.65, alpha: 1.0)
        let darkBlue = NSColor(red: 0.05, green: 0.1, blue: 0.4, alpha: 1.0)
        let skin = NSColor(red: 0.95, green: 0.8, blue: 0.65, alpha: 1.0)
        let black = NSColor.black
        let brown = NSColor(red: 0.5, green: 0.3, blue: 0.1, alpha: 1.0)
        let anim = frame % 2

        for x in 5...10 { setPixel(&grid, x: x, y: 0, color: brown) }
        for x in 4...11 { setPixel(&grid, x: x, y: 1, color: brown) }
        for x in 4...11 { setPixel(&grid, x: x, y: 2, color: skin) }
        for x in 5...10 { setPixel(&grid, x: x, y: 3, color: skin) }
        setPixel(&grid, x: 5, y: 2, color: blue); setPixel(&grid, x: 6, y: 2, color: blue)
        setPixel(&grid, x: 7, y: 2, color: black); setPixel(&grid, x: 8, y: 2, color: black)
        setPixel(&grid, x: 9, y: 2, color: blue); setPixel(&grid, x: 10, y: 2, color: blue)
        for x in 4...11 { setPixel(&grid, x: x, y: 4, color: blue) }
        for x in 4...11 { setPixel(&grid, x: x, y: 5, color: darkBlue) }
        setPixel(&grid, x: 7, y: 4, color: black); setPixel(&grid, x: 8, y: 4, color: black)
        if anim == 0 {
            setPixel(&grid, x: 5, y: 6, color: blue); setPixel(&grid, x: 10, y: 6, color: blue)
        } else {
            setPixel(&grid, x: 4, y: 6, color: blue); setPixel(&grid, x: 11, y: 6, color: blue)
        }
    }

    func drawMVSheHulk(grid: inout [[NSColor]], frame: Int) {
        let green = NSColor(red: 0.35, green: 0.75, blue: 0.35, alpha: 1.0)
        let darkGreen = NSColor(red: 0.25, green: 0.55, blue: 0.25, alpha: 1.0)
        let purple = NSColor(red: 0.5, green: 0.2, blue: 0.6, alpha: 1.0)
        let black = NSColor.black
        let brown = NSColor(red: 0.45, green: 0.2, blue: 0.08, alpha: 1.0)
        let anim = frame % 2

        for x in 5...10 { setPixel(&grid, x: x, y: 0, color: brown) }
        for x in 4...11 { setPixel(&grid, x: x, y: 1, color: brown) }
        for x in 4...11 { setPixel(&grid, x: x, y: 2, color: green) }
        for x in 5...10 { setPixel(&grid, x: x, y: 3, color: green) }
        setPixel(&grid, x: 4, y: 1, color: brown); setPixel(&grid, x: 11, y: 1, color: brown)
        setPixel(&grid, x: 6, y: 2, color: black); setPixel(&grid, x: 9, y: 2, color: black)
        for x in 4...11 { setPixel(&grid, x: x, y: 4, color: purple) }
        for x in 4...11 { setPixel(&grid, x: x, y: 5, color: purple) }
        setPixel(&grid, x: 3, y: 4, color: green); setPixel(&grid, x: 12, y: 4, color: green)
        if anim == 0 {
            setPixel(&grid, x: 5, y: 6, color: purple); setPixel(&grid, x: 10, y: 6, color: purple)
        } else {
            setPixel(&grid, x: 4, y: 6, color: purple); setPixel(&grid, x: 11, y: 6, color: purple)
        }
    }

    func drawMVJuggernaut(grid: inout [[NSColor]], frame: Int) {
        let red = NSColor(red: 0.75, green: 0.1, blue: 0.1, alpha: 1.0)
        let darkRed = NSColor(red: 0.5, green: 0.05, blue: 0.05, alpha: 1.0)
        let brown = NSColor(red: 0.5, green: 0.3, blue: 0.1, alpha: 1.0)
        let black = NSColor.black
        let anim = frame % 2

        for x in 4...11 { setPixel(&grid, x: x, y: 0, color: brown) }
        for x in 3...12 { setPixel(&grid, x: x, y: 1, color: brown) }
        for x in 3...12 { setPixel(&grid, x: x, y: 2, color: brown) }
        for x in 4...11 { setPixel(&grid, x: x, y: 3, color: brown) }
        setPixel(&grid, x: 5, y: 1, color: red); setPixel(&grid, x: 10, y: 1, color: red)
        setPixel(&grid, x: 6, y: 2, color: black); setPixel(&grid, x: 9, y: 2, color: black)
        for x in 3...12 { setPixel(&grid, x: x, y: 4, color: red) }
        for x in 3...12 { setPixel(&grid, x: x, y: 5, color: darkRed) }
        if anim == 0 {
            setPixel(&grid, x: 5, y: 6, color: darkRed); setPixel(&grid, x: 10, y: 6, color: darkRed)
        } else {
            setPixel(&grid, x: 4, y: 6, color: darkRed); setPixel(&grid, x: 11, y: 6, color: darkRed)
        }
    }

    func drawMVLoki(grid: inout [[NSColor]], frame: Int) {
        let green = NSColor(red: 0.2, green: 0.6, blue: 0.25, alpha: 1.0)
        let gold = NSColor(red: 0.92, green: 0.78, blue: 0.22, alpha: 1.0)
        let skin = NSColor(red: 0.95, green: 0.8, blue: 0.65, alpha: 1.0)
        let black = NSColor.black
        let darkGreen = NSColor(red: 0.1, green: 0.4, blue: 0.15, alpha: 1.0)
        let anim = frame % 2

        setPixel(&grid, x: 4, y: 0, color: gold); setPixel(&grid, x: 11, y: 0, color: gold)
        setPixel(&grid, x: 5, y: 1, color: gold); setPixel(&grid, x: 10, y: 1, color: gold)
        for x in 5...10 { setPixel(&grid, x: x, y: 0, color: gold) }
        for x in 4...11 { setPixel(&grid, x: x, y: 1, color: green) }
        for x in 4...11 { setPixel(&grid, x: x, y: 2, color: skin) }
        for x in 5...10 { setPixel(&grid, x: x, y: 3, color: skin) }
        setPixel(&grid, x: 6, y: 2, color: green); setPixel(&grid, x: 9, y: 2, color: green)
        for x in 4...11 { setPixel(&grid, x: x, y: 4, color: green) }
        for x in 4...11 { setPixel(&grid, x: x, y: 5, color: darkGreen) }
        setPixel(&grid, x: 7, y: 4, color: gold); setPixel(&grid, x: 8, y: 4, color: gold)
        setPixel(&grid, x: 3, y: 4, color: green); setPixel(&grid, x: 12, y: 4, color: green)
        if anim == 0 {
            setPixel(&grid, x: 5, y: 6, color: gold); setPixel(&grid, x: 10, y: 6, color: gold)
        } else {
            setPixel(&grid, x: 4, y: 6, color: gold); setPixel(&grid, x: 11, y: 6, color: gold)
        }
    }

    func drawMVVenom(grid: inout [[NSColor]], frame: Int) {
        let black = NSColor.black
        let darkGray = NSColor(red: 0.25, green: 0.25, blue: 0.28, alpha: 1.0)
        let white = NSColor.white
        let red = NSColor(red: 0.85, green: 0.1, blue: 0.1, alpha: 1.0)
        let pink = NSColor(red: 0.9, green: 0.35, blue: 0.45, alpha: 1.0)
        let anim = frame % 2

        // Head (big, black, with tendrils)
        for x in 4...11 { setPixel(&grid, x: x, y: 0, color: black) }
        for x in 3...12 { setPixel(&grid, x: x, y: 1, color: black) }
        for x in 3...12 { setPixel(&grid, x: x, y: 2, color: black) }
        for x in 4...11 { setPixel(&grid, x: x, y: 3, color: black) }

        // Eyes (big, white, angular)
        setPixel(&grid, x: 5, y: 1, color: white); setPixel(&grid, x: 5, y: 2, color: white)
        setPixel(&grid, x: 6, y: 1, color: white); setPixel(&grid, x: 6, y: 2, color: white)
        setPixel(&grid, x: 9, y: 1, color: white); setPixel(&grid, x: 9, y: 2, color: white)
        setPixel(&grid, x: 10, y: 1, color: white); setPixel(&grid, x: 10, y: 2, color: white)
        // Eye pupils (small black)
        setPixel(&grid, x: 6, y: 2, color: black); setPixel(&grid, x: 9, y: 2, color: black)

        // Mouth (big, red tongue)
        for x in 5...10 { setPixel(&grid, x: x, y: 3, color: red) }
        setPixel(&grid, x: 5, y: 4, color: pink); setPixel(&grid, x: 10, y: 4, color: pink)
        setPixel(&grid, x: 6, y: 4, color: red); setPixel(&grid, x: 7, y: 4, color: red)
        setPixel(&grid, x: 8, y: 4, color: red); setPixel(&grid, x: 9, y: 4, color: red)
        // Teeth
        setPixel(&grid, x: 6, y: 3, color: white); setPixel(&grid, x: 8, y: 3, color: white)

        // Body (black, muscular)
        for x in 4...11 { setPixel(&grid, x: x, y: 5, color: black) }
        for x in 4...11 { setPixel(&grid, x: x, y: 6, color: black) }
        // Spider symbol on chest (white)
        setPixel(&grid, x: 7, y: 5, color: white); setPixel(&grid, x: 8, y: 5, color: white)
        setPixel(&grid, x: 6, y: 5, color: darkGray); setPixel(&grid, x: 9, y: 5, color: darkGray)

        // Arms (big, black)
        setPixel(&grid, x: 3, y: 5, color: black); setPixel(&grid, x: 3, y: 6, color: black)
        setPixel(&grid, x: 12, y: 5, color: black); setPixel(&grid, x: 12, y: 6, color: black)

        // Legs
        if anim == 0 {
            setPixel(&grid, x: 5, y: 7, color: black); setPixel(&grid, x: 10, y: 7, color: black)
        } else {
            setPixel(&grid, x: 4, y: 7, color: black); setPixel(&grid, x: 11, y: 7, color: black)
        }
    }

    func drawDCBatman(grid: inout [[NSColor]], frame: Int) {
        let gray = NSColor(red: 0.6, green: 0.6, blue: 0.65, alpha: 1.0)
        let black = NSColor(red: 0.1, green: 0.1, blue: 0.12, alpha: 1.0)
        let yellow = NSColor(red: 1.0, green: 0.85, blue: 0.0, alpha: 1.0)
        let skin = NSColor(red: 0.95, green: 0.8, blue: 0.65, alpha: 1.0)
        for x in 6...9 { setPixel(&grid, x: x, y: 1, color: black) }
        setPixel(&grid, x: 5, y: 0, color: black)
        setPixel(&grid, x: 10, y: 0, color: black)
        for x in 5...10 { setPixel(&grid, x: x, y: 2, color: black) }
        for x in 5...10 { setPixel(&grid, x: x, y: 3, color: skin) }
        setPixel(&grid, x: 6, y: 3, color: NSColor.black)
        setPixel(&grid, x: 9, y: 3, color: NSColor.black)
        for x in 5...10 { setPixel(&grid, x: x, y: 4, color: gray) }
        setPixel(&grid, x: 7, y: 4, color: yellow)
        setPixel(&grid, x: 8, y: 4, color: yellow)
        for x in 4...11 { setPixel(&grid, x: x, y: 5, color: gray) }
        for x in 3...12 { setPixel(&grid, x: x, y: 6, color: black) }
        if frame % 2 == 0 {
            setPixel(&grid, x: 5, y: 7, color: gray)
            setPixel(&grid, x: 10, y: 7, color: gray)
        } else {
            setPixel(&grid, x: 6, y: 7, color: gray)
            setPixel(&grid, x: 9, y: 7, color: gray)
        }
    }

    func drawDCSuperman(grid: inout [[NSColor]], frame: Int) {
        let blue = NSColor(red: 0.1, green: 0.25, blue: 0.7, alpha: 1.0)
        let red = NSColor(red: 0.85, green: 0.1, blue: 0.1, alpha: 1.0)
        let skin = NSColor(red: 0.95, green: 0.8, blue: 0.65, alpha: 1.0)
        let yellow = NSColor(red: 1.0, green: 0.85, blue: 0.0, alpha: 1.0)
        for x in 6...9 { setPixel(&grid, x: x, y: 1, color: NSColor.black) }
        for x in 5...10 { setPixel(&grid, x: x, y: 2, color: NSColor.black) }
        for x in 5...10 { setPixel(&grid, x: x, y: 3, color: skin) }
        setPixel(&grid, x: 6, y: 3, color: NSColor.black)
        setPixel(&grid, x: 9, y: 3, color: NSColor.black)
        for x in 5...10 { setPixel(&grid, x: x, y: 4, color: blue) }
        setPixel(&grid, x: 7, y: 4, color: red)
        setPixel(&grid, x: 8, y: 4, color: red)
        for x in 4...11 { setPixel(&grid, x: x, y: 5, color: blue) }
        for x in 4...11 { setPixel(&grid, x: x, y: 6, color: red) }
        if frame % 2 == 0 {
            setPixel(&grid, x: 5, y: 7, color: red)
            setPixel(&grid, x: 10, y: 7, color: red)
        } else {
            setPixel(&grid, x: 6, y: 7, color: red)
            setPixel(&grid, x: 9, y: 7, color: red)
        }
    }

    func drawDCWonderWoman(grid: inout [[NSColor]], frame: Int) {
        let red = NSColor(red: 0.85, green: 0.1, blue: 0.1, alpha: 1.0)
        let darkRed = NSColor(red: 0.55, green: 0.05, blue: 0.05, alpha: 1.0)
        let brightRed = NSColor(red: 1.0, green: 0.2, blue: 0.15, alpha: 1.0)
        let blue = NSColor(red: 0.1, green: 0.2, blue: 0.65, alpha: 1.0)
        let darkBlue = NSColor(red: 0.05, green: 0.1, blue: 0.4, alpha: 1.0)
        let brightBlue = NSColor(red: 0.2, green: 0.35, blue: 0.9, alpha: 1.0)
        let gold = NSColor(red: 1.0, green: 0.82, blue: 0.0, alpha: 1.0)
        let darkGold = NSColor(red: 0.8, green: 0.6, blue: 0.0, alpha: 1.0)
        let brightGold = NSColor(red: 1.0, green: 0.95, blue: 0.4, alpha: 1.0)
        let skin = NSColor(red: 0.95, green: 0.8, blue: 0.65, alpha: 1.0)
        let black = NSColor.black
        let white = NSColor.white
        let silver = NSColor(red: 0.8, green: 0.8, blue: 0.83, alpha: 1.0)
        let lassoGlow = NSColor(red: 1.0, green: 0.9, blue: 0.3, alpha: 0.9)

        // === LASSO (animated, glowing, swinging from left hand) ===
        let lassoPhase = frame % 4
        switch lassoPhase {
        case 0:
            setPixel(&grid, x: 1, y: 3, color: brightGold)
            setPixel(&grid, x: 1, y: 4, color: gold)
            setPixel(&grid, x: 0, y: 5, color: lassoGlow)
            setPixel(&grid, x: 1, y: 5, color: gold)
        case 1:
            setPixel(&grid, x: 1, y: 2, color: brightGold)
            setPixel(&grid, x: 1, y: 3, color: gold)
            setPixel(&grid, x: 0, y: 4, color: lassoGlow)
            setPixel(&grid, x: 1, y: 4, color: gold)
        case 2:
            setPixel(&grid, x: 0, y: 3, color: brightGold)
            setPixel(&grid, x: 1, y: 3, color: gold)
            setPixel(&grid, x: 0, y: 4, color: lassoGlow)
            setPixel(&grid, x: 1, y: 4, color: gold)
        default:
            setPixel(&grid, x: 0, y: 2, color: brightGold)
            setPixel(&grid, x: 1, y: 3, color: gold)
            setPixel(&grid, x: 0, y: 3, color: lassoGlow)
            setPixel(&grid, x: 1, y: 4, color: gold)
        }

        // === HAIR (long, flowing black) ===
        for x in 6...9 { setPixel(&grid, x: x, y: 0, color: black) }
        for x in 5...10 { setPixel(&grid, x: x, y: 1, color: black) }
        for x in 4...5 { setPixel(&grid, x: x, y: 2, color: black) }
        for x in 10...11 { setPixel(&grid, x: x, y: 2, color: black) }
        // Flowing hair strands
        setPixel(&grid, x: 4, y: 3, color: black)
        setPixel(&grid, x: 11, y: 3, color: black)
        setPixel(&grid, x: 4, y: 4, color: black)
        setPixel(&grid, x: 11, y: 4, color: black)
        setPixel(&grid, x: 3, y: 5, color: black)
        setPixel(&grid, x: 12, y: 5, color: black)

        // === TIARA (gold with red star) ===
        setPixel(&grid, x: 6, y: 1, color: gold)
        setPixel(&grid, x: 7, y: 1, color: gold)
        setPixel(&grid, x: 8, y: 1, color: gold)
        setPixel(&grid, x: 9, y: 1, color: gold)
        setPixel(&grid, x: 7, y: 0, color: brightGold)
        setPixel(&grid, x: 8, y: 0, color: brightGold)
        // Red star on tiara
        setPixel(&grid, x: 7, y: 1, color: red)
        setPixel(&grid, x: 8, y: 1, color: red)

        // === FACE (skin, beautiful) ===
        for x in 6...9 { setPixel(&grid, x: x, y: 2, color: skin) }
        for x in 5...10 { setPixel(&grid, x: x, y: 3, color: skin) }

        // Eyes (blue, intense)
        setPixel(&grid, x: 6, y: 2, color: brightBlue)
        setPixel(&grid, x: 9, y: 2, color: brightBlue)
        setPixel(&grid, x: 6, y: 2, color: black)
        setPixel(&grid, x: 9, y: 2, color: black)
        setPixel(&grid, x: 6, y: 2, color: brightBlue)
        setPixel(&grid, x: 9, y: 2, color: brightBlue)

        // Lips (red)
        setPixel(&grid, x: 7, y: 3, color: red)
        setPixel(&grid, x: 8, y: 3, color: red)

        // === NECK ===
        setPixel(&grid, x: 7, y: 4, color: skin)
        setPixel(&grid, x: 8, y: 4, color: skin)

        // === SHOULDERS (silver bracelets visible) ===
        for x in 3...5 { setPixel(&grid, x: x, y: 5, color: skin) }
        for x in 10...12 { setPixel(&grid, x: x, y: 5, color: skin) }
        // Silver bracelets
        setPixel(&grid, x: 3, y: 5, color: silver)
        setPixel(&grid, x: 12, y: 5, color: silver)

        // === CHEST (red armor with gold eagle) ===
        for x in 5...10 { setPixel(&grid, x: x, y: 5, color: red) }
        for x in 4...11 { setPixel(&grid, x: x, y: 6, color: red) }
        for x in 5...10 { setPixel(&grid, x: x, y: 7, color: red) }
        // Chest highlight
        setPixel(&grid, x: 6, y: 6, color: brightRed)
        setPixel(&grid, x: 9, y: 6, color: brightRed)

        // GOLD EAGLE emblem (spread wings)
        setPixel(&grid, x: 7, y: 6, color: gold)
        setPixel(&grid, x: 8, y: 6, color: gold)
        setPixel(&grid, x: 7, y: 7, color: gold)
        setPixel(&grid, x: 8, y: 7, color: gold)
        setPixel(&grid, x: 5, y: 6, color: gold)
        setPixel(&grid, x: 10, y: 6, color: gold)
        setPixel(&grid, x: 6, y: 5, color: gold)
        setPixel(&grid, x: 9, y: 5, color: gold)
        // Eagle head
        setPixel(&grid, x: 7, y: 5, color: brightGold)
        setPixel(&grid, x: 8, y: 5, color: brightGold)

        // === LEFT ARM (holding lasso) ===
        setPixel(&grid, x: 2, y: 5, color: skin)
        setPixel(&grid, x: 2, y: 6, color: skin)
        setPixel(&grid, x: 2, y: 7, color: skin)
        // Silver bracelet
        setPixel(&grid, x: 2, y: 5, color: silver)

        // === RIGHT ARM (extended, warrior pose) ===
        setPixel(&grid, x: 13, y: 5, color: skin)
        setPixel(&grid, x: 14, y: 5, color: skin)
        setPixel(&grid, x: 14, y: 6, color: skin)
        setPixel(&grid, x: 15, y: 6, color: skin)
        setPixel(&grid, x: 15, y: 7, color: skin)
        // Silver bracelet
        setPixel(&grid, x: 13, y: 5, color: silver)

        // === WAIST (blue with stars) ===
        for x in 5...10 { setPixel(&grid, x: x, y: 8, color: blue) }
        setPixel(&grid, x: 5, y: 8, color: darkBlue)
        setPixel(&grid, x: 10, y: 8, color: darkBlue)

        // Gold belt
        for x in 5...10 { setPixel(&grid, x: x, y: 9, color: gold) }
        setPixel(&grid, x: 7, y: 9, color: brightGold)
        setPixel(&grid, x: 8, y: 9, color: brightGold)

        // === SKIRT (blue with white stars) ===
        for x in 4...11 { setPixel(&grid, x: x, y: 10, color: blue) }
        // Stars on skirt
        setPixel(&grid, x: 5, y: 10, color: white)
        setPixel(&grid, x: 8, y: 10, color: white)
        setPixel(&grid, x: 11, y: 10, color: white)

        // === LEGS (skin, muscular) ===
        for x in 4...6 { setPixel(&grid, x: x, y: 11, color: skin) }
        for x in 9...11 { setPixel(&grid, x: x, y: 11, color: skin) }
        for x in 4...6 { setPixel(&grid, x: x, y: 12, color: skin) }
        for x in 9...11 { setPixel(&grid, x: x, y: 12, color: skin) }

        // Knee highlights
        setPixel(&grid, x: 4, y: 11, color: NSColor(red: 1.0, green: 0.9, blue: 0.8, alpha: 1.0))
        setPixel(&grid, x: 11, y: 11, color: NSColor(red: 1.0, green: 0.9, blue: 0.8, alpha: 1.0))

        // === BOOTS (red with white stripe) ===
        for x in 3...6 { setPixel(&grid, x: x, y: 13, color: red) }
        for x in 9...12 { setPixel(&grid, x: x, y: 13, color: red) }
        setPixel(&grid, x: 3, y: 13, color: brightRed)
        setPixel(&grid, x: 12, y: 13, color: brightRed)
        // White stripe
        setPixel(&grid, x: 4, y: 13, color: white)
        setPixel(&grid, x: 11, y: 13, color: white)
        // Boot tops
        setPixel(&grid, x: 3, y: 12, color: darkRed)
        setPixel(&grid, x: 12, y: 12, color: darkRed)
        // Boot soles
        for x in 3...6 { setPixel(&grid, x: x, y: 14, color: darkRed) }
        for x in 9...12 { setPixel(&grid, x: x, y: 14, color: darkRed) }
    }

    func drawDCFlash(grid: inout [[NSColor]], frame: Int) {
        let red = NSColor(red: 0.85, green: 0.1, blue: 0.1, alpha: 1.0)
        let yellow = NSColor(red: 1.0, green: 0.85, blue: 0.0, alpha: 1.0)
        let skin = NSColor(red: 0.95, green: 0.8, blue: 0.65, alpha: 1.0)
        let white = NSColor.white
        for x in 6...9 { setPixel(&grid, x: x, y: 1, color: red) }
        for x in 5...10 { setPixel(&grid, x: x, y: 2, color: red) }
        setPixel(&grid, x: 5, y: 1, color: yellow)
        setPixel(&grid, x: 10, y: 1, color: yellow)
        for x in 5...10 { setPixel(&grid, x: x, y: 3, color: skin) }
        setPixel(&grid, x: 6, y: 3, color: white)
        setPixel(&grid, x: 9, y: 3, color: white)
        for x in 5...10 { setPixel(&grid, x: x, y: 4, color: red) }
        setPixel(&grid, x: 7, y: 4, color: yellow)
        setPixel(&grid, x: 8, y: 4, color: yellow)
        for x in 4...11 { setPixel(&grid, x: x, y: 5, color: red) }
        for x in 4...11 { setPixel(&grid, x: x, y: 6, color: yellow) }
        if frame % 2 == 0 {
            setPixel(&grid, x: 5, y: 7, color: red)
            setPixel(&grid, x: 10, y: 7, color: red)
        } else {
            setPixel(&grid, x: 6, y: 7, color: red)
            setPixel(&grid, x: 9, y: 7, color: red)
        }
    }

    func drawDCGreenLantern(grid: inout [[NSColor]], frame: Int) {
        let green = NSColor(red: 0.1, green: 0.7, blue: 0.2, alpha: 1.0)
        let darkGreen = NSColor(red: 0.05, green: 0.45, blue: 0.1, alpha: 1.0)
        let black = NSColor(red: 0.1, green: 0.1, blue: 0.12, alpha: 1.0)
        let white = NSColor.white
        for x in 6...9 { setPixel(&grid, x: x, y: 1, color: green) }
        for x in 5...10 { setPixel(&grid, x: x, y: 2, color: black) }
        for x in 5...10 { setPixel(&grid, x: x, y: 3, color: black) }
        setPixel(&grid, x: 6, y: 3, color: white)
        setPixel(&grid, x: 9, y: 3, color: white)
        for x in 5...10 { setPixel(&grid, x: x, y: 4, color: green) }
        setPixel(&grid, x: 7, y: 4, color: white)
        setPixel(&grid, x: 8, y: 4, color: white)
        for x in 4...11 { setPixel(&grid, x: x, y: 5, color: black) }
        for x in 4...11 { setPixel(&grid, x: x, y: 6, color: green) }
        if frame % 2 == 0 {
            setPixel(&grid, x: 5, y: 7, color: black)
            setPixel(&grid, x: 10, y: 7, color: black)
        } else {
            setPixel(&grid, x: 6, y: 7, color: black)
            setPixel(&grid, x: 9, y: 7, color: black)
        }
    }

    func drawDCAquaman(grid: inout [[NSColor]], frame: Int) {
        let green = NSColor(red: 0.1, green: 0.6, blue: 0.2, alpha: 1.0)
        let gold = NSColor(red: 1.0, green: 0.8, blue: 0.0, alpha: 1.0)
        let skin = NSColor(red: 0.95, green: 0.8, blue: 0.65, alpha: 1.0)
        let orange = NSColor(red: 0.9, green: 0.55, blue: 0.1, alpha: 1.0)
        for x in 6...9 { setPixel(&grid, x: x, y: 1, color: NSColor.black) }
        for x in 5...10 { setPixel(&grid, x: x, y: 2, color: NSColor.black) }
        for x in 5...10 { setPixel(&grid, x: x, y: 3, color: skin) }
        setPixel(&grid, x: 6, y: 3, color: NSColor.black)
        setPixel(&grid, x: 9, y: 3, color: NSColor.black)
        for x in 5...10 { setPixel(&grid, x: x, y: 4, color: orange) }
        setPixel(&grid, x: 7, y: 4, color: gold)
        setPixel(&grid, x: 8, y: 4, color: gold)
        for x in 4...11 { setPixel(&grid, x: x, y: 5, color: green) }
        for x in 4...11 { setPixel(&grid, x: x, y: 6, color: orange) }
        if frame % 2 == 0 {
            setPixel(&grid, x: 5, y: 7, color: green)
            setPixel(&grid, x: 10, y: 7, color: green)
        } else {
            setPixel(&grid, x: 6, y: 7, color: green)
            setPixel(&grid, x: 9, y: 7, color: green)
        }
    }

    func drawDCJoker(grid: inout [[NSColor]], frame: Int) {
        let green = NSColor(red: 0.15, green: 0.7, blue: 0.15, alpha: 1.0)
        let purple = NSColor(red: 0.55, green: 0.15, blue: 0.6, alpha: 1.0)
        let white = NSColor.white
        let red = NSColor(red: 0.85, green: 0.1, blue: 0.1, alpha: 1.0)
        for x in 6...9 { setPixel(&grid, x: x, y: 1, color: green) }
        for x in 5...10 { setPixel(&grid, x: x, y: 2, color: green) }
        for x in 5...10 { setPixel(&grid, x: x, y: 3, color: white) }
        setPixel(&grid, x: 6, y: 3, color: red)
        setPixel(&grid, x: 9, y: 3, color: red)
        for x in 5...10 { setPixel(&grid, x: x, y: 4, color: white) }
        setPixel(&grid, x: 7, y: 4, color: red)
        setPixel(&grid, x: 8, y: 4, color: red)
        for x in 4...11 { setPixel(&grid, x: x, y: 5, color: purple) }
        for x in 4...11 { setPixel(&grid, x: x, y: 6, color: green) }
        if frame % 2 == 0 {
            setPixel(&grid, x: 5, y: 7, color: purple)
            setPixel(&grid, x: 10, y: 7, color: purple)
        } else {
            setPixel(&grid, x: 6, y: 7, color: purple)
            setPixel(&grid, x: 9, y: 7, color: purple)
        }
    }

    func drawDCHarleyQuinn(grid: inout [[NSColor]], frame: Int) {
        let red = NSColor(red: 0.85, green: 0.1, blue: 0.1, alpha: 1.0)
        let black = NSColor(red: 0.1, green: 0.1, blue: 0.12, alpha: 1.0)
        let white = NSColor.white
        let skin = NSColor(red: 0.95, green: 0.8, blue: 0.65, alpha: 1.0)
        for x in 6...9 { setPixel(&grid, x: x, y: 1, color: red) }
        setPixel(&grid, x: 5, y: 0, color: black)
        setPixel(&grid, x: 10, y: 0, color: red)
        for x in 5...10 { setPixel(&grid, x: x, y: 2, color: white) }
        for x in 5...10 { setPixel(&grid, x: x, y: 3, color: skin) }
        setPixel(&grid, x: 6, y: 3, color: NSColor.black)
        setPixel(&grid, x: 9, y: 3, color: NSColor.black)
        for x in 5...10 { setPixel(&grid, x: x, y: 4, color: white) }
        setPixel(&grid, x: 7, y: 4, color: red)
        setPixel(&grid, x: 8, y: 4, color: red)
        for x in 4...11 { setPixel(&grid, x: x, y: 5, color: black) }
        for x in 4...11 { setPixel(&grid, x: x, y: 6, color: red) }
        if frame % 2 == 0 {
            setPixel(&grid, x: 5, y: 7, color: black)
            setPixel(&grid, x: 10, y: 7, color: red)
        } else {
            setPixel(&grid, x: 6, y: 7, color: black)
            setPixel(&grid, x: 9, y: 7, color: red)
        }
    }

    func drawDCLexLuthor(grid: inout [[NSColor]], frame: Int) {
        let green = NSColor(red: 0.1, green: 0.55, blue: 0.15, alpha: 1.0)
        let gray = NSColor(red: 0.75, green: 0.75, blue: 0.78, alpha: 1.0)
        let skin = NSColor(red: 0.95, green: 0.8, blue: 0.65, alpha: 1.0)
        for x in 6...9 { setPixel(&grid, x: x, y: 2, color: skin) }
        for x in 5...10 { setPixel(&grid, x: x, y: 3, color: skin) }
        setPixel(&grid, x: 6, y: 3, color: NSColor.black)
        setPixel(&grid, x: 9, y: 3, color: NSColor.black)
        for x in 5...10 { setPixel(&grid, x: x, y: 4, color: skin) }
        for x in 5...10 { setPixel(&grid, x: x, y: 5, color: green) }
        for x in 4...11 { setPixel(&grid, x: x, y: 6, color: gray) }
        if frame % 2 == 0 {
            setPixel(&grid, x: 5, y: 7, color: green)
            setPixel(&grid, x: 10, y: 7, color: green)
        } else {
            setPixel(&grid, x: 6, y: 7, color: green)
            setPixel(&grid, x: 9, y: 7, color: green)
        }
    }

    func drawDCDarkseid(grid: inout [[NSColor]], frame: Int) {
        let gray = NSColor(red: 0.45, green: 0.42, blue: 0.4, alpha: 1.0)
        let darkGray = NSColor(red: 0.3, green: 0.28, blue: 0.26, alpha: 1.0)
        let red = NSColor(red: 0.9, green: 0.1, blue: 0.1, alpha: 1.0)
        for x in 5...10 { setPixel(&grid, x: x, y: 1, color: gray) }
        for x in 4...11 { setPixel(&grid, x: x, y: 2, color: gray) }
        for x in 4...11 { setPixel(&grid, x: x, y: 3, color: darkGray) }
        setPixel(&grid, x: 6, y: 3, color: red)
        setPixel(&grid, x: 9, y: 3, color: red)
        for x in 4...11 { setPixel(&grid, x: x, y: 4, color: gray) }
        for x in 3...12 { setPixel(&grid, x: x, y: 5, color: darkGray) }
        for x in 3...12 { setPixel(&grid, x: x, y: 6, color: gray) }
        if frame % 2 == 0 {
            setPixel(&grid, x: 4, y: 7, color: darkGray)
            setPixel(&grid, x: 11, y: 7, color: darkGray)
        } else {
            setPixel(&grid, x: 5, y: 7, color: darkGray)
            setPixel(&grid, x: 10, y: 7, color: darkGray)
        }
    }

    // MARK: - Naruto
    func drawNarutoNaruto(grid: inout [[NSColor]], frame: Int) {
        let orange = NSColor(red: 0.95, green: 0.55, blue: 0.1, alpha: 1.0)
        let yellow = NSColor(red: 1.0, green: 0.9, blue: 0.2, alpha: 1.0)
        let skin = NSColor(red: 0.95, green: 0.8, blue: 0.65, alpha: 1.0)
        let blue = NSColor(red: 0.1, green: 0.3, blue: 0.75, alpha: 1.0)
        for x in 6...9 { setPixel(&grid, x: x, y: 0, color: yellow) }
        for x in 5...10 { setPixel(&grid, x: x, y: 1, color: yellow) }
        for x in 4...11 { setPixel(&grid, x: x, y: 2, color: blue) }
        for x in 5...10 { setPixel(&grid, x: x, y: 3, color: skin) }
        setPixel(&grid, x: 6, y: 3, color: NSColor.black)
        setPixel(&grid, x: 9, y: 3, color: NSColor.black)
        setPixel(&grid, x: 5, y: 4, color: NSColor.red)
        setPixel(&grid, x: 10, y: 4, color: NSColor.red)
        for x in 5...10 { setPixel(&grid, x: x, y: 4, color: skin) }
        for x in 5...10 { setPixel(&grid, x: x, y: 5, color: orange) }
        for x in 4...11 { setPixel(&grid, x: x, y: 6, color: orange) }
        if frame % 2 == 0 {
            setPixel(&grid, x: 5, y: 7, color: orange)
            setPixel(&grid, x: 10, y: 7, color: orange)
        } else {
            setPixel(&grid, x: 6, y: 7, color: orange)
            setPixel(&grid, x: 9, y: 7, color: orange)
        }
    }

    func drawNarutoSasuke(grid: inout [[NSColor]], frame: Int) {
        let black = NSColor(red: 0.1, green: 0.1, blue: 0.12, alpha: 1.0)
        let blue = NSColor(red: 0.1, green: 0.2, blue: 0.6, alpha: 1.0)
        let skin = NSColor(red: 0.95, green: 0.8, blue: 0.65, alpha: 1.0)
        let white = NSColor.white
        for x in 6...9 { setPixel(&grid, x: x, y: 0, color: black) }
        for x in 5...10 { setPixel(&grid, x: x, y: 1, color: black) }
        for x in 5...10 { setPixel(&grid, x: x, y: 2, color: blue) }
        for x in 5...10 { setPixel(&grid, x: x, y: 3, color: skin) }
        setPixel(&grid, x: 6, y: 3, color: NSColor.black)
        setPixel(&grid, x: 9, y: 3, color: NSColor.black)
        setPixel(&grid, x: 6, y: 3, color: white)
        setPixel(&grid, x: 9, y: 3, color: white)
        for x in 5...10 { setPixel(&grid, x: x, y: 4, color: blue) }
        for x in 4...11 { setPixel(&grid, x: x, y: 5, color: black) }
        for x in 4...11 { setPixel(&grid, x: x, y: 6, color: blue) }
        if frame % 2 == 0 {
            setPixel(&grid, x: 5, y: 7, color: black)
            setPixel(&grid, x: 10, y: 7, color: black)
        } else {
            setPixel(&grid, x: 6, y: 7, color: black)
            setPixel(&grid, x: 9, y: 7, color: black)
        }
    }

    func drawNarutoSakura(grid: inout [[NSColor]], frame: Int) {
        let pink = NSColor(red: 0.95, green: 0.5, blue: 0.6, alpha: 1.0)
        let green = NSColor(red: 0.15, green: 0.6, blue: 0.2, alpha: 1.0)
        let skin = NSColor(red: 0.95, green: 0.8, blue: 0.65, alpha: 1.0)
        for x in 6...9 { setPixel(&grid, x: x, y: 0, color: pink) }
        for x in 5...10 { setPixel(&grid, x: x, y: 1, color: pink) }
        for x in 5...10 { setPixel(&grid, x: x, y: 2, color: pink) }
        for x in 5...10 { setPixel(&grid, x: x, y: 3, color: skin) }
        setPixel(&grid, x: 6, y: 3, color: NSColor.black)
        setPixel(&grid, x: 9, y: 3, color: NSColor.black)
        for x in 5...10 { setPixel(&grid, x: x, y: 4, color: skin) }
        for x in 5...10 { setPixel(&grid, x: x, y: 5, color: green) }
        for x in 4...11 { setPixel(&grid, x: x, y: 6, color: green) }
        if frame % 2 == 0 {
            setPixel(&grid, x: 5, y: 7, color: green)
            setPixel(&grid, x: 10, y: 7, color: green)
        } else {
            setPixel(&grid, x: 6, y: 7, color: green)
            setPixel(&grid, x: 9, y: 7, color: green)
        }
    }

    func drawNarutoKakashi(grid: inout [[NSColor]], frame: Int) {
        let gray = NSColor(red: 0.7, green: 0.7, blue: 0.73, alpha: 1.0)
        let darkGray = NSColor(red: 0.4, green: 0.4, blue: 0.43, alpha: 1.0)
        let skin = NSColor(red: 0.95, green: 0.8, blue: 0.65, alpha: 1.0)
        let green = NSColor(red: 0.15, green: 0.5, blue: 0.15, alpha: 1.0)
        for x in 6...9 { setPixel(&grid, x: x, y: 0, color: gray) }
        for x in 5...10 { setPixel(&grid, x: x, y: 1, color: gray) }
        for x in 5...10 { setPixel(&grid, x: x, y: 2, color: darkGray) }
        for x in 5...10 { setPixel(&grid, x: x, y: 3, color: skin) }
        setPixel(&grid, x: 6, y: 3, color: NSColor.black)
        setPixel(&grid, x: 9, y: 3, color: NSColor.black)
        for x in 6...9 { setPixel(&grid, x: x, y: 4, color: darkGray) }
        for x in 5...10 { setPixel(&grid, x: x, y: 5, color: green) }
        for x in 4...11 { setPixel(&grid, x: x, y: 6, color: darkGray) }
        if frame % 2 == 0 {
            setPixel(&grid, x: 5, y: 7, color: green)
            setPixel(&grid, x: 10, y: 7, color: green)
        } else {
            setPixel(&grid, x: 6, y: 7, color: green)
            setPixel(&grid, x: 9, y: 7, color: green)
        }
    }

    func drawNarutoItachi(grid: inout [[NSColor]], frame: Int) {
        let black = NSColor(red: 0.1, green: 0.1, blue: 0.12, alpha: 1.0)
        let red = NSColor(red: 0.7, green: 0.1, blue: 0.1, alpha: 1.0)
        let skin = NSColor(red: 0.95, green: 0.8, blue: 0.65, alpha: 1.0)
        for x in 6...9 { setPixel(&grid, x: x, y: 0, color: black) }
        for x in 5...10 { setPixel(&grid, x: x, y: 1, color: black) }
        for x in 5...10 { setPixel(&grid, x: x, y: 2, color: red) }
        for x in 5...10 { setPixel(&grid, x: x, y: 3, color: skin) }
        setPixel(&grid, x: 6, y: 3, color: NSColor.black)
        setPixel(&grid, x: 9, y: 3, color: NSColor.black)
        setPixel(&grid, x: 6, y: 3, color: red)
        setPixel(&grid, x: 9, y: 3, color: red)
        for x in 5...10 { setPixel(&grid, x: x, y: 4, color: black) }
        for x in 3...12 { setPixel(&grid, x: x, y: 5, color: red) }
        for x in 3...12 { setPixel(&grid, x: x, y: 6, color: black) }
        if frame % 2 == 0 {
            setPixel(&grid, x: 4, y: 7, color: black)
            setPixel(&grid, x: 11, y: 7, color: black)
        } else {
            setPixel(&grid, x: 5, y: 7, color: black)
            setPixel(&grid, x: 10, y: 7, color: black)
        }
    }

    func drawNarutoGaara(grid: inout [[NSColor]], frame: Int) {
        let red = NSColor(red: 0.75, green: 0.2, blue: 0.15, alpha: 1.0)
        let sand = NSColor(red: 0.85, green: 0.75, blue: 0.5, alpha: 1.0)
        let skin = NSColor(red: 0.95, green: 0.8, blue: 0.65, alpha: 1.0)
        let green = NSColor(red: 0.15, green: 0.5, blue: 0.2, alpha: 1.0)
        for x in 6...9 { setPixel(&grid, x: x, y: 0, color: red) }
        for x in 5...10 { setPixel(&grid, x: x, y: 1, color: red) }
        for x in 5...10 { setPixel(&grid, x: x, y: 2, color: sand) }
        for x in 5...10 { setPixel(&grid, x: x, y: 3, color: skin) }
        setPixel(&grid, x: 6, y: 3, color: NSColor.black)
        setPixel(&grid, x: 9, y: 3, color: NSColor.black)
        for x in 5...10 { setPixel(&grid, x: x, y: 4, color: skin) }
        for x in 5...10 { setPixel(&grid, x: x, y: 5, color: green) }
        for x in 4...11 { setPixel(&grid, x: x, y: 6, color: sand) }
        if frame % 2 == 0 {
            setPixel(&grid, x: 5, y: 7, color: green)
            setPixel(&grid, x: 10, y: 7, color: green)
        } else {
            setPixel(&grid, x: 6, y: 7, color: green)
            setPixel(&grid, x: 9, y: 7, color: green)
        }
    }

    func drawNarutoOrochimaru(grid: inout [[NSColor]], frame: Int) {
        let white = NSColor.white
        let purple = NSColor(red: 0.45, green: 0.15, blue: 0.5, alpha: 1.0)
        let skin = NSColor(red: 0.9, green: 0.88, blue: 0.82, alpha: 1.0)
        let black = NSColor.black
        for x in 6...9 { setPixel(&grid, x: x, y: 0, color: black) }
        for x in 5...10 { setPixel(&grid, x: x, y: 1, color: black) }
        for x in 5...10 { setPixel(&grid, x: x, y: 2, color: black) }
        for x in 5...10 { setPixel(&grid, x: x, y: 3, color: skin) }
        setPixel(&grid, x: 6, y: 3, color: purple)
        setPixel(&grid, x: 9, y: 3, color: purple)
        for x in 5...10 { setPixel(&grid, x: x, y: 4, color: skin) }
        for x in 5...10 { setPixel(&grid, x: x, y: 5, color: white) }
        for x in 4...11 { setPixel(&grid, x: x, y: 6, color: purple) }
        if frame % 2 == 0 {
            setPixel(&grid, x: 5, y: 7, color: white)
            setPixel(&grid, x: 10, y: 7, color: white)
        } else {
            setPixel(&grid, x: 6, y: 7, color: white)
            setPixel(&grid, x: 9, y: 7, color: white)
        }
    }

    func drawNarutoJiraiya(grid: inout [[NSColor]], frame: Int) {
        let white = NSColor.white
        let red = NSColor(red: 0.8, green: 0.15, blue: 0.1, alpha: 1.0)
        let skin = NSColor(red: 0.95, green: 0.8, blue: 0.65, alpha: 1.0)
        let green = NSColor(red: 0.15, green: 0.5, blue: 0.2, alpha: 1.0)
        for x in 5...10 { setPixel(&grid, x: x, y: 0, color: white) }
        for x in 4...11 { setPixel(&grid, x: x, y: 1, color: white) }
        for x in 4...11 { setPixel(&grid, x: x, y: 2, color: white) }
        for x in 5...10 { setPixel(&grid, x: x, y: 3, color: skin) }
        setPixel(&grid, x: 6, y: 3, color: NSColor.black)
        setPixel(&grid, x: 9, y: 3, color: NSColor.black)
        for x in 5...10 { setPixel(&grid, x: x, y: 4, color: skin) }
        for x in 4...11 { setPixel(&grid, x: x, y: 5, color: red) }
        for x in 4...11 { setPixel(&grid, x: x, y: 6, color: green) }
        if frame % 2 == 0 {
            setPixel(&grid, x: 5, y: 7, color: red)
            setPixel(&grid, x: 10, y: 7, color: red)
        } else {
            setPixel(&grid, x: 6, y: 7, color: red)
            setPixel(&grid, x: 9, y: 7, color: red)
        }
    }

    func drawNarutoTsunade(grid: inout [[NSColor]], frame: Int) {
        let yellow = NSColor(red: 0.95, green: 0.85, blue: 0.3, alpha: 1.0)
        let green = NSColor(red: 0.15, green: 0.55, blue: 0.2, alpha: 1.0)
        let skin = NSColor(red: 0.95, green: 0.8, blue: 0.65, alpha: 1.0)
        for x in 6...9 { setPixel(&grid, x: x, y: 0, color: yellow) }
        for x in 5...10 { setPixel(&grid, x: x, y: 1, color: yellow) }
        for x in 5...10 { setPixel(&grid, x: x, y: 2, color: yellow) }
        for x in 5...10 { setPixel(&grid, x: x, y: 3, color: skin) }
        setPixel(&grid, x: 6, y: 3, color: NSColor.black)
        setPixel(&grid, x: 9, y: 3, color: NSColor.black)
        for x in 5...10 { setPixel(&grid, x: x, y: 4, color: skin) }
        for x in 5...10 { setPixel(&grid, x: x, y: 5, color: green) }
        for x in 4...11 { setPixel(&grid, x: x, y: 6, color: green) }
        if frame % 2 == 0 {
            setPixel(&grid, x: 5, y: 7, color: green)
            setPixel(&grid, x: 10, y: 7, color: green)
        } else {
            setPixel(&grid, x: 6, y: 7, color: green)
            setPixel(&grid, x: 9, y: 7, color: green)
        }
    }

    func drawNarutoRockLee(grid: inout [[NSColor]], frame: Int) {
        let green = NSColor(red: 0.1, green: 0.6, blue: 0.15, alpha: 1.0)
        let black = NSColor.black
        let skin = NSColor(red: 0.95, green: 0.8, blue: 0.65, alpha: 1.0)
        let orange = NSColor(red: 0.95, green: 0.55, blue: 0.1, alpha: 1.0)
        for x in 6...9 { setPixel(&grid, x: x, y: 1, color: green) }
        for x in 5...10 { setPixel(&grid, x: x, y: 2, color: green) }
        for x in 5...10 { setPixel(&grid, x: x, y: 3, color: skin) }
        setPixel(&grid, x: 6, y: 3, color: black)
        setPixel(&grid, x: 9, y: 3, color: black)
        setPixel(&grid, x: 6, y: 3, color: NSColor.white)
        setPixel(&grid, x: 9, y: 3, color: NSColor.white)
        for x in 5...10 { setPixel(&grid, x: x, y: 4, color: green) }
        for x in 5...10 { setPixel(&grid, x: x, y: 5, color: orange) }
        for x in 4...11 { setPixel(&grid, x: x, y: 6, color: orange) }
        if frame % 2 == 0 {
            setPixel(&grid, x: 5, y: 7, color: orange)
            setPixel(&grid, x: 10, y: 7, color: orange)
        } else {
            setPixel(&grid, x: 6, y: 7, color: orange)
            setPixel(&grid, x: 9, y: 7, color: orange)
        }
    }

    func drawNarutoHinata(grid: inout [[NSColor]], frame: Int) {
        let darkBlue = NSColor(red: 0.15, green: 0.15, blue: 0.45, alpha: 1.0)
        let lavender = NSColor(red: 0.7, green: 0.6, blue: 0.85, alpha: 1.0)
        let skin = NSColor(red: 0.95, green: 0.8, blue: 0.65, alpha: 1.0)
        for x in 6...9 { setPixel(&grid, x: x, y: 0, color: darkBlue) }
        for x in 5...10 { setPixel(&grid, x: x, y: 1, color: darkBlue) }
        for x in 5...10 { setPixel(&grid, x: x, y: 2, color: darkBlue) }
        for x in 5...10 { setPixel(&grid, x: x, y: 3, color: skin) }
        setPixel(&grid, x: 6, y: 3, color: lavender)
        setPixel(&grid, x: 9, y: 3, color: lavender)
        for x in 5...10 { setPixel(&grid, x: x, y: 4, color: skin) }
        for x in 5...10 { setPixel(&grid, x: x, y: 5, color: lavender) }
        for x in 4...11 { setPixel(&grid, x: x, y: 6, color: darkBlue) }
        if frame % 2 == 0 {
            setPixel(&grid, x: 5, y: 7, color: lavender)
            setPixel(&grid, x: 10, y: 7, color: lavender)
        } else {
            setPixel(&grid, x: 6, y: 7, color: lavender)
            setPixel(&grid, x: 9, y: 7, color: lavender)
        }
    }

    func drawNarutoShikamaru(grid: inout [[NSColor]], frame: Int) {
        let brown = NSColor(red: 0.5, green: 0.35, blue: 0.15, alpha: 1.0)
        let mesh = NSColor(red: 0.3, green: 0.3, blue: 0.32, alpha: 1.0)
        let skin = NSColor(red: 0.95, green: 0.8, blue: 0.65, alpha: 1.0)
        let green = NSColor(red: 0.15, green: 0.5, blue: 0.2, alpha: 1.0)
        for x in 6...9 { setPixel(&grid, x: x, y: 0, color: brown) }
        for x in 5...10 { setPixel(&grid, x: x, y: 1, color: brown) }
        for x in 5...10 { setPixel(&grid, x: x, y: 2, color: brown) }
        for x in 5...10 { setPixel(&grid, x: x, y: 3, color: skin) }
        setPixel(&grid, x: 6, y: 3, color: NSColor.black)
        setPixel(&grid, x: 9, y: 3, color: NSColor.black)
        for x in 5...10 { setPixel(&grid, x: x, y: 4, color: mesh) }
        for x in 5...10 { setPixel(&grid, x: x, y: 5, color: green) }
        for x in 4...11 { setPixel(&grid, x: x, y: 6, color: mesh) }
        if frame % 2 == 0 {
            setPixel(&grid, x: 5, y: 7, color: green)
            setPixel(&grid, x: 10, y: 7, color: green)
        } else {
            setPixel(&grid, x: 6, y: 7, color: green)
            setPixel(&grid, x: 9, y: 7, color: green)
        }
    }

    // MARK: - The Simpsons
    func drawSimpsonsHomer(grid: inout [[NSColor]], frame: Int) {
        let yellow = NSColor(red: 1.0, green: 0.87, blue: 0.15, alpha: 1.0)
        let white = NSColor.white
        let brown = NSColor(red: 0.55, green: 0.35, blue: 0.1, alpha: 1.0)
        for x in 6...9 { setPixel(&grid, x: x, y: 0, color: yellow) }
        for x in 5...10 { setPixel(&grid, x: x, y: 1, color: yellow) }
        for x in 5...10 { setPixel(&grid, x: x, y: 2, color: yellow) }
        for x in 4...11 { setPixel(&grid, x: x, y: 3, color: yellow) }
        setPixel(&grid, x: 6, y: 3, color: NSColor.black)
        setPixel(&grid, x: 9, y: 3, color: NSColor.black)
        setPixel(&grid, x: 7, y: 3, color: white)
        setPixel(&grid, x: 8, y: 3, color: white)
        for x in 4...11 { setPixel(&grid, x: x, y: 4, color: yellow) }
        for x in 5...10 { setPixel(&grid, x: x, y: 5, color: white) }
        for x in 5...10 { setPixel(&grid, x: x, y: 6, color: white) }
        if frame % 2 == 0 {
            setPixel(&grid, x: 5, y: 7, color: brown)
            setPixel(&grid, x: 10, y: 7, color: brown)
        } else {
            setPixel(&grid, x: 6, y: 7, color: brown)
            setPixel(&grid, x: 9, y: 7, color: brown)
        }
    }

    func drawSimpsonsMarge(grid: inout [[NSColor]], frame: Int) {
        let yellow = NSColor(red: 1.0, green: 0.87, blue: 0.15, alpha: 1.0)
        let blue = NSColor(red: 0.15, green: 0.35, blue: 0.75, alpha: 1.0)
        let green = NSColor(red: 0.15, green: 0.55, blue: 0.15, alpha: 1.0)
        for x in 7...8 { setPixel(&grid, x: x, y: 0, color: blue) }
        for x in 6...9 { setPixel(&grid, x: x, y: 1, color: blue) }
        for x in 6...9 { setPixel(&grid, x: x, y: 2, color: blue) }
        for x in 5...10 { setPixel(&grid, x: x, y: 3, color: yellow) }
        setPixel(&grid, x: 6, y: 3, color: NSColor.black)
        setPixel(&grid, x: 9, y: 3, color: NSColor.black)
        for x in 5...10 { setPixel(&grid, x: x, y: 4, color: yellow) }
        for x in 5...10 { setPixel(&grid, x: x, y: 5, color: green) }
        for x in 4...11 { setPixel(&grid, x: x, y: 6, color: green) }
        if frame % 2 == 0 {
            setPixel(&grid, x: 5, y: 7, color: yellow)
            setPixel(&grid, x: 10, y: 7, color: yellow)
        } else {
            setPixel(&grid, x: 6, y: 7, color: yellow)
            setPixel(&grid, x: 9, y: 7, color: yellow)
        }
    }

    func drawSimpsonsBart(grid: inout [[NSColor]], frame: Int) {
        let yellow = NSColor(red: 1.0, green: 0.87, blue: 0.15, alpha: 1.0)
        let orange = NSColor(red: 0.9, green: 0.55, blue: 0.1, alpha: 1.0)
        let blue = NSColor(red: 0.1, green: 0.25, blue: 0.65, alpha: 1.0)
        for x in 5...10 { setPixel(&grid, x: x, y: 0, color: yellow) }
        for x in 5...10 { setPixel(&grid, x: x, y: 1, color: yellow) }
        for x in 5...10 { setPixel(&grid, x: x, y: 2, color: yellow) }
        for x in 5...10 { setPixel(&grid, x: x, y: 3, color: yellow) }
        setPixel(&grid, x: 6, y: 3, color: NSColor.black)
        setPixel(&grid, x: 9, y: 3, color: NSColor.black)
        for x in 5...10 { setPixel(&grid, x: x, y: 4, color: yellow) }
        for x in 5...10 { setPixel(&grid, x: x, y: 5, color: orange) }
        for x in 4...11 { setPixel(&grid, x: x, y: 6, color: blue) }
        if frame % 2 == 0 {
            setPixel(&grid, x: 5, y: 7, color: blue)
            setPixel(&grid, x: 10, y: 7, color: blue)
        } else {
            setPixel(&grid, x: 6, y: 7, color: blue)
            setPixel(&grid, x: 9, y: 7, color: blue)
        }
    }

    func drawSimpsonsLisa(grid: inout [[NSColor]], frame: Int) {
        let yellow = NSColor(red: 1.0, green: 0.87, blue: 0.15, alpha: 1.0)
        let red = NSColor(red: 0.85, green: 0.15, blue: 0.1, alpha: 1.0)
        let orange = NSColor(red: 0.9, green: 0.55, blue: 0.1, alpha: 1.0)
        for x in 5...10 { setPixel(&grid, x: x, y: 0, color: yellow) }
        for x in 5...10 { setPixel(&grid, x: x, y: 1, color: yellow) }
        for x in 5...10 { setPixel(&grid, x: x, y: 2, color: yellow) }
        for x in 5...10 { setPixel(&grid, x: x, y: 3, color: yellow) }
        setPixel(&grid, x: 6, y: 3, color: NSColor.black)
        setPixel(&grid, x: 9, y: 3, color: NSColor.black)
        for x in 5...10 { setPixel(&grid, x: x, y: 4, color: yellow) }
        for x in 5...10 { setPixel(&grid, x: x, y: 5, color: red) }
        for x in 4...11 { setPixel(&grid, x: x, y: 6, color: orange) }
        if frame % 2 == 0 {
            setPixel(&grid, x: 5, y: 7, color: orange)
            setPixel(&grid, x: 10, y: 7, color: orange)
        } else {
            setPixel(&grid, x: 6, y: 7, color: orange)
            setPixel(&grid, x: 9, y: 7, color: orange)
        }
    }

    func drawSimpsonsMaggie(grid: inout [[NSColor]], frame: Int) {
        let yellow = NSColor(red: 1.0, green: 0.87, blue: 0.15, alpha: 1.0)
        let blue = NSColor(red: 0.1, green: 0.3, blue: 0.75, alpha: 1.0)
        let lightBlue = NSColor(red: 0.5, green: 0.75, blue: 1.0, alpha: 1.0)
        for x in 6...9 { setPixel(&grid, x: x, y: 1, color: yellow) }
        for x in 5...10 { setPixel(&grid, x: x, y: 2, color: yellow) }
        for x in 5...10 { setPixel(&grid, x: x, y: 3, color: yellow) }
        setPixel(&grid, x: 6, y: 3, color: NSColor.black)
        setPixel(&grid, x: 9, y: 3, color: NSColor.black)
        setPixel(&grid, x: 7, y: 4, color: lightBlue)
        setPixel(&grid, x: 8, y: 4, color: lightBlue)
        for x in 5...10 { setPixel(&grid, x: x, y: 4, color: yellow) }
        for x in 5...10 { setPixel(&grid, x: x, y: 5, color: blue) }
        for x in 4...11 { setPixel(&grid, x: x, y: 6, color: blue) }
        if frame % 2 == 0 {
            setPixel(&grid, x: 5, y: 7, color: yellow)
            setPixel(&grid, x: 10, y: 7, color: yellow)
        } else {
            setPixel(&grid, x: 6, y: 7, color: yellow)
            setPixel(&grid, x: 9, y: 7, color: yellow)
        }
    }

    func drawSimpsonsNedFlanders(grid: inout [[NSColor]], frame: Int) {
        let yellow = NSColor(red: 1.0, green: 0.87, blue: 0.15, alpha: 1.0)
        let green = NSColor(red: 0.15, green: 0.55, blue: 0.15, alpha: 1.0)
        let brown = NSColor(red: 0.55, green: 0.35, blue: 0.1, alpha: 1.0)
        for x in 6...9 { setPixel(&grid, x: x, y: 0, color: brown) }
        for x in 5...10 { setPixel(&grid, x: x, y: 1, color: brown) }
        for x in 5...10 { setPixel(&grid, x: x, y: 2, color: yellow) }
        for x in 5...10 { setPixel(&grid, x: x, y: 3, color: yellow) }
        setPixel(&grid, x: 6, y: 3, color: NSColor.black)
        setPixel(&grid, x: 9, y: 3, color: NSColor.black)
        setPixel(&grid, x: 7, y: 4, color: brown)
        setPixel(&grid, x: 8, y: 4, color: brown)
        for x in 5...10 { setPixel(&grid, x: x, y: 4, color: yellow) }
        for x in 5...10 { setPixel(&grid, x: x, y: 5, color: green) }
        for x in 4...11 { setPixel(&grid, x: x, y: 6, color: green) }
        if frame % 2 == 0 {
            setPixel(&grid, x: 5, y: 7, color: brown)
            setPixel(&grid, x: 10, y: 7, color: brown)
        } else {
            setPixel(&grid, x: 6, y: 7, color: brown)
            setPixel(&grid, x: 9, y: 7, color: brown)
        }
    }

    func drawSimpsonsMrBurns(grid: inout [[NSColor]], frame: Int) {
        let yellow = NSColor(red: 1.0, green: 0.87, blue: 0.15, alpha: 1.0)
        let green = NSColor(red: 0.15, green: 0.5, blue: 0.15, alpha: 1.0)
        let white = NSColor.white
        let gray = NSColor(red: 0.7, green: 0.7, blue: 0.73, alpha: 1.0)
        for x in 6...9 { setPixel(&grid, x: x, y: 0, color: gray) }
        for x in 5...10 { setPixel(&grid, x: x, y: 1, color: yellow) }
        for x in 5...10 { setPixel(&grid, x: x, y: 2, color: yellow) }
        for x in 4...11 { setPixel(&grid, x: x, y: 3, color: yellow) }
        setPixel(&grid, x: 6, y: 3, color: NSColor.black)
        setPixel(&grid, x: 9, y: 3, color: NSColor.black)
        for x in 4...11 { setPixel(&grid, x: x, y: 4, color: yellow) }
        for x in 5...10 { setPixel(&grid, x: x, y: 5, color: green) }
        for x in 4...11 { setPixel(&grid, x: x, y: 6, color: green) }
        if frame % 2 == 0 {
            setPixel(&grid, x: 5, y: 7, color: yellow)
            setPixel(&grid, x: 10, y: 7, color: yellow)
        } else {
            setPixel(&grid, x: 6, y: 7, color: yellow)
            setPixel(&grid, x: 9, y: 7, color: yellow)
        }
    }

    func drawSimpsonsSmithers(grid: inout [[NSColor]], frame: Int) {
        let yellow = NSColor(red: 1.0, green: 0.87, blue: 0.15, alpha: 1.0)
        let brown = NSColor(red: 0.5, green: 0.3, blue: 0.1, alpha: 1.0)
        let white = NSColor.white
        for x in 6...9 { setPixel(&grid, x: x, y: 0, color: brown) }
        for x in 5...10 { setPixel(&grid, x: x, y: 1, color: brown) }
        for x in 5...10 { setPixel(&grid, x: x, y: 2, color: yellow) }
        for x in 5...10 { setPixel(&grid, x: x, y: 3, color: yellow) }
        setPixel(&grid, x: 6, y: 3, color: NSColor.black)
        setPixel(&grid, x: 9, y: 3, color: NSColor.black)
        setPixel(&grid, x: 7, y: 3, color: white)
        setPixel(&grid, x: 8, y: 3, color: white)
        for x in 5...10 { setPixel(&grid, x: x, y: 4, color: yellow) }
        for x in 5...10 { setPixel(&grid, x: x, y: 5, color: white) }
        for x in 4...11 { setPixel(&grid, x: x, y: 6, color: brown) }
        if frame % 2 == 0 {
            setPixel(&grid, x: 5, y: 7, color: brown)
            setPixel(&grid, x: 10, y: 7, color: brown)
        } else {
            setPixel(&grid, x: 6, y: 7, color: brown)
            setPixel(&grid, x: 9, y: 7, color: brown)
        }
    }

    func drawSimpsonsMilhouse(grid: inout [[NSColor]], frame: Int) {
        let yellow = NSColor(red: 1.0, green: 0.87, blue: 0.15, alpha: 1.0)
        let blue = NSColor(red: 0.1, green: 0.3, blue: 0.75, alpha: 1.0)
        let red = NSColor(red: 0.85, green: 0.15, blue: 0.1, alpha: 1.0)
        let white = NSColor.white
        for x in 6...9 { setPixel(&grid, x: x, y: 0, color: blue) }
        for x in 5...10 { setPixel(&grid, x: x, y: 1, color: blue) }
        for x in 5...10 { setPixel(&grid, x: x, y: 2, color: yellow) }
        for x in 5...10 { setPixel(&grid, x: x, y: 3, color: yellow) }
        setPixel(&grid, x: 6, y: 3, color: NSColor.black)
        setPixel(&grid, x: 9, y: 3, color: NSColor.black)
        setPixel(&grid, x: 7, y: 3, color: white)
        setPixel(&grid, x: 8, y: 3, color: white)
        for x in 5...10 { setPixel(&grid, x: x, y: 4, color: yellow) }
        for x in 5...10 { setPixel(&grid, x: x, y: 5, color: red) }
        for x in 4...11 { setPixel(&grid, x: x, y: 6, color: red) }
        if frame % 2 == 0 {
            setPixel(&grid, x: 5, y: 7, color: blue)
            setPixel(&grid, x: 10, y: 7, color: blue)
        } else {
            setPixel(&grid, x: 6, y: 7, color: blue)
            setPixel(&grid, x: 9, y: 7, color: blue)
        }
    }

    func drawSimpsonsNelson(grid: inout [[NSColor]], frame: Int) {
        let yellow = NSColor(red: 1.0, green: 0.87, blue: 0.15, alpha: 1.0)
        let brown = NSColor(red: 0.5, green: 0.3, blue: 0.1, alpha: 1.0)
        let blue = NSColor(red: 0.1, green: 0.25, blue: 0.6, alpha: 1.0)
        for x in 6...9 { setPixel(&grid, x: x, y: 0, color: brown) }
        for x in 5...10 { setPixel(&grid, x: x, y: 1, color: brown) }
        for x in 5...10 { setPixel(&grid, x: x, y: 2, color: yellow) }
        for x in 5...10 { setPixel(&grid, x: x, y: 3, color: yellow) }
        setPixel(&grid, x: 6, y: 3, color: NSColor.black)
        setPixel(&grid, x: 9, y: 3, color: NSColor.black)
        for x in 5...10 { setPixel(&grid, x: x, y: 4, color: yellow) }
        for x in 5...10 { setPixel(&grid, x: x, y: 5, color: brown) }
        for x in 4...11 { setPixel(&grid, x: x, y: 6, color: blue) }
        if frame % 2 == 0 {
            setPixel(&grid, x: 5, y: 7, color: brown)
            setPixel(&grid, x: 10, y: 7, color: brown)
        } else {
            setPixel(&grid, x: 6, y: 7, color: brown)
            setPixel(&grid, x: 9, y: 7, color: brown)
        }
    }

    func drawSimpsonsPrincipalSkinner(grid: inout [[NSColor]], frame: Int) {
        let yellow = NSColor(red: 1.0, green: 0.87, blue: 0.15, alpha: 1.0)
        let gray = NSColor(red: 0.5, green: 0.5, blue: 0.55, alpha: 1.0)
        let brown = NSColor(red: 0.55, green: 0.35, blue: 0.1, alpha: 1.0)
        for x in 6...9 { setPixel(&grid, x: x, y: 0, color: gray) }
        for x in 5...10 { setPixel(&grid, x: x, y: 1, color: gray) }
        for x in 5...10 { setPixel(&grid, x: x, y: 2, color: yellow) }
        for x in 5...10 { setPixel(&grid, x: x, y: 3, color: yellow) }
        setPixel(&grid, x: 6, y: 3, color: NSColor.black)
        setPixel(&grid, x: 9, y: 3, color: NSColor.black)
        for x in 5...10 { setPixel(&grid, x: x, y: 4, color: yellow) }
        for x in 5...10 { setPixel(&grid, x: x, y: 5, color: gray) }
        for x in 4...11 { setPixel(&grid, x: x, y: 6, color: brown) }
        if frame % 2 == 0 {
            setPixel(&grid, x: 5, y: 7, color: gray)
            setPixel(&grid, x: 10, y: 7, color: gray)
        } else {
            setPixel(&grid, x: 6, y: 7, color: gray)
            setPixel(&grid, x: 9, y: 7, color: gray)
        }
    }

    func drawSimpsonsKrusty(grid: inout [[NSColor]], frame: Int) {
        let pink = NSColor(red: 0.95, green: 0.6, blue: 0.65, alpha: 1.0)
        let green = NSColor(red: 0.15, green: 0.55, blue: 0.15, alpha: 1.0)
        let white = NSColor.white
        let red = NSColor(red: 0.85, green: 0.15, blue: 0.1, alpha: 1.0)
        for x in 6...9 { setPixel(&grid, x: x, y: 0, color: white) }
        for x in 5...10 { setPixel(&grid, x: x, y: 1, color: white) }
        for x in 5...10 { setPixel(&grid, x: x, y: 2, color: pink) }
        for x in 5...10 { setPixel(&grid, x: x, y: 3, color: pink) }
        setPixel(&grid, x: 6, y: 3, color: NSColor.black)
        setPixel(&grid, x: 9, y: 3, color: NSColor.black)
        for x in 5...10 { setPixel(&grid, x: x, y: 4, color: pink) }
        for x in 5...10 { setPixel(&grid, x: x, y: 5, color: green) }
        for x in 4...11 { setPixel(&grid, x: x, y: 6, color: red) }
        if frame % 2 == 0 {
            setPixel(&grid, x: 5, y: 7, color: green)
            setPixel(&grid, x: 10, y: 7, color: green)
        } else {
            setPixel(&grid, x: 6, y: 7, color: green)
            setPixel(&grid, x: 9, y: 7, color: green)
        }
    }

    // MARK: - Mortal Kombat
    func drawMKScorpion(grid: inout [[NSColor]], frame: Int) {
        let yellow = NSColor(red: 0.95, green: 0.8, blue: 0.1, alpha: 1.0)
        let darkYellow = NSColor(red: 0.7, green: 0.55, blue: 0.05, alpha: 1.0)
        let brightYellow = NSColor(red: 1.0, green: 0.95, blue: 0.3, alpha: 1.0)
        let black = NSColor(red: 0.1, green: 0.1, blue: 0.12, alpha: 1.0)
        let skin = NSColor(red: 0.95, green: 0.8, blue: 0.65, alpha: 1.0)
        let fire = NSColor(red: 1.0, green: 0.5, blue: 0.0, alpha: 1.0)
        let brightFire = NSColor(red: 1.0, green: 0.8, blue: 0.2, alpha: 1.0)

        // Hood/mask (yellow with black ninja details)
        for x in 6...9 { setPixel(&grid, x: x, y: 0, color: yellow) }
        for x in 5...10 { setPixel(&grid, x: x, y: 1, color: yellow) }
        for x in 4...11 { setPixel(&grid, x: x, y: 2, color: yellow) }

        // Mask wrap lines
        setPixel(&grid, x: 6, y: 0, color: darkYellow)
        setPixel(&grid, x: 9, y: 0, color: darkYellow)

        // Eye slit (dark, narrow)
        for x in 4...11 { setPixel(&grid, x: x, y: 3, color: black) }

        // Eyes (white glowing through slit)
        setPixel(&grid, x: 6, y: 3, color: NSColor(red: 1.0, green: 0.9, blue: 0.5, alpha: 1.0))
        setPixel(&grid, x: 7, y: 3, color: NSColor(red: 1.0, green: 0.9, blue: 0.5, alpha: 1.0))
        setPixel(&grid, x: 8, y: 3, color: NSColor(red: 1.0, green: 0.9, blue: 0.5, alpha: 1.0))
        setPixel(&grid, x: 9, y: 3, color: NSColor(red: 1.0, green: 0.9, blue: 0.5, alpha: 1.0))

        // Lower mask
        for x in 4...11 { setPixel(&grid, x: x, y: 4, color: yellow) }
        setPixel(&grid, x: 7, y: 4, color: darkYellow)
        setPixel(&grid, x: 8, y: 4, color: darkYellow)

        // Torso (yellow ninja vest)
        for x in 3...12 { setPixel(&grid, x: x, y: 5, color: yellow) }
        for x in 3...12 { setPixel(&grid, x: x, y: 6, color: darkYellow) }
        for x in 4...11 { setPixel(&grid, x: x, y: 7, color: yellow) }

        // Ninja belt
        setPixel(&grid, x: 7, y: 6, color: black)
        setPixel(&grid, x: 8, y: 6, color: black)

        // Shoulder guards (black)
        setPixel(&grid, x: 3, y: 5, color: black)
        setPixel(&grid, x: 12, y: 5, color: black)

        // === LEFT ARM (throwing spear!) ===
        setPixel(&grid, x: 2, y: 5, color: yellow)
        setPixel(&grid, x: 2, y: 6, color: yellow)
        setPixel(&grid, x: 1, y: 6, color: yellow)
        setPixel(&grid, x: 1, y: 7, color: darkYellow)
        // Hand
        setPixel(&grid, x: 1, y: 8, color: skin)
        setPixel(&grid, x: 2, y: 8, color: skin)

        // SPEAR (harpoon with chain!)
        setPixel(&grid, x: 1, y: 5, color: NSColor.gray)
        setPixel(&grid, x: 1, y: 4, color: NSColor.gray)
        setPixel(&grid, x: 1, y: 3, color: NSColor.gray)
        setPixel(&grid, x: 1, y: 2, color: NSColor.gray)
        // Spear tip
        setPixel(&grid, x: 1, y: 1, color: NSColor(red: 0.9, green: 0.1, blue: 0.1, alpha: 1.0))
        setPixel(&grid, x: 0, y: 2, color: NSColor.gray)

        // === RIGHT ARM ===
        setPixel(&grid, x: 13, y: 5, color: yellow)
        setPixel(&grid, x: 13, y: 6, color: yellow)
        setPixel(&grid, x: 14, y: 6, color: yellow)
        setPixel(&grid, x: 14, y: 7, color: darkYellow)
        setPixel(&grid, x: 14, y: 8, color: skin)
        setPixel(&grid, x: 15, y: 8, color: skin)

        // === LEGS (yellow) ===
        for x in 4...6 { setPixel(&grid, x: x, y: 8, color: yellow) }
        for x in 9...12 { setPixel(&grid, x: x, y: 8, color: yellow) }
        for x in 4...6 { setPixel(&grid, x: x, y: 9, color: darkYellow) }
        for x in 9...12 { setPixel(&grid, x: x, y: 9, color: darkYellow) }

        // Boots (black)
        for x in 3...6 { setPixel(&grid, x: x, y: 10, color: black) }
        for x in 9...12 { setPixel(&grid, x: x, y: 10, color: black) }

        // === FIRE EFFECT (animated) ===
        let firePhase = frame % 4
        if firePhase == 0 {
            setPixel(&grid, x: 1, y: 0, color: fire)
            setPixel(&grid, x: 0, y: 1, color: brightFire)
        } else if firePhase == 1 {
            setPixel(&grid, x: 0, y: 0, color: brightFire)
            setPixel(&grid, x: 1, y: 0, color: fire)
        } else if firePhase == 2 {
            setPixel(&grid, x: 0, y: 0, color: fire)
            setPixel(&grid, x: 1, y: 1, color: brightFire)
        } else {
            setPixel(&grid, x: 1, y: 0, color: brightFire)
            setPixel(&grid, x: 0, y: 0, color: fire)
        }
    }

    func drawMKSubZero(grid: inout [[NSColor]], frame: Int) {
        let blue = NSColor(red: 0.1, green: 0.3, blue: 0.85, alpha: 1.0)
        let darkBlue = NSColor(red: 0.05, green: 0.15, blue: 0.5, alpha: 1.0)
        let lightBlue = NSColor(red: 0.3, green: 0.6, blue: 1.0, alpha: 1.0)
        let ice = NSColor(red: 0.7, green: 0.9, blue: 1.0, alpha: 1.0)
        let white = NSColor.white
        let black = NSColor(red: 0.1, green: 0.1, blue: 0.12, alpha: 1.0)
        let skin = NSColor(red: 0.95, green: 0.8, blue: 0.65, alpha: 1.0)

        // Hood (blue ninja)
        for x in 6...9 { setPixel(&grid, x: x, y: 0, color: blue) }
        for x in 5...10 { setPixel(&grid, x: x, y: 1, color: blue) }
        for x in 4...11 { setPixel(&grid, x: x, y: 2, color: blue) }
        setPixel(&grid, x: 6, y: 0, color: darkBlue)
        setPixel(&grid, x: 9, y: 0, color: darkBlue)

        // Eye slit
        for x in 4...11 { setPixel(&grid, x: x, y: 3, color: black) }
        // Glowing blue eyes
        setPixel(&grid, x: 6, y: 3, color: lightBlue)
        setPixel(&grid, x: 7, y: 3, color: ice)
        setPixel(&grid, x: 8, y: 3, color: ice)
        setPixel(&grid, x: 9, y: 3, color: lightBlue)

        // Lower mask
        for x in 4...11 { setPixel(&grid, x: x, y: 4, color: blue) }
        setPixel(&grid, x: 7, y: 4, color: darkBlue)
        setPixel(&grid, x: 8, y: 4, color: darkBlue)

        // Torso (blue)
        for x in 3...12 { setPixel(&grid, x: x, y: 5, color: blue) }
        for x in 3...12 { setPixel(&grid, x: x, y: 6, color: darkBlue) }
        for x in 4...11 { setPixel(&grid, x: x, y: 7, color: blue) }
        // Belt
        setPixel(&grid, x: 7, y: 6, color: black)
        setPixel(&grid, x: 8, y: 6, color: black)
        // Shoulder guards
        setPixel(&grid, x: 3, y: 5, color: black)
        setPixel(&grid, x: 12, y: 5, color: black)

        // === LEFT ARM (ice effects) ===
        setPixel(&grid, x: 2, y: 5, color: blue)
        setPixel(&grid, x: 2, y: 6, color: blue)
        setPixel(&grid, x: 1, y: 6, color: blue)
        setPixel(&grid, x: 1, y: 7, color: darkBlue)
        setPixel(&grid, x: 1, y: 8, color: skin)
        setPixel(&grid, x: 2, y: 8, color: skin)

        // Ice shards from hand
        setPixel(&grid, x: 1, y: 5, color: ice)
        setPixel(&grid, x: 0, y: 5, color: ice)
        setPixel(&grid, x: 0, y: 4, color: white)
        setPixel(&grid, x: 1, y: 4, color: ice)
        setPixel(&grid, x: 0, y: 3, color: ice)

        // === RIGHT ARM ===
        setPixel(&grid, x: 13, y: 5, color: blue)
        setPixel(&grid, x: 13, y: 6, color: blue)
        setPixel(&grid, x: 14, y: 6, color: blue)
        setPixel(&grid, x: 14, y: 7, color: darkBlue)
        setPixel(&grid, x: 14, y: 8, color: skin)
        setPixel(&grid, x: 15, y: 8, color: skin)

        // === LEGS ===
        for x in 4...6 { setPixel(&grid, x: x, y: 8, color: blue) }
        for x in 9...12 { setPixel(&grid, x: x, y: 8, color: blue) }
        for x in 4...6 { setPixel(&grid, x: x, y: 9, color: darkBlue) }
        for x in 9...12 { setPixel(&grid, x: x, y: 9, color: darkBlue) }
        // Boots (dark blue)
        for x in 3...6 { setPixel(&grid, x: x, y: 10, color: darkBlue) }
        for x in 9...12 { setPixel(&grid, x: x, y: 10, color: darkBlue) }

        // === ICE FREEZE EFFECT (animated) ===
        let icePhase = frame % 4
        if icePhase == 0 {
            setPixel(&grid, x: 0, y: 3, color: ice)
            setPixel(&grid, x: 15, y: 4, color: ice)
        } else if icePhase == 1 {
            setPixel(&grid, x: 0, y: 4, color: white)
            setPixel(&grid, x: 15, y: 3, color: white)
        } else if icePhase == 2 {
            setPixel(&grid, x: 1, y: 3, color: ice)
            setPixel(&grid, x: 14, y: 4, color: ice)
        } else {
            setPixel(&grid, x: 0, y: 3, color: white)
            setPixel(&grid, x: 15, y: 3, color: ice)
        }
    }

    func drawMKRaiden(grid: inout [[NSColor]], frame: Int) {
        let blue = NSColor(red: 0.1, green: 0.2, blue: 0.7, alpha: 1.0)
        let darkBlue = NSColor(red: 0.05, green: 0.1, blue: 0.45, alpha: 1.0)
        let white = NSColor.white
        let silver = NSColor(red: 0.75, green: 0.75, blue: 0.78, alpha: 1.0)
        let lightning = NSColor(red: 1.0, green: 1.0, blue: 0.4, alpha: 1.0)
        let brightLightning = NSColor(red: 1.0, green: 1.0, blue: 0.8, alpha: 1.0)
        let skin = NSColor(red: 0.95, green: 0.8, blue: 0.65, alpha: 1.0)
        let black = NSColor.black

        // === ICONIC CONICAL HAT ===
        for x in 7...8 { setPixel(&grid, x: x, y: 0, color: blue) }
        for x in 6...9 { setPixel(&grid, x: x, y: 1, color: blue) }
        for x in 5...10 { setPixel(&grid, x: x, y: 2, color: blue) }
        setPixel(&grid, x: 7, y: 0, color: white)
        setPixel(&grid, x: 8, y: 0, color: white)
        setPixel(&grid, x: 5, y: 2, color: darkBlue)
        setPixel(&grid, x: 10, y: 2, color: darkBlue)

        // Hat brim (silver)
        for x in 4...11 { setPixel(&grid, x: x, y: 3, color: silver) }
        setPixel(&grid, x: 4, y: 3, color: white)
        setPixel(&grid, x: 11, y: 3, color: white)

        // Face
        for x in 5...10 { setPixel(&grid, x: x, y: 4, color: skin) }

        // Eyes (glowing white/blue — god of thunder)
        setPixel(&grid, x: 6, y: 4, color: lightning)
        setPixel(&grid, x: 9, y: 4, color: lightning)
        setPixel(&grid, x: 6, y: 4, color: brightLightning)
        setPixel(&grid, x: 9, y: 4, color: brightLightning)

        // Mouth
        setPixel(&grid, x: 7, y: 4, color: skin)
        setPixel(&grid, x: 8, y: 4, color: skin)

        // === BLUE ROBE ===
        for x in 3...12 { setPixel(&grid, x: x, y: 5, color: blue) }
        for x in 3...12 { setPixel(&grid, x: x, y: 6, color: blue) }
        for x in 3...12 { setPixel(&grid, x: x, y: 7, color: darkBlue) }

        // White trim on robe
        setPixel(&grid, x: 3, y: 5, color: white)
        setPixel(&grid, x: 12, y: 5, color: white)

        // === LEFT ARM ===
        setPixel(&grid, x: 2, y: 5, color: blue)
        setPixel(&grid, x: 2, y: 6, color: blue)
        setPixel(&grid, x: 1, y: 6, color: darkBlue)
        setPixel(&grid, x: 1, y: 7, color: darkBlue)
        setPixel(&grid, x: 1, y: 8, color: skin)
        setPixel(&grid, x: 2, y: 8, color: skin)

        // === RIGHT ARM ===
        setPixel(&grid, x: 13, y: 5, color: blue)
        setPixel(&grid, x: 13, y: 6, color: blue)
        setPixel(&grid, x: 14, y: 6, color: darkBlue)
        setPixel(&grid, x: 14, y: 7, color: darkBlue)
        setPixel(&grid, x: 14, y: 8, color: skin)
        setPixel(&grid, x: 15, y: 8, color: skin)

        // === LEGS ===
        for x in 5...7 { setPixel(&grid, x: x, y: 8, color: blue) }
        for x in 8...10 { setPixel(&grid, x: x, y: 8, color: blue) }
        for x in 5...7 { setPixel(&grid, x: x, y: 9, color: darkBlue) }
        for x in 8...10 { setPixel(&grid, x: x, y: 9, color: darkBlue) }
        // Sandals
        for x in 4...7 { setPixel(&grid, x: x, y: 10, color: silver) }
        for x in 8...11 { setPixel(&grid, x: x, y: 10, color: silver) }

        // === LIGHTNING BOLTS (animated!) ===
        let lPhase = frame % 4
        if lPhase == 0 {
            setPixel(&grid, x: 0, y: 4, color: lightning)
            setPixel(&grid, x: 0, y: 3, color: brightLightning)
            setPixel(&grid, x: 15, y: 5, color: lightning)
            setPixel(&grid, x: 15, y: 4, color: brightLightning)
        } else if lPhase == 1 {
            setPixel(&grid, x: 0, y: 5, color: brightLightning)
            setPixel(&grid, x: 15, y: 4, color: brightLightning)
            setPixel(&grid, x: 0, y: 3, color: lightning)
            setPixel(&grid, x: 15, y: 3, color: lightning)
        } else if lPhase == 2 {
            setPixel(&grid, x: 1, y: 4, color: lightning)
            setPixel(&grid, x: 14, y: 5, color: lightning)
        } else {
            setPixel(&grid, x: 0, y: 4, color: brightLightning)
            setPixel(&grid, x: 15, y: 4, color: brightLightning)
            setPixel(&grid, x: 0, y: 5, color: lightning)
            setPixel(&grid, x: 15, y: 3, color: lightning)
        }
    }

    func drawMKLiuKang(grid: inout [[NSColor]], frame: Int) {
        let black = NSColor.black
        let red = NSColor(red: 0.85, green: 0.1, blue: 0.1, alpha: 1.0)
        let darkRed = NSColor(red: 0.6, green: 0.05, blue: 0.05, alpha: 1.0)
        let brightRed = NSColor(red: 0.95, green: 0.2, blue: 0.15, alpha: 1.0)
        let skin = NSColor(red: 0.95, green: 0.8, blue: 0.65, alpha: 1.0)
        let orange = NSColor(red: 1.0, green: 0.5, blue: 0.0, alpha: 1.0)
        let yellow = NSColor(red: 1.0, green: 0.85, blue: 0.0, alpha: 1.0)
        let dragon = NSColor(red: 1.0, green: 0.6, blue: 0.0, alpha: 1.0)

        // Hair (black, flowing)
        for x in 6...9 { setPixel(&grid, x: x, y: 0, color: black) }
        for x in 5...10 { setPixel(&grid, x: x, y: 1, color: black) }
        setPixel(&grid, x: 5, y: 2, color: black)
        setPixel(&grid, x: 10, y: 2, color: black)

        // Face
        for x in 5...10 { setPixel(&grid, x: x, y: 2, color: skin) }
        for x in 5...10 { setPixel(&grid, x: x, y: 3, color: skin) }

        // Eyes (intense, focused)
        setPixel(&grid, x: 6, y: 2, color: black)
        setPixel(&grid, x: 9, y: 2, color: black)
        setPixel(&grid, x: 6, y: 2, color: red)
        setPixel(&grid, x: 9, y: 2, color: red)

        // Mouth
        setPixel(&grid, x: 7, y: 3, color: darkRed)
        setPixel(&grid, x: 8, y: 3, color: darkRed)

        // Headband (red)
        for x in 5...10 { setPixel(&grid, x: x, y: 1, color: red) }
        setPixel(&grid, x: 4, y: 1, color: red)
        setPixel(&grid, x: 11, y: 1, color: red)

        // === BODY (bare chest with red pants) ===
        for x in 3...12 { setPixel(&grid, x: x, y: 4, color: skin) }
        for x in 3...12 { setPixel(&grid, x: x, y: 5, color: skin) }

        // Chest muscles
        setPixel(&grid, x: 5, y: 4, color: darkRed)
        setPixel(&grid, x: 10, y: 4, color: darkRed)
        setPixel(&grid, x: 7, y: 5, color: darkRed)
        setPixel(&grid, x: 8, y: 5, color: darkRed)

        // Pants (red)
        for x in 4...11 { setPixel(&grid, x: x, y: 6, color: red) }

        // === LEFT ARM (fist, fighting stance) ===
        setPixel(&grid, x: 2, y: 4, color: skin)
        setPixel(&grid, x: 2, y: 5, color: skin)
        setPixel(&grid, x: 1, y: 5, color: skin)
        setPixel(&grid, x: 1, y: 6, color: darkRed)
        setPixel(&grid, x: 1, y: 7, color: skin)
        setPixel(&grid, x: 2, y: 7, color: skin)

        // === RIGHT ARM (extended punch) ===
        setPixel(&grid, x: 13, y: 4, color: skin)
        setPixel(&grid, x: 14, y: 4, color: skin)
        setPixel(&grid, x: 15, y: 4, color: skin)
        setPixel(&grid, x: 14, y: 5, color: darkRed)
        setPixel(&grid, x: 15, y: 5, color: skin)

        // === LEGS ===
        for x in 4...6 { setPixel(&grid, x: x, y: 7, color: red) }
        for x in 9...11 { setPixel(&grid, x: x, y: 7, color: red) }
        for x in 4...6 { setPixel(&grid, x: x, y: 8, color: red) }
        for x in 9...11 { setPixel(&grid, x: x, y: 8, color: red) }
        // Black sash
        setPixel(&grid, x: 4, y: 6, color: black)
        setPixel(&grid, x: 11, y: 6, color: black)

        // === DRAGON FIRE EFFECT (animated) ===
        let firePhase = frame % 4
        if firePhase == 0 {
            setPixel(&grid, x: 15, y: 3, color: orange)
            setPixel(&grid, x: 14, y: 3, color: yellow)
            setPixel(&grid, x: 15, y: 2, color: dragon)
        } else if firePhase == 1 {
            setPixel(&grid, x: 15, y: 3, color: yellow)
            setPixel(&grid, x: 14, y: 3, color: dragon)
            setPixel(&grid, x: 15, y: 2, color: orange)
        } else if firePhase == 2 {
            setPixel(&grid, x: 15, y: 3, color: dragon)
            setPixel(&grid, x: 15, y: 2, color: yellow)
            setPixel(&grid, x: 14, y: 2, color: orange)
        } else {
            setPixel(&grid, x: 15, y: 3, color: orange)
            setPixel(&grid, x: 15, y: 2, color: dragon)
        }
    }

    func drawMKSonya(grid: inout [[NSColor]], frame: Int) {
        let green = NSColor(red: 0.1, green: 0.55, blue: 0.15, alpha: 1.0)
        let darkGreen = NSColor(red: 0.05, green: 0.35, blue: 0.08, alpha: 1.0)
        let brightGreen = NSColor(red: 0.2, green: 0.7, blue: 0.3, alpha: 1.0)
        let skin = NSColor(red: 0.95, green: 0.8, blue: 0.65, alpha: 1.0)
        let yellow = NSColor(red: 0.9, green: 0.8, blue: 0.2, alpha: 1.0)
        let blonde = NSColor(red: 0.95, green: 0.85, blue: 0.3, alpha: 1.0)
        let black = NSColor.black
        let white = NSColor.white

        // Blonde hair (ponytail)
        for x in 6...9 { setPixel(&grid, x: x, y: 0, color: blonde) }
        for x in 5...10 { setPixel(&grid, x: x, y: 1, color: blonde) }
        for x in 5...10 { setPixel(&grid, x: x, y: 2, color: blonde) }
        setPixel(&grid, x: 5, y: 0, color: yellow)
        setPixel(&grid, x: 10, y: 0, color: yellow)
        // Ponytail
        setPixel(&grid, x: 10, y: 0, color: blonde)
        setPixel(&grid, x: 11, y: 0, color: blonde)
        setPixel(&grid, x: 11, y: 1, color: blonde)

        // Face
        for x in 5...10 { setPixel(&grid, x: x, y: 3, color: skin) }

        // Eyes (blue)
        setPixel(&grid, x: 6, y: 3, color: NSColor(red: 0.2, green: 0.5, blue: 0.9, alpha: 1.0))
        setPixel(&grid, x: 9, y: 3, color: NSColor(red: 0.2, green: 0.5, blue: 0.9, alpha: 1.0))

        // Mouth
        setPixel(&grid, x: 7, y: 3, color: NSColor(red: 0.8, green: 0.3, blue: 0.3, alpha: 1.0))

        // === GREEN MILITARY OUTFIT ===
        for x in 4...11 { setPixel(&grid, x: x, y: 4, color: green) }
        for x in 3...12 { setPixel(&grid, x: x, y: 5, color: green) }
        for x in 4...11 { setPixel(&grid, x: x, y: 6, color: darkGreen) }

        // Belt (brown)
        for x in 4...11 { setPixel(&grid, x: x, y: 6, color: NSColor(red: 0.5, green: 0.3, blue: 0.1, alpha: 1.0)) }

        // Shoulder straps
        setPixel(&grid, x: 4, y: 4, color: black)
        setPixel(&grid, x: 11, y: 4, color: black)

        // === LEFT ARM ===
        setPixel(&grid, x: 2, y: 4, color: skin)
        setPixel(&grid, x: 2, y: 5, color: skin)
        setPixel(&grid, x: 1, y: 5, color: skin)
        setPixel(&grid, x: 1, y: 6, color: skin)
        setPixel(&grid, x: 1, y: 7, color: skin)
        setPixel(&grid, x: 2, y: 7, color: skin)

        // === RIGHT ARM ===
        setPixel(&grid, x: 13, y: 4, color: skin)
        setPixel(&grid, x: 13, y: 5, color: skin)
        setPixel(&grid, x: 14, y: 5, color: skin)
        setPixel(&grid, x: 14, y: 6, color: skin)
        setPixel(&grid, x: 14, y: 7, color: skin)
        setPixel(&grid, x: 15, y: 7, color: skin)

        // === LEGS (green shorts) ===
        for x in 4...6 { setPixel(&grid, x: x, y: 7, color: green) }
        for x in 9...11 { setPixel(&grid, x: x, y: 7, color: green) }
        // Bare legs
        for x in 4...6 { setPixel(&grid, x: x, y: 8, color: skin) }
        for x in 9...11 { setPixel(&grid, x: x, y: 8, color: skin) }

        // Boots (brown)
        for x in 3...6 { setPixel(&grid, x: x, y: 9, color: NSColor(red: 0.4, green: 0.25, blue: 0.1, alpha: 1.0)) }
        for x in 9...12 { setPixel(&grid, x: x, y: 9, color: NSColor(red: 0.4, green: 0.25, blue: 0.1, alpha: 1.0)) }

        // === ENERGY RING (animated!) ===
        let ringPhase = frame % 4
        if ringPhase == 0 {
            setPixel(&grid, x: 15, y: 6, color: brightGreen)
            setPixel(&grid, x: 15, y: 5, color: green)
        } else if ringPhase == 1 {
            setPixel(&grid, x: 15, y: 6, color: green)
            setPixel(&grid, x: 14, y: 5, color: brightGreen)
        } else if ringPhase == 2 {
            setPixel(&grid, x: 14, y: 6, color: brightGreen)
            setPixel(&grid, x: 15, y: 5, color: green)
        } else {
            setPixel(&grid, x: 15, y: 6, color: green)
            setPixel(&grid, x: 15, y: 5, color: brightGreen)
        }
    }

    func drawMKJohnnyCage(grid: inout [[NSColor]], frame: Int) {
        let brown = NSColor(red: 0.5, green: 0.3, blue: 0.1, alpha: 1.0)
        let darkBrown = NSColor(red: 0.35, green: 0.2, blue: 0.08, alpha: 1.0)
        let green = NSColor(red: 0.1, green: 0.5, blue: 0.15, alpha: 1.0)
        let darkGreen = NSColor(red: 0.05, green: 0.35, blue: 0.08, alpha: 1.0)
        let skin = NSColor(red: 0.95, green: 0.8, blue: 0.65, alpha: 1.0)
        let black = NSColor.black
        let white = NSColor.white
        let gold = NSColor(red: 1.0, green: 0.8, blue: 0.0, alpha: 1.0)

        // Hair (brown, slicked back)
        for x in 6...9 { setPixel(&grid, x: x, y: 0, color: brown) }
        for x in 5...10 { setPixel(&grid, x: x, y: 1, color: brown) }
        setPixel(&grid, x: 5, y: 1, color: darkBrown)
        setPixel(&grid, x: 10, y: 1, color: darkBrown)

        // Face
        for x in 5...10 { setPixel(&grid, x: x, y: 2, color: skin) }
        for x in 5...10 { setPixel(&grid, x: x, y: 3, color: skin) }

        // SUNGLASSES (iconic!)
        setPixel(&grid, x: 6, y: 2, color: black)
        setPixel(&grid, x: 7, y: 2, color: black)
        setPixel(&grid, x: 8, y: 2, color: black)
        setPixel(&grid, x: 9, y: 2, color: black)
        setPixel(&grid, x: 6, y: 2, color: NSColor(red: 0.1, green: 0.1, blue: 0.2, alpha: 1.0))
        setPixel(&grid, x: 9, y: 2, color: NSColor(red: 0.1, green: 0.1, blue: 0.2, alpha: 1.0))
        // Glasses shine
        setPixel(&grid, x: 6, y: 2, color: NSColor(red: 0.3, green: 0.3, blue: 0.4, alpha: 1.0))

        // Smirk
        setPixel(&grid, x: 7, y: 3, color: darkBrown)
        setPixel(&grid, x: 8, y: 3, color: skin)

        // Chin
        setPixel(&grid, x: 7, y: 3, color: skin)
        setPixel(&grid, x: 8, y: 3, color: skin)

        // === GREEN FIGHTING SUIT ===
        for x in 3...12 { setPixel(&grid, x: x, y: 4, color: green) }
        for x in 3...12 { setPixel(&grid, x: x, y: 5, color: green) }
        for x in 4...11 { setPixel(&grid, x: x, y: 6, color: darkGreen) }

        // Chest detail
        setPixel(&grid, x: 7, y: 4, color: darkGreen)
        setPixel(&grid, x: 8, y: 4, color: darkGreen)

        // Gold trim
        setPixel(&grid, x: 3, y: 4, color: gold)
        setPixel(&grid, x: 12, y: 4, color: gold)

        // === LEFT ARM (punching!) ===
        setPixel(&grid, x: 2, y: 4, color: skin)
        setPixel(&grid, x: 2, y: 5, color: skin)
        setPixel(&grid, x: 1, y: 5, color: skin)
        setPixel(&grid, x: 1, y: 6, color: skin)
        setPixel(&grid, x: 1, y: 7, color: skin)
        setPixel(&grid, x: 2, y: 7, color: skin)

        // === RIGHT ARM (shadow kick stance) ===
        setPixel(&grid, x: 13, y: 4, color: skin)
        setPixel(&grid, x: 14, y: 4, color: skin)
        setPixel(&grid, x: 15, y: 4, color: skin)
        setPixel(&grid, x: 14, y: 5, color: green)
        setPixel(&grid, x: 15, y: 5, color: skin)

        // === LEGS ===
        for x in 4...6 { setPixel(&grid, x: x, y: 7, color: green) }
        for x in 9...11 { setPixel(&grid, x: x, y: 7, color: green) }
        for x in 4...6 { setPixel(&grid, x: x, y: 8, color: darkGreen) }
        for x in 9...11 { setPixel(&grid, x: x, y: 8, color: darkGreen) }
        // Boots
        for x in 3...6 { setPixel(&grid, x: x, y: 9, color: black) }
        for x in 9...12 { setPixel(&grid, x: x, y: 9, color: black) }

        // === NUT PUNCH EFFECT (animated!) ===
        let punchPhase = frame % 4
        if punchPhase == 0 {
            setPixel(&grid, x: 1, y: 4, color: gold)
            setPixel(&grid, x: 0, y: 4, color: gold)
        } else if punchPhase == 1 {
            setPixel(&grid, x: 0, y: 3, color: gold)
            setPixel(&grid, x: 0, y: 5, color: gold)
        } else if punchPhase == 2 {
            setPixel(&grid, x: 1, y: 3, color: gold)
            setPixel(&grid, x: 1, y: 5, color: gold)
        }
    }

    func drawMKShangTsung(grid: inout [[NSColor]], frame: Int) {
        let gray = NSColor(red: 0.6, green: 0.6, blue: 0.63, alpha: 1.0)
        let darkGray = NSColor(red: 0.4, green: 0.4, blue: 0.43, alpha: 1.0)
        let black = NSColor.black
        let white = NSColor.white
        let skin = NSColor(red: 0.9, green: 0.75, blue: 0.6, alpha: 1.0)
        let darkSkin = NSColor(red: 0.7, green: 0.55, blue: 0.4, alpha: 1.0)
        let evil = NSColor(red: 0.6, green: 0.0, blue: 0.0, alpha: 1.0)

        // Grey/white hair (sorcerer)
        for x in 6...9 { setPixel(&grid, x: x, y: 0, color: gray) }
        for x in 5...10 { setPixel(&grid, x: x, y: 1, color: gray) }
        setPixel(&grid, x: 5, y: 0, color: white)
        setPixel(&grid, x: 10, y: 0, color: white)

        // Face (aged, sinister)
        for x in 5...10 { setPixel(&grid, x: x, y: 2, color: skin) }
        for x in 5...10 { setPixel(&grid, x: x, y: 3, color: skin) }

        // Eyes (red, soul-stealing)
        setPixel(&grid, x: 6, y: 2, color: evil)
        setPixel(&grid, x: 9, y: 2, color: evil)
        setPixel(&grid, x: 6, y: 2, color: white)
        setPixel(&grid, x: 9, y: 2, color: white)
        setPixel(&grid, x: 6, y: 2, color: evil)
        setPixel(&grid, x: 9, y: 2, color: evil)

        // Evil grin
        setPixel(&grid, x: 7, y: 3, color: black)
        setPixel(&grid, x: 8, y: 3, color: black)

        // Wrinkles
        setPixel(&grid, x: 5, y: 2, color: darkSkin)
        setPixel(&grid, x: 10, y: 2, color: darkSkin)

        // === DARK ROBES ===
        for x in 2...13 { setPixel(&grid, x: x, y: 4, color: black) }
        for x in 1...14 { setPixel(&grid, x: x, y: 5, color: black) }
        for x in 2...13 { setPixel(&grid, x: x, y: 6, color: darkGray) }

        // Red trim
        setPixel(&grid, x: 2, y: 4, color: evil)
        setPixel(&grid, x: 13, y: 4, color: evil)
        setPixel(&grid, x: 1, y: 5, color: evil)
        setPixel(&grid, x: 14, y: 5, color: evil)

        // === LEFT ARM ===
        setPixel(&grid, x: 1, y: 4, color: black)
        setPixel(&grid, x: 1, y: 5, color: black)
        setPixel(&grid, x: 0, y: 5, color: black)
        setPixel(&grid, x: 0, y: 6, color: darkGray)
        setPixel(&grid, x: 0, y: 7, color: skin)
        setPixel(&grid, x: 1, y: 7, color: skin)

        // === RIGHT ARM (soul steal) ===
        setPixel(&grid, x: 14, y: 4, color: black)
        setPixel(&grid, x: 15, y: 4, color: black)
        setPixel(&grid, x: 15, y: 5, color: black)
        setPixel(&grid, x: 15, y: 6, color: darkGray)
        setPixel(&grid, x: 15, y: 7, color: skin)
        setPixel(&grid, x: 14, y: 7, color: skin)

        // === LEGS ===
        for x in 4...6 { setPixel(&grid, x: x, y: 7, color: black) }
        for x in 9...11 { setPixel(&grid, x: x, y: 7, color: black) }
        for x in 4...6 { setPixel(&grid, x: x, y: 8, color: darkGray) }
        for x in 9...11 { setPixel(&grid, x: x, y: 8, color: darkGray) }
        // Boots
        for x in 3...6 { setPixel(&grid, x: x, y: 9, color: black) }
        for x in 9...12 { setPixel(&grid, x: x, y: 9, color: black) }

        // === SOUL EFFECT (animated!) ===
        let soulPhase = frame % 4
        if soulPhase == 0 {
            setPixel(&grid, x: 0, y: 4, color: NSColor(red: 0.0, green: 0.8, blue: 0.8, alpha: 1.0))
            setPixel(&grid, x: 0, y: 3, color: NSColor(red: 0.2, green: 1.0, blue: 1.0, alpha: 1.0))
        } else if soulPhase == 1 {
            setPixel(&grid, x: 0, y: 3, color: NSColor(red: 0.0, green: 0.6, blue: 0.6, alpha: 1.0))
            setPixel(&grid, x: 1, y: 3, color: NSColor(red: 0.2, green: 1.0, blue: 1.0, alpha: 1.0))
        } else if soulPhase == 2 {
            setPixel(&grid, x: 1, y: 4, color: NSColor(red: 0.0, green: 0.8, blue: 0.8, alpha: 1.0))
        }
    }

    func drawMKGoro(grid: inout [[NSColor]], frame: Int) {
        let brown = NSColor(red: 0.6, green: 0.35, blue: 0.15, alpha: 1.0)
        let darkBrown = NSColor(red: 0.4, green: 0.25, blue: 0.1, alpha: 1.0)
        let brightBrown = NSColor(red: 0.75, green: 0.45, blue: 0.2, alpha: 1.0)
        let skin = NSColor(red: 0.95, green: 0.8, blue: 0.65, alpha: 1.0)
        let black = NSColor.black
        let white = NSColor.white
        let red = NSColor(red: 0.8, green: 0.1, blue: 0.1, alpha: 1.0)

        // === HEAD (huge, four-eyed Shokan) ===
        for x in 5...10 { setPixel(&grid, x: x, y: 0, color: brown) }
        for x in 4...11 { setPixel(&grid, x: x, y: 1, color: brown) }
        for x in 4...11 { setPixel(&grid, x: x, y: 2, color: brown) }
        for x in 4...11 { setPixel(&grid, x: x, y: 3, color: brown) }

        // Eyes (red, menacing)
        setPixel(&grid, x: 6, y: 2, color: red)
        setPixel(&grid, x: 9, y: 2, color: red)
        setPixel(&grid, x: 6, y: 2, color: black)
        setPixel(&grid, x: 9, y: 2, color: black)
        setPixel(&grid, x: 6, y: 2, color: red)
        setPixel(&grid, x: 9, y: 2, color: red)

        // Brow ridge
        setPixel(&grid, x: 5, y: 2, color: darkBrown)
        setPixel(&grid, x: 10, y: 2, color: darkBrown)

        // Mouth (fangs)
        setPixel(&grid, x: 6, y: 3, color: black)
        setPixel(&grid, x: 7, y: 3, color: black)
        setPixel(&grid, x: 8, y: 3, color: black)
        setPixel(&grid, x: 9, y: 3, color: black)
        setPixel(&grid, x: 7, y: 3, color: white)
        setPixel(&grid, x: 9, y: 3, color: white)

        // === FOUR ARMS (iconic!) ===
        // Upper left arm
        setPixel(&grid, x: 3, y: 3, color: brown)
        setPixel(&grid, x: 3, y: 4, color: brown)
        setPixel(&grid, x: 2, y: 4, color: brown)
        setPixel(&grid, x: 2, y: 5, color: brown)
        setPixel(&grid, x: 2, y: 6, color: skin)
        setPixel(&grid, x: 3, y: 6, color: skin)

        // Upper right arm
        setPixel(&grid, x: 12, y: 3, color: brown)
        setPixel(&grid, x: 12, y: 4, color: brown)
        setPixel(&grid, x: 13, y: 4, color: brown)
        setPixel(&grid, x: 13, y: 5, color: brown)
        setPixel(&grid, x: 13, y: 6, color: skin)
        setPixel(&grid, x: 12, y: 6, color: skin)

        // Lower left arm
        setPixel(&grid, x: 3, y: 5, color: brown)
        setPixel(&grid, x: 3, y: 6, color: brown)
        setPixel(&grid, x: 2, y: 7, color: brown)
        setPixel(&grid, x: 1, y: 7, color: skin)
        setPixel(&grid, x: 2, y: 8, color: skin)

        // Lower right arm
        setPixel(&grid, x: 12, y: 5, color: brown)
        setPixel(&grid, x: 12, y: 6, color: brown)
        setPixel(&grid, x: 13, y: 7, color: brown)
        setPixel(&grid, x: 14, y: 7, color: skin)
        setPixel(&grid, x: 13, y: 8, color: skin)

        // === BODY (massive, brown, muscular) ===
        for x in 4...11 { setPixel(&grid, x: x, y: 4, color: brown) }
        for x in 3...12 { setPixel(&grid, x: x, y: 5, color: brown) }
        for x in 3...12 { setPixel(&grid, x: x, y: 6, color: darkBrown) }
        for x in 4...11 { setPixel(&grid, x: x, y: 7, color: brown) }

        // Chest muscles
        setPixel(&grid, x: 6, y: 5, color: brightBrown)
        setPixel(&grid, x: 9, y: 5, color: brightBrown)
        setPixel(&grid, x: 7, y: 5, color: brightBrown)
        setPixel(&grid, x: 8, y: 5, color: brightBrown)

        // Belt (loincloth)
        for x in 5...10 { setPixel(&grid, x: x, y: 7, color: NSColor(red: 0.5, green: 0.3, blue: 0.1, alpha: 1.0)) }

        // === LEGS (massive) ===
        for x in 3...6 { setPixel(&grid, x: x, y: 8, color: brown) }
        for x in 9...12 { setPixel(&grid, x: x, y: 8, color: brown) }
        for x in 3...6 { setPixel(&grid, x: x, y: 9, color: darkBrown) }
        for x in 9...12 { setPixel(&grid, x: x, y: 9, color: darkBrown) }
        // Feet
        for x in 2...6 { setPixel(&grid, x: x, y: 10, color: brown) }
        for x in 9...13 { setPixel(&grid, x: x, y: 10, color: brown) }
    }

    func drawMKKitana(grid: inout [[NSColor]], frame: Int) {
        let blue = NSColor(red: 0.1, green: 0.35, blue: 0.85, alpha: 1.0)
        let darkBlue = NSColor(red: 0.05, green: 0.2, blue: 0.55, alpha: 1.0)
        let brightBlue = NSColor(red: 0.2, green: 0.5, blue: 1.0, alpha: 1.0)
        let skin = NSColor(red: 0.95, green: 0.8, blue: 0.65, alpha: 1.0)
        let black = NSColor.black
        let white = NSColor.white
        let silver = NSColor(red: 0.8, green: 0.8, blue: 0.85, alpha: 1.0)

        // Blue tiara/mask
        for x in 6...9 { setPixel(&grid, x: x, y: 0, color: blue) }
        for x in 5...10 { setPixel(&grid, x: x, y: 1, color: blue) }
        setPixel(&grid, x: 6, y: 0, color: brightBlue)
        setPixel(&grid, x: 9, y: 0, color: brightBlue)
        // Tiara points
        setPixel(&grid, x: 5, y: 0, color: silver)
        setPixel(&grid, x: 10, y: 0, color: silver)

        // Hair (black, flowing)
        setPixel(&grid, x: 4, y: 1, color: black)
        setPixel(&grid, x: 11, y: 1, color: black)
        setPixel(&grid, x: 4, y: 2, color: black)
        setPixel(&grid, x: 11, y: 2, color: black)

        // Face
        for x in 5...10 { setPixel(&grid, x: x, y: 2, color: skin) }
        for x in 5...10 { setPixel(&grid, x: x, y: 3, color: skin) }

        // Eyes (blue, princess)
        setPixel(&grid, x: 6, y: 2, color: brightBlue)
        setPixel(&grid, x: 9, y: 2, color: brightBlue)

        // Mouth
        setPixel(&grid, x: 7, y: 3, color: NSColor(red: 0.8, green: 0.3, blue: 0.4, alpha: 1.0))

        // === BLUE OUTFIT (revealing, warrior princess) ===
        for x in 4...11 { setPixel(&grid, x: x, y: 4, color: blue) }
        for x in 3...12 { setPixel(&grid, x: x, y: 5, color: blue) }
        for x in 4...11 { setPixel(&grid, x: x, y: 6, color: darkBlue) }

        // Cleavage detail
        setPixel(&grid, x: 7, y: 4, color: skin)
        setPixel(&grid, x: 8, y: 4, color: skin)

        // Belt (silver)
        for x in 4...11 { setPixel(&grid, x: x, y: 6, color: silver) }

        // === LEFT ARM (holding fan) ===
        setPixel(&grid, x: 2, y: 4, color: skin)
        setPixel(&grid, x: 2, y: 5, color: skin)
        setPixel(&grid, x: 1, y: 5, color: skin)
        setPixel(&grid, x: 1, y: 6, color: skin)
        setPixel(&grid, x: 1, y: 7, color: skin)
        setPixel(&grid, x: 2, y: 7, color: skin)

        // FAN (steel, sharp!)
        setPixel(&grid, x: 0, y: 4, color: silver)
        setPixel(&grid, x: 0, y: 5, color: silver)
        setPixel(&grid, x: 0, y: 6, color: silver)
        setPixel(&grid, x: 1, y: 4, color: white)
        setPixel(&grid, x: 1, y: 5, color: white)

        // === RIGHT ARM ===
        setPixel(&grid, x: 13, y: 4, color: skin)
        setPixel(&grid, x: 13, y: 5, color: skin)
        setPixel(&grid, x: 14, y: 5, color: skin)
        setPixel(&grid, x: 14, y: 6, color: skin)
        setPixel(&grid, x: 14, y: 7, color: skin)
        setPixel(&grid, x: 15, y: 7, color: skin)

        // === LEGS (blue, bare) ===
        for x in 4...6 { setPixel(&grid, x: x, y: 7, color: blue) }
        for x in 9...11 { setPixel(&grid, x: x, y: 7, color: blue) }
        for x in 4...6 { setPixel(&grid, x: x, y: 8, color: skin) }
        for x in 9...11 { setPixel(&grid, x: x, y: 8, color: skin) }

        // Boots (blue, tall)
        for x in 3...6 { setPixel(&grid, x: x, y: 9, color: darkBlue) }
        for x in 9...12 { setPixel(&grid, x: x, y: 9, color: darkBlue) }

        // === FAN THROW EFFECT (animated) ===
        let fanPhase = frame % 4
        if fanPhase == 0 {
            setPixel(&grid, x: 0, y: 3, color: silver)
            setPixel(&grid, x: 0, y: 2, color: white)
        } else if fanPhase == 1 {
            setPixel(&grid, x: 0, y: 2, color: silver)
            setPixel(&grid, x: 1, y: 2, color: white)
        } else if fanPhase == 2 {
            setPixel(&grid, x: 1, y: 3, color: silver)
        }
    }

    func drawMKJade(grid: inout [[NSColor]], frame: Int) {
        let green = NSColor(red: 0.1, green: 0.6, blue: 0.2, alpha: 1.0)
        let darkGreen = NSColor(red: 0.05, green: 0.4, blue: 0.1, alpha: 1.0)
        let brightGreen = NSColor(red: 0.2, green: 0.8, blue: 0.35, alpha: 1.0)
        let skin = NSColor(red: 0.95, green: 0.8, blue: 0.65, alpha: 1.0)
        let black = NSColor.black
        let silver = NSColor(red: 0.8, green: 0.8, blue: 0.85, alpha: 1.0)
        let white = NSColor.white

        // Green headband
        for x in 6...9 { setPixel(&grid, x: x, y: 0, color: green) }
        for x in 5...10 { setPixel(&grid, x: x, y: 1, color: green) }
        setPixel(&grid, x: 5, y: 0, color: brightGreen)
        setPixel(&grid, x: 10, y: 0, color: brightGreen)

        // Hair (black)
        setPixel(&grid, x: 4, y: 1, color: black)
        setPixel(&grid, x: 11, y: 1, color: black)
        setPixel(&grid, x: 4, y: 2, color: black)
        setPixel(&grid, x: 11, y: 2, color: black)

        // Face
        for x in 5...10 { setPixel(&grid, x: x, y: 2, color: skin) }
        for x in 5...10 { setPixel(&grid, x: x, y: 3, color: skin) }

        // Eyes (green)
        setPixel(&grid, x: 6, y: 2, color: brightGreen)
        setPixel(&grid, x: 9, y: 2, color: brightGreen)

        // Mouth
        setPixel(&grid, x: 7, y: 3, color: NSColor(red: 0.7, green: 0.2, blue: 0.3, alpha: 1.0))

        // === GREEN OUTFIT ===
        for x in 4...11 { setPixel(&grid, x: x, y: 4, color: green) }
        for x in 3...12 { setPixel(&grid, x: x, y: 5, color: green) }
        for x in 4...11 { setPixel(&grid, x: x, y: 6, color: darkGreen) }

        // Silver trim
        setPixel(&grid, x: 3, y: 5, color: silver)
        setPixel(&grid, x: 12, y: 5, color: silver)

        // === LEFT ARM ===
        setPixel(&grid, x: 2, y: 4, color: skin)
        setPixel(&grid, x: 2, y: 5, color: skin)
        setPixel(&grid, x: 1, y: 5, color: skin)
        setPixel(&grid, x: 1, y: 6, color: skin)
        setPixel(&grid, x: 1, y: 7, color: skin)
        setPixel(&grid, x: 2, y: 7, color: skin)

        // === RIGHT ARM ===
        setPixel(&grid, x: 13, y: 4, color: skin)
        setPixel(&grid, x: 13, y: 5, color: skin)
        setPixel(&grid, x: 14, y: 5, color: skin)
        setPixel(&grid, x: 14, y: 6, color: skin)
        setPixel(&grid, x: 14, y: 7, color: skin)
        setPixel(&grid, x: 15, y: 7, color: skin)

        // STAFF (silver, held in right hand)
        setPixel(&grid, x: 15, y: 6, color: silver)
        setPixel(&grid, x: 15, y: 5, color: silver)
        setPixel(&grid, x: 15, y: 4, color: silver)
        setPixel(&grid, x: 15, y: 3, color: silver)
        setPixel(&grid, x: 15, y: 2, color: brightGreen)
        setPixel(&grid, x: 15, y: 1, color: brightGreen)

        // === LEGS ===
        for x in 4...6 { setPixel(&grid, x: x, y: 7, color: green) }
        for x in 9...11 { setPixel(&grid, x: x, y: 7, color: green) }
        for x in 4...6 { setPixel(&grid, x: x, y: 8, color: skin) }
        for x in 9...11 { setPixel(&grid, x: x, y: 8, color: skin) }
        // Boots (green)
        for x in 3...6 { setPixel(&grid, x: x, y: 9, color: darkGreen) }
        for x in 9...12 { setPixel(&grid, x: x, y: 9, color: darkGreen) }

        // === STAFF GLOW (animated) ===
        let glowPhase = frame % 4
        if glowPhase == 0 {
            setPixel(&grid, x: 15, y: 1, color: white)
        } else if glowPhase == 2 {
            setPixel(&grid, x: 15, y: 0, color: brightGreen)
        }
    }

    func drawMKMilena(grid: inout [[NSColor]], frame: Int) {
        let pink = NSColor(red: 0.85, green: 0.2, blue: 0.5, alpha: 1.0)
        let darkPink = NSColor(red: 0.65, green: 0.1, blue: 0.35, alpha: 1.0)
        let brightPink = NSColor(red: 0.95, green: 0.35, blue: 0.65, alpha: 1.0)
        let skin = NSColor(red: 0.95, green: 0.8, blue: 0.65, alpha: 1.0)
        let black = NSColor.black
        let white = NSColor.white
        let red = NSColor(red: 0.8, green: 0.1, blue: 0.1, alpha: 1.0)

        // Pink mask (covers face like Kitana but tattered)
        for x in 6...9 { setPixel(&grid, x: x, y: 0, color: pink) }
        for x in 5...10 { setPixel(&grid, x: x, y: 1, color: pink) }
        for x in 4...11 { setPixel(&grid, x: x, y: 2, color: pink) }

        // Hair (black, wild)
        setPixel(&grid, x: 4, y: 0, color: black)
        setPixel(&grid, x: 11, y: 0, color: black)
        setPixel(&grid, x: 4, y: 1, color: black)
        setPixel(&grid, x: 11, y: 1, color: black)

        // Eye holes (dark, showing skin through mask)
        for x in 5...10 { setPixel(&grid, x: x, y: 3, color: pink) }
        setPixel(&grid, x: 6, y: 2, color: black)
        setPixel(&grid, x: 7, y: 2, color: black)
        setPixel(&grid, x: 8, y: 2, color: black)
        setPixel(&grid, x: 9, y: 2, color: black)

        // Eyes (red, feral — she's half-tarkatan!)
        setPixel(&grid, x: 6, y: 2, color: red)
        setPixel(&grid, x: 7, y: 2, color: red)
        setPixel(&grid, x: 8, y: 2, color: red)
        setPixel(&grid, x: 9, y: 2, color: red)

        // Mask lower (showing mouth through tear)
        setPixel(&grid, x: 7, y: 3, color: skin)
        setPixel(&grid, x: 8, y: 3, color: skin)
        // Fangs!
        setPixel(&grid, x: 7, y: 3, color: white)
        setPixel(&grid, x: 8, y: 3, color: white)

        // === PINK OUTFIT ===
        for x in 4...11 { setPixel(&grid, x: x, y: 4, color: pink) }
        for x in 3...12 { setPixel(&grid, x: x, y: 5, color: pink) }
        for x in 4...11 { setPixel(&grid, x: x, y: 6, color: darkPink) }

        // Sai weapons on belt
        setPixel(&grid, x: 5, y: 6, color: NSColor.gray)
        setPixel(&grid, x: 10, y: 6, color: NSColor.gray)

        // === LEFT ARM ===
        setPixel(&grid, x: 2, y: 4, color: skin)
        setPixel(&grid, x: 2, y: 5, color: skin)
        setPixel(&grid, x: 1, y: 5, color: skin)
        setPixel(&grid, x: 1, y: 6, color: skin)
        setPixel(&grid, x: 1, y: 7, color: skin)
        setPixel(&grid, x: 2, y: 7, color: skin)

        // Sai (pronged dagger)
        setPixel(&grid, x: 1, y: 4, color: NSColor.gray)
        setPixel(&grid, x: 1, y: 3, color: NSColor.gray)
        setPixel(&grid, x: 0, y: 3, color: NSColor.gray)
        setPixel(&grid, x: 1, y: 2, color: white)

        // === RIGHT ARM ===
        setPixel(&grid, x: 13, y: 4, color: skin)
        setPixel(&grid, x: 13, y: 5, color: skin)
        setPixel(&grid, x: 14, y: 5, color: skin)
        setPixel(&grid, x: 14, y: 6, color: skin)
        setPixel(&grid, x: 14, y: 7, color: skin)
        setPixel(&grid, x: 15, y: 7, color: skin)

        // === LEGS ===
        for x in 4...6 { setPixel(&grid, x: x, y: 7, color: pink) }
        for x in 9...11 { setPixel(&grid, x: x, y: 7, color: pink) }
        for x in 4...6 { setPixel(&grid, x: x, y: 8, color: skin) }
        for x in 9...11 { setPixel(&grid, x: x, y: 8, color: skin) }
        // Boots (pink)
        for x in 3...6 { setPixel(&grid, x: x, y: 9, color: darkPink) }
        for x in 9...12 { setPixel(&grid, x: x, y: 9, color: darkPink) }

        // === BLOOD EFFECT (animated — she's savage!) ===
        let bloodPhase = frame % 4
        if bloodPhase == 0 {
            setPixel(&grid, x: 7, y: 4, color: red)
            setPixel(&grid, x: 8, y: 4, color: red)
        } else if bloodPhase == 1 {
            setPixel(&grid, x: 7, y: 4, color: darkPink)
            setPixel(&grid, x: 8, y: 5, color: red)
        } else if bloodPhase == 2 {
            setPixel(&grid, x: 7, y: 5, color: red)
        }
    }

    func drawMKReptile(grid: inout [[NSColor]], frame: Int) {
        let green = NSColor(red: 0.15, green: 0.6, blue: 0.15, alpha: 1.0)
        let darkGreen = NSColor(red: 0.08, green: 0.4, blue: 0.08, alpha: 1.0)
        let brightGreen = NSColor(red: 0.3, green: 0.8, blue: 0.3, alpha: 1.0)
        let yellow = NSColor(red: 0.9, green: 0.85, blue: 0.1, alpha: 1.0)
        let black = NSColor.black
        let white = NSColor.white
        let acid = NSColor(red: 0.4, green: 1.0, blue: 0.2, alpha: 1.0)

        // Reptilian head (scaly green)
        for x in 6...9 { setPixel(&grid, x: x, y: 0, color: green) }
        for x in 5...10 { setPixel(&grid, x: x, y: 1, color: green) }
        for x in 4...11 { setPixel(&grid, x: x, y: 2, color: green) }
        setPixel(&grid, x: 5, y: 0, color: darkGreen)
        setPixel(&grid, x: 10, y: 0, color: darkGreen)

        // Mask (green, reptilian)
        for x in 4...11 { setPixel(&grid, x: x, y: 3, color: darkGreen) }

        // Eyes (yellow, reptilian slits)
        setPixel(&grid, x: 6, y: 2, color: yellow)
        setPixel(&grid, x: 9, y: 2, color: yellow)
        setPixel(&grid, x: 6, y: 2, color: black)
        setPixel(&grid, x: 9, y: 2, color: black)
        setPixel(&grid, x: 6, y: 2, color: yellow)
        setPixel(&grid, x: 9, y: 2, color: yellow)

        // Reptile snout
        setPixel(&grid, x: 7, y: 3, color: green)
        setPixel(&grid, x: 8, y: 3, color: green)

        // === GREEN BODY ===
        for x in 3...12 { setPixel(&grid, x: x, y: 4, color: green) }
        for x in 3...12 { setPixel(&grid, x: x, y: 5, color: green) }
        for x in 4...11 { setPixel(&grid, x: x, y: 6, color: darkGreen) }

        // Scale pattern
        setPixel(&grid, x: 5, y: 4, color: brightGreen)
        setPixel(&grid, x: 10, y: 4, color: brightGreen)
        setPixel(&grid, x: 6, y: 5, color: brightGreen)
        setPixel(&grid, x: 9, y: 5, color: brightGreen)

        // Belt
        setPixel(&grid, x: 7, y: 6, color: black)
        setPixel(&grid, x: 8, y: 6, color: black)

        // === LEFT ARM ===
        setPixel(&grid, x: 2, y: 4, color: green)
        setPixel(&grid, x: 2, y: 5, color: green)
        setPixel(&grid, x: 1, y: 5, color: green)
        setPixel(&grid, x: 1, y: 6, color: darkGreen)
        setPixel(&grid, x: 1, y: 7, color: green)
        setPixel(&grid, x: 2, y: 7, color: green)
        // Claws
        setPixel(&grid, x: 1, y: 7, color: yellow)
        setPixel(&grid, x: 0, y: 7, color: yellow)

        // === RIGHT ARM ===
        setPixel(&grid, x: 13, y: 4, color: green)
        setPixel(&grid, x: 13, y: 5, color: green)
        setPixel(&grid, x: 14, y: 5, color: green)
        setPixel(&grid, x: 14, y: 6, color: darkGreen)
        setPixel(&grid, x: 14, y: 7, color: green)
        setPixel(&grid, x: 15, y: 7, color: green)
        // Claws
        setPixel(&grid, x: 15, y: 7, color: yellow)
        setPixel(&grid, x: 15, y: 6, color: yellow)

        // === LEGS ===
        for x in 4...6 { setPixel(&grid, x: x, y: 7, color: green) }
        for x in 9...11 { setPixel(&grid, x: x, y: 7, color: green) }
        for x in 4...6 { setPixel(&grid, x: x, y: 8, color: darkGreen) }
        for x in 9...11 { setPixel(&grid, x: x, y: 8, color: darkGreen) }
        // Feet (reptilian)
        for x in 3...6 { setPixel(&grid, x: x, y: 9, color: darkGreen) }
        for x in 9...12 { setPixel(&grid, x: x, y: 9, color: darkGreen) }
        setPixel(&grid, x: 3, y: 9, color: yellow)
        setPixel(&grid, x: 12, y: 9, color: yellow)

        // === ACID SPIT EFFECT (animated!) ===
        let acidPhase = frame % 4
        if acidPhase == 0 {
            setPixel(&grid, x: 7, y: 3, color: acid)
            setPixel(&grid, x: 8, y: 3, color: acid)
        } else if acidPhase == 1 {
            setPixel(&grid, x: 7, y: 2, color: acid)
            setPixel(&grid, x: 8, y: 2, color: brightGreen)
        } else if acidPhase == 2 {
            setPixel(&grid, x: 7, y: 2, color: brightGreen)
            setPixel(&grid, x: 8, y: 1, color: acid)
        } else {
            setPixel(&grid, x: 8, y: 1, color: brightGreen)
        }
    }


    // MARK: - Minions
    private func drawMinionsBase(grid: inout [[NSColor]], frame: Int, height: Int, goggleColor: NSColor, hairStyle: Int) {
        let yellow = NSColor(red: 1.0, green: 0.85, blue: 0.1, alpha: 1.0)
        let darkYellow = NSColor(red: 0.85, green: 0.72, blue: 0.05, alpha: 1.0)
        let goggleGray = NSColor(red: 0.65, green: 0.65, blue: 0.68, alpha: 1.0)
        let goggleDark = NSColor(red: 0.4, green: 0.4, blue: 0.43, alpha: 1.0)
        let goggleWhite = NSColor.white
        let gogglePupil = NSColor(red: 0.3, green: 0.2, blue: 0.1, alpha: 1.0)
        let blue = NSColor(red: 0.15, green: 0.3, blue: 0.7, alpha: 1.0)
        let darkBlue = NSColor(red: 0.1, green: 0.2, blue: 0.5, alpha: 1.0)
        let mouth = NSColor(red: 0.6, green: 0.3, blue: 0.15, alpha: 1.0)
        let black = NSColor.black

        // Hair
        if hairStyle == 0 {
            // Single strand up
            setPixel(&grid, x: 7, y: 0, color: black)
            setPixel(&grid, x: 8, y: 0, color: black)
        } else if hairStyle == 1 {
            // Two strands
            setPixel(&grid, x: 6, y: 0, color: black)
            setPixel(&grid, x: 9, y: 0, color: black)
        } else {
            // Messy
            setPixel(&grid, x: 6, y: 0, color: black)
            setPixel(&grid, x: 7, y: 0, color: black)
            setPixel(&grid, x: 9, y: 0, color: black)
        }

        // Head (pill shape)
        for x in 5...10 { setPixel(&grid, x: x, y: 1, color: yellow) }
        for x in 4...11 { setPixel(&grid, x: x, y: 2, color: yellow) }
        for x in 4...11 { setPixel(&grid, x: x, y: 3, color: yellow) }
        for x in 4...11 { setPixel(&grid, x: x, y: 4, color: darkYellow) }

        // Goggle strap
        for x in 4...11 { setPixel(&grid, x: x, y: 2, color: goggleGray) }

        // Single goggle (cyclops style for some, two eyes for others)
        if height <= 8 {
            // One eye (cyclops)
            setPixel(&grid, x: 7, y: 2, color: goggleDark)
            setPixel(&grid, x: 8, y: 2, color: goggleDark)
            setPixel(&grid, x: 7, y: 3, color: goggleGray)
            setPixel(&grid, x: 8, y: 3, color: goggleGray)
            setPixel(&grid, x: 7, y: 2, color: goggleWhite)
            setPixel(&grid, x: 8, y: 2, color: goggleWhite)
            setPixel(&grid, x: 7, y: 3, color: gogglePupil)
        } else {
            // Two eyes
            setPixel(&grid, x: 5, y: 2, color: goggleWhite)
            setPixel(&grid, x: 6, y: 2, color: goggleWhite)
            setPixel(&grid, x: 5, y: 3, color: gogglePupil)
            setPixel(&grid, x: 10, y: 2, color: goggleWhite)
            setPixel(&grid, x: 9, y: 2, color: goggleWhite)
            setPixel(&grid, x: 10, y: 3, color: gogglePupil)
        }

        // Mouth
        setPixel(&grid, x: 7, y: 4, color: mouth)
        setPixel(&grid, x: 8, y: 4, color: mouth)

        // Body (overalls)
        for x in 4...11 { setPixel(&grid, x: x, y: 5, color: blue) }
        for x in 4...11 { setPixel(&grid, x: x, y: 6, color: blue) }

        // Overall straps
        setPixel(&grid, x: 5, y: 5, color: darkBlue)
        setPixel(&grid, x: 10, y: 5, color: darkBlue)

        // Legs
        if frame % 2 == 0 {
            setPixel(&grid, x: 5, y: 7, color: blue)
            setPixel(&grid, x: 10, y: 7, color: blue)
        } else {
            setPixel(&grid, x: 6, y: 7, color: blue)
            setPixel(&grid, x: 9, y: 7, color: blue)
        }
    }

    func drawMinionsKevin(grid: inout [[NSColor]], frame: Int) {
        let yellow = NSColor(red: 1.0, green: 0.85, blue: 0.1, alpha: 1.0)
        let darkYellow = NSColor(red: 0.85, green: 0.72, blue: 0.05, alpha: 1.0)
        let goggleGray = NSColor(red: 0.65, green: 0.65, blue: 0.68, alpha: 1.0)
        let goggleDark = NSColor(red: 0.4, green: 0.4, blue: 0.43, alpha: 1.0)
        let white = NSColor.white
        let pupil = NSColor(red: 0.3, green: 0.2, blue: 0.1, alpha: 1.0)
        let blue = NSColor(red: 0.15, green: 0.3, blue: 0.7, alpha: 1.0)
        let black = NSColor.black
        // Tall minion - single eye
        setPixel(&grid, x: 7, y: 0, color: black)
        for x in 5...10 { setPixel(&grid, x: x, y: 1, color: yellow) }
        for x in 4...11 { setPixel(&grid, x: x, y: 2, color: goggleGray) }
        for x in 4...11 { setPixel(&grid, x: x, y: 3, color: yellow) }
        setPixel(&grid, x: 7, y: 2, color: white)
        setPixel(&grid, x: 8, y: 2, color: white)
        setPixel(&grid, x: 7, y: 3, color: pupil)
        setPixel(&grid, x: 8, y: 3, color: pupil)
        for x in 4...11 { setPixel(&grid, x: x, y: 4, color: darkYellow) }
        setPixel(&grid, x: 7, y: 4, color: NSColor(red: 0.6, green: 0.3, blue: 0.15, alpha: 1.0))
        setPixel(&grid, x: 8, y: 4, color: NSColor(red: 0.6, green: 0.3, blue: 0.15, alpha: 1.0))
        for x in 4...11 { setPixel(&grid, x: x, y: 5, color: blue) }
        for x in 4...11 { setPixel(&grid, x: x, y: 6, color: blue) }
        setPixel(&grid, x: 5, y: 5, color: NSColor(red: 0.1, green: 0.2, blue: 0.5, alpha: 1.0))
        setPixel(&grid, x: 10, y: 5, color: NSColor(red: 0.1, green: 0.2, blue: 0.5, alpha: 1.0))
        if frame % 2 == 0 {
            setPixel(&grid, x: 5, y: 7, color: blue)
            setPixel(&grid, x: 10, y: 7, color: blue)
        } else {
            setPixel(&grid, x: 6, y: 7, color: blue)
            setPixel(&grid, x: 9, y: 7, color: blue)
        }
    }

    func drawMinionsStuart(grid: inout [[NSColor]], frame: Int) {
        drawMinionsBase(grid: &grid, frame: frame, height: 7, goggleColor: NSColor.gray, hairStyle: 2)
    }

    func drawMinionsBob(grid: inout [[NSColor]], frame: Int) {
        drawMinionsBase(grid: &grid, frame: frame, height: 7, goggleColor: NSColor.gray, hairStyle: 0)
    }

    func drawMinionsDave(grid: inout [[NSColor]], frame: Int) {
        drawMinionsBase(grid: &grid, frame: frame, height: 9, goggleColor: NSColor.gray, hairStyle: 1)
    }

    func drawMinionsJerry(grid: inout [[NSColor]], frame: Int) {
        drawMinionsBase(grid: &grid, frame: frame, height: 7, goggleColor: NSColor.gray, hairStyle: 2)
    }

    func drawMinionsPhil(grid: inout [[NSColor]], frame: Int) {
        drawMinionsBase(grid: &grid, frame: frame, height: 9, goggleColor: NSColor.gray, hairStyle: 0)
    }

    func drawMinionsTim(grid: inout [[NSColor]], frame: Int) {
        drawMinionsBase(grid: &grid, frame: frame, height: 7, goggleColor: NSColor.gray, hairStyle: 1)
    }

    func drawMinionsMark(grid: inout [[NSColor]], frame: Int) {
        drawMinionsBase(grid: &grid, frame: frame, height: 9, goggleColor: NSColor.gray, hairStyle: 2)
    }

    func drawMinionsCarl(grid: inout [[NSColor]], frame: Int) {
        drawMinionsBase(grid: &grid, frame: frame, height: 7, goggleColor: NSColor.gray, hairStyle: 0)
    }

    func drawMinionsJorge(grid: inout [[NSColor]], frame: Int) {
        drawMinionsBase(grid: &grid, frame: frame, height: 9, goggleColor: NSColor.gray, hairStyle: 1)
    }

    func drawMinionsDonny(grid: inout [[NSColor]], frame: Int) {
        drawMinionsBase(grid: &grid, frame: frame, height: 7, goggleColor: NSColor.gray, hairStyle: 2)
    }

    func drawMinionsEric(grid: inout [[NSColor]], frame: Int) {
        drawMinionsBase(grid: &grid, frame: frame, height: 9, goggleColor: NSColor.gray, hairStyle: 0)
    }

    // MARK: - Gundam
    func drawGundamRX78(grid: inout [[NSColor]], frame: Int) {
        let white = NSColor.white
        let red = NSColor(red: 0.85, green: 0.15, blue: 0.1, alpha: 1.0)
        let blue = NSColor(red: 0.1, green: 0.3, blue: 0.75, alpha: 1.0)
        let yellow = NSColor(red: 1.0, green: 0.85, blue: 0.0, alpha: 1.0)
        let gray = NSColor(red: 0.65, green: 0.65, blue: 0.68, alpha: 1.0)
        // V-fin
        setPixel(&grid, x: 5, y: 0, color: yellow)
        setPixel(&grid, x: 10, y: 0, color: yellow)
        setPixel(&grid, x: 7, y: 0, color: red)
        setPixel(&grid, x: 8, y: 0, color: red)
        for x in 5...10 { setPixel(&grid, x: x, y: 1, color: white) }
        setPixel(&grid, x: 7, y: 1, color: red)
        setPixel(&grid, x: 8, y: 1, color: red)
        for x in 6...9 { setPixel(&grid, x: x, y: 2, color: white) }
        setPixel(&grid, x: 7, y: 2, color: blue)
        setPixel(&grid, x: 8, y: 2, color: blue)
        for x in 4...11 { setPixel(&grid, x: x, y: 3, color: blue) }
        setPixel(&grid, x: 7, y: 3, color: yellow)
        setPixel(&grid, x: 8, y: 3, color: yellow)
        for x in 4...11 { setPixel(&grid, x: x, y: 4, color: red) }
        for x in 5...10 { setPixel(&grid, x: x, y: 5, color: white) }
        for x in 5...10 { setPixel(&grid, x: x, y: 6, color: blue) }
        if frame % 2 == 0 {
            setPixel(&grid, x: 5, y: 7, color: gray)
            setPixel(&grid, x: 10, y: 7, color: gray)
        } else {
            setPixel(&grid, x: 6, y: 7, color: gray)
            setPixel(&grid, x: 9, y: 7, color: gray)
        }
    }

    func drawGundamZaku(grid: inout [[NSColor]], frame: Int) {
        let green = NSColor(red: 0.2, green: 0.55, blue: 0.2, alpha: 1.0)
        let darkGreen = NSColor(red: 0.1, green: 0.35, blue: 0.1, alpha: 1.0)
        let red = NSColor(red: 0.9, green: 0.15, blue: 0.15, alpha: 1.0)
        let gray = NSColor(red: 0.55, green: 0.55, blue: 0.58, alpha: 1.0)
        for x in 5...10 { setPixel(&grid, x: x, y: 1, color: green) }
        setPixel(&grid, x: 7, y: 1, color: red)
        setPixel(&grid, x: 8, y: 1, color: red)
        for x in 5...10 { setPixel(&grid, x: x, y: 2, color: darkGreen) }
        for x in 4...11 { setPixel(&grid, x: x, y: 3, color: green) }
        setPixel(&grid, x: 7, y: 3, color: gray)
        setPixel(&grid, x: 8, y: 3, color: gray)
        setPixel(&grid, x: 4, y: 3, color: gray)
        setPixel(&grid, x: 11, y: 3, color: gray)
        for x in 4...11 { setPixel(&grid, x: x, y: 4, color: darkGreen) }
        for x in 5...10 { setPixel(&grid, x: x, y: 5, color: green) }
        for x in 5...10 { setPixel(&grid, x: x, y: 6, color: darkGreen) }
        if frame % 2 == 0 {
            setPixel(&grid, x: 5, y: 7, color: gray)
            setPixel(&grid, x: 10, y: 7, color: gray)
        } else {
            setPixel(&grid, x: 6, y: 7, color: gray)
            setPixel(&grid, x: 9, y: 7, color: gray)
        }
    }

    func drawGundamFreedom(grid: inout [[NSColor]], frame: Int) {
        let white = NSColor.white
        let blue = NSColor(red: 0.1, green: 0.25, blue: 0.7, alpha: 1.0)
        let red = NSColor(red: 0.85, green: 0.15, blue: 0.1, alpha: 1.0)
        let gold = NSColor(red: 1.0, green: 0.8, blue: 0.0, alpha: 1.0)
        setPixel(&grid, x: 5, y: 0, color: gold)
        setPixel(&grid, x: 10, y: 0, color: gold)
        for x in 5...10 { setPixel(&grid, x: x, y: 1, color: white) }
        setPixel(&grid, x: 7, y: 1, color: blue)
        setPixel(&grid, x: 8, y: 1, color: blue)
        for x in 5...10 { setPixel(&grid, x: x, y: 2, color: white) }
        for x in 4...11 { setPixel(&grid, x: x, y: 3, color: blue) }
        setPixel(&grid, x: 7, y: 3, color: gold)
        setPixel(&grid, x: 8, y: 3, color: gold)
        for x in 4...11 { setPixel(&grid, x: x, y: 4, color: white) }
        setPixel(&grid, x: 2, y: 3, color: blue)
        setPixel(&grid, x: 13, y: 3, color: blue)
        setPixel(&grid, x: 2, y: 4, color: red)
        setPixel(&grid, x: 13, y: 4, color: red)
        for x in 5...10 { setPixel(&grid, x: x, y: 5, color: blue) }
        for x in 5...10 { setPixel(&grid, x: x, y: 6, color: white) }
        if frame % 2 == 0 {
            setPixel(&grid, x: 5, y: 7, color: blue)
            setPixel(&grid, x: 10, y: 7, color: blue)
        } else {
            setPixel(&grid, x: 6, y: 7, color: blue)
            setPixel(&grid, x: 9, y: 7, color: blue)
        }
    }

    func drawGundamJustice(grid: inout [[NSColor]], frame: Int) {
        let red = NSColor(red: 0.85, green: 0.15, blue: 0.1, alpha: 1.0)
        let darkRed = NSColor(red: 0.6, green: 0.08, blue: 0.08, alpha: 1.0)
        let white = NSColor.white
        let green = NSColor(red: 0.2, green: 0.7, blue: 0.3, alpha: 1.0)
        setPixel(&grid, x: 5, y: 0, color: white)
        setPixel(&grid, x: 10, y: 0, color: white)
        for x in 5...10 { setPixel(&grid, x: x, y: 1, color: red) }
        setPixel(&grid, x: 7, y: 1, color: green)
        setPixel(&grid, x: 8, y: 1, color: green)
        for x in 5...10 { setPixel(&grid, x: x, y: 2, color: white) }
        for x in 4...11 { setPixel(&grid, x: x, y: 3, color: red) }
        setPixel(&grid, x: 7, y: 3, color: green)
        setPixel(&grid, x: 8, y: 3, color: green)
        for x in 4...11 { setPixel(&grid, x: x, y: 4, color: darkRed) }
        setPixel(&grid, x: 2, y: 3, color: red)
        setPixel(&grid, x: 13, y: 3, color: red)
        for x in 5...10 { setPixel(&grid, x: x, y: 5, color: red) }
        for x in 5...10 { setPixel(&grid, x: x, y: 6, color: darkRed) }
        if frame % 2 == 0 {
            setPixel(&grid, x: 5, y: 7, color: red)
            setPixel(&grid, x: 10, y: 7, color: red)
        } else {
            setPixel(&grid, x: 6, y: 7, color: red)
            setPixel(&grid, x: 9, y: 7, color: red)
        }
    }

    func drawGundamStrike(grid: inout [[NSColor]], frame: Int) {
        let blue = NSColor(red: 0.1, green: 0.3, blue: 0.75, alpha: 1.0)
        let red = NSColor(red: 0.85, green: 0.15, blue: 0.1, alpha: 1.0)
        let white = NSColor.white
        let gray = NSColor(red: 0.6, green: 0.6, blue: 0.63, alpha: 1.0)
        setPixel(&grid, x: 6, y: 0, color: red)
        setPixel(&grid, x: 9, y: 0, color: red)
        for x in 5...10 { setPixel(&grid, x: x, y: 1, color: white) }
        setPixel(&grid, x: 7, y: 1, color: blue)
        setPixel(&grid, x: 8, y: 1, color: blue)
        for x in 5...10 { setPixel(&grid, x: x, y: 2, color: white) }
        for x in 4...11 { setPixel(&grid, x: x, y: 3, color: blue) }
        setPixel(&grid, x: 7, y: 3, color: red)
        setPixel(&grid, x: 8, y: 3, color: red)
        for x in 4...11 { setPixel(&grid, x: x, y: 4, color: red) }
        for x in 5...10 { setPixel(&grid, x: x, y: 5, color: blue) }
        for x in 5...10 { setPixel(&grid, x: x, y: 6, color: white) }
        if frame % 2 == 0 {
            setPixel(&grid, x: 5, y: 7, color: gray)
            setPixel(&grid, x: 10, y: 7, color: gray)
        } else {
            setPixel(&grid, x: 6, y: 7, color: gray)
            setPixel(&grid, x: 9, y: 7, color: gray)
        }
    }

    func drawGundamBarbatos(grid: inout [[NSColor]], frame: Int) {
        let gray = NSColor(red: 0.55, green: 0.55, blue: 0.58, alpha: 1.0)
        let darkGray = NSColor(red: 0.35, green: 0.35, blue: 0.38, alpha: 1.0)
        let white = NSColor.white
        let red = NSColor(red: 0.85, green: 0.15, blue: 0.1, alpha: 1.0)
        setPixel(&grid, x: 5, y: 0, color: white)
        setPixel(&grid, x: 10, y: 0, color: white)
        for x in 5...10 { setPixel(&grid, x: x, y: 1, color: gray) }
        setPixel(&grid, x: 7, y: 1, color: red)
        setPixel(&grid, x: 8, y: 1, color: red)
        for x in 5...10 { setPixel(&grid, x: x, y: 2, color: darkGray) }
        for x in 4...11 { setPixel(&grid, x: x, y: 3, color: gray) }
        setPixel(&grid, x: 7, y: 3, color: red)
        setPixel(&grid, x: 8, y: 3, color: red)
        setPixel(&grid, x: 3, y: 3, color: white)
        setPixel(&grid, x: 12, y: 3, color: white)
        for x in 4...11 { setPixel(&grid, x: x, y: 4, color: darkGray) }
        for x in 5...10 { setPixel(&grid, x: x, y: 5, color: gray) }
        for x in 5...10 { setPixel(&grid, x: x, y: 6, color: darkGray) }
        if frame % 2 == 0 {
            setPixel(&grid, x: 5, y: 7, color: gray)
            setPixel(&grid, x: 10, y: 7, color: gray)
        } else {
            setPixel(&grid, x: 6, y: 7, color: gray)
            setPixel(&grid, x: 9, y: 7, color: gray)
        }
    }

    func drawGundamUnicorn(grid: inout [[NSColor]], frame: Int) {
        let white = NSColor.white
        let red = NSColor(red: 0.85, green: 0.15, blue: 0.1, alpha: 1.0)
        let glow = NSColor(red: 1.0, green: 0.4, blue: 0.4, alpha: 1.0)
        let gray = NSColor(red: 0.65, green: 0.65, blue: 0.68, alpha: 1.0)
        setPixel(&grid, x: 7, y: 0, color: white)
        setPixel(&grid, x: 8, y: 0, color: white)
        for x in 5...10 { setPixel(&grid, x: x, y: 1, color: white) }
        for x in 5...10 { setPixel(&grid, x: x, y: 2, color: white) }
        setPixel(&grid, x: 7, y: 2, color: glow)
        setPixel(&grid, x: 8, y: 2, color: glow)
        for x in 4...11 { setPixel(&grid, x: x, y: 3, color: white) }
        setPixel(&grid, x: 7, y: 3, color: red)
        setPixel(&grid, x: 8, y: 3, color: red)
        for x in 4...11 { setPixel(&grid, x: x, y: 4, color: white) }
        setPixel(&grid, x: 5, y: 4, color: glow)
        setPixel(&grid, x: 10, y: 4, color: glow)
        for x in 5...10 { setPixel(&grid, x: x, y: 5, color: white) }
        for x in 5...10 { setPixel(&grid, x: x, y: 6, color: gray) }
        if frame % 2 == 0 {
            setPixel(&grid, x: 5, y: 7, color: glow)
            setPixel(&grid, x: 10, y: 7, color: glow)
        } else {
            setPixel(&grid, x: 6, y: 7, color: glow)
            setPixel(&grid, x: 9, y: 7, color: glow)
        }
    }

    func drawGundamSinanju(grid: inout [[NSColor]], frame: Int) {
        let red = NSColor(red: 0.85, green: 0.15, blue: 0.1, alpha: 1.0)
        let gold = NSColor(red: 1.0, green: 0.8, blue: 0.0, alpha: 1.0)
        let white = NSColor.white
        let darkRed = NSColor(red: 0.6, green: 0.08, blue: 0.08, alpha: 1.0)
        setPixel(&grid, x: 7, y: 0, color: gold)
        setPixel(&grid, x: 8, y: 0, color: gold)
        for x in 5...10 { setPixel(&grid, x: x, y: 1, color: red) }
        setPixel(&grid, x: 7, y: 1, color: white)
        setPixel(&grid, x: 8, y: 1, color: white)
        for x in 5...10 { setPixel(&grid, x: x, y: 2, color: red) }
        for x in 4...11 { setPixel(&grid, x: x, y: 3, color: red) }
        setPixel(&grid, x: 7, y: 3, color: gold)
        setPixel(&grid, x: 8, y: 3, color: gold)
        setPixel(&grid, x: 4, y: 3, color: gold)
        setPixel(&grid, x: 11, y: 3, color: gold)
        for x in 4...11 { setPixel(&grid, x: x, y: 4, color: darkRed) }
        for x in 5...10 { setPixel(&grid, x: x, y: 5, color: red) }
        for x in 5...10 { setPixel(&grid, x: x, y: 6, color: darkRed) }
        if frame % 2 == 0 {
            setPixel(&grid, x: 5, y: 7, color: gold)
            setPixel(&grid, x: 10, y: 7, color: gold)
        } else {
            setPixel(&grid, x: 6, y: 7, color: gold)
            setPixel(&grid, x: 9, y: 7, color: gold)
        }
    }

    func drawGundamExia(grid: inout [[NSColor]], frame: Int) {
        let blue = NSColor(red: 0.1, green: 0.3, blue: 0.75, alpha: 1.0)
        let white = NSColor.white
        let green = NSColor(red: 0.2, green: 0.8, blue: 0.3, alpha: 1.0)
        let gray = NSColor(red: 0.6, green: 0.6, blue: 0.63, alpha: 1.0)
        setPixel(&grid, x: 6, y: 0, color: green)
        setPixel(&grid, x: 9, y: 0, color: green)
        for x in 5...10 { setPixel(&grid, x: x, y: 1, color: white) }
        setPixel(&grid, x: 7, y: 1, color: green)
        setPixel(&grid, x: 8, y: 1, color: green)
        for x in 5...10 { setPixel(&grid, x: x, y: 2, color: white) }
        for x in 4...11 { setPixel(&grid, x: x, y: 3, color: blue) }
        setPixel(&grid, x: 7, y: 3, color: green)
        setPixel(&grid, x: 8, y: 3, color: green)
        for x in 4...11 { setPixel(&grid, x: x, y: 4, color: white) }
        setPixel(&grid, x: 3, y: 3, color: green)
        setPixel(&grid, x: 12, y: 3, color: green)
        for x in 5...10 { setPixel(&grid, x: x, y: 5, color: blue) }
        for x in 5...10 { setPixel(&grid, x: x, y: 6, color: white) }
        if frame % 2 == 0 {
            setPixel(&grid, x: 5, y: 7, color: gray)
            setPixel(&grid, x: 10, y: 7, color: gray)
        } else {
            setPixel(&grid, x: 6, y: 7, color: gray)
            setPixel(&grid, x: 9, y: 7, color: gray)
        }
    }

    func drawGundamWingZero(grid: inout [[NSColor]], frame: Int) {
        let white = NSColor.white
        let blue = NSColor(red: 0.1, green: 0.25, blue: 0.7, alpha: 1.0)
        let gold = NSColor(red: 1.0, green: 0.8, blue: 0.0, alpha: 1.0)
        let gray = NSColor(red: 0.6, green: 0.6, blue: 0.63, alpha: 1.0)
        setPixel(&grid, x: 4, y: 0, color: gold)
        setPixel(&grid, x: 11, y: 0, color: gold)
        setPixel(&grid, x: 5, y: 0, color: gold)
        setPixel(&grid, x: 10, y: 0, color: gold)
        for x in 5...10 { setPixel(&grid, x: x, y: 1, color: white) }
        setPixel(&grid, x: 7, y: 1, color: blue)
        setPixel(&grid, x: 8, y: 1, color: blue)
        for x in 5...10 { setPixel(&grid, x: x, y: 2, color: white) }
        setPixel(&grid, x: 2, y: 2, color: white)
        setPixel(&grid, x: 3, y: 1, color: white)
        setPixel(&grid, x: 12, y: 2, color: white)
        setPixel(&grid, x: 13, y: 1, color: white)
        setPixel(&grid, x: 2, y: 3, color: gray)
        setPixel(&grid, x: 13, y: 3, color: gray)
        for x in 4...11 { setPixel(&grid, x: x, y: 3, color: blue) }
        setPixel(&grid, x: 7, y: 3, color: gold)
        setPixel(&grid, x: 8, y: 3, color: gold)
        for x in 4...11 { setPixel(&grid, x: x, y: 4, color: white) }
        for x in 5...10 { setPixel(&grid, x: x, y: 5, color: blue) }
        for x in 5...10 { setPixel(&grid, x: x, y: 6, color: white) }
        if frame % 2 == 0 {
            setPixel(&grid, x: 5, y: 7, color: gray)
            setPixel(&grid, x: 10, y: 7, color: gray)
        } else {
            setPixel(&grid, x: 6, y: 7, color: gray)
            setPixel(&grid, x: 9, y: 7, color: gray)
        }
    }

    func drawGundamDeathscythe(grid: inout [[NSColor]], frame: Int) {
        let black = NSColor.black
        let darkPurple = NSColor(red: 0.25, green: 0.1, blue: 0.35, alpha: 1.0)
        let white = NSColor.white
        let red = NSColor(red: 0.85, green: 0.15, blue: 0.1, alpha: 1.0)
        let gray = NSColor(red: 0.5, green: 0.5, blue: 0.53, alpha: 1.0)
        setPixel(&grid, x: 5, y: 0, color: darkPurple)
        setPixel(&grid, x: 10, y: 0, color: darkPurple)
        for x in 5...10 { setPixel(&grid, x: x, y: 1, color: black) }
        setPixel(&grid, x: 7, y: 1, color: red)
        setPixel(&grid, x: 8, y: 1, color: red)
        for x in 5...10 { setPixel(&grid, x: x, y: 2, color: darkPurple) }
        setPixel(&grid, x: 2, y: 2, color: black)
        setPixel(&grid, x: 3, y: 1, color: black)
        setPixel(&grid, x: 12, y: 2, color: black)
        setPixel(&grid, x: 13, y: 1, color: black)
        setPixel(&grid, x: 2, y: 3, color: darkPurple)
        setPixel(&grid, x: 13, y: 3, color: darkPurple)
        for x in 4...11 { setPixel(&grid, x: x, y: 3, color: black) }
        setPixel(&grid, x: 7, y: 3, color: red)
        setPixel(&grid, x: 8, y: 3, color: red)
        for x in 4...11 { setPixel(&grid, x: x, y: 4, color: darkPurple) }
        setPixel(&grid, x: 2, y: 5, color: gray)
        setPixel(&grid, x: 2, y: 6, color: gray)
        for x in 5...10 { setPixel(&grid, x: x, y: 5, color: black) }
        for x in 5...10 { setPixel(&grid, x: x, y: 6, color: darkPurple) }
        if frame % 2 == 0 {
            setPixel(&grid, x: 5, y: 7, color: gray)
            setPixel(&grid, x: 10, y: 7, color: gray)
        } else {
            setPixel(&grid, x: 6, y: 7, color: gray)
            setPixel(&grid, x: 9, y: 7, color: gray)
        }
    }

    func drawGundamHeavyArms(grid: inout [[NSColor]], frame: Int) {
        let orange = NSColor(red: 0.9, green: 0.5, blue: 0.1, alpha: 1.0)
        let green = NSColor(red: 0.2, green: 0.55, blue: 0.2, alpha: 1.0)
        let gray = NSColor(red: 0.55, green: 0.55, blue: 0.58, alpha: 1.0)
        for x in 5...10 { setPixel(&grid, x: x, y: 1, color: orange) }
        setPixel(&grid, x: 7, y: 1, color: green)
        setPixel(&grid, x: 8, y: 1, color: green)
        for x in 5...10 { setPixel(&grid, x: x, y: 2, color: orange) }
        for x in 4...11 { setPixel(&grid, x: x, y: 3, color: orange) }
        setPixel(&grid, x: 5, y: 3, color: gray)
        setPixel(&grid, x: 6, y: 3, color: gray)
        setPixel(&grid, x: 9, y: 3, color: gray)
        setPixel(&grid, x: 10, y: 3, color: gray)
        for x in 4...11 { setPixel(&grid, x: x, y: 4, color: green) }
        setPixel(&grid, x: 3, y: 4, color: gray)
        setPixel(&grid, x: 12, y: 4, color: gray)
        for x in 5...10 { setPixel(&grid, x: x, y: 5, color: orange) }
        for x in 5...10 { setPixel(&grid, x: x, y: 6, color: green) }
        if frame % 2 == 0 {
            setPixel(&grid, x: 5, y: 7, color: gray)
            setPixel(&grid, x: 10, y: 7, color: gray)
        } else {
            setPixel(&grid, x: 6, y: 7, color: gray)
            setPixel(&grid, x: 9, y: 7, color: gray)
        }
    }

    // MARK: - Star Wars
    func drawStarWarsLuke(grid: inout [[NSColor]], frame: Int) {
        let blonde = NSColor(red: 0.9, green: 0.8, blue: 0.3, alpha: 1.0)
        let skin = NSColor(red: 0.95, green: 0.8, blue: 0.65, alpha: 1.0)
        let white = NSColor.white
        let blue = NSColor(red: 0.15, green: 0.3, blue: 0.7, alpha: 1.0)
        let green = NSColor(red: 0.2, green: 0.55, blue: 0.2, alpha: 1.0)
        let black = NSColor.black
        for x in 6...9 { setPixel(&grid, x: x, y: 1, color: blonde) }
        setPixel(&grid, x: 6, y: 0, color: blonde)
        setPixel(&grid, x: 9, y: 0, color: blonde)
        for x in 6...9 { setPixel(&grid, x: x, y: 2, color: skin) }
        setPixel(&grid, x: 7, y: 2, color: black)
        setPixel(&grid, x: 8, y: 2, color: black)
        for x in 5...10 { setPixel(&grid, x: x, y: 3, color: white) }
        setPixel(&grid, x: 7, y: 3, color: skin)
        setPixel(&grid, x: 8, y: 3, color: skin)
        for x in 5...10 { setPixel(&grid, x: x, y: 4, color: white) }
        for x in 5...10 { setPixel(&grid, x: x, y: 5, color: blue) }
        setPixel(&grid, x: 7, y: 5, color: green)
        setPixel(&grid, x: 8, y: 5, color: green)
        for x in 5...10 { setPixel(&grid, x: x, y: 6, color: blue) }
        if frame % 2 == 0 {
            setPixel(&grid, x: 5, y: 7, color: black)
            setPixel(&grid, x: 10, y: 7, color: black)
        } else {
            setPixel(&grid, x: 6, y: 7, color: black)
            setPixel(&grid, x: 9, y: 7, color: black)
        }
    }

    func drawStarWarsVader(grid: inout [[NSColor]], frame: Int) {
        let black = NSColor(red: 0.1, green: 0.1, blue: 0.12, alpha: 1.0)
        let darkGray = NSColor(red: 0.25, green: 0.25, blue: 0.28, alpha: 1.0)
        let red = NSColor(red: 0.85, green: 0.15, blue: 0.1, alpha: 1.0)
        let darkRed = NSColor(red: 0.5, green: 0.05, blue: 0.05, alpha: 1.0)
        for x in 6...9 { setPixel(&grid, x: x, y: 0, color: black) }
        for x in 5...10 { setPixel(&grid, x: x, y: 1, color: black) }
        setPixel(&grid, x: 5, y: 1, color: darkGray)
        setPixel(&grid, x: 10, y: 1, color: darkGray)
        for x in 5...10 { setPixel(&grid, x: x, y: 2, color: black) }
        setPixel(&grid, x: 7, y: 2, color: red)
        setPixel(&grid, x: 8, y: 2, color: red)
        for x in 4...11 { setPixel(&grid, x: x, y: 3, color: black) }
        setPixel(&grid, x: 7, y: 3, color: darkRed)
        setPixel(&grid, x: 8, y: 3, color: darkRed)
        for x in 4...11 { setPixel(&grid, x: x, y: 4, color: darkGray) }
        for x in 4...11 { setPixel(&grid, x: x, y: 5, color: black) }
        for x in 4...11 { setPixel(&grid, x: x, y: 6, color: darkGray) }
        if frame % 2 == 0 {
            setPixel(&grid, x: 5, y: 7, color: black)
            setPixel(&grid, x: 10, y: 7, color: black)
        } else {
            setPixel(&grid, x: 6, y: 7, color: black)
            setPixel(&grid, x: 9, y: 7, color: black)
        }
    }

    func drawStarWarsLeia(grid: inout [[NSColor]], frame: Int) {
        let brown = NSColor(red: 0.45, green: 0.25, blue: 0.1, alpha: 1.0)
        let skin = NSColor(red: 0.95, green: 0.8, blue: 0.65, alpha: 1.0)
        let white = NSColor.white
        let black = NSColor.black
        for x in 5...10 { setPixel(&grid, x: x, y: 0, color: brown) }
        setPixel(&grid, x: 5, y: 1, color: brown)
        setPixel(&grid, x: 10, y: 1, color: brown)
        for x in 6...9 { setPixel(&grid, x: x, y: 1, color: brown) }
        setPixel(&grid, x: 4, y: 0, color: brown)
        setPixel(&grid, x: 11, y: 0, color: brown)
        for x in 6...9 { setPixel(&grid, x: x, y: 2, color: skin) }
        setPixel(&grid, x: 7, y: 2, color: black)
        setPixel(&grid, x: 8, y: 2, color: black)
        for x in 5...10 { setPixel(&grid, x: x, y: 3, color: white) }
        setPixel(&grid, x: 7, y: 3, color: skin)
        setPixel(&grid, x: 8, y: 3, color: skin)
        for x in 5...10 { setPixel(&grid, x: x, y: 4, color: white) }
        for x in 5...10 { setPixel(&grid, x: x, y: 5, color: white) }
        setPixel(&grid, x: 4, y: 5, color: white)
        setPixel(&grid, x: 11, y: 5, color: white)
        for x in 5...10 { setPixel(&grid, x: x, y: 6, color: white) }
        if frame % 2 == 0 {
            setPixel(&grid, x: 5, y: 7, color: black)
            setPixel(&grid, x: 10, y: 7, color: black)
        } else {
            setPixel(&grid, x: 6, y: 7, color: black)
            setPixel(&grid, x: 9, y: 7, color: black)
        }
    }

    func drawStarWarsHan(grid: inout [[NSColor]], frame: Int) {
        let brown = NSColor(red: 0.45, green: 0.25, blue: 0.1, alpha: 1.0)
        let skin = NSColor(red: 0.95, green: 0.8, blue: 0.65, alpha: 1.0)
        let white = NSColor.white
        let tan = NSColor(red: 0.7, green: 0.55, blue: 0.35, alpha: 1.0)
        let black = NSColor.black
        let darkBrown = NSColor(red: 0.35, green: 0.18, blue: 0.05, alpha: 1.0)
        for x in 6...9 { setPixel(&grid, x: x, y: 0, color: brown) }
        for x in 6...9 { setPixel(&grid, x: x, y: 1, color: brown) }
        for x in 6...9 { setPixel(&grid, x: x, y: 2, color: skin) }
        setPixel(&grid, x: 7, y: 2, color: black)
        setPixel(&grid, x: 8, y: 2, color: black)
        for x in 5...10 { setPixel(&grid, x: x, y: 3, color: white) }
        setPixel(&grid, x: 7, y: 3, color: skin)
        setPixel(&grid, x: 8, y: 3, color: skin)
        for x in 5...10 { setPixel(&grid, x: x, y: 4, color: white) }
        setPixel(&grid, x: 7, y: 4, color: tan)
        setPixel(&grid, x: 8, y: 4, color: tan)
        for x in 5...10 { setPixel(&grid, x: x, y: 5, color: tan) }
        for x in 5...10 { setPixel(&grid, x: x, y: 6, color: darkBrown) }
        if frame % 2 == 0 {
            setPixel(&grid, x: 5, y: 7, color: black)
            setPixel(&grid, x: 10, y: 7, color: black)
        } else {
            setPixel(&grid, x: 6, y: 7, color: black)
            setPixel(&grid, x: 9, y: 7, color: black)
        }
    }

    func drawStarWarsChewbacca(grid: inout [[NSColor]], frame: Int) {
        let brown = NSColor(red: 0.5, green: 0.3, blue: 0.12, alpha: 1.0)
        let darkBrown = NSColor(red: 0.35, green: 0.18, blue: 0.05, alpha: 1.0)
        let lightBrown = NSColor(red: 0.65, green: 0.42, blue: 0.2, alpha: 1.0)
        let black = NSColor.black
        let red = NSColor(red: 0.75, green: 0.15, blue: 0.1, alpha: 1.0)
        for x in 5...10 { setPixel(&grid, x: x, y: 0, color: brown) }
        for x in 4...11 { setPixel(&grid, x: x, y: 1, color: brown) }
        for x in 5...10 { setPixel(&grid, x: x, y: 2, color: darkBrown) }
        setPixel(&grid, x: 6, y: 2, color: black)
        setPixel(&grid, x: 9, y: 2, color: black)
        for x in 4...11 { setPixel(&grid, x: x, y: 3, color: brown) }
        setPixel(&grid, x: 5, y: 3, color: lightBrown)
        setPixel(&grid, x: 10, y: 3, color: lightBrown)
        for x in 4...11 { setPixel(&grid, x: x, y: 4, color: brown) }
        setPixel(&grid, x: 7, y: 4, color: red)
        setPixel(&grid, x: 8, y: 4, color: red)
        for x in 4...11 { setPixel(&grid, x: x, y: 5, color: darkBrown) }
        for x in 5...10 { setPixel(&grid, x: x, y: 6, color: brown) }
        if frame % 2 == 0 {
            setPixel(&grid, x: 5, y: 7, color: darkBrown)
            setPixel(&grid, x: 10, y: 7, color: darkBrown)
        } else {
            setPixel(&grid, x: 6, y: 7, color: darkBrown)
            setPixel(&grid, x: 9, y: 7, color: darkBrown)
        }
    }

    func drawStarWarsYoda(grid: inout [[NSColor]], frame: Int) {
        let green = NSColor(red: 0.35, green: 0.6, blue: 0.25, alpha: 1.0)
        let darkGreen = NSColor(red: 0.2, green: 0.4, blue: 0.15, alpha: 1.0)
        let cream = NSColor(red: 0.9, green: 0.85, blue: 0.7, alpha: 1.0)
        let black = NSColor.black
        let brown = NSColor(red: 0.5, green: 0.35, blue: 0.15, alpha: 1.0)
        for x in 6...9 { setPixel(&grid, x: x, y: 1, color: green) }
        setPixel(&grid, x: 5, y: 1, color: green)
        setPixel(&grid, x: 10, y: 1, color: green)
        setPixel(&grid, x: 4, y: 0, color: green)
        setPixel(&grid, x: 11, y: 0, color: green)
        for x in 6...9 { setPixel(&grid, x: x, y: 2, color: green) }
        setPixel(&grid, x: 7, y: 2, color: black)
        setPixel(&grid, x: 8, y: 2, color: black)
        for x in 5...10 { setPixel(&grid, x: x, y: 3, color: cream) }
        setPixel(&grid, x: 7, y: 3, color: darkGreen)
        setPixel(&grid, x: 8, y: 3, color: darkGreen)
        for x in 5...10 { setPixel(&grid, x: x, y: 4, color: cream) }
        for x in 5...10 { setPixel(&grid, x: x, y: 5, color: brown) }
        for x in 5...10 { setPixel(&grid, x: x, y: 6, color: darkGreen) }
        if frame % 2 == 0 {
            setPixel(&grid, x: 5, y: 7, color: darkGreen)
            setPixel(&grid, x: 10, y: 7, color: darkGreen)
        } else {
            setPixel(&grid, x: 6, y: 7, color: darkGreen)
            setPixel(&grid, x: 9, y: 7, color: darkGreen)
        }
    }

    func drawStarWarsMaul(grid: inout [[NSColor]], frame: Int) {
        let red = NSColor(red: 0.8, green: 0.1, blue: 0.1, alpha: 1.0)
        let black = NSColor.black
        let darkRed = NSColor(red: 0.55, green: 0.05, blue: 0.05, alpha: 1.0)
        let yellow = NSColor(red: 1.0, green: 0.9, blue: 0.2, alpha: 1.0)
        for x in 5...10 { setPixel(&grid, x: x, y: 0, color: black) }
        for x in 5...10 { setPixel(&grid, x: x, y: 1, color: black) }
        setPixel(&grid, x: 4, y: 0, color: black)
        setPixel(&grid, x: 11, y: 0, color: black)
        for x in 5...10 { setPixel(&grid, x: x, y: 2, color: red) }
        setPixel(&grid, x: 5, y: 1, color: black)
        setPixel(&grid, x: 10, y: 1, color: black)
        setPixel(&grid, x: 7, y: 2, color: yellow)
        setPixel(&grid, x: 8, y: 2, color: yellow)
        for x in 5...10 { setPixel(&grid, x: x, y: 3, color: red) }
        setPixel(&grid, x: 7, y: 3, color: black)
        setPixel(&grid, x: 8, y: 3, color: black)
        for x in 5...10 { setPixel(&grid, x: x, y: 4, color: darkRed) }
        for x in 5...10 { setPixel(&grid, x: x, y: 5, color: black) }
        for x in 5...10 { setPixel(&grid, x: x, y: 6, color: red) }
        if frame % 2 == 0 {
            setPixel(&grid, x: 5, y: 7, color: black)
            setPixel(&grid, x: 10, y: 7, color: black)
        } else {
            setPixel(&grid, x: 6, y: 7, color: black)
            setPixel(&grid, x: 9, y: 7, color: black)
        }
    }

    func drawStarWarsBobaFett(grid: inout [[NSColor]], frame: Int) {
        let green = NSColor(red: 0.3, green: 0.5, blue: 0.25, alpha: 1.0)
        let darkGreen = NSColor(red: 0.2, green: 0.35, blue: 0.15, alpha: 1.0)
        let yellow = NSColor(red: 0.9, green: 0.8, blue: 0.2, alpha: 1.0)
        let gray = NSColor(red: 0.55, green: 0.55, blue: 0.58, alpha: 1.0)
        let black = NSColor.black
        let red = NSColor(red: 0.8, green: 0.15, blue: 0.1, alpha: 1.0)
        for x in 6...9 { setPixel(&grid, x: x, y: 1, color: green) }
        setPixel(&grid, x: 6, y: 0, color: green)
        setPixel(&grid, x: 9, y: 0, color: green)
        for x in 6...9 { setPixel(&grid, x: x, y: 2, color: green) }
        setPixel(&grid, x: 6, y: 2, color: gray)
        setPixel(&grid, x: 9, y: 2, color: gray)
        for x in 5...10 { setPixel(&grid, x: x, y: 3, color: green) }
        setPixel(&grid, x: 7, y: 3, color: black)
        setPixel(&grid, x: 8, y: 3, color: black)
        setPixel(&grid, x: 5, y: 3, color: yellow)
        for x in 5...10 { setPixel(&grid, x: x, y: 4, color: darkGreen) }
        setPixel(&grid, x: 5, y: 4, color: red)
        setPixel(&grid, x: 10, y: 4, color: red)
        for x in 5...10 { setPixel(&grid, x: x, y: 5, color: green) }
        setPixel(&grid, x: 4, y: 5, color: gray)
        setPixel(&grid, x: 11, y: 5, color: gray)
        for x in 5...10 { setPixel(&grid, x: x, y: 6, color: darkGreen) }
        if frame % 2 == 0 {
            setPixel(&grid, x: 5, y: 7, color: gray)
            setPixel(&grid, x: 10, y: 7, color: gray)
        } else {
            setPixel(&grid, x: 6, y: 7, color: gray)
            setPixel(&grid, x: 9, y: 7, color: gray)
        }
    }

    func drawStarWarsC3PO(grid: inout [[NSColor]], frame: Int) {
        let gold = NSColor(red: 1.0, green: 0.82, blue: 0.0, alpha: 1.0)
        let darkGold = NSColor(red: 0.8, green: 0.6, blue: 0.0, alpha: 1.0)
        let brightGold = NSColor(red: 1.0, green: 0.95, blue: 0.4, alpha: 1.0)
        let black = NSColor.black
        let silver = NSColor(red: 0.75, green: 0.75, blue: 0.78, alpha: 1.0)
        for x in 6...9 { setPixel(&grid, x: x, y: 0, color: gold) }
        setPixel(&grid, x: 6, y: 0, color: brightGold)
        for x in 5...10 { setPixel(&grid, x: x, y: 1, color: gold) }
        setPixel(&grid, x: 7, y: 1, color: black)
        setPixel(&grid, x: 8, y: 1, color: black)
        for x in 5...10 { setPixel(&grid, x: x, y: 2, color: gold) }
        setPixel(&grid, x: 5, y: 2, color: brightGold)
        for x in 5...10 { setPixel(&grid, x: x, y: 3, color: gold) }
        setPixel(&grid, x: 7, y: 3, color: darkGold)
        setPixel(&grid, x: 8, y: 3, color: darkGold)
        for x in 5...10 { setPixel(&grid, x: x, y: 4, color: gold) }
        for x in 5...10 { setPixel(&grid, x: x, y: 5, color: gold) }
        setPixel(&grid, x: 4, y: 5, color: silver)
        setPixel(&grid, x: 11, y: 5, color: silver)
        for x in 5...10 { setPixel(&grid, x: x, y: 6, color: darkGold) }
        if frame % 2 == 0 {
            setPixel(&grid, x: 5, y: 7, color: gold)
            setPixel(&grid, x: 10, y: 7, color: gold)
        } else {
            setPixel(&grid, x: 6, y: 7, color: gold)
            setPixel(&grid, x: 9, y: 7, color: gold)
        }
    }

    func drawStarWarsR2D2(grid: inout [[NSColor]], frame: Int) {
        let white = NSColor.white
        let blue = NSColor(red: 0.1, green: 0.3, blue: 0.75, alpha: 1.0)
        let silver = NSColor(red: 0.75, green: 0.75, blue: 0.78, alpha: 1.0)
        let black = NSColor.black
        let red = NSColor(red: 0.85, green: 0.15, blue: 0.1, alpha: 1.0)
        for x in 6...9 { setPixel(&grid, x: x, y: 1, color: white) }
        setPixel(&grid, x: 6, y: 0, color: silver)
        setPixel(&grid, x: 9, y: 0, color: silver)
        for x in 6...9 { setPixel(&grid, x: x, y: 2, color: white) }
        setPixel(&grid, x: 7, y: 2, color: blue)
        setPixel(&grid, x: 8, y: 2, color: blue)
        for x in 5...10 { setPixel(&grid, x: x, y: 3, color: white) }
        setPixel(&grid, x: 7, y: 3, color: black)
        setPixel(&grid, x: 8, y: 3, color: black)
        setPixel(&grid, x: 6, y: 3, color: blue)
        setPixel(&grid, x: 9, y: 3, color: blue)
        for x in 5...10 { setPixel(&grid, x: x, y: 4, color: silver) }
        setPixel(&grid, x: 5, y: 4, color: blue)
        setPixel(&grid, x: 10, y: 4, color: blue)
        for x in 5...10 { setPixel(&grid, x: x, y: 5, color: white) }
        setPixel(&grid, x: 5, y: 5, color: red)
        setPixel(&grid, x: 10, y: 5, color: red)
        for x in 5...10 { setPixel(&grid, x: x, y: 6, color: silver) }
        if frame % 2 == 0 {
            setPixel(&grid, x: 5, y: 7, color: white)
            setPixel(&grid, x: 10, y: 7, color: white)
        } else {
            setPixel(&grid, x: 6, y: 7, color: white)
            setPixel(&grid, x: 9, y: 7, color: white)
        }
    }

    func drawStarWarsObiWan(grid: inout [[NSColor]], frame: Int) {
        let brown = NSColor(red: 0.55, green: 0.3, blue: 0.12, alpha: 1.0)
        let tan = NSColor(red: 0.85, green: 0.75, blue: 0.55, alpha: 1.0)
        let skin = NSColor(red: 0.95, green: 0.8, blue: 0.65, alpha: 1.0)
        let black = NSColor.black
        let gray = NSColor(red: 0.55, green: 0.55, blue: 0.58, alpha: 1.0)
        for x in 6...9 { setPixel(&grid, x: x, y: 0, color: brown) }
        for x in 6...9 { setPixel(&grid, x: x, y: 1, color: brown) }
        setPixel(&grid, x: 6, y: 0, color: tan)
        setPixel(&grid, x: 9, y: 0, color: tan)
        for x in 6...9 { setPixel(&grid, x: x, y: 2, color: skin) }
        setPixel(&grid, x: 7, y: 2, color: black)
        setPixel(&grid, x: 8, y: 2, color: black)
        for x in 5...10 { setPixel(&grid, x: x, y: 3, color: tan) }
        setPixel(&grid, x: 7, y: 3, color: skin)
        setPixel(&grid, x: 8, y: 3, color: skin)
        for x in 5...10 { setPixel(&grid, x: x, y: 4, color: tan) }
        for x in 5...10 { setPixel(&grid, x: x, y: 5, color: brown) }
        for x in 5...10 { setPixel(&grid, x: x, y: 6, color: gray) }
        if frame % 2 == 0 {
            setPixel(&grid, x: 5, y: 7, color: brown)
            setPixel(&grid, x: 10, y: 7, color: brown)
        } else {
            setPixel(&grid, x: 6, y: 7, color: brown)
            setPixel(&grid, x: 9, y: 7, color: brown)
        }
    }

    func drawStarWarsKyloRen(grid: inout [[NSColor]], frame: Int) {
        let black = NSColor(red: 0.1, green: 0.1, blue: 0.12, alpha: 1.0)
        let darkGray = NSColor(red: 0.2, green: 0.2, blue: 0.22, alpha: 1.0)
        let red = NSColor(red: 0.85, green: 0.15, blue: 0.1, alpha: 1.0)
        let silver = NSColor(red: 0.6, green: 0.6, blue: 0.63, alpha: 1.0)
        for x in 6...9 { setPixel(&grid, x: x, y: 0, color: black) }
        for x in 5...10 { setPixel(&grid, x: x, y: 1, color: black) }
        for x in 5...10 { setPixel(&grid, x: x, y: 2, color: darkGray) }
        setPixel(&grid, x: 7, y: 2, color: silver)
        setPixel(&grid, x: 8, y: 2, color: silver)
        for x in 4...11 { setPixel(&grid, x: x, y: 3, color: black) }
        setPixel(&grid, x: 7, y: 3, color: red)
        setPixel(&grid, x: 8, y: 3, color: red)
        for x in 4...11 { setPixel(&grid, x: x, y: 4, color: darkGray) }
        for x in 4...11 { setPixel(&grid, x: x, y: 5, color: black) }
        for x in 4...11 { setPixel(&grid, x: x, y: 6, color: darkGray) }
        if frame % 2 == 0 {
            setPixel(&grid, x: 5, y: 7, color: black)
            setPixel(&grid, x: 10, y: 7, color: black)
        } else {
            setPixel(&grid, x: 6, y: 7, color: black)
            setPixel(&grid, x: 9, y: 7, color: black)
        }
    }

    func drawStarWarsStormtrooper(grid: inout [[NSColor]], frame: Int) {
        let white = NSColor.white
        let black = NSColor.black
        let gray = NSColor(red: 0.65, green: 0.65, blue: 0.68, alpha: 1.0)
        let darkGray = NSColor(red: 0.4, green: 0.4, blue: 0.43, alpha: 1.0)
        for x in 6...9 { setPixel(&grid, x: x, y: 0, color: white) }
        setPixel(&grid, x: 6, y: 0, color: gray)
        setPixel(&grid, x: 9, y: 0, color: gray)
        for x in 5...10 { setPixel(&grid, x: x, y: 1, color: white) }
        setPixel(&grid, x: 5, y: 1, color: gray)
        setPixel(&grid, x: 10, y: 1, color: gray)
        for x in 5...10 { setPixel(&grid, x: x, y: 2, color: white) }
        setPixel(&grid, x: 6, y: 2, color: black)
        setPixel(&grid, x: 9, y: 2, color: black)
        setPixel(&grid, x: 7, y: 2, color: darkGray)
        setPixel(&grid, x: 8, y: 2, color: darkGray)
        for x in 4...11 { setPixel(&grid, x: x, y: 3, color: white) }
        setPixel(&grid, x: 7, y: 3, color: black)
        setPixel(&grid, x: 8, y: 3, color: black)
        setPixel(&grid, x: 4, y: 3, color: gray)
        setPixel(&grid, x: 11, y: 3, color: gray)
        for x in 4...11 { setPixel(&grid, x: x, y: 4, color: white) }
        for x in 4...11 { setPixel(&grid, x: x, y: 5, color: white) }
        setPixel(&grid, x: 4, y: 5, color: darkGray)
        setPixel(&grid, x: 11, y: 5, color: darkGray)
        for x in 5...10 { setPixel(&grid, x: x, y: 6, color: white) }
        if frame % 2 == 0 {
            setPixel(&grid, x: 5, y: 7, color: gray)
            setPixel(&grid, x: 10, y: 7, color: gray)
        } else {
            setPixel(&grid, x: 6, y: 7, color: gray)
            setPixel(&grid, x: 9, y: 7, color: gray)
        }
    }

    func drawStarWarsGrogu(grid: inout [[NSColor]], frame: Int) {
        let green = NSColor(red: 0.4, green: 0.75, blue: 0.35, alpha: 1.0)
        let darkGreen = NSColor(red: 0.3, green: 0.55, blue: 0.25, alpha: 1.0)
        let brown = NSColor(red: 0.55, green: 0.35, blue: 0.15, alpha: 1.0)
        let white = NSColor.white
        let black = NSColor.black
        let anim = frame % 2

        // Big ears
        setPixel(&grid, x: 3, y: 1, color: green); setPixel(&grid, x: 3, y: 2, color: green)
        setPixel(&grid, x: 12, y: 1, color: green); setPixel(&grid, x: 12, y: 2, color: green)
        setPixel(&grid, x: 2, y: 2, color: darkGreen); setPixel(&grid, x: 13, y: 2, color: darkGreen)

        // Head (green)
        for x in 4...11 { setPixel(&grid, x: x, y: 0, color: green) }
        for x in 4...11 { setPixel(&grid, x: x, y: 1, color: green) }
        for x in 4...11 { setPixel(&grid, x: x, y: 2, color: green) }
        for x in 5...10 { setPixel(&grid, x: x, y: 3, color: green) }

        // Eyes (big, cute, black)
        setPixel(&grid, x: 5, y: 1, color: black); setPixel(&grid, x: 5, y: 2, color: black)
        setPixel(&grid, x: 10, y: 1, color: black); setPixel(&grid, x: 10, y: 2, color: black)

        // Robe (brown)
        for x in 4...11 { setPixel(&grid, x: x, y: 4, color: brown) }
        for x in 4...11 { setPixel(&grid, x: x, y: 5, color: brown) }
        for x in 5...10 { setPixel(&grid, x: x, y: 6, color: brown) }

        // Arms
        setPixel(&grid, x: 3, y: 4, color: green); setPixel(&grid, x: 12, y: 4, color: green)

        // Feet
        if anim == 0 {
            setPixel(&grid, x: 5, y: 7, color: brown); setPixel(&grid, x: 10, y: 7, color: brown)
        } else {
            setPixel(&grid, x: 4, y: 7, color: brown); setPixel(&grid, x: 11, y: 7, color: brown)
        }
    }

    func drawStarWarsMandalorian(grid: inout [[NSColor]], frame: Int) {
        let silver = NSColor(red: 0.7, green: 0.7, blue: 0.75, alpha: 1.0)
        let darkGray = NSColor(red: 0.4, green: 0.4, blue: 0.43, alpha: 1.0)
        let black = NSColor.black
        let orange = NSColor(red: 0.85, green: 0.5, blue: 0.1, alpha: 1.0)
        let brown = NSColor(red: 0.5, green: 0.3, blue: 0.12, alpha: 1.0)
        let anim = frame % 2

        // Helmet (silver with T-visor)
        for x in 5...10 { setPixel(&grid, x: x, y: 0, color: silver) }
        for x in 4...11 { setPixel(&grid, x: x, y: 1, color: silver) }
        for x in 4...11 { setPixel(&grid, x: x, y: 2, color: silver) }
        for x in 5...10 { setPixel(&grid, x: x, y: 3, color: silver) }

        // T-visor (black)
        setPixel(&grid, x: 7, y: 1, color: black); setPixel(&grid, x: 8, y: 1, color: black)
        setPixel(&grid, x: 7, y: 2, color: black); setPixel(&grid, x: 8, y: 2, color: black)
        setPixel(&grid, x: 6, y: 2, color: black); setPixel(&grid, x: 9, y: 2, color: black)

        // Body (silver armor with brown cape)
        for x in 4...11 { setPixel(&grid, x: x, y: 4, color: silver) }
        for x in 4...11 { setPixel(&grid, x: x, y: 5, color: darkGray) }
        for x in 4...11 { setPixel(&grid, x: x, y: 6, color: brown) }

        // Cape (brown)
        setPixel(&grid, x: 3, y: 4, color: brown); setPixel(&grid, x: 3, y: 5, color: brown)
        setPixel(&grid, x: 12, y: 4, color: brown); setPixel(&grid, x: 12, y: 5, color: brown)

        // Belt (orange)
        setPixel(&grid, x: 7, y: 5, color: orange); setPixel(&grid, x: 8, y: 5, color: orange)

        // Legs
        if anim == 0 {
            setPixel(&grid, x: 5, y: 7, color: darkGray); setPixel(&grid, x: 10, y: 7, color: darkGray)
        } else {
            setPixel(&grid, x: 4, y: 7, color: darkGray); setPixel(&grid, x: 11, y: 7, color: darkGray)
        }
    }
}
