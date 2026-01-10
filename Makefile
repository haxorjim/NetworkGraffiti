# Network Graffiti Makefile
# Cross-platform build with QB64 Phoenix Edition

QB64PE_DIR = QB64pe
QB64PE_REPO = https://github.com/QB64-Phoenix-Edition/QB64pe.git

# Detect operating system
ifeq ($(OS),Windows_NT)
    DETECTED_OS := Windows
    QB64PE_BIN := $(QB64PE_DIR)/qb64pe.exe
    SETUP_CMD := cd $(QB64PE_DIR) && setup_win.bat
    RM := del /Q
else
    UNAME_S := $(shell uname -s)
    ifeq ($(UNAME_S),Darwin)
        DETECTED_OS := macOS
        QB64PE_BIN := $(QB64PE_DIR)/qb64pe
        SETUP_CMD := cd $(QB64PE_DIR) && ./setup_osx.command
        RM := rm -f
    else
        DETECTED_OS := Linux
        QB64PE_BIN := $(QB64PE_DIR)/qb64pe
        SETUP_CMD := cd $(QB64PE_DIR) && ./setup_lnx.sh
        RM := rm -f
    endif
endif

.PHONY: all build clean install-qb64pe install-deps help

all: build

# Build graffiti from graffiti.bas
build: $(QB64PE_BIN)
	$(QB64PE_BIN) -x graffiti.bas -o graffiti

# Install platform-specific dependencies
install-deps:
ifeq ($(DETECTED_OS),macOS)
	xcode-select --install
else ifeq ($(DETECTED_OS),Linux)
	@echo "Installing dependencies (requires sudo)..."
	@if command -v apt-get >/dev/null 2>&1; then \
		sudo apt-get install -y build-essential libgl1-mesa-dev libasound2-dev; \
	elif command -v dnf >/dev/null 2>&1; then \
		sudo dnf install -y gcc-c++ mesa-libGL-devel alsa-lib-devel; \
	elif command -v pacman >/dev/null 2>&1; then \
		sudo pacman -S --noconfirm base-devel mesa alsa-lib; \
	else \
		echo "Unknown package manager. Install: C++ compiler, OpenGL dev, ALSA dev"; \
	fi
else
	@echo "Windows: No additional dependencies required (uses MinGW bundled with QB64-PE)"
endif

# Clone and build QB64 Phoenix Edition
install-qb64pe:
ifeq ($(OS),Windows_NT)
	@if exist "$(QB64PE_DIR)" ( \
		echo QB64pe directory already exists. Remove it first to reinstall. \
	) else ( \
		git clone $(QB64PE_REPO) $(QB64PE_DIR) && \
		$(SETUP_CMD) \
	)
else
	@if [ -d "$(QB64PE_DIR)" ]; then \
		echo "QB64pe directory already exists. Remove it first to reinstall."; \
	else \
		git clone $(QB64PE_REPO) $(QB64PE_DIR) && \
		$(SETUP_CMD); \
	fi
endif

# Check if QB64-PE is installed
$(QB64PE_BIN):
	@echo "QB64-PE not found. Run 'make install-qb64pe' first."
ifeq ($(OS),Windows_NT)
	@exit /b 1
else
	@exit 1
endif

# Remove built executable
clean:
	$(RM) graffiti
ifeq ($(OS),Windows_NT)
	$(RM) graffiti.exe
endif

help:
	@echo "Network Graffiti Build System"
	@echo "Detected OS: $(DETECTED_OS)"
	@echo ""
	@echo "Targets:"
	@echo "  install-deps    - Install platform build dependencies"
	@echo "  install-qb64pe  - Clone and build QB64 Phoenix Edition"
	@echo "  build           - Compile graffiti.bas to executable (default)"
	@echo "  clean           - Remove built executable"
	@echo "  help            - Show this help message"
