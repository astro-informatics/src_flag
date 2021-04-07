# ======== COMPILER ========


CC	= gcc

#OPT	= -Wall -O3 -fopenmp -DFLAG_VERSION=\"0.1\" -DFLAG_BUILD=\"`git rev-parse HEAD`\"
OPT	= -Wall -g -fopenmp -DFLAG_VERSION=\"0.0.1\" -DFLAG_BUILD=\"`git rev-parse HEAD`\"


# ======== LINKS ========

UNAME := $(shell uname)
PROGDIR = ..

MLAB		= ${MATLAB}
MLABINC	= ${MLAB}/extern/include
MLABLIB	= ${MLAB}/extern/lib
# -------------------- 
ifeq ($(UNAME), Linux)
  MEXEXT	= mexa64
endif
ifeq ($(UNAME), Darwin)
  MEXEXT	= mexmaci64
endif
# -------------------- 
MEX 		= ${MLAB}/bin/mex
MEXFLAGS	= -cxx

FLAGDIR   = $(PROGDIR)/flag
FLAGLIB   = $(FLAGDIR)/lib/c
FLAGLIBNM = flag
FLAGSRC   = $(FLAGDIR)/src/c
FLAGBIN   = $(FLAGDIR)/bin/c
FLAGOBJ   = $(FLAGSRC)
FLAGINC   = $(FLAGDIR)/include/c
FLAGDOC   = $(FLAGDIR)/docs/c

SSHTDIR  = $(PROGDIR)/ssht
SSHTLIB  = $(SSHTDIR)/lib/c
SSHTLIBNM= ssht
SSHTBIN  = $(SSHTDIR)/bin/c
SSHTINC  = $(SSHTDIR)/include/c

FFTWDIR      = $(FFTW)
FFTWINC	     = $(FFTWDIR)/include
FFTWLIB      = $(FFTWDIR)/lib
FFTWLIBNM    = fftw3
#FFTWOMPLIBNM = fftw3_threads

SSHTSRCMAT	= $(SSHTDIR)/src/matlab
SSHTOBJMAT  	= $(SSHTSRCMAT)
SSHTOBJMEX  	= $(SSHTSRCMAT)

FLAGSRCMAT	= $(FLAGDIR)/src/matlab
FLAGOBJMAT	= $(FLAGSRCMAT)
FLAGOBJMEX	= $(FLAGSRCMAT)

GSLDIR	= ${GSL}
GSLLIB	= $(GSLDIR)/include
GSLINC	= $(GSLDIR)/lib
GSLLIBN = gsl


# ======== SOURCE LOCATIONS ========

vpath %.c $(FLAGSRC)
vpath %.h $(FLAGSRC)
vpath %_mex.c $(FLAGSRCMAT)


# ======== FFFLAGS ========

FFLAGS  = -I$(FFTWINC) -I$(SSHTINC) -I$(FLAGINC)
ifeq ($(UNAME), Linux)
  # Add -fPIC flag (required for mex build).
  # (Note that fftw must also be built with -fPIC.)
  FFLAGS += -fPIC
endif


# ======== LDFLAGS ========

LDFLAGS = -L$(FLAGLIB) -l$(FLAGLIBNM) -L$(SSHTLIB) -l$(SSHTLIBNM) -L$(FFTWLIB) -l$(FFTWLIBNM) -lm

LDFLAGSMEX = -L$(FLAGLIB) -l$(FLAGLIBNM) -L$(SSHTLIB) -l$(SSHTLIBNM) -L$(FFTWLIB) -l$(FFTWLIBNM)


#LDFLAGS = -L$(FLAGLIB) -l$(FLAGLIBNM) -L$(SSHTLIB) -l$(SSHTLIBNM) -L$(FFTWLIB) -l$(FFTWOMPLIBNM) -l$(FFTWLIBNM) -lm

#LDFLAGSMEX = -L$(FLAGLIB) -l$(FLAGLIBNM) -L$(SSHTLIB) -l$(SSHTLIBNM) -L$(FFTWLIB) -l$(FFTWOMPLIBNM) -l$(FFTWLIBNM)


# ======== OBJECT FILES TO MAKE ========

FLAGOBJS = $(FLAGOBJ)/flag_sampling.o      \
           $(FLAGOBJ)/flag_core.o          \
           $(FLAGOBJ)/flag_spherlaguerre.o 
           # $(FLAGOBJ)/flag_spherbessel.o 

FLAGHEADERS = flag_types.h           \
			  flag_sampling.h        \
              flag_core.h 	         \
              flag_spherlaguerre.h   
              # flag_spherbessel.h     

ifneq (,$(wildcard $(GSLINC)/gsl/gsl_sf.h))
	FLAGOBJS+= $(FLAGOBJ)/flag_spherbessel.o
	FFLAGS+= -I$(GSLINC)
	LDFLAGS+= -L$(GSLLIB)
	LDFLAGS+= -l$(GSLLIBN)
	LDFLAGSMEX+= -L$(GSLLIB)
	LDFLAGSMEX+= -l$(GSLLIBN)
endif   

FLAGOBJSMAT = $(FLAGOBJMAT)/flag_sampling_mex.o \
              $(FLAGOBJMAT)/flag_sbessel_basis_mex.o \
              $(FLAGOBJMAT)/flag_synthesis_mex.o \
              $(FLAGOBJMAT)/flag_analysis_mex.o  \
              $(FLAGOBJMAT)/flag_get_tau_mex.o  


FLAGOBJSMEX = $(FLAGOBJMEX)/flag_sampling_mex.$(MEXEXT) \
              $(FLAGOBJMEX)/flag_sbessel_basis_mex.$(MEXEXT) \
              $(FLAGOBJMEX)/flag_synthesis_mex.$(MEXEXT) \
              $(FLAGOBJMEX)/flag_analysis_mex.$(MEXEXT)  \
              $(FLAGOBJMEX)/flag_get_tau_mex.$(MEXEXT)  


# ======== MAKE RULES ========

$(FLAGOBJ)/%.o: %.c $(FLAGHEADERS)
	$(CC) $(OPT) $(FFLAGS) -c $< -o $@

# .PHONY: default
# default: lib unittest test about

# .PHONY: unittest
# unittest: $(FLAGBIN)/unittest/flag_unittest
# $(FLAGBIN)/unittest/flag_unittest: $(FLAGOBJ)/unittest/flag_unittest.o $(FLAGLIB)/lib$(FLAGLIBNM).a
# 	$(CC) $(OPT) $< -o $(FLAGBIN)/unittest/flag_unittest $(LDFLAGS)

# .PHONY: rununittest
# rununittest: unittest
# 	$(FLAGBIN)/unittest/flag_unittest

# .PHONY: test
# test: $(FLAGBIN)/flag_test about
# $(FLAGBIN)/flag_test: $(FLAGOBJ)/flag_test.o $(FLAGLIB)/lib$(FLAGLIBNM).a
# 	$(CC) $(OPT) $< -o $(FLAGBIN)/flag_test $(LDFLAGS)

# .PHONY: test_csv
# test_csv: $(FLAGBIN)/flag_test_csv about
# $(FLAGBIN)/flag_test_csv: $(FLAGOBJ)/flag_test_csv.o $(FLAGLIB)/lib$(FLAGLIBNM).a
# 	$(CC) $(OPT) $< -o $(FLAGBIN)/flag_test_csv $(LDFLAGS)

# .PHONY: about
# about: $(FLAGBIN)/flag_about
# $(FLAGBIN)/flag_about: $(FLAGOBJ)/flag_about.o
# 	$(CC) $(OPT) $< -o $(FLAGBIN)/flag_about

# .PHONY: runtest
# runtest: test
# 	$(FLAGBIN)/flag_test

# .PHONY: all
# all: lib unittest test test_csv about matlab


# Library

.PHONY: lib
lib: $(FLAGLIB)/lib$(FLAGLIBNM).a
$(FLAGLIB)/lib$(FLAGLIBNM).a: $(FLAGOBJS)
	ar -r $(FLAGLIB)/lib$(FLAGLIBNM).a $(FLAGOBJS)


# Matlab

$(FLAGOBJMAT)/%_mex.o: %_mex.c $(FLAGLIB)/lib$(FLAGLIBNM).a
	$(CC) $(OPT) $(FFLAGS) -c $< -o $@ -I${MLABINC}

$(FLAGOBJMEX)/%_mex.$(MEXEXT): $(FLAGOBJMAT)/%_mex.o $(FLAGLIB)/lib$(FLAGLIBNM).a
	$(MEX) $< -output $@ $(LDFLAGSMEX) $(MEXFLAGS) -L$(MLABLIB)

.PHONY: matlab
matlab: $(FLAGOBJSMEX)


# Documentation

# .PHONY: doc
# doc:
# 	doxygen $(FLAGSRC)/doxygen.config
# .PHONY: cleandoc
# cleandoc:
# 	rm -f $(FLAGDOC)/html/*


# Cleaning up

.PHONY: clean
clean:	tidy
	rm -f $(FLAGOBJ)/*.o
	# rm -f $(FLAGOBJ)/unittest/*.o
	rm -f $(FLAGLIB)/lib$(FLAGLIBNM).a
	# rm -f $(FLAGBIN)/flag_test
	# rm -f $(FLAGBIN)/flag_about
	# rm -f $(FLAGBIN)/unittest/flag_unittest
	rm -f $(FLAGOBJMAT)/*.o
	rm -f $(FLAGOBJMEX)/*.$(MEXEXT)

.PHONY: tidy
tidy:
	rm -f *~

.PHONY: cleanall
cleanall: clean #cleandoc

