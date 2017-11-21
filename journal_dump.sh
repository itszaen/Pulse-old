#!/bin/bash
journalctl -n 10 > ~/.journal
sed 1d ~/.journal > ~/.journal-t
fold -w 80 ~/.journal-t > ~/.journal.txt
