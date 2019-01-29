#!/bin/bash

function promptFileDelete {
	if [ -e $1 ]; then
		echo "File $1 already exists"
		while true; do
			read -p "Replace? " yn

			case $yn in
				[Yy]* ) rm $1; break;;
				[Nn]* ) exit 1;;
				* ) echo "Please answer yes or no.";;
			esac
		done;
		if [ -e $1 ]; then
			echo "$1 still exists. Please delete manually."
			exit 1
		fi
	fi
}

pushd `dirname $0` > /dev/null
CURRENT_PATH=`pwd`

echo "#> bodeme dev environment <#"
echo "##> Installation from $CURRENT_PATH"
echo ""
echo "##> Installation VIM environment"

if [ "$1" == "-f" ]; then
  rm -f ~/.vimrc
  rm -f ~/.vim
  rm -f ~/.bashrc
else
  promptFileDelete ~/.vimrc
  promptFileDelete ~/.vim
  promptFileDelete ~/.bashrc
fi

echo "##> Creating symlinks"
[ ! -L ~/.vimrc ] && ln -s $CURRENT_PATH/vim/vimrc ~/.vimrc
[ ! -L ~/.bashrc ] && ln -s $CURRENT_PATH/bash/bashrc ~/.bashrc
[ ! -L ~/.vim ] && ln -s $CURRENT_PATH/vim/ ~/.vim

echo "##> Initializing submodules"
git submodule init
git submodule update

popd > /dev/null

echo "#> Finished"
exit 0
