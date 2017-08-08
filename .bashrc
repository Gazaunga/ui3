#!/bin/bash

# Use Liquid Prompt (but not in interactive shells)
[[ $- = *i* ]] && source ~/liquidprompt/liquidprompt

# Source global definitions
[ -f /etc/bashrc ] && source /etc/bashrc

[ -f ~/.bash_aliases ] && source ~/.bash_aliases

[ -f ~/.bash_env ] && source ~/.bash_env

[ -f ~/.bash_functions ] && source ~/.bash_functions

if [ "$TERM" = "screen" ]; then
    export TERM=screen-256color
fi

source /usr/share/doc/pkgfile/command-not-found.bash

shopt -s autocd
