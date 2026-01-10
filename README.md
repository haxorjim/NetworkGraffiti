# Network Graffiti

A nostalgic LAN chat application for macOS, Linux, and Windows.

![](/screenshot.bmp?raw=true)

## About

Network Graffiti (NWG) enables real-time text chat over a local network using a shared file as a simple message broker—all clients read and write to the same `chat.log` file on a network drive.

### History

Network Graffiti was written in 1999 for a college LAN running Windows NT 4.0. It evolved from earlier experiments with NT's `net send` command, which could pop messages onto any computer on the network. Network Graffiti took a different approach—using a shared file as a message broker to enable multi-user chat rooms.

The original version was compiled with Microsoft QuickBASIC 4.5 and ran in MS-DOS. In 2026 the codebase was modernized to compile with [QB64 Phoenix Edition](https://github.com/QB64-Phoenix-Edition/QB64pe), bringing cross-platform support while preserving the retro text-mode aesthetic.

Features:
- Multiple chat channels
- User colors (15 options)
- User list with connection stats
- Punt/kick functionality with anti-punt protection
- Anti-Hack Mode (escape to a secret chat location)
- Messages per minute tracking

## Usage

```
graffiti --share <path> [--user <name>]
```

| Option | Description |
|--------|-------------|
| `--share <path>` | Path to shared network directory (required) |
| `--user <name>` | Set chat nickname (skips login prompt) |
| `--help` | Show help message |

Examples:
```
graffiti --share /mnt/network/chat
graffiti --share //server/share --user Alice
```

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
