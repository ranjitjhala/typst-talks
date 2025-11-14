all: pliss2025.pdf

%.pdf: %.typ
	@echo "Compiling $< to $@..."
	typst compile $< $@
