#! /usr/bin/env python

import os, sys
from os.path import join, abspath, isdir, isfile, exists, islink
from getopt import getopt

# defaults
ignores = ".git pwd.kdb make_links.sh make_links.py".split(" ")
user_dir = os.path.expanduser('~')
force = False
dry_run = False
verbose = False

# utilities
def chatter(*args):
    if verbose:
        print " ".join(args)

def do(cmd, *args):
    if not dry_run:
        cmd(*args)

# ensure we are in the right dir
os.chdir(os.path.dirname(sys.argv[0]))

# parse
opts, rest =  getopt(sys.argv[1:], "hfdvu:")
for flag, val in opts:
    if flag == "-f":
        force = True
    elif flag == "-d":
        dry_run = True
    elif flag == "-v":
        verbose = True
    elif flag == '-u':
        user_dir = os.path.expanduser(val)
    elif flag == '-h':
        print """Usage:
 -f     force
 -d     dryrun
 -u     specify the user-dir (defaults to ${userdir}
 -h     halps!
 -v     verbose
 """

if dry_run: chatter("doing dryrun")
chatter("inserting symlinks into", user_dir)

for path, paths, files in os.walk(".", topdown=True):
    for list in paths, files:
        for each in list[:]:
            if each in ignores: 
                chatter('ignoring', each)
                list.remove(each)

    new_path = abspath(join(user_dir, path))
    path = abspath(path)

    if not isdir(new_path): 
        chatter('making dir', new_path)
        do(os.mkdir, new_path)

    for file in files:
        src = join(path, file)
        dest = join(new_path, file)
        if force and (exists(dest) or islink(dest)):
            chatter('unlinking', dest)
            do(os.unlink, dest)

        if not force and (exists(dest) or islink(dest)):
            chatter('skipping existing', dest)
        else:  
            do(os.symlink, src, dest)
            print "+ %s -> %s" % (src, dest)

