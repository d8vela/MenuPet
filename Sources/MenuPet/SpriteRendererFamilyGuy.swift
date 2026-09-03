import AppKit

extension SpriteRenderer {
    // MARK: - Family Guy
    func drawFamilyGuyPeter(grid: inout [[NSColor]], frame: Int) {
        let hairBrown = NSColor(red: 0.45, green: 0.3, blue: 0.18, alpha: 1.0)
        let skin = NSColor(red: 0.96, green: 0.84, blue: 0.74, alpha: 1.0)
        let white = NSColor.white
        let black = NSColor.black
        let green = NSColor(red: 0.15, green: 0.62, blue: 0.22, alpha: 1.0)
        let beltBrown = NSColor(red: 0.32, green: 0.2, blue: 0.1, alpha: 1.0)
        let buckleGold = NSColor(red: 0.88, green: 0.78, blue: 0.2, alpha: 1.0)
        let shoeBrown = NSColor(red: 0.38, green: 0.24, blue: 0.14, alpha: 1.0)

        for x in 6...9 { setPixel(&grid, x: x, y: 0, color: hairBrown) }
        for x in 5...10 { setPixel(&grid, x: x, y: 1, color: hairBrown) }
        for x in 5...10 { setPixel(&grid, x: x, y: 2, color: skin) }
        setPixel(&grid, x: 6, y: 2, color: black)
        setPixel(&grid, x: 7, y: 2, color: white)
        setPixel(&grid, x: 8, y: 2, color: white)
        setPixel(&grid, x: 9, y: 2, color: black)
        for x in 4...11 { setPixel(&grid, x: x, y: 3, color: skin) }
        setPixel(&grid, x: 7, y: 3, color: NSColor(red: 0.8, green: 0.5, blue: 0.45, alpha: 1.0))
        setPixel(&grid, x: 8, y: 3, color: NSColor(red: 0.8, green: 0.5, blue: 0.45, alpha: 1.0))
        for x in 4...11 { setPixel(&grid, x: x, y: 4, color: white) }
        for x in 4...11 { setPixel(&grid, x: x, y: 5, color: white) }
        setPixel(&grid, x: 5, y: 5, color: beltBrown)
        setPixel(&grid, x: 6, y: 5, color: beltBrown)
        setPixel(&grid, x: 7, y: 5, color: buckleGold)
        setPixel(&grid, x: 8, y: 5, color: buckleGold)
        setPixel(&grid, x: 9, y: 5, color: beltBrown)
        setPixel(&grid, x: 10, y: 5, color: beltBrown)
        for x in 4...11 { setPixel(&grid, x: x, y: 6, color: green) }

        if frame % 2 == 0 {
            setPixel(&grid, x: 5, y: 7, color: shoeBrown)
            setPixel(&grid, x: 10, y: 7, color: shoeBrown)
        } else {
            setPixel(&grid, x: 6, y: 7, color: shoeBrown)
            setPixel(&grid, x: 9, y: 7, color: shoeBrown)
        }
    }

    func drawFamilyGuyLois(grid: inout [[NSColor]], frame: Int) {
        let hairGinger = NSColor(red: 0.88, green: 0.38, blue: 0.15, alpha: 1.0)
        let skin = NSColor(red: 0.96, green: 0.84, blue: 0.76, alpha: 1.0)
        let tealEarring = NSColor(red: 0.15, green: 0.7, blue: 0.65, alpha: 1.0)
        let mintShirt = NSColor(red: 0.52, green: 0.82, blue: 0.72, alpha: 1.0)
        let khaki = NSColor(red: 0.82, green: 0.74, blue: 0.58, alpha: 1.0)
        let lipsRed = NSColor(red: 0.88, green: 0.25, blue: 0.25, alpha: 1.0)
        let magentaShoe = NSColor(red: 0.72, green: 0.2, blue: 0.35, alpha: 1.0)
        let black = NSColor.black

        for x in 5...10 { setPixel(&grid, x: x, y: 0, color: hairGinger) }
        for x in 4...11 { setPixel(&grid, x: x, y: 1, color: hairGinger) }
        for x in 5...10 { setPixel(&grid, x: x, y: 2, color: skin) }
        setPixel(&grid, x: 4, y: 2, color: tealEarring)
        setPixel(&grid, x: 11, y: 2, color: tealEarring)
        setPixel(&grid, x: 6, y: 2, color: black)
        setPixel(&grid, x: 9, y: 2, color: black)
        for x in 5...10 { setPixel(&grid, x: x, y: 3, color: skin) }
        setPixel(&grid, x: 4, y: 3, color: hairGinger)
        setPixel(&grid, x: 11, y: 3, color: hairGinger)
        setPixel(&grid, x: 7, y: 3, color: lipsRed)
        setPixel(&grid, x: 8, y: 3, color: lipsRed)
        for x in 5...10 { setPixel(&grid, x: x, y: 4, color: mintShirt) }
        setPixel(&grid, x: 4, y: 4, color: skin)
        setPixel(&grid, x: 11, y: 4, color: skin)
        for x in 5...10 { setPixel(&grid, x: x, y: 5, color: mintShirt) }
        for x in 5...10 { setPixel(&grid, x: x, y: 6, color: khaki) }

        if frame % 2 == 0 {
            setPixel(&grid, x: 5, y: 7, color: magentaShoe)
            setPixel(&grid, x: 10, y: 7, color: magentaShoe)
        } else {
            setPixel(&grid, x: 6, y: 7, color: magentaShoe)
            setPixel(&grid, x: 9, y: 7, color: magentaShoe)
        }
    }

    func drawFamilyGuyStewie(grid: inout [[NSColor]], frame: Int) {
        let skin = NSColor(red: 0.96, green: 0.85, blue: 0.74, alpha: 1.0)
        let black = NSColor.black
        let red = NSColor(red: 0.85, green: 0.15, blue: 0.15, alpha: 1.0)
        let yellow = NSColor(red: 0.95, green: 0.85, blue: 0.2, alpha: 1.0)
        let blue = NSColor(red: 0.2, green: 0.45, blue: 0.8, alpha: 1.0)

        // Strands of hair
        setPixel(&grid, x: 5, y: 0, color: black)
        setPixel(&grid, x: 7, y: 0, color: black)
        setPixel(&grid, x: 9, y: 0, color: black)
        setPixel(&grid, x: 11, y: 0, color: black)

        // Wide football head
        for x in 4...11 { setPixel(&grid, x: x, y: 1, color: skin) }
        for x in 3...12 { setPixel(&grid, x: x, y: 2, color: skin) }
        setPixel(&grid, x: 6, y: 2, color: black)
        setPixel(&grid, x: 9, y: 2, color: black)
        for x in 4...11 { setPixel(&grid, x: x, y: 3, color: skin) }
        setPixel(&grid, x: 7, y: 3, color: NSColor(red: 0.8, green: 0.45, blue: 0.4, alpha: 1.0))
        setPixel(&grid, x: 8, y: 3, color: NSColor(red: 0.8, green: 0.45, blue: 0.4, alpha: 1.0))

        // Yellow shirt with red overalls
        for x in 5...10 { setPixel(&grid, x: x, y: 4, color: yellow) }
        setPixel(&grid, x: 6, y: 4, color: red)
        setPixel(&grid, x: 9, y: 4, color: red)
        setPixel(&grid, x: 4, y: 4, color: skin)
        setPixel(&grid, x: 11, y: 4, color: skin)

        for x in 5...10 { setPixel(&grid, x: x, y: 5, color: red) }
        setPixel(&grid, x: 6, y: 5, color: yellow)
        setPixel(&grid, x: 9, y: 5, color: yellow)

        for x in 5...10 { setPixel(&grid, x: x, y: 6, color: red) }

        if frame % 2 == 0 {
            setPixel(&grid, x: 5, y: 7, color: blue)
            setPixel(&grid, x: 10, y: 7, color: blue)
        } else {
            setPixel(&grid, x: 6, y: 7, color: blue)
            setPixel(&grid, x: 9, y: 7, color: blue)
        }
    }

    func drawFamilyGuyBrian(grid: inout [[NSColor]], frame: Int) {
        let white = NSColor.white
        let black = NSColor.black
        let redCollar = NSColor(red: 0.85, green: 0.15, blue: 0.15, alpha: 1.0)
        let goldTag = NSColor(red: 0.95, green: 0.82, blue: 0.15, alpha: 1.0)
        let earGray = NSColor(red: 0.88, green: 0.88, blue: 0.9, alpha: 1.0)

        for x in 6...9 { setPixel(&grid, x: x, y: 0, color: white) }
        for x in 5...10 { setPixel(&grid, x: x, y: 1, color: white) }
        setPixel(&grid, x: 4, y: 1, color: earGray)
        setPixel(&grid, x: 11, y: 1, color: earGray)
        for x in 5...10 { setPixel(&grid, x: x, y: 2, color: white) }
        setPixel(&grid, x: 4, y: 2, color: earGray)
        setPixel(&grid, x: 11, y: 2, color: earGray)
        setPixel(&grid, x: 6, y: 2, color: black)
        setPixel(&grid, x: 9, y: 2, color: black)
        for x in 5...10 { setPixel(&grid, x: x, y: 3, color: white) }
        setPixel(&grid, x: 7, y: 3, color: black)
        setPixel(&grid, x: 8, y: 3, color: black)

        // Red collar with gold tag
        for x in 5...10 { setPixel(&grid, x: x, y: 4, color: redCollar) }
        setPixel(&grid, x: 7, y: 4, color: goldTag)
        setPixel(&grid, x: 8, y: 4, color: goldTag)

        for x in 5...10 { setPixel(&grid, x: x, y: 5, color: white) }
        for x in 5...10 { setPixel(&grid, x: x, y: 6, color: white) }

        if frame % 2 == 0 {
            setPixel(&grid, x: 5, y: 7, color: earGray)
            setPixel(&grid, x: 10, y: 7, color: earGray)
        } else {
            setPixel(&grid, x: 6, y: 7, color: earGray)
            setPixel(&grid, x: 9, y: 7, color: earGray)
        }
    }

    func drawFamilyGuyChris(grid: inout [[NSColor]], frame: Int) {
        let capBlue = NSColor(red: 0.15, green: 0.35, blue: 0.75, alpha: 1.0)
        let capRed = NSColor(red: 0.85, green: 0.2, blue: 0.15, alpha: 1.0)
        let hairBlonde = NSColor(red: 0.95, green: 0.82, blue: 0.35, alpha: 1.0)
        let skin = NSColor(red: 0.96, green: 0.84, blue: 0.74, alpha: 1.0)
        let shirtBlue = NSColor(red: 0.2, green: 0.45, blue: 0.8, alpha: 1.0)
        let black = NSColor.black
        let redShoe = NSColor(red: 0.85, green: 0.2, blue: 0.2, alpha: 1.0)

        for x in 5...10 { setPixel(&grid, x: x, y: 0, color: capBlue) }
        for x in 4...11 { setPixel(&grid, x: x, y: 1, color: capBlue) }
        setPixel(&grid, x: 7, y: 1, color: capRed)
        setPixel(&grid, x: 8, y: 1, color: capRed)
        for x in 5...10 { setPixel(&grid, x: x, y: 2, color: skin) }
        setPixel(&grid, x: 4, y: 2, color: hairBlonde)
        setPixel(&grid, x: 11, y: 2, color: hairBlonde)
        setPixel(&grid, x: 6, y: 2, color: black)
        setPixel(&grid, x: 9, y: 2, color: black)
        for x in 5...10 { setPixel(&grid, x: x, y: 3, color: skin) }
        setPixel(&grid, x: 4, y: 3, color: hairBlonde)
        setPixel(&grid, x: 11, y: 3, color: hairBlonde)
        for x in 4...11 { setPixel(&grid, x: x, y: 4, color: shirtBlue) }
        for x in 4...11 { setPixel(&grid, x: x, y: 5, color: shirtBlue) }
        for x in 4...11 { setPixel(&grid, x: x, y: 6, color: black) }

        if frame % 2 == 0 {
            setPixel(&grid, x: 5, y: 7, color: redShoe)
            setPixel(&grid, x: 10, y: 7, color: redShoe)
        } else {
            setPixel(&grid, x: 6, y: 7, color: redShoe)
            setPixel(&grid, x: 9, y: 7, color: redShoe)
        }
    }

    func drawFamilyGuyMeg(grid: inout [[NSColor]], frame: Int) {
        let beaniePink = NSColor(red: 0.85, green: 0.35, blue: 0.6, alpha: 1.0)
        let hairBrown = NSColor(red: 0.45, green: 0.3, blue: 0.18, alpha: 1.0)
        let skin = NSColor(red: 0.96, green: 0.84, blue: 0.74, alpha: 1.0)
        let shirtPink = NSColor(red: 0.95, green: 0.55, blue: 0.72, alpha: 1.0)
        let jeansBlue = NSColor(red: 0.22, green: 0.38, blue: 0.65, alpha: 1.0)
        let white = NSColor.white
        let black = NSColor.black

        for x in 5...10 { setPixel(&grid, x: x, y: 0, color: beaniePink) }
        for x in 4...11 { setPixel(&grid, x: x, y: 1, color: beaniePink) }
        for x in 5...10 { setPixel(&grid, x: x, y: 2, color: skin) }
        setPixel(&grid, x: 4, y: 2, color: hairBrown)
        setPixel(&grid, x: 11, y: 2, color: hairBrown)
        setPixel(&grid, x: 6, y: 2, color: black)
        setPixel(&grid, x: 7, y: 2, color: white)
        setPixel(&grid, x: 8, y: 2, color: white)
        setPixel(&grid, x: 9, y: 2, color: black)
        for x in 5...10 { setPixel(&grid, x: x, y: 3, color: skin) }
        setPixel(&grid, x: 4, y: 3, color: hairBrown)
        setPixel(&grid, x: 11, y: 3, color: hairBrown)
        for x in 5...10 { setPixel(&grid, x: x, y: 4, color: shirtPink) }
        setPixel(&grid, x: 7, y: 4, color: white)
        setPixel(&grid, x: 8, y: 4, color: white)
        setPixel(&grid, x: 4, y: 4, color: skin)
        setPixel(&grid, x: 11, y: 4, color: skin)
        for x in 5...10 { setPixel(&grid, x: x, y: 5, color: shirtPink) }
        for x in 5...10 { setPixel(&grid, x: x, y: 6, color: jeansBlue) }

        if frame % 2 == 0 {
            setPixel(&grid, x: 5, y: 7, color: white)
            setPixel(&grid, x: 10, y: 7, color: white)
        } else {
            setPixel(&grid, x: 6, y: 7, color: white)
            setPixel(&grid, x: 9, y: 7, color: white)
        }
    }

    func drawFamilyGuyQuagmire(grid: inout [[NSColor]], frame: Int) {
        let hairBlack = NSColor(red: 0.1, green: 0.1, blue: 0.1, alpha: 1.0)
        let skin = NSColor(red: 0.95, green: 0.8, blue: 0.7, alpha: 1.0)
        let shirtRed = NSColor(red: 0.88, green: 0.15, blue: 0.15, alpha: 1.0)
        let flowerYellow = NSColor(red: 0.95, green: 0.85, blue: 0.2, alpha: 1.0)
        let blueJeans = NSColor(red: 0.22, green: 0.38, blue: 0.65, alpha: 1.0)
        let shoeBrown = NSColor(red: 0.4, green: 0.25, blue: 0.15, alpha: 1.0)
        let black = NSColor.black

        for x in 6...9 { setPixel(&grid, x: x, y: 0, color: hairBlack) }
        for x in 5...10 { setPixel(&grid, x: x, y: 1, color: hairBlack) }
        for x in 5...10 { setPixel(&grid, x: x, y: 2, color: skin) }
        setPixel(&grid, x: 6, y: 2, color: black)
        setPixel(&grid, x: 9, y: 2, color: black)
        // Huge cleft jaw
        for x in 4...11 { setPixel(&grid, x: x, y: 3, color: skin) }
        setPixel(&grid, x: 7, y: 3, color: NSColor(red: 0.8, green: 0.5, blue: 0.45, alpha: 1.0))
        setPixel(&grid, x: 8, y: 3, color: NSColor(red: 0.8, green: 0.5, blue: 0.45, alpha: 1.0))
        for x in 4...11 { setPixel(&grid, x: x, y: 4, color: shirtRed) }
        setPixel(&grid, x: 5, y: 4, color: flowerYellow)
        setPixel(&grid, x: 10, y: 4, color: flowerYellow)
        for x in 5...10 { setPixel(&grid, x: x, y: 5, color: shirtRed) }
        setPixel(&grid, x: 7, y: 5, color: flowerYellow)
        for x in 5...10 { setPixel(&grid, x: x, y: 6, color: blueJeans) }

        if frame % 2 == 0 {
            setPixel(&grid, x: 5, y: 7, color: shoeBrown)
            setPixel(&grid, x: 10, y: 7, color: shoeBrown)
        } else {
            setPixel(&grid, x: 6, y: 7, color: shoeBrown)
            setPixel(&grid, x: 9, y: 7, color: shoeBrown)
        }
    }

    func drawFamilyGuyCleveland(grid: inout [[NSColor]], frame: Int) {
        let afroBlack = NSColor(red: 0.12, green: 0.12, blue: 0.12, alpha: 1.0)
        let skin = NSColor(red: 0.65, green: 0.42, blue: 0.28, alpha: 1.0)
        let shirtYellow = NSColor(red: 0.95, green: 0.85, blue: 0.15, alpha: 1.0)
        let jeansBlue = NSColor(red: 0.22, green: 0.38, blue: 0.65, alpha: 1.0)
        let shoeBlue = NSColor(red: 0.15, green: 0.25, blue: 0.5, alpha: 1.0)
        let black = NSColor.black

        for x in 5...10 { setPixel(&grid, x: x, y: 0, color: afroBlack) }
        for x in 5...10 { setPixel(&grid, x: x, y: 1, color: afroBlack) }
        for x in 5...10 { setPixel(&grid, x: x, y: 2, color: skin) }
        setPixel(&grid, x: 6, y: 2, color: black)
        setPixel(&grid, x: 9, y: 2, color: black)
        for x in 5...10 { setPixel(&grid, x: x, y: 3, color: skin) }
        // Mustache
        for x in 6...9 { setPixel(&grid, x: x, y: 3, color: afroBlack) }
        for x in 4...11 { setPixel(&grid, x: x, y: 4, color: shirtYellow) }
        for x in 5...10 { setPixel(&grid, x: x, y: 5, color: shirtYellow) }
        for x in 5...10 { setPixel(&grid, x: x, y: 6, color: jeansBlue) }

        if frame % 2 == 0 {
            setPixel(&grid, x: 5, y: 7, color: shoeBlue)
            setPixel(&grid, x: 10, y: 7, color: shoeBlue)
        } else {
            setPixel(&grid, x: 6, y: 7, color: shoeBlue)
            setPixel(&grid, x: 9, y: 7, color: shoeBlue)
        }
    }

    func drawFamilyGuyJoe(grid: inout [[NSColor]], frame: Int) {
        let hairBrown = NSColor(red: 0.42, green: 0.28, blue: 0.16, alpha: 1.0)
        let skin = NSColor(red: 0.95, green: 0.8, blue: 0.72, alpha: 1.0)
        let shirtGray = NSColor(red: 0.65, green: 0.68, blue: 0.72, alpha: 1.0)
        let pantsBlue = NSColor(red: 0.18, green: 0.25, blue: 0.45, alpha: 1.0)
        let metalSilver = NSColor(red: 0.78, green: 0.8, blue: 0.85, alpha: 1.0)
        let wheelYellow = NSColor(red: 0.95, green: 0.82, blue: 0.15, alpha: 1.0)
        let black = NSColor.black

        for x in 6...9 { setPixel(&grid, x: x, y: 0, color: hairBrown) }
        for x in 5...10 { setPixel(&grid, x: x, y: 1, color: hairBrown) }
        for x in 5...10 { setPixel(&grid, x: x, y: 2, color: skin) }
        setPixel(&grid, x: 6, y: 2, color: black)
        setPixel(&grid, x: 9, y: 2, color: black)
        // Big cleft jaw
        for x in 4...11 { setPixel(&grid, x: x, y: 3, color: skin) }
        setPixel(&grid, x: 7, y: 3, color: NSColor(red: 0.8, green: 0.5, blue: 0.45, alpha: 1.0))
        setPixel(&grid, x: 8, y: 3, color: NSColor(red: 0.8, green: 0.5, blue: 0.45, alpha: 1.0))
        for x in 4...11 { setPixel(&grid, x: x, y: 4, color: shirtGray) }
        // Wheelchair back and wheels
        setPixel(&grid, x: 3, y: 4, color: metalSilver)
        setPixel(&grid, x: 12, y: 4, color: metalSilver)
        for x in 5...10 { setPixel(&grid, x: x, y: 5, color: pantsBlue) }
        setPixel(&grid, x: 3, y: 5, color: metalSilver)
        setPixel(&grid, x: 12, y: 5, color: metalSilver)
        for x in 5...10 { setPixel(&grid, x: x, y: 6, color: pantsBlue) }
        setPixel(&grid, x: 3, y: 6, color: wheelYellow)
        setPixel(&grid, x: 12, y: 6, color: wheelYellow)

        // Rolling wheelchair wheel animation
        if frame % 2 == 0 {
            setPixel(&grid, x: 3, y: 7, color: black)
            setPixel(&grid, x: 4, y: 7, color: metalSilver)
            setPixel(&grid, x: 11, y: 7, color: metalSilver)
            setPixel(&grid, x: 12, y: 7, color: black)
        } else {
            setPixel(&grid, x: 3, y: 7, color: metalSilver)
            setPixel(&grid, x: 4, y: 7, color: black)
            setPixel(&grid, x: 11, y: 7, color: black)
            setPixel(&grid, x: 12, y: 7, color: metalSilver)
        }
    }

    func drawFamilyGuyAdamWest(grid: inout [[NSColor]], frame: Int) {
        let hairGray = NSColor(red: 0.75, green: 0.75, blue: 0.78, alpha: 1.0)
        let skin = NSColor(red: 0.94, green: 0.8, blue: 0.72, alpha: 1.0)
        let suitNavy = NSColor(red: 0.15, green: 0.22, blue: 0.4, alpha: 1.0)
        let tieRed = NSColor(red: 0.85, green: 0.15, blue: 0.15, alpha: 1.0)
        let white = NSColor.white
        let black = NSColor.black

        for x in 6...9 { setPixel(&grid, x: x, y: 0, color: hairGray) }
        for x in 5...10 { setPixel(&grid, x: x, y: 1, color: hairGray) }
        for x in 5...10 { setPixel(&grid, x: x, y: 2, color: skin) }
        setPixel(&grid, x: 6, y: 2, color: black)
        setPixel(&grid, x: 9, y: 2, color: black)
        for x in 5...10 { setPixel(&grid, x: x, y: 3, color: skin) }
        for x in 4...11 { setPixel(&grid, x: x, y: 4, color: suitNavy) }
        setPixel(&grid, x: 7, y: 4, color: white)
        setPixel(&grid, x: 8, y: 4, color: tieRed)
        for x in 4...11 { setPixel(&grid, x: x, y: 5, color: suitNavy) }
        setPixel(&grid, x: 7, y: 5, color: tieRed)
        setPixel(&grid, x: 8, y: 5, color: tieRed)
        for x in 5...10 { setPixel(&grid, x: x, y: 6, color: suitNavy) }

        if frame % 2 == 0 {
            setPixel(&grid, x: 5, y: 7, color: black)
            setPixel(&grid, x: 10, y: 7, color: black)
        } else {
            setPixel(&grid, x: 6, y: 7, color: black)
            setPixel(&grid, x: 9, y: 7, color: black)
        }
    }

    func drawFamilyGuyHerbert(grid: inout [[NSColor]], frame: Int) {
        let skinPale = NSColor(red: 0.94, green: 0.84, blue: 0.78, alpha: 1.0)
        let whiteHair = NSColor(red: 0.9, green: 0.9, blue: 0.92, alpha: 1.0)
        let robeBlue = NSColor(red: 0.65, green: 0.78, blue: 0.88, alpha: 1.0)
        let slipperGray = NSColor(red: 0.55, green: 0.55, blue: 0.6, alpha: 1.0)
        let black = NSColor.black

        for x in 6...9 { setPixel(&grid, x: x, y: 0, color: skinPale) }
        for x in 6...9 { setPixel(&grid, x: x, y: 1, color: skinPale) }
        setPixel(&grid, x: 5, y: 1, color: whiteHair)
        setPixel(&grid, x: 10, y: 1, color: whiteHair)
        for x in 5...10 { setPixel(&grid, x: x, y: 2, color: skinPale) }
        setPixel(&grid, x: 4, y: 2, color: whiteHair)
        setPixel(&grid, x: 11, y: 2, color: whiteHair)
        setPixel(&grid, x: 6, y: 2, color: black)
        setPixel(&grid, x: 9, y: 2, color: black)
        for x in 5...10 { setPixel(&grid, x: x, y: 3, color: skinPale) }
        // Long drooping nose
        setPixel(&grid, x: 7, y: 3, color: NSColor(red: 0.85, green: 0.65, blue: 0.6, alpha: 1.0))
        setPixel(&grid, x: 8, y: 3, color: NSColor(red: 0.85, green: 0.65, blue: 0.6, alpha: 1.0))
        for x in 4...11 { setPixel(&grid, x: x, y: 4, color: robeBlue) }
        for x in 4...11 { setPixel(&grid, x: x, y: 5, color: robeBlue) }
        for x in 5...10 { setPixel(&grid, x: x, y: 6, color: robeBlue) }

        if frame % 2 == 0 {
            setPixel(&grid, x: 5, y: 7, color: slipperGray)
            setPixel(&grid, x: 10, y: 7, color: slipperGray)
        } else {
            setPixel(&grid, x: 6, y: 7, color: slipperGray)
            setPixel(&grid, x: 9, y: 7, color: slipperGray)
        }
    }

    func drawFamilyGuyTomTucker(grid: inout [[NSColor]], frame: Int) {
        let hairBrown = NSColor(red: 0.38, green: 0.24, blue: 0.14, alpha: 1.0)
        let skin = NSColor(red: 0.95, green: 0.82, blue: 0.72, alpha: 1.0)
        let suitCharcoal = NSColor(red: 0.25, green: 0.25, blue: 0.28, alpha: 1.0)
        let tieBlue = NSColor(red: 0.2, green: 0.45, blue: 0.85, alpha: 1.0)
        let white = NSColor.white
        let black = NSColor.black

        for x in 5...10 { setPixel(&grid, x: x, y: 0, color: hairBrown) }
        for x in 5...10 { setPixel(&grid, x: x, y: 1, color: hairBrown) }
        for x in 5...10 { setPixel(&grid, x: x, y: 2, color: skin) }
        setPixel(&grid, x: 6, y: 2, color: black)
        setPixel(&grid, x: 9, y: 2, color: black)
        for x in 5...10 { setPixel(&grid, x: x, y: 3, color: skin) }
        // Mustache
        for x in 6...9 { setPixel(&grid, x: x, y: 3, color: hairBrown) }
        for x in 4...11 { setPixel(&grid, x: x, y: 4, color: suitCharcoal) }
        setPixel(&grid, x: 7, y: 4, color: white)
        setPixel(&grid, x: 8, y: 4, color: tieBlue)
        for x in 4...11 { setPixel(&grid, x: x, y: 5, color: suitCharcoal) }
        setPixel(&grid, x: 7, y: 5, color: tieBlue)
        setPixel(&grid, x: 8, y: 5, color: tieBlue)
        for x in 5...10 { setPixel(&grid, x: x, y: 6, color: suitCharcoal) }

        if frame % 2 == 0 {
            setPixel(&grid, x: 5, y: 7, color: black)
            setPixel(&grid, x: 10, y: 7, color: black)
        } else {
            setPixel(&grid, x: 6, y: 7, color: black)
            setPixel(&grid, x: 9, y: 7, color: black)
        }
    }
}
