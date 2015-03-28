#! /usr/bin/env python

import os
import re
import sys
import argparse
import subprocess as sp
from datetime import datetime

main_name = 'thesis'

main_tex = main_name + '.tex'
main_pdf = main_name + '.pdf'
main_log = main_name + '.log'

def get_mtime(fname):
    return os.path.getmtime(fname)

def get_dependence(fname):
    dependence = []
    for line in open(fname):
        line = line.replace('\n', '')
        try:
            dep = re.match(r'\\input{(.*)}', line).groups()[0]
            if dep is not None:
                dependence.append(dep)
        except:
            pass

    return dependence

# Colorize LaTeX output.
C_WARNING = '\033[93m'
C_ERROR   = '\033[1;31m'
C_INFO    = '\033[1;34m'
C_RESET   = '\033[0m'

def colorize_latex_output():

    log = open(main_log).read().split('\n')

    p = re.compile('.*Output written on \([^(]*\)(\([^)]\{1,\}\)).*')

    line_error = re.compile('^l\.\d*')

    for line in log:

        if 'Output written on' in line:
            print(C_INFO + line + C_RESET)

        if 'LaTeX Error:' in line:
            print(C_ERROR + line + C_RESET + '\n')

        if 'Underfull' in line:
            print(C_WARNING + line + C_RESET + '\n')

        if 'Overfull' in line:
            print(C_WARNING + line + C_RESET + '\n')

        if 'Warning:' in line:
            print(C_WARNING + line + C_RESET + '\n')

        if 'Undefined control sequence' in line:
            print(C_ERROR + line + C_RESET + '\n')

        if line_error.findall(line):
            print(C_ERROR + line + C_RESET +'\n')


def compile_tex():

    pdflatex_cmd = 'pdflatex -interaction=batchmode -file-line-error %s > /dev/null' % main_tex

    os.system(pdflatex_cmd)

    colorize_latex_output()


def clean_all():

    to_rm = [
        main_name+'.toc',
        main_name+'.aux',
        main_name+'.out',
        main_name+'.log',
        main_name+'.snm',
        main_name+'.vrb',
        main_name+'.nav',
        main_name+'.dvi',
        main_name+'.ps',
        main_name+'.pdf',
        ]

    for f in to_rm:
        os.system('rm -f %s' % f)

def main():

    parser = argparse.ArgumentParser()

    parser.add_argument('-f', dest='force', action='store_true', help='Force compilation')

    args = parser.parse_args()

    if args.force:
        clean_all()

    need_compile = False
    if not os.path.isfile(main_pdf):
        need_compile = True
    else:
        main_pdf_time = datetime.fromtimestamp(get_mtime(main_pdf))
        main_tex_time = datetime.fromtimestamp(get_mtime(main_tex))

        diff = (main_tex_time-main_pdf_time).total_seconds()
        if diff > 0:
            need_compile = True
        else:
            for dep in get_dependence(main_tex):

                dep_time = datetime.fromtimestamp(get_mtime(dep))
                if (main_pdf_time - dep_time).total_seconds() < 0:
                    need_compile = True
                    break

    if need_compile:
        compile_tex()
    else:
        print('nothing to be done')

if __name__ == '__main__':
    main()
