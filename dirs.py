#!/usr/bin/python3

import os


def main():
    queue = ['.']

    while queue:
        dir = queue.pop(0)
        print(dir)

        try:
            dirs = next(os.walk(dir))[1]
        except StopIteration:
            pass

        for elem in dirs:
            queue.append(dir + "/" + elem)


if __name__ == "__main__":
    main()
