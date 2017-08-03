#---*- Makefile -*-------------------------------------------------------
#$Author$
#$Date$
#$Revision$
#$URL$
#------------------------------------------------------------------------

# Run tests in a test directory (tests/ by default) and report if
# all tests pass.

# USAGE:
#     make clean
#     make distclean
#     make tests
#     make

#------------------------------------------------------------------------------

# Include local configuration files from this directory:

MAKECONF_FILES = ${filter-out %~, ${wildcard Makeconf*}}

ifneq ("${MAKECONF_FILES}","")
include ${MAKECONF_FILES}
endif

#------------------------------------------------------------------------------

BIN_DIR  = .

TEST_DIR = tests/cases
OUTP_DIR = tests/outputs

INP_FILES  = ${wildcard ${TEST_DIR}/*.inp}
OPT_FILES  = ${wildcard ${TEST_DIR}/*.opt}
SH_FILES   = ${wildcard ${TEST_DIR}/*.sh}

INP_DIFFS = ${INP_FILES:${TEST_DIR}/%.inp=${OUTP_DIR}/%.diff}
INP_OUTS  = ${INP_FILES:${TEST_DIR}/%.inp=${OUTP_DIR}/%.out}

OPT_DIFFS = ${OPT_FILES:${TEST_DIR}/%.opt=${OUTP_DIR}/%.diff}
OPT_OUTS  = ${OPT_FILES:${TEST_DIR}/%.opt=${OUTP_DIR}/%.out}

SH_DIFFS = ${SH_FILES:${TEST_DIR}/%.sh=${OUTP_DIR}/%.diff}
SH_OUTS  = ${SH_FILES:${TEST_DIR}/%.sh=${OUTP_DIR}/%.out}

DIFF_FILES = $(sort ${INP_DIFFS} ${OPT_DIFFS} ${SH_DIFFS})
OUTP_FILES = $(sort ${INP_OUTS} ${OPT_OUTS} ${SH_OUTS})

.PHONY: all clean cleanAll distclean test tests out outputs display

all: tests

display:
	@echo ${SH_DIFFS}

#------------------------------------------------------------------------------

# Include Makefiles with additional rules for this directory:

MAKELOCAL_FILES = ${filter-out %~, ${wildcard Makelocal*}}

ifneq ("${MAKELOCAL_FILES}","")
include ${MAKELOCAL_FILES}
endif

#------------------------------------------------------------------------------

test tests: ${DIFF_FILES}

out outputs: ${OUTP_FILES}

#------------------------------------------------------------------------------

# Rules to run script-specific tests:

${OUTP_DIR}/%.diff: ${TEST_DIR}/%.inp ${TEST_DIR}/%.opt ${OUTP_DIR}/%.out
	-@printf "%-30s " "$<:" ; \
	if [ ! -e ${TEST_DIR}/$*.tst ] || ${TEST_DIR}/$*.tst; then \
		${BIN_DIR}/$(shell echo $* | sed -e 's/_[0-9]*$$//') \
		    $(shell grep -v '^#' ${word 2, $^}) \
	    	$< 2>&1 \
		| diff ${OUTP_DIR}/$*.out - > $@ ; \
		if [ $$? = 0 ]; then echo "OK"; else echo "FAILED:"; cat $@; fi; \
	fi

${OUTP_DIR}/%.diff: ${TEST_DIR}/%.inp ${OUTP_DIR}/%.out
	-@printf "%-30s " "$<:" ; \
	if [ ! -e ${TEST_DIR}/$*.tst ] || ${TEST_DIR}/$*.tst; then \
		${BIN_DIR}/$(shell echo $* | sed -e 's/_[0-9]*$$//') \
		    $< 2>&1 \
		| diff ${OUTP_DIR}/$*.out - > $@ ; \
		if [ $$? = 0 ]; then echo "OK"; else echo "FAILED:"; cat $@; fi; \
	fi

${OUTP_DIR}/%.diff: ${OUTP_DIR}/%.opt ${OUTP_DIR}/%.out
	-@printf "%-30s " "$<:" ; \
	if [ ! -e ${TEST_DIR}/$*.tst ] || ${TEST_DIR}/$*.tst; then \
		${BIN_DIR}/$(shell echo $* | sed -e 's/_[0-9]*$$//') \
		    $(shell grep -v '^#' $<) \
		2>&1 \
		| diff ${OUTP_DIR}/$*.out - > $@ ; \
		if [ $$? = 0 ]; then echo "OK"; else echo "FAILED:"; cat $@; fi; \
	fi

${OUTP_DIR}/%.diff: ${TEST_DIR}/%.sh ${OUTP_DIR}/%.out
	-@printf "%-30s " "$<:" ; \
	if [ ! -e ${TEST_DIR}/$*.tst ] || ${TEST_DIR}/$*.tst; then \
		$< 2>&1 | diff ${OUTP_DIR}/$*.out - > $@ ; \
		if [ $$? = 0 ]; then echo "OK"; else echo "FAILED:"; cat $@; fi; \
	fi

# Rules to generate sample test outputs:

${OUTP_DIR}/%.out: ${TEST_DIR}/%.inp ${TEST_DIR}/%.opt
	-@test -f $@ || echo "$@:"
	-@test -f $@ || \
	${BIN_DIR}/$(shell echo $* | sed -e 's/_[0-9]*$$//') \
	    $(shell grep -v '^#' ${word 2, $^}) \
	    $< \
	2>&1 \
	| tee $@
	-@touch $@

${OUTP_DIR}/%.out: ${TEST_DIR}/%.inp
	-@test -f $@ || echo "$@:"
	-@test -f $@ || \
	${BIN_DIR}/$(shell echo $* | sed -e 's/_[0-9]*$$//') \
	    $< \
	2>&1 \
	| tee $@
	-@touch $@

${OUTP_DIR}/%.out: ${TEST_DIR}/%.opt
	-@test -f $@ || echo "$@:"
	-@test -f $@ || \
	${BIN_DIR}/$(shell echo $* | sed -e 's/_[0-9]*$$//') \
	    $(shell grep -v '^#' $<) \
	    $< \
	2>&1 \
	| tee $@
	-@touch $@

${OUTP_DIR}/%.out: ${TEST_DIR}/%.inp
	-@test -f $@ || echo "$@:"
	-@test -f $@ || \
	${BIN_DIR}/$(shell echo $* | sed -e 's/_[0-9]*$$//') \
	    $< \
	2>&1 \
	| tee $@
	-@touch $@

${OUTP_DIR}/%.out: ${TEST_DIR}/%.sh
	-@test -f $@ || echo "$@:"
	-@test -f $@ || \
	$< 2>&1 | tee $@
	-@touch $@

#------------------------------------------------------------------------------

.PHONY: failed listdiff

failed listdiff: ## test
	@-find ${OUTP_DIR} -type f -size +0 | sort -u

#------------------------------------------------------------------------------

clean:
	rm -f ${DIFF_FILES}

distclean cleanAll: clean
