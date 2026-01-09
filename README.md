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
| CTRL+J | Join a channel |
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

Compile with QuickBASIC 4.5 or QB64:

```
qb64 graffiti.bas -o graffiti.exe
```

## History

Copyright 1999 haxorjim.
