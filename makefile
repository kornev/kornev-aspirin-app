.PHONY: all clean compile
.SILENT:    clean compile

.DEFAULT: all

all: clean compile

compile:
	emacs -Q --batch --eval \
	'(progn \
	   (byte-recompile-directory user-emacs-directory 0) \
	   (delete-file (expand-file-name "init.elc" user-emacs-directory)))'

clean:
	find . ! -path './.packages/*' -name '*.elc' -delete

