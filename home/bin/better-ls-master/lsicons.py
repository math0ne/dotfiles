#!/usr/bin/env python
#-*- coding: utf-8 -*-
from os import path
import os
import subprocess
import glob
import stat
from pwd import getpwuid
from optparse import OptionParser


# File extension descriptions.
# Format: "EXTENSION": [u"ICON","COLOR CODE"]
EXTENSIONS = {":FILE":	[u"", "14"],
              ":DIRECTORY":	[u"", "7"],
              "7z":			[u"", "11"],
              "ai":			[u"", "4"],
              "bat":		[u"", "9"],
              "bmp":		[u"", "4"],
              "bz":			[u"", "11"],
              "bz2":		[u"", "11"],
              "c":			[u"", "9"],
              "c++":		[u"", "9"],
              "cc":			[u"", "9"],
              "clj":		[u"", "9"],
              "cljc":		[u"", "9"],
              "cljs":		[u"", "9"],
              "coffee":		[u"", "9"],
              "conf":		[u"", "9"],
              "cp":			[u"", "9"],
              "cpp":		[u"", "9"],
              "css":		[u"", "9"],
              "cxx":		[u"", "9"],
              "d":			[u"", "9"],
              "dart":		[u"", "9"],
              "db":			[u"", "9"],
              "diff":		[u"", "9"],
              "dump":		[u"", "3"],
              "edn":		[u"", "9"],
              "ejs":		[u"", "9"],
              "erl":		[u"", "9"],
              "f#":			[u"", "9"],
              "fish":		[u"", "9"],
              "fs":			[u"", "9"],
              "fsi":		[u"", "9"],
              "fsscript":	[u"", "9"],
              "fsx":		[u"", "9"],
              "gif":		[u"", "4"],
              "go":			[u"", "9"],
              "gz":			[u"", "11"],
              "hbs":		[u"", "9"],
              "hrl":		[u"", "9"],
              "hs":			[u"", "9"],
              "htm":		[u"", "9"],
              "html":		[u"", "9"],
              "ico":		[u"", "4"],
              "ini":		[u"", "9"],
              "java":		[u"", "9"],
              "jl":			[u"", "9"],
              "jpeg":		[u"", "4"],
              "jpg":		[u"", "4"],
              "js":			[u"", "9"],
              "json":		[u"", "9"],
              "jsx":		[u"", "9"],
              "less":		[u"", "9"],
              "lhs":		[u"", "9"],
              "lua":		[u"", "9"],
              "markdown":	[u"", "3"],
              "md":			[u"", "3"],
              "ml":			[u"λ", "9"],
              "mli":		[u"λ", "9"],
              "mustache":	[u"", "9"],
              "php":		[u"", "9"],
              "pl":			[u"", "9"],
              "pm":			[u"", "9"],
              "png":		[u"", "4"],
              "psb":		[u"", "4"],
              "psd":		[u"", "4"],
              "py":			[u"", "9"],
              "pyc":		[u"", "9"],
              "pyd":		[u"", "9"],
              "pyo":		[u"", "9"],
              "rb":			[u"", "9"],
              "rlib":		[u"", "9"],
              "rs":			[u"", "9"],
              "rss":		[u"", "3"],
              "scala":		[u"", "9"],
              "scss":		[u"", "9"],
              "sh":			[u"", "9"],
              "slim":		[u"", "9"],
              "sln":		[u"", "9"],
              "sql":		[u"", "9"],
              "styl":		[u"", "9"],
              "suo":		[u"", "9"],
              "t":			[u"", "3"],
              "tar":		[u"", "11"],
              "ts":			[u"", "4"],
              "twig":		[u"", "9"],
              "txt":		[u"", "3"],
              "vim":		[u"", "9"],
              "xul":		[u"", "9"],
              "xz":			[u"", "11"],
              "yml":		[u"", "9"],
              "zip":		[u"", "11"],
              }

# Formats colors. Makes printing a bit easier.
def colorfmt(c):
    return "\x1b[38;5;%sm" % c

def permissions_to_unix_name(st):
    is_dir = 'd' if stat.S_ISDIR(st.st_mode) else '-'
    dic = {'7': 'rwx', '6': 'rw-', '5': 'r-x', '4': 'r--', '0': '---'}
    perm = str(oct(st.st_mode)[-3:])
    return is_dir + ''.join(dic.get(x, x) for x in perm)

def get_user_name(file_stat):
    try:
        return getpwuid(file_stat.st_uid).pw_name
    except KeyError:
        return ""

def get_file_size(file_stat):
    size = file_stat.st_size
    if size <= 1024:
        return "%d B" % size
    size /= 1024

    if size <= 1024:
        return "%d KB" % size
    size /= 1024

    if size <= 1024:
        return "%d MB" % size
    size /= 1024

    return "%d GB" % size

if __name__ == '__main__':
    parser = OptionParser()
    parser.add_option(
        "-l",
        "-a",
        "--list",
        action="store_true",
        default=False,
     dest="is_list")
    parser.add_option("-d", "--dir", dest="dir", default='')
    (options, args) = parser.parse_args()

    files = glob.glob(options.dir + '.*') + glob.glob(options.dir + '*')
    formattedfiles = []

    for f in sorted(files, key=lambda v: v.upper(),):
        file_line = ''
        file_color = ''
        if path.isfile(f):
            (name, ext) = path.splitext(f)
            ext = ext.replace(".", "")
            if ext in EXTENSIONS:
                file_line = ("%s %s" % (EXTENSIONS[ext][0], f))
                file_color = colorfmt(EXTENSIONS[ext][1])
            if ext not in EXTENSIONS:
                file_line = ("%s %s" % (EXTENSIONS[u":FILE"][0], f))
                file_color = colorfmt(EXTENSIONS[u":FILE"][1])
        else:
            file_line = ("%s %s" % (EXTENSIONS[u":DIRECTORY"][0], f))
            file_color = colorfmt(EXTENSIONS[u":DIRECTORY"][1])
        if options.is_list:
            try:
                file_stat = os.stat(f)
                file_line = u"{:<15}{:<10}{:<10}{}".format(
                                    permissions_to_unix_name(file_stat),
                                    get_user_name(file_stat),
                                    get_file_size(file_stat), file_line)
            except OSError:
                file_line = f
        formattedfiles.append((file_line, file_color))
    fstr = ''
    for f in formattedfiles:
        fstr += f[0]+"\n"

    if not options.is_list:
        # Temporary file because I can't pipe the string to column yet -
        # limitation (hdd speed)
        tmpfile = open("lsfile", "w")
        try:
            # Python 3
            tmpfile.write(fstr)
        except UnicodeEncodeError:
            # Python 2
            tmpfile.write(str(fstr.encode('utf-8')))
        tmpfile.close()
        # Yes, I know I'm using shell=True. One reason why you SHOULD NOT give
        # this program full permissions.
        output = subprocess.check_output(
            "cat lsfile | column -c $(tput cols); rm -rf lsfile",
            shell=True).decode('utf-8')
    else:
        output = fstr

    for f in formattedfiles:
        output = output.replace(f[0], f[1]+f[0])

    print(output.strip('\n'))
