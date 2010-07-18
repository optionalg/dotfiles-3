import sys
import os

# ADD FUNCTIONS HERE ----------------------------------------------------------

def square(x):
    print int(x)**2

def add(*nums):
    print sum([int(num) for num in nums])

def wrap(file, width=79):
    "Usage: %prog [-w]"
    import textwrap
    print '\n'.join(textwrap.wrap(open(file).read(), width))

def rot13():
    import codecs
    for line in sys.stdin:
        sys.stdout.write(codecs.encode(line, 'rot13'))

# DO NOT MODIFY AFTER HERE ----------------------------------------------------

import inspect
import string
from optparse import OptionParser

def _func_to_option_parser(func):
    args, varargs, kwargs, defaults = inspect.getargspec(func)
    defaults = defaults or ()
    options = dict(zip(args[-len(defaults):], defaults))
    required_args = args[:]
    if defaults:
        required_args = args[:-len(defaults)]

    parser = OptionParser(usage=func.__doc__)
    parser.prog = func.__name__
    short_names = set(['h'])
    for arg_name, default in options.items():
        lower, upper = list(arg_name), list(arg_name.upper())
        short_chars = reduce(lambda a, b: a + list(b), zip(lower, upper), [])
        short_chars = [c for c in short_chars if c not in short_names]
        if short_chars:
            short_name = short_chars[0]
        else:
            sort_name = arg_name[0]
        short_names.add(short_name)

        arg_type = 'string'
        if type(default) == int:
            arg_type = 'int'
        elif type(default) == float:
            arg_type = 'float'

        if default in (True, False, bool):
            action = 'store_true'
            arg_type = None
        else:
            action = 'store'
        short_name = '-' + short_name
        long_name = '--' + arg_name.replace('_', '-')
        parser.add_option(short_name, long_name, action=action, dest=arg_name,
                          default=default, type=arg_type)
    return parser, required_args

if __name__ == '__main__':
    if len(sys.argv) > 1:
        func = globals()[sys.argv[1]]
        parser, required_args = _func_to_option_parser(func)
        options, args = parser.parse_args(sys.argv[2:])
        if len(required_args) != len(args):
            parser.error('Need %d arguments, got %d' % (
                len(required_args), len(args)
            ))
        options = options.__dict__
        sys.exit(func(*args, **options) or 0)

    for name, item in globals().items():
        if not name.startswith('_') and inspect.isfunction(item):
            print "function %(func)s { python %(script)s %(func)s $@; };" % {
                'func': name,
                'script': os.path.abspath(__file__),
            }
