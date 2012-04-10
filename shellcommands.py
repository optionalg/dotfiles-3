import sys
import os
import string
import random
import thread
import time

# ADD FUNCTIONS HERE ----------------------------------------------------------

def makepassword(length=8):
    chars = list(string.letters + string.digits)
    print(''.join(random.choice(chars) for i in range(length)))

def square(x):
    print(int(x)**2)

def add(*nums):
    print(sum([int(num) for num in nums]))

def wrap(filename, width=79):
    "Usage: %prog [-w]"
    import textwrap
    fp = sys.stdin if filename == '-' else open(filename)
    print '\n'.join('\n'.join(textwrap.wrap(l, width)) for l in fp.readlines())

def rot13():
    import codecs
    for line in sys.stdin:
        sys.stdout.write(codecs.encode(line, 'rot13'))

def mksecretkey():
    import string
    import random
    chars = string.letters + string.digits + '!+*_&$)('
    print(''.join(random.sample(chars, 50)))

def webshare(open_in_browser=False, port=8000):
    if open_in_browser:
        import webbrowser
        def open_in_browser():
            webbrowser.open_new_tab('http://localhost:{0}'.format(port))
        _delay_background(open_in_browser, 0.5)

    # BaseHTTPServer looks at argv[1] for port
    sys.argv = [sys.argv[0], port]
    import SimpleHTTPServer
    try:
        SimpleHTTPServer.test()
    except KeyboardInterrupt:
        print '\nStopping...'

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

def _delay_background(func, delay):
    def delayed_func():
        time.sleep(delay)
        func()
    thread.start_new_thread(delayed_func, ())

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

    variables = globals().copy().items()
    for name, item in variables:
        if not name.startswith('_') and inspect.isfunction(item):
            print("function %(func)s { python %(script)s %(func)s $@; };" % {
                'func': name,
                'script': os.path.abspath(__file__),
            })
