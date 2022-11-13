CXX       := clang++
CXXFLAGS  := -O3

.PHONY: all clean run
all: libmfm.so mfm.wasm repl
clean:
	rm -f *.so* *.wasm repl
run: repl
	./repl

## shared library
SONAME := libmfm.so.1
libmfm.so: mfm.cc
	$(CXX) $(CXXFLAGS) -shared -Wl,-soname,$(SONAME) -o $(SONAME) $^
	ln -s $(SONAME) $@

## Wasm
CXXFLAGS_WASM := --target=wasm32 -nostdlib -Wl,--no-entry
mfm.wasm: mfm.cc
	$(CXX) $(CXXFLAGS) $(CXXFLAGS_WASM) -o $@ $^

## REPL
repl: repl.cc libmfm.so
	$(CXX) $(CXXFLAGS) -o $@ $^
