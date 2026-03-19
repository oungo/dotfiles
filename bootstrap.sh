#!/bin/bash

set -e

echo "Starting dotfiles bootstrap..."

# chezmoi 설치 및 dotfiles 적용
sh -c "$(curl -fsLS get.chezmoi.io)" -- init --apply oungo

echo "Bootstrap complete!"
