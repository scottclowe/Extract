#!/bin/bash
# function Extract for common file formats

function extract {
    if [ -z "$1" ] || [ "$1" == "-h" ]; then
        # display usage if no parameters given
        echo "Usage: extract <path/file_name>.<zip|rar|bz2|gz|tar|tbz2|tgz|Z|7z|xz|ex|tar.bz2|tar.gz|tar.xz>"
        return 0;
    fi;
    if [ ! -f "$1" ] ; then
        echo "'$1' - file does not exist"
        return 1;
    fi;
    NAME=${1%.*}
    #mkdir $NAME && cd $NAME
    case "$1" in
        *.tar.bz2)   tar xvjf "$1";     return  ;;
        *.tar.gz)    tar xvzf "$1";     return  ;;
        *.tar.xz)    tar xvJf "$1";     return  ;;
        *.lzma)      unlzma "$1";       return  ;;
        *.bz2)       bunzip2 "$1";      return  ;;
        *.rar)       unrar x -ad "$1";  return  ;;
        *.gz)        gunzip "$1";       return  ;;
        *.tar)       tar xvf "$1";      return  ;;
        *.tbz2)      tar xvjf "$1";     return  ;;
        *.tgz)       tar xvzf "$1";     return  ;;
        *.zip)       unzip "$1";        return  ;;
        *.Z)         uncompress "$1";   return  ;;
        *.7z)        7z x "$1";         return  ;;
        *.xz)        unxz "$1";         return  ;;
        *.exe)       cabextract "$1";   return  ;;
        *)           echo "extract: '$1' - unknown extension";;
    esac;
    # No extension given it seems, so we will try to work it out by MIME-type
    TYPE=$(file --mime-type -b "$1")
    echo "Trying to deduce compression from MIME type";
    echo "$1 is a $TYPE";
    case $TYPE in
        application/x-gtar)
            tar -xvf "$1";;
        application/x-lzma)
            unlzma "$1";;
        application/x-bzip2)
            bunzip2 "$1";;
        application/x-rar)
            unrar x -ad "$1";;
        application/gzip)
            # gunzip won't work without an extension, so just use 7z
            false;;
        application/zip)
            unzip "$1";;
        application/x-compress)
            uncompress "$1";;
        application/x-7z-compressed)
            7z x "$1";
            return;; # Don't double up on 7z
        application/x-xz)
            unxz "$1";;
        *)
            echo "extract: '$1' - unknown mime-type '$TYPE'";
            false;;
    esac;
    # 7z is a Swiss-army knife for decompression, so try that
    if [[ $? -ne 0 ]];
    then
        command -v 7z >/dev/null 2>&1 \
            && 7z x "$FILE";
    fi;
}

# Main
extract "$@";
