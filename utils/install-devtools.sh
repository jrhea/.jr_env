#!/usr/bin/env bash
set -euo pipefail

OS="$(uname -s)"
echo "==> Installing dev tools for $OS"

# -----------------------
# Helpers
# -----------------------
have() { command -v "$1" >/dev/null 2>&1; }

section() {
  echo
  echo "==> $1"
}

# -----------------------
# Package manager
# -----------------------
if [ "$OS" = "Darwin" ]; then
  if ! have brew; then
    echo "Homebrew not found. Install it first:"
    echo '/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"'
    exit 1
  fi
  PKG_INSTALL="brew install"
elif have apt; then
  sudo apt update
  PKG_INSTALL="sudo apt install -y"
else
  echo "Unsupported OS or missing package manager"
  exit 1
fi

# -----------------------
# Core CLI tools
# -----------------------
section "Core CLI tools"
$PKG_INSTALL git ripgrep fd || true

# -----------------------
# Neovim
# -----------------------
section "Neovim"
if ! have nvim; then
  if [ "$OS" = "Darwin" ]; then
    $PKG_INSTALL neovim
  else
    curl -LO https://github.com/neovim/neovim/releases/latest/download/nvim.appimage
    chmod +x nvim.appimage
    sudo mv nvim.appimage /usr/local/bin/nvim
  fi
else
  echo "Neovim already installed"
fi

# -----------------------
# Go + tooling
# -----------------------
section "Go tooling"
if have go; then
  go install golang.org/x/tools/gopls@latest
  go install golang.org/x/tools/cmd/goimports@latest
  go install github.com/go-delve/delve/cmd/dlv@latest
else
  echo "Go not found. Skipping Go tools."
fi

# -----------------------
# Node (via nvm)
# -----------------------
section "Node tooling"
if have nvm; then
  nvm install --lts
  nvm use --lts
else
  echo "nvm not found. Skipping Node install."
fi

# -----------------------
# Python tooling
# -----------------------
section "Python tooling"
if have pyenv; then
  DEFAULT_PY="3.12.1"
  pyenv install -s "$DEFAULT_PY"
  echo "Installed Python $DEFAULT_PY (not changing global)"
else
  echo "pyenv not found. Skipping Python install."
fi

# -----------------------
# Final checks
# -----------------------
section "Versions"
have nvim && nvim --version | head -n 1
have go && go version
have node && node --version
have python && python --version

echo
echo "==> Dev tools installation complete"
