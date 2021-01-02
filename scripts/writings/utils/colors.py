#!/usr/bin/env python3

class bcolors:
    HEADER = '\033[95m'
    OKBLUE = '\033[94m'
    OKCYAN = '\033[96m'
    OKGREEN = '\033[92m'
    WARNING = '\033[93m'
    FAIL = '\033[91m'
    ENDC = '\033[0m'
    BOLD = '\033[1m'
    UNDERLINE = '\033[4m'

PRE_TEXT = "[SCRIPT]: "

def optional(fn):
    def optional_print(text, condition=True):
        if (condition):
            fn(text)
    return optional_print

def _print(text):
    print(text + bcolors.ENDC)

# Print Heading information
@optional
def printh(text):
    pre_text = bcolors.BOLD + bcolors.HEADER + PRE_TEXT + bcolors.OKBLUE
    _print(pre_text + '-------------------------')
    _print(pre_text + '[[ ' + text + ' ]]')
    _print(pre_text + '-------------------------')

# Print sub heading info
@optional
def printp(text):
    _print(bcolors.BOLD + bcolors.HEADER + PRE_TEXT + text)

# Print extraneous information
@optional
def printi(text):
    _print(PRE_TEXT + text)

# Print error
@optional
def printe(text):
    _print(bcolors.FAIL + PRE_TEXT + bcolors.WARNING + text)
