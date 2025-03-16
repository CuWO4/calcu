TARGET := calcu
EXTERN := cpp
COMPILER := clang++

COMPILE_OPTION := -Wall -O2
# to generate dependent files #
COMPILE_OPTION_DES := -MMD -MP 

# store .o and .d files #
TMPDIR := tmp
# store the target file #
DEBUGDIR := debug

# sources, objects and dependencies #
SRCS := $(wildcard *.$(EXTERN))
OBJS := $(patsubst %.$(EXTERN), $(TMPDIR)/%.o, $(SRCS))
DEPS := $(patsubst %.$(EXTERN), $(TMPDIR)/%.d, $(SRCS))

FFLAGS := -d
BFLAGS := -d

# flex & bison source files
FSRC := $(wildcard *.l)
BSRC := $(wildcard *.y)
F_CFILES := $(patsubst %.l, $(TMPDIR)/%.lex.cpp, $(FSRC)) 
B_CFILES := $(patsubst %.y, $(TMPDIR)/%.tab.cpp, $(BSRC))
FB_CFILES := $(F_CFILES) $(B_CFILES)

# link #
$(DEBUGDIR)/$(TARGET) : $(OBJS) $(FB_CFILES) | $(DEBUGDIR)
	@ echo linking...
	$(COMPILER) $(OBJS) $(FB_CFILES) -o $(DEBUGDIR)/$(TARGET)
	@ echo completed!

# compile #
$(TMPDIR)/%.o : %.$(EXTERN) $(F_CFILES) | $(TMPDIR)
	@ echo compiling $<...
	$(COMPILER) $< -o $@ -c $(COMPILE_OPTION) $(COMPILE_OPTION_DES)

$(TMPDIR)/%.lex.cpp : %.l $(B_CFILES) | $(TMPDIR)
	flex -o$@ $(FFLAGS) $<

$(TMPDIR)/%.tab.cpp : %.y | $(TMPDIR)
	bison $(BFLAGS) -o $@ $<

# create TMPDIR when it does not exist #
$(TMPDIR) :
	@ mkdir $(patsubst ./%, %, $(TMPDIR))

$(DEBUGDIR) :
	@ mkdir $(DEBUGDIR)

# files dependecies #
-include $(DEPS)

# run command #
.PHONY : run
run : $(DEBUGDIR)/$(TARGET)
	./$(DEBUGDIR)/$(TARGET)

# clean command #
.PHONY : clean
clean :
	@ echo try to clean...
	rm -r $(DEBUGDIR)/$(TARGET) $(OBJS) $(DEPS) $(FB_CFILES)
	@ echo completed!