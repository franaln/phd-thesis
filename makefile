# thesis makefile

MAIN := thesis

all: $(MAIN).pdf

$(MAIN).pdf: $(MAIN).tex $(MAIN).cls
	$(call run-latex,$(MAIN))

clean:
	rm -f $(MAIN).toc $(MAIN).aux $(MAIN).out $(MAIN).log $(MAIN).snm $(MAIN).vrb $(MAIN).nav $(MAIN).dvi $(MAIN).ps $(MAIN).pdf



# utils
run-latex = @pdflatex -interaction=batchmode -file-line-error $1.tex > /dev/null ; \
	fatal=`$(call colorize-latex-errors,$1.log)`; \
	if [ x"$$fatal" != x"" ]; then \
		echo "$$fatal"; \
		exit 1; \
	fi; \
	$(call latex-color-log,$1.log)

run-bibtex	= bibtex $1 | $(color_bib);


# colors
REAL_TPUT	:= $(if $(NO_COLOR),,$(shell which tput))
get-term-code = $(if $(REAL_TPUT),$(shell $(REAL_TPUT) $1),)

black	:= $(call get-term-code,setaf 0)
red		:= $(call get-term-code,setaf 1)
green	:= $(call get-term-code,setaf 2)
yellow	:= $(call get-term-code,setaf 3)
blue	:= $(call get-term-code,setaf 4)
magenta	:= $(call get-term-code,setaf 5)
cyan	:= $(call get-term-code,setaf 6)
bold	:= $(call get-term-code,bold)
reset	:= $(call get-term-code,sgr0)

C_WARNING	:= $(magenta)
C_ERROR		:= $(red)
C_INFO		:= $(green)
C_UNDERFULL	:= $(magenta)
C_OVERFULL	:= $(red) $(bold)
C_PAGES		:= $(bold)
C_BUILD		:= $(cyan)
C_GRAPHIC	:= $(yellow)
C_DEP		:= $(green)
C_SUCCESS	:= $(green) $(bold)
C_FAILURE	:= $(red) $(bold)
C_RESET		:= $(reset)

# Colorize LaTeX output.
color_tex := \
sed \
-e '$${' \
-e '  /^$$/!{' \
-e '    H' \
-e '    s/.*//' \
-e '  }' \
-e '}' \
-e '/^$$/!{' \
-e '  H' \
-e '  d' \
-e '}' \
-e '/^$$/{' \
-e '  x' \
-e '  s/^\n//' \
-e '  /Output written on /{' \
-e '    s/.*Output written on \([^(]*\) (\([^)]\{1,\}\)).*/Success!  Wrote \2 to \1/' \
-e '    s/[[:digit:]]\{1,\}/$(C_PAGES)&$(C_RESET)/g' \
-e '    s/Success!/$(C_SUCCESS)&$(C_RESET)/g' \
-e '    s/to \(.*\)$$/to $(C_SUCCESS)\1$(C_RESET)/' \
-e '    b end' \
-e '  }' \
-e '  / *LaTeX Error:.*/{' \
-e '    s/.*\( *LaTeX Error:.*\)/\1/' \
-e '    b error' \
-e '  }' \
-e '  /^[^[:cntrl:]:]*:[[:digit:]]\{1,\}:/b error' \
-e '  /.*Warning:.*/{' \
-e '    s//$(C_WARNING)&$(C_RESET)/' \
-e '    b end' \
-e '  }' \
-e '  /Underfull.*/{' \
-e '    s/.*\(Underfull.*\)/$(C_UNDERFULL)\1$(C_RESET)/' \
-e '    b end' \
-e '  }' \
-e '  /Overfull.*/{' \
-e '    s/.*\(Overfull.*\)/$(C_OVERFULL)\1$(C_RESET)/' \
-e '    b end' \
-e '  }' \
-e '  d' \
-e '  :error' \
-e '  s/.*/$(C_ERROR)&$(C_RESET)/' \
-e '  b end' \
-e '  :end' \
-e '  G' \
-e '}'

latex-color-log	= $(color_tex) $1

# Colorize BibTeX output.
color_bib := \
$(SED) \
-e 's/^Warning--.*/$(C_WARNING)&$(C_RESET)/' \
-e 't' \
-e '/---/,/^.[^:]/{' \
-e '  H' \
-e '  /^.[^:]/{' \
-e '    x' \
-e '    s/\n\(.*\)/$(C_ERROR)\1$(C_RESET)/' \
-e '    p' \
-e '    s/.*//' \
-e '    h' \
-e '    d' \
-e '  }' \
-e '  d' \
-e '}' \
-e '/(.*error.*)/s//$(C_ERROR)&$(C_RESET)/' \
-e 'd'

define colorize-latex-errors
sed \
-e '$${' \
-e '  /^$$/!{' \
-e '    H' \
-e '    s/.*//' \
-e '  }' \
-e '}' \
-e '/^$$/!{' \
-e '  H' \
-e '  d' \
-e '}' \
-e '/^$$/{' \
-e '  x' \
-e '  s/^\(\n\)\(.*\)/\2\1/' \
-e '}' \
-e '/^::P\(P\{1,\}\)::/{' \
-e '  s//::\1::/' \
-e '  G' \
-e '  h' \
-e '  d' \
-e '}' \
-e '/^::P::/{' \
-e '  s//::0::/' \
-e '  G' \
-e '}' \
-e 'b start' \
-e ':needonemore' \
-e 's/^/::P::/' \
-e 'G' \
-e 'h' \
-e 'd' \
-e ':needtwomore' \
-e 's/^/::PP::/' \
-e 'G' \
-e 'h' \
-e 'd' \
-e ':needthreemore' \
-e 's/^/::PPP::/' \
-e 'G' \
-e 'h' \
-e 'd' \
-e ':start' \
-e '/^! LaTeX Error: File /{' \
-e '  s/\n//g' \
-e '  b needtwomore' \
-e '}' \
-e 's/^[^[:cntrl:]:]*:[[:digit:]]\{1,\}:/!!! &/' \
-e 's/^\(.*\n\)\([^[:cntrl:]:]*:[[:digit:]]\{1,\}: .*\)/\1!!! \2/' \
-e '/^!!! .*[[:space:][:cntrl:]]LaTeX[[:space:][:cntrl:]]Error:[[:space:][:cntrl:]]*File /{' \
-e '  s/\n//g' \
-e '  b needonemore' \
-e '}' \
-e '/^::0::! LaTeX Error: File .*/{' \
-e '  /\n\n$$/{' \
-e '    s/^::0:://' \
-e '    b needonemore' \
-e '  }' \
-e '  s/^::0::! //' \
-e '  s/^\(.*not found.\).*Enter file name:.*\n\(.*[[:digit:]]\{1,\}\): Emergency stop.*/\2: \1/' \
-e '  b error' \
-e '}' \
-e '/^::0::!!! .*LaTeX Error: File .*/{' \
-e '  /\n\n$$/{' \
-e '    s/^::0:://' \
-e '    b needonemore' \
-e '  }' \
-e '  s/::0::!!! //' \
-e '  /File .*\.e\{0,1\}ps'"'"' not found/b skip' \
-e '  /could not locate.*any of these extensions:/{' \
-e '    b skip' \
-e '  }' \
-e '  s/\(not found\.\).*/\1/' \
-e '  s/^/!!! /' \
-e '  b error' \
-e '}' \
-e '/^\(.* LaTeX Error: Missing .begin.document.\.\).*/{' \
-e '  s//\1 --- Are you trying to build an include file?/' \
-e '  b error' \
-e '}' \
-e '/.*\(!!! .*Undefined control sequence\)[^[:cntrl:]]*\(.*\)/{' \
-e '  s//\1: \2/' \
-e '  s/\nl\.[[:digit:]][^[:cntrl:]]*\(\\[^\\[:cntrl:]]*\).*/\1/' \
-e '  b error' \
-e '}' \
-e '/^\(!pdfTeX error:.*\)s*/{' \
-e '  b error' \
-e '}' \
-e '/.*\(!!! .*\)/{' \
-e '  s//\1/' \
-e '  s/[[:cntrl:]]//' \
-e '  s/[[:cntrl:]]$$//' \
-e '  /Cannot determine size of graphic .*(no BoundingBox)/b skip' \
-e '  b error' \
-e '}' \
-e ':skip' \
-e 'd' \
-e ':error' \
-e 's/^!\(!! \)\{0,1\}\(.*\)/$(C_ERROR)\2$(C_RESET)/' \
-e 'p' \
-e 'd' \
'$1' | sed -e 's/\\\\/\\\\\\\\/g'
endef
