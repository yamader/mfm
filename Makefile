CXX := clang++

CXXFLAGS      := -O3
CXXFLAGS_WASM := --target=wasm32 -nostdlib -Wl,--no-entry

.PHONY: all clean

all: mfm.so mfm.wasm repl

clean:
	rm -f mfm.so mfm.wasm repl

mfm.so: mfm.cc
	$(CXX) $(CXXFLAGS) -shared -o $@ $^

mfm.wasm: mfm.cc
	$(CXX) $(CXXFLAGS) $(CXXFLAGS_WASM) -o $@ $^

repl: repl.cc mfm.cc
	$(CXX) $(CXXFLAGS) -o $@ $^
