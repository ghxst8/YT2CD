#!/bin/bash

echo "THIS SCRIPT IS IN VERY VERY VERY EARLY DEVELOPMENT"
echo "STUFF MAY NOT WORK!!!!! I DON'T KNOW WHAT I'M DOING!!!!"
echo ""
echo "Please enter the URL to the playlist you'd like to download and burn"

# read url of audio
read urlinput

# set output dir
output=${1:-"."}

# make output dir
mkdir -p "$output/cddownload"
output="$output/cddownload"

echo "Downloading..."
yt-dlp -x \
    --audio-format wav \
    -o "$output/%(playlist_index)02d_%(title)s.%(ext)s" \
    -S "asr:44100" \
    --embed-metadata \
    --parse-metadata "uploader:%(artist)s" \
    --parse-metadata "title:%(title)s" \
    --parse-metadata "playlist_index:%(playlist_index)s" \
    $urlinput

# check if download worked
if [ $? -ne 0 ]; then
    echo "Error: Playlist download failed."
    exit 1
fi

# create a text file for metadata
# THIS WAS A PAIN IN THE ASS.
./generatecue.sh

# to set where the CD drive is
echo "Please enter the device path of your CD burner. Default is /dev/sr0"
read $cddrivepath
cddrivepath=${cddrivepath:-/dev/sr0}

# move cue file to cddownload
mv output.cue $output

echo "Burning the audio CD..."
cdrdao write -n --eject --device $cddrivepath $output/output.cue

echo "Done! Your CD is ready with proper order and metadata."