#! /bin/bash

pushd "$HOME/.local/share/skk/" || exit 1
"$HOME"/.local/bin/yaskkserv2_make_dictionary --dictionary-filename=/tmp/dictionary.yaskkserv2 \
    SKK-JISYO.L SKK-JISYO.geo SKK-JISYO.jinmei SKK-JISYO.propernoun SKK-JISYO.station SKK-JISYO-USER.euc &&
    yaskkserv2 /tmp/dictionary.yaskkserv2 \
        --google-cache-filename=/tmp/yaskkserv2-google-suggest.cache
