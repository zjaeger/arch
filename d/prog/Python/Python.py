# Python.py

>>> import time
>>> dir(time.gmtime)
['__call__', '__class__', '__cmp__', '__delattr__', '__doc__', '__eq__', '__format__', '__ge__', '__getattribut__', '__gt__', '__hash__', '__init__', '__le__', '__lt__', '__module__', '__name__', '__ne__', '__new__', '__reuce__', '__reduce_ex__', '__repr__', '__self__', '__setattr__', '__sizeof__', '__str__', '__subclasshook__']
>>> print time.gmtime.__doc__
# gmtime([seconds]) -> (tm_year, tm_mon, tm_mday, tm_hour, tm_min,
#                        tm_sec, tm_wday, tm_yday, tm_isdst)
# 
# Convert seconds since the Epoch to a time tuple expressing UTC (a.k.a.
# GMT).  When 'seconds' is not passed in, convert the current time instead.
>>> help(time.gmtime)
# gmtime(...)
#     gmtime([seconds]) -> (tm_year, tm_mon, tm_mday, tm_hour, tm_min,
#                            tm_sec, tm_wday, tm_yday, tm_isdst)
# 
#     Convert seconds since the Epoch to a time tuple expressing UTC (a.k.a.
#     GMT).  When 'seconds' is not passed in, convert the current time instead.
# 
>>> t='ALFA'
>>> type(t)
# <type 'str'>

# --- factory functions -------------------------------------------------------
int(4.0)           # creates integer 4
str(4)             # creates string '4'
list(1, 2, 3, 4)   # creates list [1,2,3,4]
tuple(1, 2, 3, 4)  # creates tuple (1,2,3,4)
dict(one=1, two=2) # creates dictionary {'one':1,'two':2}

# --- variable types ----------------------------------------------------------
12, 3.14159, 999L, 3+4j         # Numbers
'spam', "guido's"               # Strings (immutable)
[ 1, [ 2, 'three'], 4, 5 ]      # Lists
{'food':'spam', 'taste':'yum'}  # Dictionaries
( 1, 'spam', 4, 'U' )           # Tuples  (immutable)
text = open('eggs','r').read()  # Files

# --- numbers -----------------------------------------------------------------
2 + 3    # Integer 5 
2.0 + 3  # Real 5.0 (if one or more operands
15 % 4   # modulus
4 ** 3   # exp.

int(1.234)          # Integer 1
long(1.234)         # Long 1L
int(float('2.345')) # Integer 2

bool(23)            # true
bool(0)             # false
bool('any text')    # true
bool('')            # false
bool([])            # false

import random
random.randint(a,b) # Generates a random integer between a and b inclusive. 
random.random()     # Generates a random real number between 0.0 and 1.0

import math
pi = math.pi
tt = abs(-42), 2**4, pow(2, 4)

myjob = 'hacker'
for c in myjob: print(c)

# --- sequences: strings, lists, tuples ---------------------------------------
#  0    1    2 ... n-2 n-1 # numbered from the start
# -n -n+1 -n+2 ...  -2  -1 # numbered from the end

S = 'spam'
S[0], S[-2]
# ('s', 'a')

# membership
'a'   in 'track'             # True 
9     in [1,2,3,4,5,6]       # False 
'x'   not in 'next'          # False 
'red' not in ['tan','pink']  # True

# membership (searching)
'a'    in 'the task'         # True 
'w'    in 'the task'         # False 
'as'   in 'the task'         # True 
'job'  not in 'the task'     # True 
'task' in 'the task'         # True

# concatenation
sequence1 + sequence2 # results in a new sequence that appends sequence2 to sequence1 
'mr'+'joe'+'soap'     # 'mrjoesoap'

# Sequence Elements and Slices
# [startindex:endindex]
# slice will consist of elements starting as the startindex up to but not including endindex.

mylist=['a','b','c','d','e'] # a list with five elements 
mylist[0]    # 'a' 
mylist[3]    # 'd' 
mylist[5]    # results in an error 
mylist[-1]   # 'e'
mylist[1:3]  # ['b','c'] 
mylist[:4]   # ['a','b','c'] 
mylist[3:]   # ['d','e']

xx='ABCDEFGHI'
xx[1:]       # 'BCDEFGHI'
xx[:2]       # 'AB'
xx[:4]       # 'ABCD'
xx[3:]       # 'DEFGHI'

mylist=[4,5,6,7,1,2,3] 
len(mylist)  # the length of seq = 7 
max(mylist)  # maximum value inseq = 7 
min(mylist)  # 1 – the minimum

# --- strings -----------------------------------------------------------------
#  \0 Null character
#  \t Horizontal tab
#  \n Newline character
#  \' Single quote
#  \" Double quote
#  \\ Backslash
>>> multiline='Line 1\nLine 2\nLine 3'
>>> print(multiline)
#  Line 1
#  Line 2
#  Line 3

>>> text = ' This is a text  '
text.find('is')      # 3
text.find('word')    # -1

>>> nums='123456'
  ''.join((text,nums)) # ' This is a text  123456'
'**'.join((text,nums)) # ' This is a text  **123456'

'Alfa'.isalpha()   # True
'Alfa0'.isalpha()  # False
'123'.isdigit()    # True

'Alfa'.upper()         # 'ALFA'
'Alfa'.lower()         # 'alfa'
'ALFA BETA'.split(' ') # ['ALFA', 'BETA']

'It is'.replace('is','was')  # 'It was

'  Alfa '.strip()  # 'Alfa'
'  Alfa '.rstrip() # '  Alfa'
'  Alfa '.lstrip() # 'Alfa '

"%-10s %04d" % ('alfa', 22)
# 'alfa       0022'

print "%-20s %4s %8s" % ('sysdate','cnt','free'), # ends with ',' => no newline

# --- lists -------------------------------------------------------------------

mylist = []            # an empty list 
mylist.append('Tom')   # ['Tom'] 
mylist.append('Dick')  # ['Tom','Dick'] 
mylist.append('Harry') # ['Tom','Dick','Harry'] 
mylist[1]='Bill'       # ['Tom','Bill','Harry'] 
del mylist[1]          # ['Tom','Harry']

# -----------------------------------------------------------------------------
import string

S = 'spammify'
S_new = string.upper(S)

row='alfa, beta, gama'
row.split(',')
# ['alfa', ' beta', ' gama']

# -----------------------------------------------------------------------------
import sys

argc = len(sys.argv)
print 'argc = ' + argc
n = 0
for arg in sys.argv:
    print('  arg %d is %s' % (n, arg)
    n += 1


line = fi.readline()
while line:
    print(line)
    line = fi.readline()

# -----------------------------------------------------------------------------
import re, os, sys
from time import gmtime, strftime


def get_sysdate():
    return strftime("%Y-%m-%d %H:%M:%S", gmtime())


# reads /proc/meminfo : MemFree
def get_MemFree():
    memFree = -1
    re_MemFree = re.compile(r'^MemFree:\s+(\d+)')
    file_in = open('/proc/meminfo', 'r')
    for line in file_in:
        result = re_MemFree.match(line)
        if result:
            memFree = result.group(1)
            break
    file_in.close()
    return memFree

# line - split
re_space = re.compile(r'\s+')
cnt = 0
for line in file_in:
    cnt += 1
    line = line.strip()
    V = re_space.split( line )

# os command
ps_cmd = 'ps axo vsz,rss,nlwp,command'
# pipe_in for os command
file_in = os.popen(ps_cmd, 'r', 1)

# os
os.path.isfile(argv)
os.chmod( sys.argv[1], # pathname
          0644)        # rw-r--r--
