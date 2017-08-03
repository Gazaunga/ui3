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

 setxkbmap -option caps:swapescape
 
 ## Todo Setup ##

# Notes
NOTES_BASE_PATH=""
[ -d "$HOME/Documents/notes" ] && NOTES_BASE_PATH="$HOME/Documents/notes"
[ -d "$HOME/docs/notes" ]      && NOTES_BASE_PATH="$HOME/docs/notes"

if [ -n "NOTES_BASE_PATH" ]
then
  alias todo="(cd $NOTES_BASE_PATH; $EDITOR todo.txt)"
  alias lstodo="rg --no-line-number ' *(\[.\].*\*)$' $NOTES_BASE_PATH/notes/todo.txt --replace '\$1' | sort"
  
  # Daily journal
  function journal() {
    today=$(date +"%m-%d-%y")
    [ ! -f $file ] && echo "# $today" > $file
    (cd $NOTES_BASE_PATH; $EDITOR "journal/$today.txt")
  }
fi
