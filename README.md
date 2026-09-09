# MenuPet

A lightweight macOS menu bar app that displays animated pixel art sprites running across your menu bar. The animation speed is tied to your CPU usage — the harder your Mac works, the faster your pet runs.

![MenuPet Screenshot](screenshot/screenshot.jpg)

## Features

- **140+ characters** across 26 categories — Pokémon, Mario, Mario Kart, Zelda, Kirby, Dragon Ball, Naruto, Metal Slug, Contra, TMNT, Ghibli, Marvel, DC, Batman, Star Wars, Street Fighter, Mortal Kombat, Overwatch, Simpsons, Minions, Gundam, Labubu, King of the Hill, Family Guy, Futurama, Transformers
- **CPU-reactive animation** — sprite speed adjusts based on system load (sleeping → walking → jogging → sprinting → overdrive)
- **Tamagotchi pet care** — Feed, Play, Clean, Sleep your pet; stats decay over time
- **Pet evolution** — 5 stages based on care quality: Neglected → Baby → Normal → Happy → Champion
- **Visual evolution effects** — sparkles for well-cared pets, darker colors and shadows for neglected ones
- **Need indicators** — thought bubbles and status bar icons appear when your pet needs attention
- **Random rotation** — automatically cycles to a random character with configurable interval (0.01s to hours)
- **Smart rotation** — prefer characters you interact with most
- **Category rotation** — rotate only within the current character's category
- **Google image search** — search for any character directly from the menu
- **Character history** — quickly access recently viewed characters
- **Auto-update** — checks for new releases on startup and daily
- **Lightweight** — pure Swift, no dependencies, minimal resource usage
- **Menu bar only** — lives in your menu bar, no dock icon

## Download

**[Click here to download MenuPet.dmg](https://github.com/d8vela/MenuPet/releases/latest)** (macOS 13.0+)

1. Download the `.dmg` file from the latest release
2. Open the downloaded `MenuPet.dmg`
3. Drag **MenuPet.app** into your **Applications** folder
4. Open MenuPet from Applications (right-click → Open the first time to bypass Gatekeeper)

## Build from source

```bash
git clone https://github.com/d8vela/MenuPet.git
cd MenuPet
swift build -c release
cp .build/release/MenuPet /usr/local/bin/
```

## Usage

- Click the menu bar icon to see CPU usage, pet status, switch characters, or adjust settings
- **Pet Stats** — view Hunger, Happiness, Energy, and Hygiene percentages in the menu
- **Care Actions** — use Feed, Play, Clean, Sleep to keep your pet happy
- **Evolution** — your pet evolves through 5 stages based on how well you care for it:
  - 🥀 Neglected (care score <20%) — dark, desaturated sprite with shadow
  - 🥚 Baby (20-39%) — slightly dimmed appearance
  - ⭐ Normal (40-64%) — default look
  - 🌟 Happy (65-84%) — brighter, more vivid colors with sparkles
  - 👑 Champion (85%+) — extra bright, extra vivid, sparkles
- **Need Indicators** — when stats drop below 40%, a thought bubble appears above the sprite showing what it needs. Below 30%, an emoji appears next to the menu bar icon.

### Indicator Reference

| Icon | Stat | Color | Meaning |
|------|------|-------|---------|
| + cross shape | 🍕 Hunger | Orange | Pet needs food |
| ○ ○ face | 😢 Happiness | Blue | Pet is sad/lonely |
| Z shape | 😴 Energy | Gray | Pet is tired |
| 💧 drops | 🧼 Hygiene | Light blue | Pet needs cleaning |

Only the worst stat is shown — if both hunger and energy are low, whichever is lower displays.

**Status Bar Emoji** (appears next to the sprite when stat < 30%):
- 🍕 = hungry, 😢 = unhappy, 😴 = tired, 🧼 = dirty

**Stage Effects** (based on care score):
- Gold sparkles above sprite = Happy or Champion stage (doing well)
- Darker colors + shadow underneath = Neglected or Baby stage (needs attention)
- Enable **Random Rotation** under the Rotation submenu to cycle characters automatically
- Set a custom **Rotation Interval** from 0.01 seconds to any value
- Use **Rotate Within Category Only** to limit rotation to the current category
- Click a character name to open a Google image search for that character
- Choose **Quit** to exit

## Character Categories

| Category | Characters |
|----------|------------|
| Pokémon | Pikachu, Jigglypuff, Snorlax, Charizard, Mew, Gengar, Bulbasaur, Squirtle, Eevee, Psyduck, Pokeball, Great Ball, Ultra Ball, Master Ball |
| Mario | Mario, Luigi, Peach, Toad, Bowser, Yoshi, Donkey Kong, Wario, Waluigi, Boo |
| Mario Kart | Mario, Luigi, Peach, Bowser, Toad, Yoshi, Donkey Kong |
| Zelda | Link, Zelda, Ganondorf, Epona, Navi |
| Kirby | Kirby, King Dedede, Meta Knight, Waddle Dee, Bandana Waddle Dee |
| Mega Man | Mega Man, Roll, Proto Man, Bass, Dr. Wily |
| Dragon Ball | Goku, Vegeta, Gohan, Frieza, Piccolo, Krillin |
| Naruto | Naruto, Sasuke, Sakura, Kakashi |
| Metal Slug | Marco, Tarma, Eri, Fio, Morden, Camel, Slug Tank, Zombie, Mummy, Ape, Hermit, Crab |
| Contra | Bill, Lance |
| TMNT | Leonardo, Donatello, Raphael, Michelangelo |
| Ghibli | Totoro, No-Face, Kiki, Calcifer, Ponyo, Satsuki, Mei, Howl, Sophie, Append, Jiro, Chihiro |
| Marvel | Iron Man, Captain America, Thor, Hulk, Spider-Man, Wolverine, Black Panther, Daredevil, Black Widow, Hawkeye, Vision, Scarlet Witch, War Machine, Spider-Woman, Cyclops, She-Hulk, Juggernaut, Loki, Venom |
| DC | Wonder Woman, Batman, Superman, The Flash, Aquaman, Green Lantern |
| Star Wars | Luke, Vader, Yoda, Boba Fett, Chewbacca, R2-D2, C-3PO, Grogu, The Mandalorian |
| Street Fighter | Ryu, Ken, Chun-Li, Guile, Dhalsim, Zangief, Blanka |
| Mortal Kombat | Scorpion, Sub-Zero, Liu Kang, Raiden, Johnny Cage, Sonya Blade, Jax |
| Overwatch | Tracer, Genji, D.Va, Winston, Mercy, Reinhardt |
| Simpsons | Homer, Bart, Marge, Lisa, Maggie |
| Minions | Kevin, Stuart, Bob |
| Gundam | RX-78-2, Char's Zaku, Wing Zero, Unicorn |
| Labubu | Labubu, Pink, Gray, Brown, White, Golden |
| King of the Hill | Hank Hill, Peggy, Bobby, Dale, Bill, Boomhauer, Luanne, Cotton, Kahn, Ladybird, John Redcorn, Buck Strickland |
| Family Guy | Peter Griffin, Lois, Stewie, Brian, Chris, Meg, Quagmire, Cleveland, Joe, Mayor Adam West, Herbert, Tom Tucker |
| Futurama | Fry, Leela, Bender, Amy, Professor Farnsworth, Hermes, Zoidberg, Cubert, Ndnd, Zapp Brannigan |
| Batman | Joker, Bane, Riddler, Penguin, Harley Quinn, Scarecrow, Killer Croc, Poison Ivy, Catwoman, Two-Face, Mr. Freeze, Red Hood, Ra's al Ghul, Deathstroke |
| Transformers | Optimus Prime, Bumblebee, Megatron, Starscream, Soundwave, Prowl, Jazz, Ironhide, Ratchet, Shockwave, Sound Blaster, Galvatron, Cyclonus, Devastator |

## Requirements

- macOS 13.0+
- Swift 5.9+

## License

MIT
