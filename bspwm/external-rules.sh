#!/bin/sh

window_id="$1"
window_class="$2"
window_instance="$3"
consequences="$4"
window_title="$(xwininfo -id "$window_id" | sed ' /^xwininfo/!d ; s,.*"\(.*\)".*,\1,')"

main() {
    case "$window_class" in
        "Spotify")
            echo "state=floating"
            echo "center=on"
            echo "follow=on"
            ;;
        "Slack")
            echo "state=floating"
            echo "center=on"
            echo "follow=on"
            ;;
        "Zoom")
            echo "state=floating"
            echo "center=on"
            echo "follow=on"
            ;;
        "")
            sleep 1
            window_class=$(xprop -id $window_id | grep "WM_CLASS" | sed 's/.*"\(.*\)"/\1/g' ) 
            window_instance="${window_class,,}"
            [[ -n "$window_class" ]] && main
            ;;
        *)
            echo "Nothing found... $1  $2  $3  $4"
            ;;
    esac
}

main

# echo "rectangle=680x770+540+110"
