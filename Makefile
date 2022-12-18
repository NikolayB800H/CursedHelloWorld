GREEN = '\033[0;32m'
BOLD  = '\033[1m'
NS    = '\033[0m' # No style

format = '$(BOLD)%12s$(NS)\b %-60s\n'

RSTDIR   = rust/
RSTCRATE = rust

CRGFLAGS = \
		   --verbose \
		   --release

RSTSTLIB = librust.a
RSTPATH  = $(RSTDIR)target/release/$(RSTSTLIB)
RSTRES   = $(STLIBS)

CC     = g++
TARGET = rust_to_c++.out

HDRS   = \
		 C++/include

STLIBS = \
		 C++/static-lib/librust.a

SRCS   = \
		 C++/src/main.cpp

CFLAGS = \
		 -pthread           \
		 -Wl,--no-as-needed \
		 -ldl               \
		 -Wall              \
		 -Wextra            \
		 -Werror

.PHONY: all build-lib clean-lib rebuild-lib build run valrun rebuild clean info

all: rebuild-lib rebuild run valrun

clean-all: clean-lib clean

build-lib:
	cargo build --manifest-path=$(RSTDIR)Cargo.toml --package $(RSTCRATE) $(CRGFLAGS)
	mv $(RSTPATH) $(RSTRES)

clean-lib:
	rm -f $(RSTRES)

rebuild-lib: clean-lib build-lib

build: $(TARGET)

run:
	@printf "$(GREEN)$(BOLD)Running without valgrind:$(NS)\b " | tr -d "'"
	./${TARGET}

valrun:
	@printf "$(GREEN)$(BOLD)Running with valgrind:$(NS)\b " | tr -d "'"
	valgrind ./${TARGET}

clean:
	rm -f $(TARGET)

rebuild: clean build

info:
	@printf "USAGE:\n\tmake <$(BOLD)target$(NS)\b>\nTARGETS:\n" | tr -d "'"
	@printf "$(format)" "info"        "Show this message"                                         | tr -d "'"
	@printf "$(format)" "all"         "Rebuild components and run both with valgrind and without" | tr -d "'"
	@printf "$(format)" "build-lib"   "Build rust static library"                                 | tr -d "'"
	@printf "$(format)" "clean-lib"   "Delete rust static library"                                | tr -d "'"
	@printf "$(format)" "rebuild-lib" "Delete rust static library and build a new one instead"    | tr -d "'"
	@printf "$(format)" "build"       "Build from C++ executable using rust static library"       | tr -d "'"
	@printf "$(format)" "run"         "Run executable"                                            | tr -d "'"
	@printf "$(format)" "valrun"      "Run executable with memory check"                          | tr -d "'"
	@printf "$(format)" "rebuild"     "Delete executable and build a new one instead"             | tr -d "'"
	@printf "$(format)" "clean"       "Delete executable"                                         | tr -d "'"

$(TARGET):
	$(CC) $(CFLAGS) $(addprefix -I, $(HDRS)) $(SRCS) $(STLIBS) -o $(TARGET)
