import sys
import os

def square(x):
    print int(x)**2

def add(*nums):
    print sum([int(num) for num in nums])

if __name__ == '__main__':
    if len(sys.argv) > 1:
        func = globals()[sys.argv[1]]
        sys.exit(func(*sys.argv[2:]) or 0)

    for name, item in globals().items():
        if callable(item):
            print "function %(func)s { python %(script)s %(func)s $@; };" % {
                'func': name,
                'script': os.path.abspath(__file__),
            }
