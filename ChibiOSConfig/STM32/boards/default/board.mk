# List of all the board related files.
BOARDSRC = $(CONFDIR)/boards/default/board.c

# Required include directories
BOARDINC = $(CONFDIR)/boards/default

# Shared variables
ALLCSRC += $(BOARDSRC)
ALLINC  += $(BOARDINC)
