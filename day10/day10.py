#!/usr/bin/env python3

input = open("input.txt").read().splitlines()
pipes, start = dict(), None
for i, l in enumerate(input):
    for j, c in enumerate(l):
        if c == "S":
            start = (i, j)
        elif c != ".":
            pipes[i, j] = c


def dirs(c, i, j):
    match c:
        case "-":
            return (i, j - 1), (i, j + 1)
        case "|":
            return (i - 1, j), (i + 1, j)
        case "L":
            return (i - 1, j), (i, j + 1)
        case "J":
            return (i - 1, j), (i, j - 1)
        case "7":
            return (i + 1, j), (i, j - 1)
        case "F":
            return (i + 1, j), (i, j + 1)
        case _:
            assert 0


def connections(pt):
    return set(dirs(pipes[*pt], *pt))


end_one, end_two = [
    pt
    for di, dj in ((-1, 0), (0, 1), (0, -1), (1, 0))
    if (pt := (start[0] + di, start[1] + dj)) in pipes and start in connections(pt)
]

for c in "-LJ7F|":
    if set(dirs(c, *start)) == set([end_one, end_two]):
        pipes[start] = c

visited, steps = set([start, end_one, end_two]), 1

while end_one != end_two:
    end_one = (connections(end_one) - visited).pop()
    end_two = (connections(end_two) - visited).pop()
    visited |= set([end_one, end_two])
    steps += 1
print(steps)

contained = 0
for i in range(len(input)):
    inside = False
    for j in range(len(input[0])):
        if (i, j) in visited:
            if pipes[i, j] in "|LJ":
                inside = not inside
            continue
        if inside:
            contained += 1
print(contained)
