# Environment

#export EDITOR='kate'
#export GIT_EDITOR='/usr/bin/kate'
#export BROWSER=qutebrowser
#export TERMINAL=konsole
#export FILEBROWSER=dolphin


if [ -d "$HOME/.local" ]; then
    PATH="$PATH:$HOME/.local"
fi

if [ -d "$HOME/.gem" ]; then
    PATH="$PATH:$HOME/.gem"
fi
