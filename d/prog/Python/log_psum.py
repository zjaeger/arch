#!/usr/bin/python
#
# log_psum.py
#
# 2019-03-04 zj
# logs processes sum values into log-file (input parameter) or on stdout (one row per one call)
# Usage:
#   <this_script_name> [<output_log_filename>|-head|-out]

import re, os, sys
from time import gmtime, strftime


def get_sysdate():
    return strftime("%Y-%m-%d %H:%M:%S", gmtime())


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


def get_sum_for_ps( header_flg ):
    # indexes - according to ps_cmd!
    VSZ  = 0
    RSS  = 1
    NLWP = 2
    CMD  = 3
    # sum lists: [ VSZ, RSS, NLWP ]
    s_all = [ 0, 0, 0 ] # sum-all
    s_red = [ 0, 0, 0 ] # sum-redApp
    s_blu = [ 0, 0, 0 ] # sum-blueApp
    s_pyt = [ 0, 0, 0 ] # sum-python
    # header
    l_head = []
    # regexp
    re_space = re.compile(r'\s+')
    re_red   = re.compile(r'redApp')
    re_blu   = re.compile(r'blueApp')
    re_pyt   = re.compile(r'python')
    # os command
    ps_cmd = 'ps axo vsz,rss,nlwp,command'
    # pipe_in for os command
    file_in = os.popen(ps_cmd, 'r', 1)
    cnt = -1
    # sum compute
    for line in file_in:
        cnt += 1
        line = line.strip()
        V = re_space.split( line )
        if cnt == 0:
            # ps header test
            if     V[ VSZ ]  == 'VSZ'  \
               and V[ RSS ]  == 'RSS'  \
               and V[ NLWP ] == 'NLWP' \
               and V[ CMD ]  == 'COMMAND': continue
            else:
                print 'Error: unexpected ps header: '+ line
                break
        s_all[ VSZ ]  += int( V[ VSZ ] )
        s_all[ RSS ]  += int( V[ RSS ] )
        s_all[ NLWP ] += int( V[ NLWP ] )
        if re_red.match( V[ CMD ]):
            s_red[ VSZ ]  += int( V[ VSZ ] )
            s_red[ RSS ]  += int( V[ RSS ] )
            s_red[ NLWP ] += int( V[ NLWP ] )
        elif re_blu.match( V[ CMD ] ):
            s_blu[ VSZ ]  += int( V[ VSZ ] )
            s_blu[ RSS ]  += int( V[ RSS ] )
            s_blu[ NLWP ] += int( V[ NLWP ] )
        elif re_pyt.match( V[ CMD ] ):
            s_pyt[ VSZ ]  += int( V[ VSZ ] )
            s_pyt[ RSS ]  += int( V[ RSS ] )
            s_pyt[ NLWP ] += int( V[ NLWP ] )
    file_in.close()
    # Header
    if header_flg:
        for val1 in ('all','red','blu','pyt'):
            for val2 in ('vsz','rss','nlwp'):
                l_head.append( val1 + '_' + val2 )

    return cnt, s_all + s_red + s_blu + s_pyt, l_head


def get_input_params(argv):
    file_out = None
    re_dish = re.match(r'^-(\w+)',argv)
    if re_dish:
        # argv startrs with '-'
        x = re_dish.group(1).lower()
        if x == 'head':
            head_flg = True
        elif x == 'out':
            head_flg = False
        else:
            head_flg = False
            print 'Error: unexpected param.: '+ argv
    else:
        # argv is log-pathnmame (assumption) - exists test:
        if os.path.isfile(argv):
            head_flg = False
        else:
            head_flg = True # file does not exist => generate header
        try:
            file_out = open(argv,'a') # open log-file for append
        except:
            file_out = None
            print 'Error: invalid log filename.: '+ argv

    return head_flg, file_out
  

# --- BEGIN ---

if len(sys.argv) == 1:
    print 'Usage: '+ sys.argv[0] +' [<output_log_filename>|-head|-out]'
    print
else:
    # init
    ( head_flg, file_out ) = get_input_params( sys.argv[1] )
    if file_out:
        sys.stdout = file_out  # stdout redirected to log-file

    # get values
    sysd    = get_sysdate()
    memFree = get_MemFree()
    ( cnt, l_All, l_Head ) = get_sum_for_ps(head_flg)
    # print out
    if head_flg:
        print "%-20s %4s %8s" % ('sysdate','cnt','free'),
        for val in l_Head:
            print "%8s" % val,
        print

    print "%-20s %4s %8s" % ( sysd, cnt, memFree ),
    for val in l_All:
        print "%8d" % val,
    print

    # end
    if file_out:
        file_out.close()
        if head_flg:
            os.chmod( sys.argv[1], # pathname (for file_out != None)
                      0644)        # rw-r--r--

# --- END ---
