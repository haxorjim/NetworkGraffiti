# Network Graffiti Makefile
# For building with QB64 Phoenix Edition on macOS

QB64PE_DIR = QB64pe
QB64PE_BIN = $(QB64PE_DIR)/qb64pe
QB64PE_REPO = https://github.com/QB64-Phoenix-Edition/QB64pe.git

.PHONY: all build clean install-qb64pe install-xcode help

all: build

# Build graffiti.exe from graffiti.bas
build: $(QB64PE_BIN)
	$(QB64PE_BIN) -x graffiti.bas -o graffiti.exe

# Install Xcode command line tools (macOS prerequisite)
install-xcode:
	xcode-select --install

# Clone and build QB64 Phoenix Edition
install-qb64pe:
	@if [ -d "$(QB64PE_DIR)" ]; then \
		echo "QB64pe directory already exists. Remove it first to reinstall."; \
	else \
		git clone $(QB64PE_REPO) $(QB64PE_DIR) && \
		cd $(QB64PE_DIR) && ./setup_osx.command; \
	fi

# Check if QB64-PE is installed
$(QB64PE_BIN):
	@echo "QB64-PE not found. Run 'make install-qb64pe' first."
	@exit 1

# Remove built executable
clean:
	rm -f graffiti.exe

help:
	@echo "Network Graffiti Build System"
	@echo ""
	@echo "Targets:"
	@echo "  install-xcode   - Install Xcode command line tools (run first on new Mac)"
	@echo "  install-qb64pe  - Clone and build QB64 Phoenix Edition"
	@echo "  build           - Compile graffiti.bas to graffiti.exe (default)"
	@echo "  clean           - Remove built executable"
	@echo "  help            - Show this help message"
