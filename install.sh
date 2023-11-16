#!/bin/zsh

# If fails, exit immediataly
set -e

CURRENT_DIR=$(readlink -f install.sh | xargs dirname)

check_path() {
    if ls /usr/local/bin | grep -q "^aliases$"; then
        echo "Shortcut already added"
    else
        echo "Adding shortcut"
        echo $CURRENT_DIR
        ln -sf $CURRENT_DIR /usr/local/bin
    fi;
}

check_if_is_installed() {
    if ! ( cat ~/.zshrc | grep -q "Flag: Aliases" ); then
        install_aliases
    fi;
}

install_aliases() {
    echo "\n" >> ~/.zshrc
    cat importing.sh >> ~/.zshrc
    echo "Aliases imported"
}

create_user_defined_functions() {git 
    mkdir -p custom
    cd custom

    if ! ( ls user-defined.sh 2> /dev/null ); then
        touch user-defined.sh 1> /dev/null
    fi;
    cd ..
}

check_path
create_user_defined_functions
check_if_is_installed