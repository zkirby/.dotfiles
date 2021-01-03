#!/usr/bin/env python3

import os
import shutil

import utils.colors as clr

class FileTree:
    def __init__(self, root_dir, file_types=None, file_skips=None, show_skip=False):
        '''
        Params:
        root_dir (String): The root directory of this file tree
        file_types (Tuple<String>) File types in this file tree, None if every file type
        file_skips (Tuple<String>) Files to be excluded from this file tree, None if no exclusions
        show_skip (Boolean) Show the skipped files or not
        '''
        self.root = root_dir
        self.file_types = file_types
        self.file_skips = file_skips
        self.show_skip = show_skip

    def walk_and_apply(self, fn):
        '''
        Apply some function every file in a directory
        
        Params:
        fn (function): Function to apply over all files
        '''
        for dirName, subdirList, fileList in os.walk(self.root):
            indent = len(dirName.split('/')) - len(self.root.split('/'))

            for fname in fileList:
                valid_file_type = not self.file_types or fname.lower().endswith(self.file_types)
                bad_file_name = self.file_skips and fname in self.file_skips
                full_file_path = dirName + '/' + fname

                if (valid_file_type and not bad_file_name):
                    clr.printp(' ' * indent + 'processing: ' + clr.bcolors.OKCYAN + full_file_path.split(self.root)[1])
                    try:
                        fn(full_file_path)
                    except Exception as exp:
                        clr.printe(str(exp))
                else:
                    clr.printi("skipping " + fname, self.show_skip)

    def copy_and_move_tree(self, dest_dir):
        '''
        Copy the directory tree to a new root and update the root.

        Params:
        dest_dir (string): The directory root to move to
        '''
        def copy_file(file_path):
            shutil.copyfile(file_path, dest_dir + '/' + os.path.basename(file_path))

        self.walk_and_apply(copy_file)
        self.root = dest_dir


