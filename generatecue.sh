#!/bin/bash

# set the directory containing wav files 
directory=${1:-"."}/cddownload
cuefile="output.cue"

# set up the begining of the cue file
firstfile=$(ls "$directory"/*.wav 2>/dev/null | head -n 1)
echo "TITLE \"$(ffprobe -v error -show_entries format_tags=album -of default=noprint_wrappers=1:nokey=1 "$firstfile")\"" >> "$cuefile"
echo "PERFORMER \"$(ffprobe -v error -show_entries format_tags=artist -of default=noprint_wrappers=1:nokey=1 "$firstfile")\"" >> "$cuefile"

# for each wav file, write file name, track number, title, artist and include INDEX 01 00:00:00 (because each song is a different file)
tracknumber=1
for FILE in "$directory"/*.wav; do
  if [ -f "$FILE" ]; then
    # use ffprobe to read metadata
    TITLE=$(ffprobe -v error -show_entries format_tags=title -of default=noprint_wrappers=1:nokey=1 "$FILE")
    ARTIST=$(ffprobe -v error -show_entries format_tags=artist -of default=noprint_wrappers=1:nokey=1 "$FILE")

    # defaults if metadata is missing (but it shouldn't be)
    TITLE=${TITLE:-"Track $tracknumber"}
    ARTIST=${ARTIST:-"Unknown Artist"}

    # write cue file
    echo "FILE \"$directory/$(basename "$FILE")\" WAVE" >> "$cuefile"
    printf "  TRACK %02d AUDIO\n" $tracknumber >> "$cuefile"
    echo "    TITLE \"$TITLE\"" >> "$cuefile"
    echo "    PERFORMER \"$ARTIST\"" >> "$cuefile"
    echo "    INDEX 01 00:00:00" >> "$cuefile"

    ((tracknumber++))
  fi
done

# give the user time to edit the cue file if they want to
echo "CUE file generated: $cuefile"
echo "I'd recomend changing some of the metadata now, in case any of the YouTube titles contain (OFFICIAL AUDIO) or (Music Video)"

# clean up
rm -r $output