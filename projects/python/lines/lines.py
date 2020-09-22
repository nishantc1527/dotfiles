#!/usr/bin/python3

import sys


def main():
    if len(sys.argv) != 2:
        return

    try:
        file = open(sys.argv[1], "r")
        print(file.read())
    except FileNotFoundError:
        return


if __name__ == "__main__":
    main()
