function cd() {
    builtin cd $@ && ls
}

# Create a new directory and enter it
mkd() { mkdir $1 && cd $1; }

# Tar extraction

extract() {      # Handy Extract Program
    if [ -f $1 ] ; then
        case $1 in
            *.tar.bz2)   tar xvjf $1     ;;
            *.tar.gz)    tar xvzf $1     ;;
            *.bz2)       bunzip2 $1      ;;
            *.rar)       unrar x $1      ;;
            *.gz)        gunzip $1       ;;
            *.tar)       tar xvf $1      ;;
            *.tbz2)      tar xvjf $1     ;;
            *.tgz)       tar xvzf $1     ;;
            *.zip)       unzip $1        ;;
            *.Z)         uncompress $1   ;;
            *.7z)        7z x $1         ;;
            *)           echo "'$1' cannot be extracted via >extract<" ;;
        esac
    else
        echo "'$1' is not a valid file!"
    fi
}

# Create a .tar.gz archive, using `zopfli`, `pigz` or `gzip` for compression

function targz() {
	local tmpFile="${@%/}.tar";
	tar -cvf "${tmpFile}" --exclude=".DS_Store" "${@}" || return 1;

	size=$(
		stat -f"%z" "${tmpFile}" 2> /dev/null; # macOS `stat`
		stat -c"%s" "${tmpFile}" 2> /dev/null;  # GNU `stat`
	);

	local cmd="";
	if (( size < 52428800 )) && hash zopfli 2> /dev/null; then
		# the .tar file is smaller than 50 MB and Zopfli is available; use it
		cmd="zopfli";
	else
		if hash pigz 2> /dev/null; then
			cmd="pigz";
		else
			cmd="gzip";
		fi;
	fi;

	echo "Compressing .tar ($((size / 1000)) kB) using \`${cmd}\`…";
	"${cmd}" -v "${tmpFile}" || return 1;
	[ -f "${tmpFile}" ] && rm "${tmpFile}";

	zippedSize=$(
		stat -f"%z" "${tmpFile}.gz" 2> /dev/null; # macOS `stat`
		stat -c"%s" "${tmpFile}.gz" 2> /dev/null; # GNU `stat`
	);

	echo "${tmpFile}.gz ($((zippedSize / 1000)) kB) created successfully.";
}

function stopwatch(){
  case $(uname) in
    "Linux") DATE=date ;;
    "Darwin") DATE=gdate ;;
  esac
  local BEGIN=`$DATE +%s`
  while true; do
    echo -ne "$($DATE -u --date @$((`$DATE +%s` - $BEGIN)) +%H:%M:%S)\r";
  done
}

# This allows the use of "Transfer hello.txt" to create a unique sharing link
# files up to 10gb
transfer() { if [ $# -eq 0 ]; then echo "No arguments specified. Usage:\necho transfer /tmp/test.md\ncat /tmp/test.md | transfer test.md"; return 1; fi 
tmpfile=$( mktemp -t transferXXX ); if tty -s; then basefile=$(basename "$1" | sed -e 's/[^a-zA-Z0-9._-]/-/g'); curl --progress-bar --upload-file "$1" "https://transfer.sh/$basefile" >> $tmpfile; else curl --progress-bar --upload-file "-" "https://transfer.sh/$1" >> $tmpfile ; fi; cat $tmpfile; rm -f $tmpfile; }

scripter()
{
    if [ -n "$1" ]; then
        local script="$1"
    else
        local script=`mktemp scriptster.rb.XXXX`
    fi

    local url="https://raw.githubusercontent.com/pazdera/scriptster/master"
    curl "$url/examples/minimal-template.rb" >"$script"
    #curl "$url/examples/documented-template.rb" >"$script"

    chmod +x "$script"
    $EDITOR "$script"
}

gitgraph() {
git log --graph --abbrev-commit --decorate --format=format:"%C(bold blue)%h%C(reset) - %C(bold cyan)%aD%C(reset) %C(bold green)(%ar)%C(reset)%C(bold yellow)%d%C(reset)%n %C(white)%s%C(reset) %C(dim white)- %an%C(reset)" --all

: '
* ca425d6 - Thu, 25 Feb 2016 21:40:28 -0800 (5 months ago) (HEAD -> develop, origin/develop, origin/HEAD)
|  Bump version, update contributors list - Jeremy Felt
*   8dfffb4 - Thu, 25 Feb 2016 21:31:48 -0800 (5 months ago)
|\   Merge pull request #813 from tucsonlabs/chore/update-optimize-power-parallels-provider-flag - Jeremy Felt
| * fb9f5e3 - Tue, 19 Jan 2016 04:37:17 -0800 (6 months ago)
| |  update deprecated parallels.optimize_power_consumption = false - Erik Trom
* | d170f3f - Sun, 21 Feb 2016 11:46:00 -0800 (5 months ago)
| |  Adjust heading for Bug fixes and enhancements - Jeremy Felt
| | * 9226f5b - Sun, 21 Feb 2016 11:46:00 -0800 (5 months ago) (tag: 1.3.0, origin/master)
| | |  Adjust heading for Bug fixes and enhancements - Jeremy Felt
| | *   2e9eec5 - Sun, 21 Feb 2016 11:42:54 -0800 (5 months ago)
| | |\   Merge branch ''develop'' - Jeremy Felt
| |_|/  
|/| |   
* | |   ba6058b - Sun, 21 Feb 2016 10:52:28 -0800 (5 months ago)
|\ \ \   Merge pull request #832 from Varying-Vagrant-Vagrants/update-docs - Jeremy Felt
| * | | 99d2772 - Sun, 21 Feb 2016 10:36:17 -0800 (5 months ago)
| | | |  Update release date for 1.3.0 - Jeremy Felt
'
}

# Encrypt a file
  function encrypt() { openssl enc -aes-256-cbc -salt -a -in $1 -out $2 ; }

  # Decrypt a file
  function decrypt() { openssl enc -aes-256-cbc -d -a -in $1 -out $2 ; }

  # Fetch weather forecast
  function weather() { curl "http://wttr.in/$1"; }

  # Convert input text into a QR code
  function qrify() { curl "http://qrenco.de/$1"; }

  # Fetch cheatsheet
  function cheat() { curl "http://cheat.sh/$1"; }

# Show actual destinatoin of a tinyurl. Eg: untiny "tinyurl.com/savepii"
  function untiny() { curl -s "http://x.datasig.io/short?url=http://$1" | awk -F '"' '/d
  
def clean() {
rm -rf "$HOME/.cache/"
rm -rf "$HOME/.thumbnails"
rm -rf "$HOME/.local/share/Trash"
}
# Remove duplicate lines
def dupe() {
vi +'%!sort | uniq' +wq file.txt
}
gacp () {
  git add --all --verbose
  git commit -m "$1"
  git push -u origin HEAD
}
## Interesting bash function for setting up a new front-end project
# Usage: new_project DIRNAME DESCRIPTION
function new_project() {
  git init "$1" && \
	  pushd "$1" && \
	  echo "$2" > README.txt && \
	  echo "$2" > .git/description && \
	  echo "/node_modules/" >> .gitignore && \
	  hub create -d "$2" && \
	  yarn init && \
	  gacp initial
}

# Create new web project folder and grab html5 boilerplate
website() {
mkdir $1
cd $1
git init
git remote add origin https://github.com/Gazaunga/HTML5-Boilerplate.git
git pull origin master
ls -a
$EDITOR index.html
}

