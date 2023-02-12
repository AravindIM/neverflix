#!/usr/bin/env bash

check_dependencies(){
    # Checking if the crap you need is installed or not.
    is_curl_installed=false
    is_fzf_installed=false
    is_peerflix_installed=false
    is_mpv_installed=false
    is_missing_installed=false


    [ -x "$(command -v curl)" ] && is_curl_installed=true
    [ -x "$(command -v fzf)" ] && is_fzf_installed=true
    [ -x "$(command -v peerflix)" ] && is_peerflix_installed=true
    [ -x "$(command -v mpv)" ] && is_mpv_installed=true

    $is_curl_installed && $is_fzf_installed && $is_peerflix_installed && $is_mpv_installed || is_missing_installed=true

    $is_missing_installed && echo -n "Hey, it looks like you forgot to install "

    $is_curl_installed || ( echo -n "curl" && $is_fzf_installed && $is_peerflix_installed && $is_mpv_installed || echo -n ", " )
    $is_fzf_installed || ( echo -n "fzf" && $is_peerflix_installed && $is_mpv_installed || echo -n ", " )
    $is_peerflix_installed || ( echo -n "peerflix" && $is_mpv_installed || echo -n ", " )
    $is_mpv_installed || echo -n "mpv"

    $is_missing_installed && echo ". Please try running the script after installing it!"
    echo
    
    $is_missing_installed && exit
}

nflix(){
    query=$(printf '%s' "$*" | tr ' ' '+' )
    echo "Searching for movie/show, please wait..."
    name=$(curl -s -L "https://1337xxx.to/search/$query/1/" | grep -E "torrent\/[0-9]{7}\/[a-zA-Z0-9?%-]*/" | cut -d\> -f5 | cut -d\< -f1 | head -n 15 | fzf)
    [ -z "$name" ] && echo "Next time, then!" && exit
    movie=$(curl -s -L "https://1337xxx.to/search/$query/1/" | grep $name | grep -Eo "torrent\/[0-9]{7}\/[a-zA-Z0-9?%-]*/" | head -n 1)
    echo "Fetching magnet link for \"$name\", please wait..."
    magnet=$(curl -s -L https://1337xxx.to/$movie | grep -Po "magnet:\?xt=urn:btih:.*announce\"" | cut -d\" -f1 | head -n 1)
    [ -z "$magnet" ] && ( echo Magnet link not found! && exit ) || echo Magnet link found for \"$movie\"...

    peerflix -l -k $magnet
}


nflixhelp(){
	echo "Usage: neverflix [-h] <Search Term>"
	echo "Options:"
	echo "-h : Shows this help menu"
	echo "Eg : neverflix Mr Robot"
}

main(){
    check_dependencies
    case $1 in
	-h) nflixhelp ;;
	*) nflix $* ;;
    esac
}

main $*

