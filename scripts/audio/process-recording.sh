#!/bin/bash

# configure output directory
BASE="${1%.*}"
BASE="${BASE// /-}"
mkdir -p ${BASE}

# resolve peak volume for normalization
DB=`ffmpeg -i "$1" -af "volumedetect" -vn -sn -dn -f null /dev/null 2>&1 | grep max_volume | sed -n "s/\(.*max_volume: -\)\(.*\)\( dB\)/\2/p"`
DB=`bc -l <<< "${DB} - 1"`

# both channels
OUT="${BASE}/${BASE}-mono-downmix-normalized.mkv"
echo "normalizing to -${DB} dB, downmixing to mono and writing to '${OUT}'..."
ffmpeg -i "$1" -af "afftdn=nt=w:om=o,volume=${DB}dB" -ac 1 -c:v copy -c:a aac -b:a 192k "${OUT}"

# isolated left channel
OUT="${BASE}/${BASE}-mono-left-normalized.mkv"
echo "normalizing to -${DB} dB, downmixing to mono and writing to '${OUT}'..."
ffmpeg -i "$1" -af "afftdn=nt=w:om=o,volume=${DB}dB,pan=mono|c0=FL" -c:v copy -c:a aac -b:a 192k "${OUT}"

# isolated right channel
OUT="${BASE}/${BASE}-mono-right-normalized.mkv"
echo "normalizing to -${DB} dB, downmixing to mono and writing to '${OUT}'..."
ffmpeg -i "$1" -af "afftdn=nt=w:om=o,volume=${DB}dB,pan=mono|c0=FR" -c:v copy -c:a aac -b:a 192k "${OUT}"

# move input to sub-directory
mv "${1}" "${BASE}/${BASE}-original.mkv"