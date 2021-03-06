# This module is used to create the user home directory
# and to set the config files


PEARL_CONFIGS="bashrc:source $PEARL_ROOT/pearl:$HOME/.bashrc
vimrc:source $PEARL_ROOT/mods/pearl/dotfiles/etc/vim/vimrc:$HOME/.vimrc
emacs:(load-file \"$PEARL_ROOT/mods/pearl/dotfiles/etc/emacs/emacs.el\"):$HOME/.emacs
inputrc:\$include $PEARL_ROOT/mods/pearl/dotfiles/etc/inputrc:$HOME/.inputrc
ranger:exec(open('$PEARL_ROOT/mods/pearl/dotfiles/etc/ranger/commands.py').read()):$HOME/.config/ranger/commands.py
screenrc:source $PEARL_ROOT/mods/pearl/dotfiles/etc/screenrc:$HOME/.screenrc
tmux:source $PEARL_ROOT/mods/pearl/dotfiles/etc/tmux.conf:$HOME/.tmux.conf
muttrc:source $PEARL_ROOT/mods/pearl/dotfiles/etc/mutt/muttrc:$HOME/.muttrc
muttrc-sidebar:source $PEARL_ROOT/mods/pearl/dotfiles/etc/mutt/muttrc-sidebar:$HOME/.muttrc
xdefaults:# include \"$PEARL_ROOT/mods/pearl/dotfiles/etc/Xdefaults\":$HOME/.Xdefaults
liquidprompt:source \"$PEARL_ROOT/mods/pearl/dotfiles/etc/liquidprompt/liquidpromptrc\":$HOME/.liquidpromptrc
gitconfig:[include] path = \"$PEARL_ROOT/mods/pearl/dotfiles/etc/git/gitconfig\":$HOME/.gitconfig
gitignore:[core] excludesfile = $PEARL_ROOT/mods/pearl/dotfiles/etc/git/gitignore:$HOME/.gitconfig"

function pearl_dotfile_enable(){
    local configname="$1"

    while read -r line; do
        local conf=$(echo $line | awk -F : '{print $1}')
        local confline=$(echo "$line" | awk -F : '{print $2}')
        local conffile=$(echo "$line" | awk -F : '{print $3}')
        if [ "$conf" == "$configname" ]
        then
            echo "Applying in $conffile ..."
            apply "$confline" "$conffile"
            return 0
        fi
    done <<< "$PEARL_CONFIGS"

    return 1
}

function pearl_dotfile_disable(){
    local configname="$1"

    while read -r line; do
        local conf=$(echo $line | awk -F : '{print $1}')
        local confline=$(echo "$line" | awk -F : '{print $2}')
        local conffile=$(echo "$line" | awk -F : '{print $3}')
        if [ "$conf" == "$configname" ]
        then
            echo "Unapplying in $conffile ..."
            unapply "$confline" "$conffile"
            return 0
        fi
    done <<< "$PEARL_CONFIGS"

    return 1
}


function pearl_dotfile_list(){
    while read -r line; do
        local conf=$(echo $line | awk -F : '{print $1}')
        local confline=$(echo "$line" | awk -F : '{print $2}')
        local conffile=$(echo "$line" | awk -F : '{print $3}')

        local enabled=""
        is_applied "$confline" "$conffile" 2> /dev/null && enabled="[enabled]"
        echo "$conf $enabled"

    done <<< "$PEARL_CONFIGS"

    return 0
}
