#!/bin/bash

pushd `dirname $0` > /dev/null
CURRENT_PATH=`pwd`
popd > /dev/null

echo "Installation from $CURRENT_PATH"

[ ! -L ~/.vimrc ] && ln -s $CURRENT_PATH/vimrc ~/.vimrc

git submodule init
git submodule update

popd > /dev/null

exit 0
