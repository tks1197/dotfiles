---
title: {{sh "~/.local/share/chezmoi/scripts/zk/get_month_of_week.sh"}}
aliases: []
tags: [weekly]
date: {{format-date now "%Y-%m-%d"}}
---
## daily notes

{{sh "zk list journal/daily --created-after 'last 1 weeks' --format='- [[{{filename-stem}}]]' --quiet"}}

## Summary
