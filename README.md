# Network Graffiti

A LAN chat application for MS-DOS, written in QBasic (1999).

![](/screenshot.bmp?raw=true)

## About

Network Graffiti (NWG) enables real-time text chat between DOS machines on a local network. It uses a shared file on a network drive as a simple message broker—all clients read and write to the same `chat.log` file.

Features:
- Multiple chat channels
- User colors (15 options)
- User list with connection stats
- Punt/kick functionality with anti-punt protection
- Anti-Hack Mode (escape to a secret chat location)
- Messages per minute tracking

## Usage

```
GRAFFITI.EXE \\server\share
```

Or run without arguments to be prompted for the network path.

## Keyboard Commands

| Key | Action |
|-----|--------|
| CTRL+L | Connect to chat |
| CTRL+N | Change nickname |
| CTRL+G | Join a channel |
| CTRL+C | Change color |
| CTRL+W | List connected users |
| CTRL+P | Punt (kick) a user |
| CTRL+A | Enter anti-punt password |
| CTRL+H | Toggle Anti-Hack Mode |
| CTRL+X | Exit |
| F1 | Help screen |
| F2 | DOS shell |
| F3 | View chat log |

## Building

Builds natively on macOS, Linux, and Windows using [QB64 Phoenix Edition](https://github.com/QB64-Phoenix-Edition/QB64pe).

### Install Dependencies

```
make install-deps
```

This installs platform-specific build dependencies:
- **macOS**: Xcode command line tools
- **Linux**: OpenGL, ALSA, and C++ compiler (auto-detects apt/dnf/pacman)
- **Windows**: None required (MinGW bundled with QB64-PE)

### Install QB64 Phoenix Edition

```
make install-qb64pe
```

### Compile

```
make build
```

### All Make Targets

| Target | Description |
|--------|-------------|
| `make install-deps` | Install platform-specific build dependencies |
| `make install-qb64pe` | Clone and build QB64 Phoenix Edition |
| `make build` | Compile graffiti.bas to executable |
| `make clean` | Remove built executable |
