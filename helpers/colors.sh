# Useful constants

RED='\033[0;31m';
GREEN='\033[0;32m';
YELLOW='\033[0;33m';
BLACK='\033[0;30m';

RED_BACKGROUND='\033[0;41m';
GREEN_BACKGROUND='\033[0;42m';
YELLOW_BACKGROUND='\033[0;43m';

BOLD='\033[1m';
NC='\033[0m';
YELLOW_BLACK='\033[0;30;43m';

logText() {
    echo -e $1
}

# Utils

logGreenBackground() {
    echo -e "${GREEN_BACKGROUND}${BOLD}$1$NC";
}

logRedBackground() {
    echo -e "${RED_BACKGROUND}${BOLD}$1$NC";
}

logYellowBackground() {
    echo -e "${YELLOW_BLACK}${BOLD}$1$NC";
}

logGreen() {
    echo -e "${GREEN}${BOLD}$1$NC";
}

logRed() {
    echo -e "${RED}${BOLD}$1$NC";
}

logYellow() {
    echo -e "${YELLOW}${BOLD}$1$NC";
}