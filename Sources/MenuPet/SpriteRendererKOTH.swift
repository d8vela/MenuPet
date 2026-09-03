import AppKit

extension SpriteRenderer {
    // MARK: - King of the Hill
    func drawKOTHHank(grid: inout [[NSColor]], frame: Int) {
        let hairBrown = NSColor(red: 0.42, green: 0.28, blue: 0.16, alpha: 1.0)
        let skin = NSColor(red: 0.96, green: 0.82, blue: 0.72, alpha: 1.0)
        let white = NSColor.white
        let black = NSColor.black
        let jeansBlue = NSColor(red: 0.22, green: 0.38, blue: 0.65, alpha: 1.0)
        let beltBrown = NSColor(red: 0.3, green: 0.18, blue: 0.1, alpha: 1.0)
        let buckleGold = NSColor(red: 0.85, green: 0.75, blue: 0.2, alpha: 1.0)
        let shoeBrown = NSColor(red: 0.4, green: 0.25, blue: 0.15, alpha: 1.0)

        for x in 6...9 { setPixel(&grid, x: x, y: 0, color: hairBrown) }
        for x in 5...10 { setPixel(&grid, x: x, y: 1, color: hairBrown) }
        for x in 5...10 { setPixel(&grid, x: x, y: 2, color: skin) }
        setPixel(&grid, x: 6, y: 2, color: black)
        setPixel(&grid, x: 7, y: 2, color: white)
        setPixel(&grid, x: 8, y: 2, color: white)
        setPixel(&grid, x: 9, y: 2, color: black)
        for x in 5...10 { setPixel(&grid, x: x, y: 3, color: skin) }
        setPixel(&grid, x: 7, y: 3, color: NSColor(red: 0.8, green: 0.5, blue: 0.4, alpha: 1.0))
        for x in 4...11 { setPixel(&grid, x: x, y: 4, color: white) }
        for x in 4...11 { setPixel(&grid, x: x, y: 5, color: white) }
        setPixel(&grid, x: 5, y: 5, color: beltBrown)
        setPixel(&grid, x: 6, y: 5, color: beltBrown)
        setPixel(&grid, x: 7, y: 5, color: buckleGold)
        setPixel(&grid, x: 8, y: 5, color: buckleGold)
        setPixel(&grid, x: 9, y: 5, color: beltBrown)
        setPixel(&grid, x: 10, y: 5, color: beltBrown)
        for x in 5...10 { setPixel(&grid, x: x, y: 6, color: jeansBlue) }

        if frame % 2 == 0 {
            setPixel(&grid, x: 5, y: 7, color: shoeBrown)
            setPixel(&grid, x: 10, y: 7, color: shoeBrown)
        } else {
            setPixel(&grid, x: 6, y: 7, color: shoeBrown)
            setPixel(&grid, x: 9, y: 7, color: shoeBrown)
        }
    }

    func drawKOTHPeggy(grid: inout [[NSColor]], frame: Int) {
        let hairBrown = NSColor(red: 0.45, green: 0.3, blue: 0.18, alpha: 1.0)
        let skin = NSColor(red: 0.95, green: 0.8, blue: 0.72, alpha: 1.0)
        let teal = NSColor(red: 0.15, green: 0.65, blue: 0.65, alpha: 1.0)
        let khaki = NSColor(red: 0.82, green: 0.74, blue: 0.58, alpha: 1.0)
        let white = NSColor.white
        let black = NSColor.black
        let lips = NSColor(red: 0.85, green: 0.4, blue: 0.45, alpha: 1.0)

        for x in 5...10 { setPixel(&grid, x: x, y: 0, color: hairBrown) }
        for x in 4...11 { setPixel(&grid, x: x, y: 1, color: hairBrown) }
        for x in 5...10 { setPixel(&grid, x: x, y: 2, color: skin) }
        setPixel(&grid, x: 4, y: 2, color: hairBrown)
        setPixel(&grid, x: 11, y: 2, color: hairBrown)
        setPixel(&grid, x: 6, y: 2, color: teal)
        setPixel(&grid, x: 7, y: 2, color: white)
        setPixel(&grid, x: 8, y: 2, color: white)
        setPixel(&grid, x: 9, y: 2, color: teal)
        for x in 5...10 { setPixel(&grid, x: x, y: 3, color: skin) }
        setPixel(&grid, x: 4, y: 3, color: hairBrown)
        setPixel(&grid, x: 11, y: 3, color: hairBrown)
        setPixel(&grid, x: 7, y: 3, color: lips)
        setPixel(&grid, x: 8, y: 3, color: lips)
        for x in 5...10 { setPixel(&grid, x: x, y: 4, color: teal) }
        setPixel(&grid, x: 4, y: 4, color: skin)
        setPixel(&grid, x: 11, y: 4, color: skin)
        for x in 5...10 { setPixel(&grid, x: x, y: 5, color: teal) }
        for x in 4...11 { setPixel(&grid, x: x, y: 6, color: khaki) }

        if frame % 2 == 0 {
            setPixel(&grid, x: 4, y: 7, color: white)
            setPixel(&grid, x: 5, y: 7, color: white)
            setPixel(&grid, x: 10, y: 7, color: white)
            setPixel(&grid, x: 11, y: 7, color: white)
        } else {
            setPixel(&grid, x: 5, y: 7, color: white)
            setPixel(&grid, x: 6, y: 7, color: white)
            setPixel(&grid, x: 9, y: 7, color: white)
            setPixel(&grid, x: 10, y: 7, color: white)
        }
    }

    func drawKOTHBobby(grid: inout [[NSColor]], frame: Int) {
        let hairBrown = NSColor(red: 0.6, green: 0.45, blue: 0.28, alpha: 1.0)
        let skin = NSColor(red: 0.96, green: 0.84, blue: 0.74, alpha: 1.0)
        let rosy = NSColor(red: 0.95, green: 0.7, blue: 0.7, alpha: 1.0)
        let white = NSColor.white
        let black = NSColor.black
        let olive = NSColor(red: 0.45, green: 0.5, blue: 0.3, alpha: 1.0)

        for x in 6...9 { setPixel(&grid, x: x, y: 0, color: hairBrown) }
        for x in 5...10 { setPixel(&grid, x: x, y: 1, color: hairBrown) }
        for x in 5...10 { setPixel(&grid, x: x, y: 2, color: skin) }
        setPixel(&grid, x: 6, y: 2, color: black)
        setPixel(&grid, x: 9, y: 2, color: black)
        for x in 4...11 { setPixel(&grid, x: x, y: 3, color: skin) }
        setPixel(&grid, x: 5, y: 3, color: rosy)
        setPixel(&grid, x: 10, y: 3, color: rosy)
        for x in 4...11 { setPixel(&grid, x: x, y: 4, color: white) }
        for x in 5...10 { setPixel(&grid, x: x, y: 5, color: white) }
        for x in 5...10 { setPixel(&grid, x: x, y: 6, color: olive) }

        if frame % 2 == 0 {
            setPixel(&grid, x: 5, y: 7, color: black)
            setPixel(&grid, x: 10, y: 7, color: black)
        } else {
            setPixel(&grid, x: 6, y: 7, color: black)
            setPixel(&grid, x: 9, y: 7, color: black)
        }
    }

    func drawKOTHDale(grid: inout [[NSColor]], frame: Int) {
        let orange = NSColor(red: 0.95, green: 0.45, blue: 0.08, alpha: 1.0)
        let white = NSColor.white
        let sunglasses = NSColor(red: 0.15, green: 0.15, blue: 0.15, alpha: 1.0)
        let skin = NSColor(red: 0.94, green: 0.8, blue: 0.7, alpha: 1.0)
        let stubble = NSColor(red: 0.7, green: 0.6, blue: 0.5, alpha: 1.0)
        let shirtTan = NSColor(red: 0.88, green: 0.78, blue: 0.45, alpha: 1.0)
        let blueJeans = NSColor(red: 0.25, green: 0.38, blue: 0.65, alpha: 1.0)
        let bootBrown = NSColor(red: 0.45, green: 0.28, blue: 0.15, alpha: 1.0)
        let cherryRed = NSColor(red: 0.95, green: 0.2, blue: 0.1, alpha: 1.0)

        for x in 5...10 { setPixel(&grid, x: x, y: 0, color: orange) }
        for x in 4...11 { setPixel(&grid, x: x, y: 1, color: orange) }
        setPixel(&grid, x: 7, y: 1, color: white)
        setPixel(&grid, x: 8, y: 1, color: white)
        for x in 5...10 { setPixel(&grid, x: x, y: 2, color: sunglasses) }
        for x in 5...10 { setPixel(&grid, x: x, y: 3, color: stubble) }
        setPixel(&grid, x: 3, y: 3, color: cherryRed)
        setPixel(&grid, x: 4, y: 3, color: white)
        for x in 5...10 { setPixel(&grid, x: x, y: 4, color: shirtTan) }
        setPixel(&grid, x: 4, y: 4, color: skin)
        setPixel(&grid, x: 11, y: 4, color: skin)
        for x in 5...10 { setPixel(&grid, x: x, y: 5, color: shirtTan) }
        for x in 5...10 { setPixel(&grid, x: x, y: 6, color: blueJeans) }

        if frame % 2 == 0 {
            setPixel(&grid, x: 5, y: 7, color: bootBrown)
            setPixel(&grid, x: 10, y: 7, color: bootBrown)
        } else {
            setPixel(&grid, x: 6, y: 7, color: bootBrown)
            setPixel(&grid, x: 9, y: 7, color: bootBrown)
        }
    }

    func drawKOTHBill(grid: inout [[NSColor]], frame: Int) {
        let skin = NSColor(red: 0.95, green: 0.8, blue: 0.7, alpha: 1.0)
        let darkBrown = NSColor(red: 0.25, green: 0.18, blue: 0.12, alpha: 1.0)
        let shadow = NSColor(red: 0.7, green: 0.62, blue: 0.55, alpha: 1.0)
        let white = NSColor.white
        let slate = NSColor(red: 0.4, green: 0.45, blue: 0.52, alpha: 1.0)
        let shoe = NSColor(red: 0.35, green: 0.3, blue: 0.28, alpha: 1.0)
        let black = NSColor.black

        for x in 6...9 { setPixel(&grid, x: x, y: 0, color: skin) }
        for x in 6...9 { setPixel(&grid, x: x, y: 1, color: skin) }
        setPixel(&grid, x: 5, y: 1, color: darkBrown)
        setPixel(&grid, x: 10, y: 1, color: darkBrown)
        for x in 5...10 { setPixel(&grid, x: x, y: 2, color: skin) }
        setPixel(&grid, x: 4, y: 2, color: darkBrown)
        setPixel(&grid, x: 11, y: 2, color: darkBrown)
        setPixel(&grid, x: 6, y: 2, color: black)
        setPixel(&grid, x: 9, y: 2, color: black)
        for x in 5...10 { setPixel(&grid, x: x, y: 3, color: shadow) }
        for x in 6...9 { setPixel(&grid, x: x, y: 4, color: white) }
        setPixel(&grid, x: 4, y: 4, color: skin)
        setPixel(&grid, x: 5, y: 4, color: skin)
        setPixel(&grid, x: 10, y: 4, color: skin)
        setPixel(&grid, x: 11, y: 4, color: skin)
        for x in 5...10 { setPixel(&grid, x: x, y: 5, color: white) }
        for x in 4...11 { setPixel(&grid, x: x, y: 6, color: slate) }

        if frame % 2 == 0 {
            setPixel(&grid, x: 5, y: 7, color: shoe)
            setPixel(&grid, x: 10, y: 7, color: shoe)
        } else {
            setPixel(&grid, x: 6, y: 7, color: shoe)
            setPixel(&grid, x: 9, y: 7, color: shoe)
        }
    }

    func drawKOTHBoomhauer(grid: inout [[NSColor]], frame: Int) {
        let blond = NSColor(red: 0.94, green: 0.84, blue: 0.38, alpha: 1.0)
        let skin = NSColor(red: 0.92, green: 0.76, blue: 0.62, alpha: 1.0)
        let black = NSColor(red: 0.12, green: 0.12, blue: 0.14, alpha: 1.0)
        let blueJeans = NSColor(red: 0.22, green: 0.36, blue: 0.62, alpha: 1.0)
        let cowboyBoot = NSColor(red: 0.5, green: 0.3, blue: 0.15, alpha: 1.0)
        let silver = NSColor(red: 0.8, green: 0.8, blue: 0.85, alpha: 1.0)

        for x in 5...10 { setPixel(&grid, x: x, y: 0, color: blond) }
        for x in 5...10 { setPixel(&grid, x: x, y: 1, color: blond) }
        for x in 5...10 { setPixel(&grid, x: x, y: 2, color: skin) }
        setPixel(&grid, x: 6, y: 2, color: black)
        setPixel(&grid, x: 9, y: 2, color: black)
        for x in 5...10 { setPixel(&grid, x: x, y: 3, color: skin) }
        for x in 4...11 { setPixel(&grid, x: x, y: 4, color: black) }
        for x in 5...10 { setPixel(&grid, x: x, y: 5, color: black) }
        setPixel(&grid, x: 7, y: 5, color: silver)
        setPixel(&grid, x: 8, y: 5, color: silver)
        for x in 5...10 { setPixel(&grid, x: x, y: 6, color: blueJeans) }

        if frame % 2 == 0 {
            setPixel(&grid, x: 5, y: 7, color: cowboyBoot)
            setPixel(&grid, x: 10, y: 7, color: cowboyBoot)
        } else {
            setPixel(&grid, x: 6, y: 7, color: cowboyBoot)
            setPixel(&grid, x: 9, y: 7, color: cowboyBoot)
        }
    }

    func drawKOTHLuanne(grid: inout [[NSColor]], frame: Int) {
        let blond = NSColor(red: 0.98, green: 0.88, blue: 0.35, alpha: 1.0)
        let skin = NSColor(red: 0.96, green: 0.82, blue: 0.74, alpha: 1.0)
        let blue = NSColor(red: 0.2, green: 0.5, blue: 0.8, alpha: 1.0)
        let pink = NSColor(red: 0.95, green: 0.55, blue: 0.7, alpha: 1.0)
        let purple = NSColor(red: 0.55, green: 0.32, blue: 0.68, alpha: 1.0)
        let white = NSColor.white

        for x in 5...10 { setPixel(&grid, x: x, y: 0, color: blond) }
        for x in 4...11 { setPixel(&grid, x: x, y: 1, color: blond) }
        for x in 5...10 { setPixel(&grid, x: x, y: 2, color: skin) }
        setPixel(&grid, x: 4, y: 2, color: blond)
        setPixel(&grid, x: 11, y: 2, color: blond)
        setPixel(&grid, x: 6, y: 2, color: blue)
        setPixel(&grid, x: 9, y: 2, color: blue)
        for x in 5...10 { setPixel(&grid, x: x, y: 3, color: skin) }
        setPixel(&grid, x: 4, y: 3, color: blond)
        setPixel(&grid, x: 11, y: 3, color: blond)
        setPixel(&grid, x: 7, y: 3, color: pink)
        setPixel(&grid, x: 8, y: 3, color: pink)
        for x in 5...10 { setPixel(&grid, x: x, y: 4, color: pink) }
        setPixel(&grid, x: 4, y: 4, color: skin)
        setPixel(&grid, x: 11, y: 4, color: skin)
        for x in 6...9 { setPixel(&grid, x: x, y: 5, color: skin) }
        for x in 5...10 { setPixel(&grid, x: x, y: 6, color: purple) }

        if frame % 2 == 0 {
            setPixel(&grid, x: 5, y: 7, color: white)
            setPixel(&grid, x: 10, y: 7, color: white)
        } else {
            setPixel(&grid, x: 6, y: 7, color: white)
            setPixel(&grid, x: 9, y: 7, color: white)
        }
    }

    func drawKOTHCotton(grid: inout [[NSColor]], frame: Int) {
        let skin = NSColor(red: 0.94, green: 0.78, blue: 0.7, alpha: 1.0)
        let gray = NSColor(red: 0.75, green: 0.75, blue: 0.75, alpha: 1.0)
        let green = NSColor(red: 0.35, green: 0.42, blue: 0.25, alpha: 1.0)
        let khaki = NSColor(red: 0.78, green: 0.7, blue: 0.52, alpha: 1.0)
        let bootBrown = NSColor(red: 0.45, green: 0.28, blue: 0.15, alpha: 1.0)
        let black = NSColor.black

        for x in 6...9 { setPixel(&grid, x: x, y: 1, color: skin) }
        setPixel(&grid, x: 5, y: 1, color: gray)
        setPixel(&grid, x: 10, y: 1, color: gray)
        for x in 5...10 { setPixel(&grid, x: x, y: 2, color: skin) }
        setPixel(&grid, x: 6, y: 2, color: black)
        setPixel(&grid, x: 9, y: 2, color: black)
        for x in 5...10 { setPixel(&grid, x: x, y: 3, color: skin) }
        setPixel(&grid, x: 7, y: 3, color: NSColor(red: 0.6, green: 0.25, blue: 0.25, alpha: 1.0))
        setPixel(&grid, x: 8, y: 3, color: NSColor(red: 0.6, green: 0.25, blue: 0.25, alpha: 1.0))
        for x in 4...11 { setPixel(&grid, x: x, y: 4, color: green) }
        for x in 5...10 { setPixel(&grid, x: x, y: 5, color: khaki) }

        if frame % 2 == 0 {
            setPixel(&grid, x: 5, y: 6, color: bootBrown)
            setPixel(&grid, x: 10, y: 6, color: bootBrown)
        } else {
            setPixel(&grid, x: 6, y: 6, color: bootBrown)
            setPixel(&grid, x: 9, y: 6, color: bootBrown)
        }
    }

    func drawKOTHKahn(grid: inout [[NSColor]], frame: Int) {
        let black = NSColor(red: 0.1, green: 0.1, blue: 0.1, alpha: 1.0)
        let skin = NSColor(red: 0.92, green: 0.76, blue: 0.58, alpha: 1.0)
        let red = NSColor(red: 0.82, green: 0.18, blue: 0.18, alpha: 1.0)
        let khaki = NSColor(red: 0.85, green: 0.78, blue: 0.62, alpha: 1.0)
        let brown = NSColor(red: 0.45, green: 0.28, blue: 0.15, alpha: 1.0)

        for x in 6...9 { setPixel(&grid, x: x, y: 0, color: black) }
        for x in 5...10 { setPixel(&grid, x: x, y: 1, color: black) }
        for x in 5...10 { setPixel(&grid, x: x, y: 2, color: skin) }
        setPixel(&grid, x: 6, y: 2, color: black)
        setPixel(&grid, x: 9, y: 2, color: black)
        for x in 5...10 { setPixel(&grid, x: x, y: 3, color: skin) }
        for x in 4...11 { setPixel(&grid, x: x, y: 4, color: red) }
        for x in 5...10 { setPixel(&grid, x: x, y: 5, color: red) }
        for x in 5...10 { setPixel(&grid, x: x, y: 6, color: khaki) }

        if frame % 2 == 0 {
            setPixel(&grid, x: 5, y: 7, color: brown)
            setPixel(&grid, x: 10, y: 7, color: brown)
        } else {
            setPixel(&grid, x: 6, y: 7, color: brown)
            setPixel(&grid, x: 9, y: 7, color: brown)
        }
    }

    func drawKOTHLadybird(grid: inout [[NSColor]], frame: Int) {
        let caramel = NSColor(red: 0.72, green: 0.48, blue: 0.24, alpha: 1.0)
        let darkCaramel = NSColor(red: 0.55, green: 0.35, blue: 0.18, alpha: 1.0)
        let muzzle = NSColor(red: 0.86, green: 0.72, blue: 0.52, alpha: 1.0)
        let collarRed = NSColor(red: 0.85, green: 0.15, blue: 0.15, alpha: 1.0)
        let black = NSColor.black

        for x in 6...9 { setPixel(&grid, x: x, y: 0, color: caramel) }
        for x in 5...10 { setPixel(&grid, x: x, y: 1, color: caramel) }
        setPixel(&grid, x: 4, y: 1, color: darkCaramel)
        setPixel(&grid, x: 11, y: 1, color: darkCaramel)
        for x in 5...10 { setPixel(&grid, x: x, y: 2, color: caramel) }
        setPixel(&grid, x: 4, y: 2, color: darkCaramel)
        setPixel(&grid, x: 11, y: 2, color: darkCaramel)
        setPixel(&grid, x: 6, y: 2, color: black)
        setPixel(&grid, x: 9, y: 2, color: black)
        for x in 5...10 { setPixel(&grid, x: x, y: 3, color: muzzle) }
        setPixel(&grid, x: 4, y: 3, color: darkCaramel)
        setPixel(&grid, x: 11, y: 3, color: darkCaramel)
        setPixel(&grid, x: 7, y: 3, color: black)
        setPixel(&grid, x: 8, y: 3, color: black)
        for x in 5...10 { setPixel(&grid, x: x, y: 4, color: collarRed) }
        for x in 5...10 { setPixel(&grid, x: x, y: 5, color: caramel) }
        if frame % 2 == 0 {
            setPixel(&grid, x: 3, y: 4, color: caramel)
        } else {
            setPixel(&grid, x: 3, y: 5, color: caramel)
        }
        for x in 5...10 { setPixel(&grid, x: x, y: 6, color: caramel) }

        if frame % 2 == 0 {
            setPixel(&grid, x: 5, y: 7, color: darkCaramel)
            setPixel(&grid, x: 10, y: 7, color: darkCaramel)
        } else {
            setPixel(&grid, x: 6, y: 7, color: darkCaramel)
            setPixel(&grid, x: 9, y: 7, color: darkCaramel)
        }
    }

    func drawKOTHJohnRedcorn(grid: inout [[NSColor]], frame: Int) {
        let black = NSColor.black
        let red = NSColor(red: 0.85, green: 0.18, blue: 0.18, alpha: 1.0)
        let bronze = NSColor(red: 0.85, green: 0.62, blue: 0.45, alpha: 1.0)
        let suede = NSColor(red: 0.55, green: 0.35, blue: 0.2, alpha: 1.0)
        let turquoise = NSColor(red: 0.2, green: 0.75, blue: 0.72, alpha: 1.0)
        let jeansBlue = NSColor(red: 0.2, green: 0.35, blue: 0.6, alpha: 1.0)
        let bootBrown = NSColor(red: 0.45, green: 0.28, blue: 0.15, alpha: 1.0)

        for x in 5...10 { setPixel(&grid, x: x, y: 0, color: black) }
        for x in 5...10 { setPixel(&grid, x: x, y: 1, color: red) }
        setPixel(&grid, x: 4, y: 1, color: black)
        setPixel(&grid, x: 11, y: 1, color: black)
        for x in 5...10 { setPixel(&grid, x: x, y: 2, color: bronze) }
        setPixel(&grid, x: 4, y: 2, color: black)
        setPixel(&grid, x: 11, y: 2, color: black)
        setPixel(&grid, x: 6, y: 2, color: black)
        setPixel(&grid, x: 9, y: 2, color: black)
        for x in 5...10 { setPixel(&grid, x: x, y: 3, color: bronze) }
        setPixel(&grid, x: 4, y: 3, color: black)
        setPixel(&grid, x: 11, y: 3, color: black)
        setPixel(&grid, x: 7, y: 3, color: turquoise)
        setPixel(&grid, x: 8, y: 3, color: turquoise)
        for x in 6...9 { setPixel(&grid, x: x, y: 4, color: bronze) }
        setPixel(&grid, x: 4, y: 4, color: suede)
        setPixel(&grid, x: 5, y: 4, color: suede)
        setPixel(&grid, x: 10, y: 4, color: suede)
        setPixel(&grid, x: 11, y: 4, color: suede)
        for x in 6...9 { setPixel(&grid, x: x, y: 5, color: bronze) }
        setPixel(&grid, x: 5, y: 5, color: suede)
        setPixel(&grid, x: 10, y: 5, color: suede)
        for x in 5...10 { setPixel(&grid, x: x, y: 6, color: jeansBlue) }

        if frame % 2 == 0 {
            setPixel(&grid, x: 5, y: 7, color: bootBrown)
            setPixel(&grid, x: 10, y: 7, color: bootBrown)
        } else {
            setPixel(&grid, x: 6, y: 7, color: bootBrown)
            setPixel(&grid, x: 9, y: 7, color: bootBrown)
        }
    }

    func drawKOTHBuckStrickland(grid: inout [[NSColor]], frame: Int) {
        let skin = NSColor(red: 0.95, green: 0.78, blue: 0.72, alpha: 1.0)
        let whiteHair = NSColor(red: 0.92, green: 0.92, blue: 0.92, alpha: 1.0)
        let navy = NSColor(red: 0.15, green: 0.22, blue: 0.4, alpha: 1.0)
        let red = NSColor(red: 0.85, green: 0.2, blue: 0.2, alpha: 1.0)
        let white = NSColor.white
        let black = NSColor.black

        for x in 6...9 { setPixel(&grid, x: x, y: 0, color: skin) }
        for x in 6...9 { setPixel(&grid, x: x, y: 1, color: skin) }
        setPixel(&grid, x: 5, y: 1, color: whiteHair)
        setPixel(&grid, x: 10, y: 1, color: whiteHair)
        for x in 5...10 { setPixel(&grid, x: x, y: 2, color: skin) }
        setPixel(&grid, x: 4, y: 2, color: whiteHair)
        setPixel(&grid, x: 11, y: 2, color: whiteHair)
        setPixel(&grid, x: 6, y: 2, color: black)
        setPixel(&grid, x: 9, y: 2, color: black)
        for x in 5...10 { setPixel(&grid, x: x, y: 3, color: skin) }
        setPixel(&grid, x: 7, y: 3, color: red)
        setPixel(&grid, x: 8, y: 3, color: red)
        for x in 4...11 { setPixel(&grid, x: x, y: 4, color: navy) }
        setPixel(&grid, x: 7, y: 4, color: white)
        setPixel(&grid, x: 8, y: 4, color: red)
        for x in 4...11 { setPixel(&grid, x: x, y: 5, color: navy) }
        for x in 5...10 { setPixel(&grid, x: x, y: 6, color: navy) }

        if frame % 2 == 0 {
            setPixel(&grid, x: 5, y: 7, color: black)
            setPixel(&grid, x: 10, y: 7, color: black)
        } else {
            setPixel(&grid, x: 6, y: 7, color: black)
            setPixel(&grid, x: 9, y: 7, color: black)
        }
    }
}
