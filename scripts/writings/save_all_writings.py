#!/usr/bin/env python3

import os
import sys
import argparse
import datetime

import utils.colors as clr
import utils.files as fl

# --- CONSTANTS ---
ROOT_DIR = '../../../Desktop/writing'
DEST_DIR = '../../../Desktop/web-dev/projects/website/website_v6/src/writings'
SLUG_BASE = '/writing'

def make_slug_text(file_path):
    slug_delim = '---'

    slug_path = '\nslug: ' + '"' + SLUG_BASE + file_path.split(ROOT_DIR)[1].split('.')[0] + '"'
    date_created = '\ndate: ' + '"' + datetime.datetime.fromtimestamp(os.stat(file_path).st_mtime).strftime("%Y-%d-%m") + '"'

    return slug_delim + slug_path + date_created + '\n' + slug_delim + '\n'

def add_slug(over_ride=False):
    def open_slug(file_path):
        with open(file_path, 'r+') as f:
            first_line = f.readline()
            second_line = f.readline()
            # If there is already a slug, skip
            slug_exists = first_line.startswith('---') and second_line.startswith('slug')
            if (not over_ride and slug_exists):
                clr.printi('slug detected, skipping')
                return

            # Need to remove any existing slugs 
            if (slug_exists):
                first_line = ''
                second_line = ''
                f.readline() 
                f.readline()

            content = f.read()
            f.seek(0, 0)
            f.write(make_slug_text(file_path) + '\n' + first_line + second_line + content)
    return open_slug

def main(arguments):
    # Argument parsing
    parser = argparse.ArgumentParser(
        description=__doc__,
        formatter_class=argparse.RawDescriptionHelpFormatter)
    parser.add_argument('-s', '--show_skips', action="store_true", help="shows the files that are skipped when walking the directory tree")
    parser.add_argument('-o', '--over_ride', action="store_true", help="will force the slug to be overridden even if it already exists")
    args = parser.parse_args(arguments)

    # File tree for this directory
    file_types = ('.md')
    skip_files = ('template.md')
    fileTree = fl.FileTree(ROOT_DIR, file_types, skip_files, args.show_skips)

    clr.printh("Adding slugs")
    slug_fn = add_slug(args.over_ride)
    fileTree.walk_and_apply(slug_fn)

    clr.printh("Copying files to web directory")
    fileTree.copy_files(DEST_DIR)

    clr.printh("Done.")

 
if __name__ == '__main__':
    sys.exit(main(sys.argv[1:]))
