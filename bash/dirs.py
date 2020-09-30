#!/usr/bin/python3

import os


def main():
    queue = ['.']

    while queue:
        dir = queue.pop(0)
        print(dir)

        dirs = next(os.walk(dir))[1]

        for elem in dirs:
            queue.append(dir + "/" + elem)


if __name__ == "__main__":
    main()
