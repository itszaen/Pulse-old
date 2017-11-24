#!/bin/bash
journalctl -n 9 > ~/.journal
sed 1d ~/.journal > ~/.journal-t
fold -w 80 ~/.journal-t > ~/.journal.txt
