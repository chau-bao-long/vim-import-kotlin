#! /usr/local/bin/zsh
sample=${SAMPLE_PATH:="$HOME/Projects/personio"}

rg -U -I -t kotlin import $sample > ~/.import.lib
no_dup_data=$(awk '!a[$0]++' ~/.import.lib)
echo $no_dup_data | sed 's/import //g' > ~/.import.lib
