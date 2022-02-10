# List of all the board related files.
set(BOARDSRC ${CONFDIR}/boards/default/board.c)

# Required include directories
set(BOARDINC ${CONFDIR}/boards/default)

# Shared variables
list(APPEND ALLCSRC ${BOARDSRC})
list(APPEND ALLINC ${BOARDINC})
