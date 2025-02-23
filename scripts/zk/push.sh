#! /bin/bash

pushd "$HOME"/.local/share/chezmoi/scripts/zk || exit
rsync -av "$ZK_NOTEBOOK_DIR"/workspaces/ "$HOME"/Dropbox/workspaces/ --exclude-from=./exclude.txt
popd || exit
