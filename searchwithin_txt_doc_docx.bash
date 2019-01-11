#!/bin/bash
dirpath="$(zenity --file-selection --directory)"
keyword="$(zenity --entry --text "Keyword for searching" --entry-text "String")"
echo "Results:" > /tmp/scanresultstext
greptxt ()
{
  find $dirpath -name "*.txt" |
  while read i; do cat "$i" |
  grep -il --label="$i" "$keyword" >> /tmp/scanresultstext ; done
}
grepdocs ()
{
  find $dirpath -name "*.doc" |
  while read i; do catdoc "$i" |
  grep -il --label="$i" "$keyword" >> /tmp/scanresultstext ; done
}
grepdocxs ()
{
  find $dirpath -name "*.docx" |
  while read i; do docx2txt < "$i" |
  grep -il --label="$i" "$keyword" >> /tmp/scanresultstext ; done
}
greptxt
grepdocs
grepdocxs
zenity --text-info --filename=/tmp/scanresultstext
