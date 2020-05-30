#!/bin/bash
DB=`ffmpeg -i "$1" -af "volumedetect" -vn -sn -dn -f null /dev/null 2>&1 | grep max_volume | sed -n "s/\(.*max_volume: -\)\(.*\)\( dB\)/\2/p"`
DB=`bc -l <<< "${DB} - 1"`
BASE="${1%.*}"
BASE="${BASE// /-}"
OUT="${BASE}/${BASE}-mono-downmix-normalized.mkv"
mkdir -p ${BASE}
echo "normalizing to -${DB} dB, downmixing to mono and writing to '${OUT}'..."
ffmpeg -i "$1" -af "afftdn=nt=w:om=o,volume=${DB}dB" -ac 1 -c:v copy -c:a aac -b:a 192k "${OUT}" 
