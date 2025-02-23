#! /bin/bash

pushd "$HOME"/.local/share/chezmoi/scripts/zk || exit
rsync -av --update "$HOME"/Dropbox/workspaces/ "$ZK_NOTEBOOK_DIR"/workspaces/ --exclude-from=./exclude.txt
popd || exit
