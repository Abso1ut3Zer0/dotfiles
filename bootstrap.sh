#!/usr/bin/env bash
set -e

# Detect OS and install ansible if needed
if [[ "$(uname)" == "Darwin" ]]; then
    if ! command -v ansible &> /dev/null; then
        echo "Installing Ansible via Homebrew..."
        brew install ansible
    fi
elif [[ -f /etc/arch-release ]]; then
    if ! command -v ansible &> /dev/null; then
        echo "Installing Ansible via pacman..."
        sudo pacman -S --noconfirm ansible
    fi
else
    echo "Unsupported OS. Install ansible manually, then run:"
    echo "  ansible-playbook ansible/setup.yml"
    exit 1
fi

cd "$(dirname "$0")"
ansible-playbook ansible/setup.yml --ask-become-pass
