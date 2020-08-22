# .bashrc
export CLICOLOR=1
export LSCOLORS=GxFxCxDxBxegedabagaced

# Source global definitions
if [ -f /etc/bashrc ]; then
	. /etc/bashrc
fi

PATH="$(pwd)/node_modules/.bin:$PATH"
PATH="~/bin:$PATH"
PATH="~/node_modules/.bin:$PATH"
PATH="~/Documents/nvim-osx64/bin/:$PATH"


# User specific aliases and functions

# -i is for inteact with user
# -v is for verbose
alias ls='ls -lahtr'
alias mv='mv -iv'
alias rm='rm -iv'
alias cp='cp -iv'
alias tp='tail -f logs/perl/error_log'
alias mr='make restart'
alias mrp='make restart-perl'
alias uwDB='perl ruby/perl/bin/nosql/import_into_couchbase.pl -f'
alias sand='ssh sand'
alias bergen='ssh bergen'
alias victory='ssh victory'
alias broad='ssh broad'
#alias screen='_ssh_auth_save ; export HOSTNAME=$(hostname) ; screen'
alias psql='psql -h pgsql01dev -U postgres'
alias less='less -i'
alias mkdir='mkdir -p'
alias cl='printf "\033c"'
alias ec='cd ~/Projects/echoveyReact/dev; ./start.sh'
alias tm='tmux attach || tmux new'
alias home='cd $(git rev-parse --show-cdup)'
alias vim='nvim'
alias vi='nvim'

# Bind ctrl+w to erase last word
stty werase undef
bind '\C-w:unix-filename-rubout'

# GIT short cuts
alias gs='git st'
alias gst='git st'
alias gch='git ch'
alias gsh='git sh'
alias gdi='git di'
alias gbr='git br'
alias gco='git co'
alias glo='git lo'
alias gbl='git bl'
alias gad='git add'
alias gpo='git stash pop'
alias g='git'




gre()
{
    git stash; git rebase -i;
}

mrpp()
{
    gp; cd ruby; gp; cd -; make restart-perl;
}



# Ensure that vim and not vi is used when editing files
export EDITOR=vim
export TERM=linux
export LESS=-Ri

# Ensrue that less is used insetad of more
export PAGER=less
# Modifies options for less so it shows the line numbers
#export LESS="-iMSx4 -FX"

alias mr-search='NODE_ENV=development.andrew node app.js'


# Check if any modified files have warns in them
warn() { git diff | grep -iE '(^--- )|warn|alert|console|die|todo'; }
warnC() { git diff --cached | grep -iE '(^--- )|warn|alert|console|die|todo'; }


### Adding this should allow screen to work with git without having to enter
### the pass phrase every time
_ssh_auth_save() {
    rm -f "$HOME/.screen/ssh-auth-sock.$HOSTNAME"
    ln -sf "$SSH_AUTH_SOCK" "$HOME/.screen/ssh-auth-sock.$HOSTNAME"
}

### Git rebase -i, but stash first

### Kill the servers/processes running on the specified port
lsp()
{
    ### Get the pid's of the starman servers
    #PID=($(lsof -w -n -i tcp:$1| grep plackup | sed -e 's/plackup\s\+\([0-9]\+\).*/\1/' | tr '\n' ' '));
    PID=($(lsof -w -n -i tcp:$1| grep plackup | sed -e 's/plackup\s\+\([0-9]\+\).*/\1/' | xargs));
    LENGTH=${#PID[@]};
    LENGTH=`expr $LENGTH - 1`

    ### Check if there are any running to begin with
    if [ "$LENGTH" -eq "-1" ]; then
        echo "No processes using that port";
        return;
    fi

    ### Kill the processes if yes
    #select yn in "Yes" "No";
    #do
    #    case $yn in
    #        Yes ) break;; 
    #        No ) echo "Nothing done"; return;;
    #    esac;
    #done;

    echo "killing the following processes:";
    for idx in `seq 0 $LENGTH`;
    do
        echo "${PID[$idx]}";
        kill ${PID[$idx]};
    done

}

## Same as svd, but you can specify a revision number which you want to diff against;
svr()
{
    svn cat -r $2 $1 | vim - -Rc "vs $1|set noro|windo diffthis|se wrap|wincmd h";
}

svd()
{
    svn cat -r HEAD $1 | vim - -Rc "vs $1|set noro|windo diffthis|se wrap|wincmd h";
}
svdd()
{
    svn diff -c $1 $2;
}

gvd()
{
    INPUT=$1;
    vim ${INPUT} -c "Diff";
}


gva()
{
    #vim -p `git ls-files -m | xargs` -c "DiffAll"
    vim -p `git status -s | awk '{if ($1 == "M" || $1 == "D" || $1 == "A" ) print $2}' | xargs` -c "DiffAll"
}

#gvd()
#{
#    INPUT=$1;
#    INDEX=$2;
#    ### Double brackets indicate use regex
#    if [ ${INPUT:0:6} != htdocs ]; then
#        INPUT="./$INPUT";
#    fi;
#
#    REVISION='HEAD';
#    LENGTH=${#INDEX};
#
#    ### if the revision number is short, 
#    ### treat it as versions before HEAD
#    if [ "$LENGTH" -lt "3" ] && [ "$LENGTH" -ne "0" ]; then
#        REVISION=HEAD~${INDEX};
#    ### If the revision number is large, its a sha
#    else
#        REVISION=${INDEX};
#    fi;
#
#    echo $REVISION;
#    echo $INPUT;
#    git show $REVISION:$INPUT | vim - -Rc "vs $INPUT|set noro|windo diffthis|se wrap|wincmd h";
#}
#gva()
#{
#    ### Initial notes...
#    #vim -c 'r !git show HEAD:htdocs/www/javascript/main.js' -c "vs htdocs/www/javascript/main.js" -c 'tabe|r !ls'
#    #git status -s | grep -E '\-min.(css|js)' | sed -e 's/^...//' | tr '\n' ' '  | xargs git add; \
#
#    ### Grab the MODIFIED files (not new or deleted)  and put them in an array (also, not images)
#    FILES=($(git status -s | grep -E '^.(M).' | grep -vE "(jpg|jpeg|gif|png)$" | sed -e 's/^...//' | tr '\n' ' '));
#
#    ### Get the last array index
#    LENGTH=${#FILES[@]};
#    LENGTH=`expr $LENGTH - 1`;
#
#    ### If there are no files, exit
#    if [ "$LENGTH" -lt "0" ]; then
#        return;
#    fi
#
#    if [ "$LENGTH" -gt "3" ]; then
#        LENGTH=3;
#    fi
#
#    ### Begin constructing the vim string
#    ### Dev/null doesnt really work because we are overwriting it each time
#    STRING="vim"
#    #STRING="$STRING -c 'set noautochdir| e /dev/null| r \!git show HEAD:${FILES[0]}'"
#    #STRING="$STRING -c 'w|set noautochdir |vs ${FILES[0]}|windo diffthis'";
#
#    #if [ "$LENGTH" -eq "0" ]; then
#    #eval $(echo $STRING | sed 's/\\!/!/g');
#    #else
#
#    for idx in `seq 0 $LENGTH`;
#    do
#        ### Since we will be using temp files to store the 'diffs', make sure to remove these first
#        rm -f tmp/.diff.tmp.$idx;
#
#        ### If this is the first file, then open the git catenation in the current window, otherwise use a new tab
#        if [ "$idx" -eq "0" ]; then
#            SPLIT="e"
#        else
#            SPLIT="tabe"
#        fi
#
#        ### Appending options to open up all of the modified files and showing their diffs
#        STRING="$STRING -c 'set noautochdir|$SPLIT tmp/.diff.tmp.$idx |r \!git show HEAD:${FILES[$idx]}'"
#        STRING="$STRING -c '1 delete|w|set ro|set noautochdir| vs ${FILES[$idx]}|windo diffthis|se wrap|wincmd h'";
#    done
#
#    ### Moves user to first tab, and first screen.
#    STRING="$STRING -c 'tabnext| wincmd h'";
#    
#    ### Repeat the string so the user knows what is going on
#    echo $STRING;
#    
#    ### Evaluate the string (execute the diffs)
#    eval $(echo $STRING | sed 's/\\!/!/g');
#
#    #fi
#}

gp()
{
    STASH=$(git stash);
    git pull --rebase;

    ### Only pop if something was stashed
    if [[ ${STASH} =~ ^Saved ]]; then
        git stash pop;
    fi;
}

# Just a git push
#gp()
#{
#    echo "Confirm pull rebase action?";
#    select yn in "Yes" "No";
#    do
#        case $yn in
#            Yes ) break;;
#            No ) return;;
#        esac;
#    done;
#    git pull --rebase;
##    git push;
#}

### Keep all the servers in sync!
#push_config()
#{
#    HOST=`hostname -s`;
#
#    if [ "$HOST" != "victory" ]; then
#        scp ~/.screenrc ~/.gitconfig ~/.bashrc ~/.vimrc victory:~/;
#        scp -r ~/.screen victory:~/;
#        scp -r ~/.vim victory:~/;
#    fi
#
#    if [ "$HOST" != "sand" ]; then
#        scp ~/.screenrc ~/.gitconfig ~/.bashrc ~/.vimrc sand:~/;
#        scp -r ~/.screen sand:~/;
#        scp -r ~/.vim sand:~/;
#    fi
#
#    if [ "$HOST" != "bergen" ]; then
#        scp ~/.screenrc ~/.gitconfig ~/.bashrc ~/.vimrc bergen:~/;
#        scp -r ~/.screen bergen:~/;
#        scp -r ~/.vim bergen:~/;
#    fi
#}

pull_config()
{
    scp -r broad:~/.vim ~/;
    scp broad:~/.gitconfig broad:~/.bashrc broad:~/.vimrc ~/;
}

create_test()
{
    touch test.pl;
    printf "#!usr/bin/perl\nuse warnings;\nuse strict;\nuse Data::Dumper;\n" > test.pl;
}

tabs()
{
    xargs bash -c '</dev/tty vim -p "$@"' ignoreme;
}

work()
{
    eval `ssh-agent` && ssh-add;
    ssh -A atam@dws38.mia2.cbsig.net;
}

f() {
    find ./$2 -iname \*$1\*
}

 
# Finding Symbolic links
# Use ls -i to locate all of the inodes of files.
# find . -inum 2>/null will write all the stderr into a log file called null    .

export NVM_DIR="/home/andrew/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh"  # This loads nvm

cd ~/Projects

export PATH="$HOME/.yarn/bin:$HOME/.config/yarn/global/node_modules/.bin:$PATH"

# tabtab source for serverless package
# uninstall by removing these lines or running `tabtab uninstall serverless`
[ -f /usr/local/lib/node_modules/serverless/node_modules/tabtab/.completions/serverless.bash ] && . /usr/local/lib/node_modules/serverless/node_modules/tabtab/.completions/serverless.bash
# tabtab source for sls package
# uninstall by removing these lines or running `tabtab uninstall sls`
[ -f /usr/local/lib/node_modules/serverless/node_modules/tabtab/.completions/sls.bash ] && . /usr/local/lib/node_modules/serverless/node_modules/tabtab/.completions/sls.bash
# tabtab source for slss package
# uninstall by removing these lines or running `tabtab uninstall slss`
[ -f /usr/local/lib/node_modules/serverless/node_modules/tabtab/.completions/slss.bash ] && . /usr/local/lib/node_modules/serverless/node_modules/tabtab/.completions/slss.bash
