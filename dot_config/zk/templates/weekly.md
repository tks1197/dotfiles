---
date: {{format-date now "%Y-%m-%d"}}
tags: [weekly]
aliases: []
---
# {{sh "~/.local/share/chezmoi/scripts/zk/get_month_of_week.sh"}}

## daily notes

{{sh "zk list journal/daily --created-after 'last 1 weeks' --format='- [[{{filename-stem}}]]' --quiet"}}

## Summary
