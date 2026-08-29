# MenuPet

A lightweight macOS menu bar app that displays animated Pokémon sprites running across your menu bar. The animation speed is tied to your CPU usage — the harder your Mac works, the faster your Pokémon runs.

## Features

- **26 Pokémon** to choose from — Pikachu, Jigglypuff, Snorlax, and more
- **CPU-reactive animation** — sprite speed adjusts based on system load
- **Random rotation** — automatically cycles to a random Pokémon every 10 minutes
- **Lightweight** — pure Swift, no dependencies, minimal resource usage
- **Menu bar only** — lives in your menu bar, no dock icon

## Install

Download `MenuPet.app` directly from the repository and move it to your Applications folder.

Or build from source:

```bash
git clone https://github.com/d8vela/MenuPet.git
cd MenuPet
swift build -c release
cp .build/release/MenuPet /usr/local/bin/
```

## Usage

- Click the menu bar icon to see CPU usage, switch Pokémon, or adjust settings
- Enable **Random Rotation** to cycle Pokémon automatically
- Choose **Quit** to exit

## Requirements

- macOS 13.0+
- Swift 5.9+

## License

MIT
