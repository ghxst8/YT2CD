# YT2CD

YT2CD is a script for Arch Linux that simplifies the process of downloading audio from YouTube, converting the audio into the propper format and including metadata, and burning to CDs.

## Features

- Download audio from YouTube videos in 16-bit 44.1khz WAVE format
- Tag audio files with metadata (e.g., title, artist, album).
- Generate a .cue file compatible with cdrado for seamless CD burning.
- Supports playlists and single videos.

## Prerequisites

Before using YT2CD, ensure the following are installed on your system:

- yt-dlp(https://github.com/yt-dlp/yt-dlp)
- ffprobe (part of ffmpeg, https://www.ffmpeg.org/)
- cdrdao (https://github.com/cdrdao/cdrdao)

## Installation

Clone this repository to your local machine:

```bash
git clone https://github.com/ghxst8/YT2CD.git
cd YT2CD
```

or just download the files from the code section.

## Usage

1. Run the script:

   ```bash
   chmod +x cddownload.sh
   chmod +x generatecue.sh
   ./cddownload.sh
   ```


## How It Works

1. **Download Audio**: Extracts the audio from the provided YouTube URLs using yt-dlp.
2. **Tag Files**: Uses ffprobe to read metadata downloaded by yt-dlp and generates a .cue file (the user can edit this before burning).
3. **Burn CD**: uses cdrdao to burn audio onto cd in the same order as the YouTube playlist, with artist name and song title.

## License

This project is licensed under the MIT License. See the [LICENSE](LICENSE) file for details.

## Acknowledgments

- yt-dlp(https://github.com/yt-dlp/yt-dlp)
- ffprobe (part of ffmpeg, https://www.ffmpeg.org/)
- cdrdao (https://github.com/cdrdao/cdrdao)

## Support

If you encounter issues or have questions, please open an issue on the [GitHub repository](https://github.com/ghxst8/YT2CD/issues).
