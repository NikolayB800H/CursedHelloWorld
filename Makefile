GREEN = '\033[0;32m'
NC    = '\033[0m' # No Color
BOLD  = '\033[1m'

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

.PHONY: all build-lib clean-lib rebuild-lib build run valrun rebuild clean

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
	@printf "$(GREEN)$(BOLD)Running without valgrind:$(BOLD)$(NC)" | tr -d "'"
	./${TARGET}

valrun:
	@printf "$(GREEN)$(BOLD)Running with valgrind:$(BOLD)$(NC)" | tr -d "'"
	valgrind ./${TARGET}

clean:
	rm -f $(TARGET)

rebuild: clean build

$(TARGET):
	$(CC) $(CFLAGS) $(addprefix -I, $(HDRS)) $(SRCS) $(STLIBS) -o $(TARGET)
