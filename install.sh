#!/bin/sh

backup_vimrc() 
{
	if [ -e ~/.vimrc ] ; then
		mv ~/.vimrc ~/.vimrc.bak
	fi
}

download_dotfiles()
{
	mkdir -p ~/dev
	pushd ~/dev

	git clone https://github.com/irightcode/dotfiles

	popd
}

overwrite_vimrc()
{
	backup_vimrc
	ln -s ~/dev/dotfiles/.vimrc ~/.vimrc
}

install_vim_plugins()
{
	git clone https://github.com/gmarik/vundle.git ~/.vim/bundle/vundle
	vim +PluginInstall +qall
}

install_vim() 
{
	overwrite_vimrc
	install_vim_plugins
}

install() 
{
	download_dotfiles
	install_vim
}

install


