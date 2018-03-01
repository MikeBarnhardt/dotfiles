ESC="\x1b["
RESET=$ESC"39;49;00m"
RED=$ESC"31m"
GREEN=$ESC"32m"
YELLOW=$ESC"33m"
BLUE=$ESC"34m"
MAGENTA=$ESC"35m"
CYAN=$ESC"36m"

function info() {
  echo "\n$CYAN$1$RESET"
}

function ok() {
  echo "$GREEN$1$RESET"
}

function warn() {
  echo "$YELLOW$1$RESET"
}

function error() {
  echo "$RED$1$RESET"
}
