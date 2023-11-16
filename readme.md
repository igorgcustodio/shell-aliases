# Terminal Aliases and Helpers

Some useful commands

## Installing on your terminal

```bash
    $ export folder=/PATH/TO/YOUR/FOLDER
    $ echo "\nexport DEVELOPMENT_FOLDER=\"$folder\"" >> ~/.zshrc
    $ zsh install.sh
    $ source ~/.zshrc
```

## Adding custom functions

You can also add your own functions on the file `user-defined`. To do this open the file on the following path:

```bash
    $ code /usr/local/bin/alias/custom/user-defined.sh
```

# Aliases

## Variables

Variable | Description
:-:|:-:
ALIASES | Aliases project folder
DEVELOPMENT_FOLDER | Your folder with your projects

## Navigation

Command | Description
:-:|:-:
`development` | Your folder with your projects

## Commands

### Git

Command | Description | Complete command | Parameters | Parameter Type
:-:|:-:|:-:|:-:|:-:
`gs` | git status | `git status`
`pre` | go back to previous branch | `git checkout -`
`cb` | copy the current branch name
`lb` | list all local branches | `git branch \| cat`
`gslc` | list all status | `git stash list \| cat`
`gsdrop [ID]` | delete the given stash | `git stash drop [ID]` | stash id | required
`glad ]ID[` | git log formatted with an optional term/id do find | `git log --pretty` | term to find | optional
`pr ]BRANCH=DEVELOP[` | open the pull request page to the BRANCH (OPTIONAL)| | branch name | optional
`merge ]BRANCH=DEVELOP[` | merge the current branch with the BRANCH (OPTIONAL)|  | branch name | optional
`gdoc` | shows conventional commit helper

### iOS

Command | Description | Complete command | Parameters | Parameter Type
:-:|:-:|:-:|:-:|:-:
`pu` | update pods | `pod update`
`pi` | install pods | `pod install`
`gres` | restore Podfile and Podfile.lock | `git restore Podfile Podfile.lock`

### Functions

Command | Description | Parameters
:-:|:-:|:-:
`measure` | Measure a command time to execute | command to be executed
`cpf` | Generates a CPF
`cnpj` | Generates a CNPJ
`cleandata` | Clean XCode derived data folder
`fixconflict` | Open VSCode to fix conflicts