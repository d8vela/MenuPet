#!/bin/bash
# Fix macOS Gatekeeper for MenuPet
# Run this after installing MenuPet.app

xattr -cr /Applications/MenuPet.app
echo "MenuPet is now ready to use! Open it from Applications."
