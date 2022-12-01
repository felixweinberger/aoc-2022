f = open("input.txt")

gnomes = []
curr = []
for l in f.readlines():
    if l.strip() != '':
        curr.append(int(l.strip()))
    else:
        gnomes.append(curr)
        curr = []
totals = map(lambda x: sum(x), gnomes)
totals.sort()
totals = totals[::-1]

# 70698
print("Part 1: ", totals[0])

# 206643
print("Part 2: ", sum(totals[0:3]))
