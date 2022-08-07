#!/bin/bash

MUSIC_DIR=/run/media/kelvin/Lexar/music
COVER=/tmp/cover.jpg

find_cover_image() {

    # First we check if the audio file has an embedded album art
    ext="$(mpc --format %file% current | sed 's/^.*\.//')"
    if [ "$ext" = "flac" ]; then
        # since FFMPEG cannot export embedded FLAC art we use metaflac
        metaflac --export-picture-to="$COVER" \
            "$(mpc --format "$MUSIC_DIR"/%file% current)" &&
            cover_path="$COVER" && return
    else
        ffmpeg -y -i "$(mpc --format "$MUSIC_DIR"/%file% | head -n 1)" \
            "$COVER" -vsync "vfr" &&
            cover_path="$COVER" && return
    fi

    # If no embedded art was found we look inside the music file's directory
    album="$(mpc --format %album% current)"
    file="$(mpc --format %file% current)"
    album_dir="${file%/*}"
    album_dir="$MUSIC_DIR/$album_dir"
    # found_covers="$(find "$album_dir" -type d -exec find {} -maxdepth 1 -type f \
    # -iregex ".*/.*\(${album}\|cover\|folder\|artwork\|front\).*[.]\\(jpe?g\|png\|gif\|bmp\)" \; )"
    found_covers="$(fd .jpg "$album_dir")"
    cover_path="$(echo "$found_covers" | head -n1)"

    if [[ -n "$cover_path" ]] ; then
      #resize the image's width to 300px 
      convert "$cover_path" -resize 300x "$COVER"
    fi
}

reset_background() {
    printf "\e]20;;100x100+1000+1000\a"
}

kill_previous_instances() {
    script_name=$(basename "$0")
    for pid in $(pidof -x "$script_name"); do
        if [ "$pid" != $$ ]; then
            kill -15 "$pid"
        fi 
    done
}

{
    find_cover_image >/dev/null 2>&1
    if [[ -f "$COVER" ]] ; then
       # scale down to fir window
       printf "\e]20;${COVER};70x70+4+30:op=keep-aspect\a"
    else
        reset_background
    fi
} &
