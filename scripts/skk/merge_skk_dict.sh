#! /usr/bin/env bash

PATH=/opt/homebrew/bin:$PATH
GOOGLE_SUGGEST_CACHE_FILE=/tmp/yaskkserv2-google-suggest.cache
if [ ! -f $GOOGLE_SUGGEST_CACHE_FILE ]; then
  echo "google cache file not found."
  exit 0
fi

pushd "$HOME/.local/share/skk/" || exit
yaskkserv2_make_dictionary \
  --cache-filename=$GOOGLE_SUGGEST_CACHE_FILE --output-jisyo-filename=tmp.SKK-JISYO-USER.euc &&
  skkdic-expr2 tmp.SKK-JISYO-USER.euc + SKK-JISYO-USER.euc >merged_SKK-JISYO-USER.euc &&
  mv merged_SKK-JISYO-USER.euc SKK-JISYO-USER.euc &&
  rm tmp.SKK-JISYO-USER.euc &&
  yaskkserv2_make_dictionary --dictionary-filename=/tmp/dictionary.yaskkserv2 SKK-JISYO*
