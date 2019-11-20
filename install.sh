# Install these config files in their correct places

if [ ! -d ~/.config ]; then
    mkdir ~/.config
    # Terminator
    ln -s terminator ~/.config/terminator
fi

# Vim
if [ -f ~/.vimrc ]; then
    echo .vimrc already exists! Manually merge files.
else
    ln -s .vimrc ~/.vimrc
fi
if [ ! -f ~/.vim/autoload/plug.vim ]; then
    echo Install vim-plug, then try again
elif [ ! -d ~/.vim/plugged/dracula ]; then
    echo Install Dracula colorscheme using vim-plug
fi
