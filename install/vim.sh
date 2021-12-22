logLine "installing: vim plugins"

# create plugins directory
vimdir=$home/.vim
vimplugindir=$vimdir/pack/inanc/start
reCreateDirectory $vimdir
runCmd mkdir -p $vimplugindir

# add plugins
runCmd cd $vimplugindir && git clone --quiet https://tpope.io/vim/sensible.git
runCmd cd $vimplugindir && git clone --quiet https://github.com/xolox/vim-misc
runCmd cd $vimplugindir && git clone --quiet https://github.com/xolox/vim-colorscheme-switcher
runCmd cd $vimplugindir && git clone --quiet https://github.com/flazz/vim-colorschemes.git
runCmd cd $vimplugindir && git clone --quiet https://github.com/preservim/nerdtree
runCmd cd $vimplugindir && git clone --quiet https://github.com/fatih/vim-go
