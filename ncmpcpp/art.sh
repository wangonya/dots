#!/bin/bash

previewdir="$HOME/.ncmpcpp-previews"
previewname="$previewdir/$(mpc --format %album% current | base64).png"

find_cover_image() {
    music_dir=/run/media/wangonya/Lexar/music/
    filename="$(mpc --format "$music_dir"%file% current)"
    
    # First we check if the audio file has an embedded album art
    ext="$(mpc --format %file% current | sed 's/^.*\.//')"
    if [ "$ext" = "flac" ]; then
        # since FFMPEG cannot export embedded FLAC art we use metaflac
        metaflac --export-picture-to="$previewname" "$filename" && return
    else
        ffmpeg -y -i "$filename" -an -vf "$previewname" && return
    fi

    # If no embedded art was found we look inside the music file's directory
    album_dir="${filename%/*}"
    found_covers="$(fd .jpg --max-depth 1 --full-path "$album_dir")"
    cover_path="$(echo "$found_covers" | head -n1)"
    cp "$cover_path" "$previewname"
}

kill_previous_instances() {
    script_name=$(basename "$0")
    for pid in $(pidof -x "$script_name"); do
        if [ "$pid" != $$ ]; then
            kill -15 "$pid"
        fi 
    done
}

display_cover_image() {
    send_to_ueberzug \
        action "add" \
        identifier "ncmpcpp_cover" \
        path "$previewname" \
        x "0" \
        y "0" \
        width "30" \
        height "30" \
        synchronously_draw "True"
}

send_to_ueberzug() {
    old_IFS="$IFS"

    # Ueberzug's "simple parser" uses tab-separated
    # keys and values so we separate words with tabs
    # and send the result to the wrapper's FIFO
    IFS="$(printf "\t")"
    echo "$*" > "$FIFO_UEBERZUG"

    IFS=${old_IFS}
}

kill_previous_instances >/dev/null 2>&1
[ -f "$previewname" ] || find_cover_image >/dev/null 2>&1
display_cover_image     2>/dev/null




####################################

# {
#     ImageLayer::add [identifier]="ncmpcpp_cover" [x]="0" [y]="0" [max_width]="30" [path]="$previewname"
# }  | ueberzug layer --silent --parser simple #>/dev/null 2>&1 &

# display_cover_image() {
#     ueberzug layer --parser bash 0< <(
#         declare -Ap add_command=(
#         [action]="add" 
#         [identifier]="ncmpcpp_cover" 
#         [x]="0" 
#         [y]="0" 
#         [max_width]="30" 
#         [path]="$previewname")
#         read
#     )
# }
