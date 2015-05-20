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
C_ERROR   = '\033[0;31m'
C_INFO    = '\033[0;32m'
C_RESET   = '\033[0m'

def colorize_latex_output():

    try:
        log = open(main_log).read().split('\n')
    except UnicodeDecodeError as e:
        try:
            for i, line in enumerate(log):
                pass
        except UnicodeDecodeError:
            print(i, line)
            print(C_ERROR + 'Weird character in the last line!' + C_RESET)
            return

    line_error = re.compile('^\./%s\:(\d*)\: (.*)' % main_tex)

    for i, line in enumerate(log):

        if 'Output written on' in line:
            print(C_INFO + line + C_RESET)
        elif 'No pages of output' in line:
            print(C_INFO + line + C_RESET)

        if 'LaTeX Error:' in line:
            print(C_ERROR + line + C_RESET)

        if 'Underfull' in line:
            print(C_WARNING + line + C_RESET)

        if 'Overfull' in line:
            print(C_WARNING + line + C_RESET)

        if 'Warning:' in line:
            print(C_WARNING + line + C_RESET)

        le = line_error.match(line)
        if le:
            print(C_ERROR + 'Error: %s (line %s)' % (le.groups()[1], le.groups()[0]) + C_RESET)


def compile_tex():

    pdflatex_cmd = 'pdflatex -interaction=batchmode -file-line-error %s > /dev/null' % main_tex

    os.system(pdflatex_cmd)
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
        try:
            os.unlink(f)
        except FileNotFoundError:
            pass

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
        print(C_INFO + 'nothing to be done' + C_RESET)

if __name__ == '__main__':
    main()
