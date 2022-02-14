spn = 3
n = 32

up = set([1,17,3,19,6,22,9,25,17,8,24,11,27,14,30,1,25,16,32,3])
dn = up ^ set(list(range(1,n+1)))
print(sorted(up))
print(sorted(dn))
magmoms = ''
for i in range(1,n+1):
    if i in up:
        magmoms +=f' {spn}'
    else:
        magmoms +=f' -{spn}'
print(magmoms)
