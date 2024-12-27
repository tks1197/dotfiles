#! /bin/bash

pushd "$HOME/.local/share/skk/" || exit
yaskkserv2_make_dictionary \
    --cache-filename=/tmp/yaskkserv2-google-suggest.cache --output-jisyo-filename=tmp.SKK-JISYO-USER.euc &&
    skkdic-expr2 tmp.SKK-JISYO-USER.euc + SKK-JISYO-USER.euc >merged_SKK-JISYO-USER.euc &&
    mv merged_SKK-JISYO-USER.euc SKK-JISYO-USER.euc &&
    rm tmp.SKK-JISYO-USER.euc &&
    yaskkserv2_make_dictionary --dictionary-filename=/tmp/dictionary.yaskkserv2 \
        SKK-JISYO.L SKK-JISYO.geo SKK-JISYO.jinmei SKK-JISYO.propernoun SKK-JISYO.station SKK-JISYO-USER.euc
