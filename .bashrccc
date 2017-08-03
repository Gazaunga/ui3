#!/bin/bash

PS1="\[\e[0;1m\]┌─ \u@\[\e[1;34m\]\h\[\e[0;1m\]:\w\n└──● \[\e[0m\]"

# Source global definitions
[ -f /etc/bashrc ] && source /etc/bashrc

[ -f ~/.bash_aliases ] && source ~/.bash_aliases

[ -f ~/.bash_env ] && source ~/.bash_env

[ -f ~/.bash_functions ] && source ~/.bash_functions

if [ "$TERM" = "screen" ]; then
    export TERM=screen-256color
fi

