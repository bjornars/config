#!/bin/bash

userdir=~
curdir=$(pwd)
reldir=${curdir:${#userdir}+1}

force=""

# set -o xtrace
while getopts "hfdu:" opt; do
    case $opt in
        f)
            force="-f"
            ;;
        d)
            dryrun=1
            ;;
        u)
            userdir=$OPTARG
            ;;
        h)
            cat << EOF
Usage:
 -f     force
 -d     dryrun
 -u     specify the user-dir (defaults to ${userdir}
 -h     halps!
EOF
        exit 1
        ;;
        \?)
            echo "Invalid option: -$OPTARG" >&2
            ;;
    esac
done

[[ -n $dryrun ]] && echo Doing dryrun.

echo Inserting symlinks into ${userdir}

for file in $(find . -type f ! -path "./.git/*" -a ! -path $0); do

    base=${file:2}
    dir=$userdir/$(dirname $base)

    if [[ ! -d $dir ]]; then
        echo Making dir for $dir
        [[ -z $dryrun ]] && mkdir -p $dir
    fi

    echo "Creating symlink: ${curdir}/${base} -> ${userdir}/${base}"
    [[ -z $dryrun ]] && 
        ln -s ${force} "$curdir/${base}" ${userdir}/${base}

done

