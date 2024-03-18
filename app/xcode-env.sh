#!/bin/bash

USER_SHELL=$(basename "$SHELL")

echo "Detected shell: $USER_SHELL"

# Source bash or zsh specific files if they exist
case $USER_SHELL in
    bash)
        if [ -f "$HOME/.bash_profile" ]; then
            echo "Sourcing .bash_profile"
            source "$HOME/.bash_profile"
        elif [ -f "$HOME/.bash_login" ]; then
            echo "Sourcing .bash_login"
            source "$HOME/.bash_login"
        elif [ -f "$HOME/.profile" ]; then
            echo "Sourcing .profile"
            source "$HOME/.profile"
        fi
        ;;
    zsh)
        if [ -f "$HOME/.zshenv" ]; then
            echo "Sourcing .zshenv"
            source "$HOME/.zshenv"
        fi
        if [ -f "$HOME/.zprofile" ]; then
            echo "Sourcing .zprofile"
            source "$HOME/.zprofile"
        fi
        if [ -f "$HOME/.zshrc" ]; then
            echo "Sourcing .zshrc"
            source "$HOME/.zshrc"
        fi
        if [ -f "$HOME/.zlogin" ]; then
            echo "Sourcing .zlogin"
            source "$HOME/.zlogin"
        fi
        ;;
    *)
        echo "Unsupported shell: $USER_SHELL"
        ;;
esac
