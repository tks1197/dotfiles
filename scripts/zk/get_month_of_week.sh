#!/bin/bash
year=$(date +'%Y')
month=$(date +'%m')
day=$(date +'%e' | tr -d '[:blank:]')

weeknum=$(cal "${month}" "${year}" | grep -v "[[:alpha:]]" | grep -nw "${day}" | cut -f1 -d':')
echo "$year"-"$month"-W"$weeknum"
