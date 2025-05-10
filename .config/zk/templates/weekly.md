---
title: {{format-date now "%Y-W%U"}}
aliases: []
tags: [weekly]
date: {{format-date now "%Y-%m-%d"}}
---


## Navigation

[[{{format-date (date "last week") "%Y-W%U"}}]] <-> [[{{format-date (date "next week") "%Y-W%U"}}]]

## DailyNotes

{{sh "zk list journal/daily --created-after 'last 1 weeks' --format='- [[{{filename-stem}}]]' --quiet"}}

## Summary
