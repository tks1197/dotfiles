#! /bin/bash

pushd "$HOME/.local/share/skk/" || exit 1
"$HOME"/.local/bin/yaskkserv2_make_dictionary --dictionary-filename=/tmp/dictionary.yaskkserv2 SKK-JISYO* &&
  yaskkserv2 /tmp/dictionary.yaskkserv2 --google-suggest --google-cache-filename=/tmp/yaskkserv2-google-suggest.cache
popd || exit 1

<"$HOME/.local/share/chezmoi/scripts/skk/job.txt" crontab -
