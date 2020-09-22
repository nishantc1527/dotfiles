#!/usr/bin/python3

"""
Trims whitespace from files
"""

import sys


def trim(file_name):
    """
    Trims a file
    """
    try:
        file = open(file_name, 'r')
    except FileNotFoundError:
        print('file ' + file_name + ' does not exist')
        return

    lines = file.readlines()
    file_writer = open(file_name, 'w')

    for line in lines:
        next_line = line.rstrip() + '\n'
        file_writer.write(next_line)


def main():
    """
    main method
    """
    if len(sys.argv) == 0:
        print('no input files given')
        return

    for file_name in sys.argv:
        trim(file_name)


if __name__ == "__main__":
    main()
