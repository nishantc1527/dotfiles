#!/usr/bin/python3
import sys


def main():
    args = sys.argv
    args = args[2:]
    new_args = []
    i = 1

    while i < len(args):
        new_args.append(args[i])
        i += 3

    args = new_args

    for elem in args:
        print(elem)


if __name__ == "__main__":
    main()
