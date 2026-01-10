'**********************
'*  Network Graffiti  *
'**********************
CLS
GOSUB Initial.Settings
GOSUB computer.name
GOSUB draw.program
GOSUB welcome.message
framecount = 0
ctrlDown = 0
DO
 k& = _KEYHIT
 ctrlDown = _KEYDOWN(100305) OR _KEYDOWN(100306)         ' Left or Right CTRL
 SELECT CASE k&
  CASE 15104: GOSUB help.screen                          ' F1
  CASE 108, 76: IF ctrlDown THEN GOSUB logon.command     ' CTRL+L
  CASE 120, 88: IF ctrlDown THEN GOSUB exit.chat         ' CTRL+X
 END SELECT
 framecount = framecount + 1
 IF framecount >= 30 THEN                                ' Every ~0.5 sec at 60fps
  COLOR 8
  GOSUB flashit
  framecount = 0
 END IF
 _LIMIT 60
LOOP
'just in case loop dies
CLS
END

'*********************
Initial.Settings:
'*********************
RANDOMIZE TIMER
mycolor = INT(RND * 15) + 1                   'Random Program Color
host.color = 7                                'NWG HOST color setup
myrandom$ = STR$(INT(RND * 100000) + 1)       'Users Random Code

IF COMMAND$ = "" THEN
        CLS
        COLOR 7
        PRINT "Network Graffiti: MS-DOS Version"
        PRINT
        PRINT "A shared network directory is required to function as"
        PRINT "a file server for communication between the chat clients."
        PRINT
        PRINT "Please enter the common network share you will be using now."
        PRINT "An invalid path will cause this program to crash!"
        PRINT
        PRINT "Example: \\server\share"
        PRINT
        INPUT "[\\computer\directory]:", filename$
ELSEIF COMMAND$ = "/?" THEN
        COLOR 7
        PRINT "Network Graffiti - Command Line"
        PRINT
        PRINT "The shared network directory can be given at the command line."
        PRINT "Example: graffiti \\server\share"
        PRINT
        END
ELSE
        filename$ = COMMAND$
END IF
        filename$ = filename$ + "\chat.log"
        normname$ = filename$

        CLS
        COLOR 7
        PRINT "Anti-Hack Mode allows you to escape to a secret chat location."
        PRINT
        PRINT "Enter an alternate network path for Anti-Hack Mode,"
        PRINT "or press ENTER to skip."
        PRINT
        PRINT "Example: \\server\secret"
        PRINT
        INPUT "[\\computer\directory]:", safefile$
        IF safefile$ <> "" THEN
                safefile$ = safefile$ + "\chat.log"
        END IF
RETURN

'*********************
computer.name:
'*********************
SHELL _HIDE "hostname > _hostname.tmp"
OPEN "_hostname.tmp" FOR INPUT AS #99
LINE INPUT #99, mycomputer$
CLOSE #99
KILL "_hostname.tmp"
IF mycomputer$ = "" THEN mycomputer$ = "UNKNOWN"
RETURN

'*********************
welcome.message:
'*********************
COLOR host.color
s$ = "\         \ \                                                            \"
what$ = "        ____,wggggMMMM0MM@@@@@@@MMMMMM0Mgggyy,____"
LOCATE 6, 4: PRINT USING s$; "NWG HOST"; what$
what$ = "   __wmM#$$g#@MM@''`                    `''MMMMMMMMMMgy__"
LOCATE 7, 4: PRINT USING s$; "NWG HOST"; what$
what$ = "  y0@OwDMMMMMMM                               ^QMMMMMMMMMM0g"
LOCATE 8, 4: PRINT USING s$; "NWG HOST"; what$
what$ = "   #@g2$0MMMMMf                                 jMNEMMMMMMMM0"
LOCATE 9, 4: PRINT USING s$; "NWG HOST"; what$
what$ = "    '90#MMMMMMMg                             _jMM#0MMMMMMMM'"
LOCATE 10, 4: PRINT USING s$; "NWG HOST"; what$
what$ = "      `''9MMMMMm                    __,yM$ZW0MM@M''`"
LOCATE 11, 4: PRINT USING s$; "NWG HOST"; what$
what$ = "          ```^~        __ygMMMMMMMMMMMMMM'^^`              "
LOCATE 12, 4: PRINT USING s$; "NWG HOST"; what$
what$ = "                    jgQ#j&MMMMMM0Am,"
LOCATE 13, 4: PRINT USING s$; "NWG HOST"; what$
what$ = "                         ``````     "
LOCATE 14, 4: PRINT USING s$; "NWG HOST"; what$
what$ = "                       _,wawyywy_   "
LOCATE 15, 4: PRINT USING s$; "NWG HOST"; what$
what$ = "                       9NMMMMMM@M`"
LOCATE 16, 4: PRINT USING s$; "NWG HOST"; what$
what$ = "                        9NM2$M@M"
LOCATE 17, 4: PRINT USING s$; "NWG HOST"; what$
what$ = "                          ~'~~~'"
LOCATE 18, 4: PRINT USING s$; "NWG HOST"; what$
COLOR mycolor
RETURN

'*********************
draw.program:
'*********************
CLS
COLOR 7
COLOR 15
LOCATE 2, 3: PRINT "      __ ___        __  ____          __  ____  __  ___ ___   ___  "
LOCATE 3, 3: PRINT "#\ # #__  #  # # # #  # #__/ #_/     # __ #__/ #__# #_  #_  #  #  #"
LOCATE 4, 3: PRINT "# \# #__  #  #_#_# #__# #  \ # \     #__# #  \ #  # #   #   #  #  #"
COLOR mycolor
LOCATE 5, 2: PRINT CHR$(218); STRING$(76, 196); CHR$(191)
FOR y = 6 TO 18
LOCATE y, 2: PRINT CHR$(179); SPC(76); CHR$(179)
NEXT y
LOCATE 19, 2: PRINT CHR$(192); STRING$(76, 196); CHR$(217)
LOCATE 20, 2: PRINT CHR$(218); STRING$(62, 196); CHR$(191)
LOCATE 21, 2: PRINT CHR$(179)
COLOR 8
LOCATE 21, 3: PRINT STRING$(62, 250)
COLOR mycolor
LOCATE 21, 65: PRINT CHR$(179)
LOCATE 22, 2: PRINT CHR$(192); STRING$(62, 196); CHR$(217)
LOCATE 20, 66: PRINT CHR$(218); STRING$(12, 196); CHR$(191)
LOCATE 21, 66: PRINT CHR$(179); SPACE$(12); CHR$(179)
LOCATE 22, 66: PRINT CHR$(192); STRING$(12, 196); CHR$(217)
COLOR 7
IF hack = 0 THEN
 LOCATE 23, 30: PRINT "[Normal Mode]"
ELSE
 LOCATE 23, 30: PRINT "[Anti-Hack Mode]"
END IF
IF online <> 1 THEN LOCATE 23, 3: PRINT "NOT CONNECTED"
LOCATE 23, 48: PRINT "[ F1: Help ] [ CTRL + X: Exit ]"
COLOR mycolor
RETURN

'*********************
help.screen:
'*********************
TIMER OFF
COLOR mycolor
LOCATE 3, 6: PRINT CHR$(218); STRING$(68, 196); CHR$(191)
FOR h = 4 TO 22
 LOCATE h, 6: PRINT CHR$(179); SPACE$(68); CHR$(179)
NEXT h
COLOR 15
LOCATE 5, 10: PRINT "                 NETWORK GRAFFITI HELP SCREEN"
COLOR 7
LOCATE 7, 10: PRINT "CTRL + L           Connect to Network Graffiti"
LOCATE 8, 10: PRINT "CTRL + N           Change your Alias while Connected"
LOCATE 9, 10: PRINT "CTRL + A           Enter the Anti-Punt Password [ANTI]"
LOCATE 10, 10: PRINT "CTRL + P           Punts an Unprotected User out of NWG"
LOCATE 11, 10: PRINT "CTRL + C           Changes Network Graffiti User Color"
LOCATE 12, 10: PRINT "CTRL + G           Joins a Channel [Default: #MAIN]"
LOCATE 13, 10: PRINT "CTRL + X           Exits Network Graffiti"
LOCATE 14, 10: PRINT "CTRL + W           Lists Connected Users and Details"
LOCATE 15, 10: PRINT "CTRL + H           Switches to [Anti-Hack Mode]"
LOCATE 17, 10: PRINT "F1                 Displays this Help Screen"
COLOR 15
LOCATE 21, 10: PRINT "        NWG - Copyright (C)1999-"; RIGHT$(DATE$, 4); " haxorjim"
COLOR mycolor
LOCATE 23, 6: PRINT CHR$(192); STRING$(68, 196); CHR$(217)
DO: _LIMIT 60: k& = _KEYHIT: LOOP UNTIL k& > 0           ' Wait for new keypress (ignore releases)
TIMER ON
GOSUB draw.program
IF online <> 1 THEN GOSUB welcome.message
RETURN

'*********************
channel.message:
'*********************
OPEN filename$ FOR APPEND SHARED AS #1
 what$ = ""
 WRITE #1, what$, "NWG HOST", host.color, mychannel$, myrandom$
 what$ = ""
 WRITE #1, what$, "NWG HOST", host.color, mychannel$, myrandom$
 what$ = "      ^\/^"
 WRITE #1, what$, "NWG HOST", host.color, mychannel$, myrandom$
 what$ = "      (Oo)"
 WRITE #1, what$, "NWG HOST", host.color, mychannel$, myrandom$
 what$ = "       ()                  Welcome to the "
 WRITE #1, what$, "NWG HOST", host.color, mychannel$, myrandom$
 what$ = "    oOO__OOo          Network Graffiti Chat Room!"
 WRITE #1, what$, "NWG HOST", host.color, mychannel$, myrandom$
 what$ = "     \/\/\/"
 WRITE #1, what$, "NWG HOST", host.color, mychannel$, myrandom$
 what$ = "      \/\/            Channel: #" + mychannel$
 WRITE #1, what$, "NWG HOST", host.color, mychannel$, myrandom$
 what$ = "       ~~"
 WRITE #1, what$, "NWG HOST", host.color, mychannel$, myrandom$
 what$ = "       ||"
 WRITE #1, what$, "NWG HOST", host.color, mychannel$, myrandom$
 what$ = "<>=-=-/__\=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=<>"
 WRITE #1, what$, "NWG HOST", host.color, mychannel$, myrandom$
 what$ = ""
 WRITE #1, what$, "NWG HOST", host.color, mychannel$, myrandom$
 what$ = ""
 WRITE #1, what$, "NWG HOST", host.color, mychannel$, myrandom$
CLOSE #1
RETURN

'*********************
logon.command:
'*********************
COLOR mycolor
LOCATE 10, 15: PRINT CHR$(218); STRING$(44, 196); CHR$(191)
LOCATE 11, 15: PRINT CHR$(179); SPACE$(29); CHR$(218); STRING$(12, 196); CHR$(191); SPACE$(1); CHR$(179)
LOCATE 12, 15: PRINT CHR$(179); SPACE$(29); CHR$(179); SPACE$(12); CHR$(179); SPACE$(1); CHR$(179)
LOCATE 13, 15: PRINT CHR$(179); SPACE$(29); CHR$(192); STRING$(12, 196); CHR$(217); SPACE$(1); CHR$(179)
LOCATE 14, 15: PRINT CHR$(192); STRING$(44, 196); CHR$(217)
COLOR 15
LOCATE 12, 20: PRINT "Handle:"
COLOR mycolor
LOCATE 12, 29: PRINT "[ " + SPACE$(10) + " ]"
COLOR 8
LOCATE 12, 31: PRINT STRING$(10, 250)
COLOR mycolor
fy = 12: fx = 47
py = 12: px = 31
by = 12: bx = 29
GOSUB input.prompts
myclient$ = current2$
ender2$ = ""
test2$ = ""
current2$ = ""
IF myclient$ <> "" AND myclient$ <> " " THEN
 online = 1
 mylevel$ = "VULNERABLE"
 GOSUB join.channel
 GOTO message.loop
ELSE
 GOSUB draw.program
 GOSUB welcome.message
END IF
RETURN

'*********************
rename.command:
'*********************
IF online = 1 THEN
 TIMER OFF
 COLOR mycolor
 LOCATE 10, 15: PRINT CHR$(218); STRING$(44, 196); CHR$(191)
 LOCATE 11, 15: PRINT CHR$(179); SPACE$(29); CHR$(218); STRING$(12, 196); CHR$(191); SPACE$(1); CHR$(179)
 LOCATE 12, 15: PRINT CHR$(179); SPACE$(29); CHR$(179); SPACE$(12); CHR$(179); SPACE$(1); CHR$(179)
 LOCATE 13, 15: PRINT CHR$(179); SPACE$(29); CHR$(192); STRING$(12, 196); CHR$(217); SPACE$(1); CHR$(179)
 LOCATE 14, 15: PRINT CHR$(192); STRING$(44, 196); CHR$(217)
 COLOR 15
 LOCATE 12, 20: PRINT "Handle:"
 COLOR mycolor
 LOCATE 12, 29: PRINT "[ " + SPACE$(10) + " ]"
 COLOR 8
 LOCATE 12, 31: PRINT STRING$(10, 250)
 COLOR mycolor
 fy = 12: fx = 47
 py = 12: px = 31
 by = 12: bx = 29
 GOSUB input.prompts
 myclient2$ = current2$
 ender2$ = ""
 test2$ = ""
 current2$ = ""
 TIMER ON
 IF myclient2$ <> "" AND myclient2$ <> " " THEN
  myclient.old$ = myclient$
  write.rename.message = 1
  myclient$ = myclient2$
 ELSE
  GOSUB draw.program
 END IF
END IF
RETURN

'*********************
hack.command:
'*********************
IF safefile$ = "" THEN
 BEEP
 RETURN
END IF
IF hack <> 1 THEN
 filename$ = safefile$
 OPEN filename$ FOR APPEND SHARED AS #1
 FOR I = 1 TO 6
 WRITE #1, "", "NWG HOST", host.color, mychannel$, myrandom$
 NEXT I
 what$ = "             [Anti-Hack Mode] has been enabled"
 WRITE #1, what$, "NWG HOST", host.color, mychannel$, myrandom$
 FOR I = 1 TO 6
 WRITE #1, "", "NWG HOST", host.color, mychannel$, myrandom$
 NEXT I
 CLOSE #1
 hack = 1
 GOSUB draw.program
 IF online <> 1 THEN GOSUB welcome.message
ELSE
 filename$ = normname$
 hack = 0
 GOSUB draw.program
 IF online <> 1 THEN GOSUB welcome.message
END IF
RETURN

'*********************
join.command:
'*********************
IF online = 1 THEN
TIMER OFF
mychannel.old$ = mychannel$
COLOR mycolor
LOCATE 10, 15: PRINT CHR$(218); STRING$(44, 196); CHR$(191)
LOCATE 11, 15: PRINT CHR$(179); SPACE$(29); CHR$(218); STRING$(12, 196); CHR$(191); SPACE$(1); CHR$(179)
LOCATE 12, 15: PRINT CHR$(179); SPACE$(29); CHR$(179); SPACE$(12); CHR$(179); SPACE$(1); CHR$(179)
LOCATE 13, 15: PRINT CHR$(179); SPACE$(29); CHR$(192); STRING$(12, 196); CHR$(217); SPACE$(1); CHR$(179)
LOCATE 14, 15: PRINT CHR$(192); STRING$(44, 196); CHR$(217)
COLOR 15
LOCATE 12, 20: PRINT "Channel:"
COLOR mycolor
LOCATE 12, 30: PRINT "[ " + SPACE$(10) + " ]"
COLOR 8
LOCATE 12, 32: PRINT STRING$(10, 250)
COLOR mycolor
fy = 12: fx = 47
py = 12: px = 32
by = 12: bx = 30
GOSUB input.prompts
mychannel$ = current2$
ender2$ = ""
test2$ = ""
current2$ = ""
TIMER ON
IF mychannel$ <> "" THEN
 write.join.message = 1
ELSE
 mychannel$ = mychannel.old$
END IF
END IF
RETURN

'*********************
who.command:
'*********************
IF online = 1 THEN
 write.who.messages = 1
END IF
RETURN

'*********************
punt.command:
'*********************
IF online = 1 THEN
TIMER OFF
mychannel.old$ = mychannel$
COLOR mycolor
LOCATE 10, 15: PRINT CHR$(218); STRING$(44, 196); CHR$(191)
LOCATE 11, 15: PRINT CHR$(179); SPACE$(29); CHR$(218); STRING$(12, 196); CHR$(191); SPACE$(1); CHR$(179)
LOCATE 12, 15: PRINT CHR$(179); SPACE$(29); CHR$(179); SPACE$(12); CHR$(179); SPACE$(1); CHR$(179)
LOCATE 13, 15: PRINT CHR$(179); SPACE$(29); CHR$(192); STRING$(12, 196); CHR$(217); SPACE$(1); CHR$(179)
LOCATE 14, 15: PRINT CHR$(192); STRING$(44, 196); CHR$(217)
COLOR 15
LOCATE 12, 20: PRINT "Punt:"
COLOR mycolor
LOCATE 12, 30: PRINT "[ " + SPACE$(10) + " ]"
COLOR 8
LOCATE 12, 32: PRINT STRING$(10, 250)
COLOR mycolor
fy = 12: fx = 47
py = 12: px = 32
by = 12: bx = 30
GOSUB input.prompts
them$ = current2$
ender2$ = ""
test2$ = ""
current2$ = ""
TIMER ON
IF them$ <> "" THEN
 write.punt.message = 1
END IF
END IF
RETURN

'*********************
anti.command:
'*********************
IF online = 1 THEN
 TIMER OFF
 COLOR mycolor
 LOCATE 10, 15: PRINT CHR$(218); STRING$(44, 196); CHR$(191)
 LOCATE 11, 15: PRINT CHR$(179); SPACE$(29); CHR$(218); STRING$(12, 196); CHR$(191); SPACE$(1); CHR$(179)
 LOCATE 12, 15: PRINT CHR$(179); SPACE$(29); CHR$(179); SPACE$(12); CHR$(179); SPACE$(1); CHR$(179)
 LOCATE 13, 15: PRINT CHR$(179); SPACE$(29); CHR$(192); STRING$(12, 196); CHR$(217); SPACE$(1); CHR$(179)
 LOCATE 14, 15: PRINT CHR$(192); STRING$(44, 196); CHR$(217)
 COLOR 15
 LOCATE 12, 20: PRINT "Password:"
 COLOR mycolor
 LOCATE 12, 30: PRINT "[ " + SPACE$(10) + " ]"
 COLOR 8
 LOCATE 12, 32: PRINT STRING$(10, 250)
 COLOR mycolor
 DO WHILE ender2$ <> "true"
  k& = _KEYHIT
  SELECT CASE k&
   CASE 13                                                ' ENTER
    ender2$ = "true"
   CASE 8                                                 ' BACKSPACE
    length = LEN(current2$)
    IF length > 0 THEN length = length - 1
    current2$ = LEFT$(current2$, length)
    pass$ = LEFT$(pass$, length)
    COLOR mycolor
    LOCATE 12, 30: PRINT "[ " + SPACE$(10) + " ]"
    COLOR 8
    LOCATE 12, 32: PRINT STRING$(10, 250)
    COLOR mycolor
    LOCATE 12, 32: PRINT pass$
   CASE 32 TO 126                                         ' Printable ASCII
    IF LEN(current2$) = 10 THEN
     BEEP
    ELSE
     current2$ = current2$ + CHR$(k&)
     pass$ = pass$ + "*"
     LOCATE 12, 32: PRINT pass$
    END IF
   CASE 0                                                 ' No key pressed
    p1 = p1 + 2
    IF p1 >= 10 THEN
     p1 = 0
     cool1$ = CHR$(177)
     LOCATE 12, 47: PRINT SPACE$(10)
    ELSE
     cool1$ = cool1$ + CHR$(177) + CHR$(177)
    END IF
    COLOR 8
    LOCATE 12, 47: PRINT cool1$
    COLOR mycolor
    _LIMIT 60
  END SELECT
 LOOP
code$ = current2$
ender2$ = ""
test2$ = ""
current2$ = ""
pass$ = ""
 COLOR mycolor
 IF UCASE$(code$) = "IDDQD" THEN
  super.access = 1
  mylevel$ = "INVINCIBLE"
  spunts$ = "off"
  punts$ = "off"
  DO WHILE VAL(num$) < 10
  num$ = RIGHT$(STR$(INT(RND * 19) + 1), 2)
  LOOP
  mycomputer$ = "ET2898-" + num$
 ELSEIF UCASE$(code$) = "ANTI" THEN
  mylevel$ = "PROTECTED"
  punts$ = "off"
 END IF
 TIMER ON
END IF
RETURN

'*********************
join.channel:
'*********************
TIMER ON
ON TIMER(1) GOSUB time.loop
mychannel$ = "MAIN"
GOSUB channel.message
OPEN filename$ FOR APPEND SHARED AS #1
 a$ = myclient$ + " just entered the chat room..."
 WRITE #1, a$, "NWG HOST", host.color, mychannel$, "not" + myrandom$
 a$ = ""
CLOSE #1
RETURN

'*********************
message.loop:
'*********************
DO
 GOSUB input.message
 IF say$ = "" OR say$ = " " THEN
  BEEP
 ELSE
  mycount = mycount + 1
  write.say.message = 1
 END IF
 Message$ = ""
 current$ = ""
 test$ = ""
 ender$ = "false"
LOOP

'*********************
chat.log.loop:
'*********************
IF write.rename.message = 1 THEN GOSUB write.rename
IF write.join.message = 1 THEN GOSUB write.join
IF write.punt.message = 1 THEN GOSUB write.punt
IF write.who.messages = 1 THEN GOSUB write.who
IF write.say.message = 1 THEN GOSUB write.say
OPEN filename$ FOR INPUT SHARED AS #255
 DO WHILE NOT EOF(255)
  INPUT #255, what$, Client$, ccolor, channel$, who$
  GOSUB Message.Display
  GOSUB Who.asked
 LOOP
CLOSE #255
GOSUB print.buffer
IF punts$ <> "off" AND who$ = "punt" + myclient$ THEN GOTO punt.Em
IF spunts$ <> "off" AND who$ = "spunt" + myclient$ THEN GOTO punt.Em
GOSUB who.response
RETURN

'*********************
write.rename:
'*********************
OPEN filename$ FOR APPEND SHARED AS #1
 what$ = "[ " + myclient.old$ + " ] changed their name to [ " + myclient$ + " ]"
 WRITE #1, what$, "NWG HOST", host.color, mychannel$, "not" + myrandom$
CLOSE #1
write.rename.message = 0
RETURN

'*********************
write.join:
'*********************
OPEN filename$ FOR APPEND SHARED AS #1
 what$ = myclient$ + " left #" + mychannel.old$
 WRITE #1, what$, "NWG HOST", host.color, mychannel.old$, "not" + myrandom$
 what$ = myclient$ + " entered #" + mychannel$
 WRITE #1, what$, "NWG HOST", host.color, mychannel$, "not" + myrandom$
CLOSE #1
GOSUB channel.message
write.join.message = 0
RETURN

'*********************
write.punt:
'*********************
OPEN filename$ FOR APPEND SHARED AS #1
 IF super.access = 1 THEN
  WRITE #1, "", "NWG HOST", 6, mychannel$, "spunt" + them$
 ELSE
  WRITE #1, "", "NWG HOST", 6, mychannel$, "punt" + them$
 END IF
CLOSE #1
write.punt.message = 0
RETURN

'*********************
write.who:
'*********************
IF who.n = 0 THEN
 OPEN filename$ FOR APPEND SHARED AS #1
  WRITE #1, "", myrandom$, 0, mychannel$, "who"
  what$ = "Handle      Channel     Computer    Punting     Line Rate"
  WRITE #1, what$, "NWG HOST", host.color, mychannel$, myrandom$
  l$ = STRING$(10, 196)
  what$ = l$ + SPACE$(2) + l$ + SPACE$(2) + l$ + SPACE$(2) + l$ + SPACE$(2) + l$
  WRITE #1, what$, "NWG HOST", host.color, mychannel$, myrandom$
  l = 12 - LEN(myclient$)
  l2 = 11 - LEN(mychannel$)
  l3 = 12 - LEN(mycomputer$)
  l4 = 13 - LEN(mylevel$)
  what$ = myclient$ + SPACE$(l) + "#" + mychannel$ + SPACE$(l2) + mycomputer$ + SPACE$(l3) + mylevel$ + SPACE$(l4) + mympm$
  WRITE #1, what$, "NWG HOST", host.color, mychannel$, myrandom$
 CLOSE #1
 who.n = 1
ELSE
 OPEN filename$ FOR APPEND SHARED AS #1
  WRITE #1, "", myrandom$, 0, mychannel$, "thanks"
 CLOSE #1
 who.n = 0
 write.who.messages = 0
END IF
RETURN

'*********************
write.say:
'*********************
 OPEN filename$ FOR APPEND SHARED AS #1
  WRITE #1, say$, myclient$, mycolor, mychannel$, "all"
 CLOSE #1
 write.say.message = 0
RETURN

'*********************
Message.Display:
'*********************
IF channel$ = mychannel$ OR channel$ = "all" THEN
 IF LEFT$(who$, 3) = "not" THEN
  IF MID$(who$, 4) <> myrandom$ THEN GOSUB Create.Buffer
 END IF
 IF who$ = myrandom$ THEN GOSUB Create.Buffer
 IF who$ = "all" THEN GOSUB Create.Buffer
END IF
RETURN

'*********************
who.response:
'*********************
IF tell = 1 THEN
 OPEN filename$ FOR APPEND SHARED AS #1
  l = 12 - LEN(myclient$)
  l2 = 11 - LEN(mychannel$)
  l3 = 12 - LEN(mycomputer$)
  l4 = 13 - LEN(mylevel$)
  what$ = myclient$ + SPACE$(l) + "#" + mychannel$ + SPACE$(l2) + mycomputer$ + SPACE$(l3) + mylevel$ + SPACE$(l4) + mympm$
  WRITE #1, what$, "NWG HOST", host.color, tell.channel$, tell.who$
 CLOSE #1
 tell = 0
 tell.who$ = ""
 tell.channel$ = ""
END IF
RETURN

'*********************
Who.asked:
'*********************
IF who$ = "who" THEN
 tell = 1
 tell.who$ = Client$
 tell.channel$ = channel$
END IF
l = 12 - LEN(myclient$)
l2 = 11 - LEN(mychannel$)
l3 = 12 - LEN(mycomputer$)
l4 = 13 - LEN(mylevel$)
this$ = myclient$ + SPACE$(l) + "#" + mychannel$ + SPACE$(l2) + mycomputer$ + SPACE$(l3) + mylevel$ + SPACE$(l4) + mympm$
IF who$ = "thanks" OR what$ = this$ THEN
 tell = 0
 tell.who$ = ""
 tell.channel$ = ""
END IF
RETURN

'*********************
input.message:
'*********************
DO WHILE ender$ <> "true"                               ' if not end go
 k& = _KEYHIT
 ctrlDown = _KEYDOWN(100305) OR _KEYDOWN(100306)        ' Left or Right CTRL
 SELECT CASE k&
  CASE 15104: GOSUB help.screen: GOTO input.msg.resume   ' F1
  CASE 97, 65                                            ' A
   IF ctrlDown THEN GOSUB anti.command: GOTO input.msg.resume ELSE GOTO type.char
  CASE 110, 78                                           ' N
   IF ctrlDown THEN GOSUB rename.command: GOTO input.msg.resume ELSE GOTO type.char
  CASE 104, 72                                           ' H
   IF ctrlDown THEN GOSUB hack.command: GOTO input.msg.resume ELSE GOTO type.char
  CASE 120, 88                                           ' X
   IF ctrlDown THEN GOSUB exit.chat ELSE GOTO type.char
  CASE 119, 87                                           ' W
   IF ctrlDown THEN GOSUB who.command: GOTO input.msg.resume ELSE GOTO type.char
  CASE 99, 67                                            ' C
   IF ctrlDown THEN GOSUB Change.Color: GOTO input.msg.resume ELSE GOTO type.char
  CASE 103, 71                                           ' G (join/Go to channel)
   IF ctrlDown THEN GOSUB join.command: GOTO input.msg.resume ELSE GOTO type.char
  CASE 112, 80                                           ' P
   IF ctrlDown THEN GOSUB punt.command: GOTO input.msg.resume ELSE GOTO type.char
  CASE 8                                                 ' BACKSPACE
   IF LEN(current$) > 0 THEN
    current$ = LEFT$(current$, LEN(current$) - 1)
    COLOR 8: LOCATE 21, 3: PRINT STRING$(62, 250)
    COLOR mycolor: LOCATE 21, 3: PRINT current$
   END IF
  CASE 13                                                ' ENTER
   ender$ = "true"
  CASE 32 TO 126                                         ' Printable ASCII
type.char:
   IF ctrlDown = 0 THEN                                  ' Only if CTRL not held
    IF k& <> 34 THEN                                     ' Not quote char
     IF LEN(current$) < 62 THEN
      current$ = current$ + CHR$(k&)
      LOCATE 21, 3: PRINT current$
     ELSE
      BEEP
     END IF
    END IF
   END IF
  CASE 0                                                 ' No key pressed
   _LIMIT 60
 END SELECT
LOOP                                                    'LOOP until enter
GOTO input.msg.done
input.msg.resume:
 LOCATE 21, 3: PRINT current$                            ' Redisplay after handler
 GOTO input.message
input.msg.done:
say$ = current$
COLOR 8
LOCATE 21, 3: PRINT STRING$(62, 250)
COLOR mycolor
RETURN

'*********************
flashit:
'*********************
 p = p + 2
 IF p >= 10 THEN
  p = 0
  cool$ = CHR$(177)
  LOCATE 21, 68: PRINT SPACE$(10)
 ELSE
  cool$ = cool$ + CHR$(177) + CHR$(177)
 END IF
 LOCATE 21, 68: PRINT cool$
RETURN

'*********************
exit.chat:
'*********************
IF online = 1 THEN
 ON ERROR GOTO 0
 TIMER OFF
 SLEEP 1
 CLOSE
 OPEN filename$ FOR APPEND SHARED AS #1
  Message$ = myclient$ + " left the chat room..."
  WRITE #1, Message$, "NWG HOST", host.color, mychannel$, "not" + myrandom$
 CLOSE #1
END IF
COLOR 7
CLS
SYSTEM

'*********************
punt.Em:
'*********************
TIMER OFF
OPEN filename$ FOR APPEND SHARED AS #1
 what$ = myclient$ + " was kicked out of the chat room..."
 WRITE #1, what$, "NWG HOST", host.color, mychannel$, "not" + myrandom$
CLOSE #1
what$ = "You've been kicked out of the chat room..."
Client$ = "NWG HOST"
ccolor = host.color
GOSUB Create.Buffer
GOSUB print.buffer
END

'*********************
Create.Buffer:
'*********************
buffer13$ = buffer12$
buffer12$ = buffer11$
buffer11$ = buffer10$
buffer10$ = buffer9$
buffer9$ = buffer8$
buffer8$ = buffer7$
buffer7$ = buffer6$
buffer6$ = buffer5$
buffer5$ = buffer4$
buffer4$ = buffer3$
buffer3$ = buffer2$
buffer2$ = buffer1$
buffer1$ = what$
buffer13n$ = buffer12n$
buffer12n$ = buffer11n$
buffer11n$ = buffer10n$
buffer10n$ = buffer9n$
buffer9n$ = buffer8n$
buffer8n$ = buffer7n$
buffer7n$ = buffer6n$
buffer6n$ = buffer5n$
buffer5n$ = buffer4n$
buffer4n$ = buffer3n$
buffer3n$ = buffer2n$
buffer2n$ = buffer1n$
buffer1n$ = Client$
buffer13c = buffer12c
buffer12c = buffer11c
buffer11c = buffer10c
buffer10c = buffer9c
buffer9c = buffer8c
buffer8c = buffer7c
buffer7c = buffer6c
buffer6c = buffer5c
buffer5c = buffer4c
buffer4c = buffer3c
buffer3c = buffer2c
buffer2c = buffer1c
buffer1c = ccolor
RETURN

'*********************
print.buffer:
'*********************
s$ = "\         \ \                                                            \"
COLOR buffer13c
LOCATE 6, 4: PRINT USING s$; buffer13n$; buffer13$
COLOR buffer12c
LOCATE 7, 4: PRINT USING s$; buffer12n$; buffer12$
COLOR buffer11c
LOCATE 8, 4: PRINT USING s$; buffer11n$; buffer11$
COLOR buffer10c
LOCATE 9, 4: PRINT USING s$; buffer10n$; buffer10$
COLOR buffer9c
LOCATE 10, 4: PRINT USING s$; buffer9n$; buffer9$
COLOR buffer8c
LOCATE 11, 4: PRINT USING s$; buffer8n$; buffer8$
COLOR buffer7c
LOCATE 12, 4: PRINT USING s$; buffer7n$; buffer7$
COLOR buffer6c
LOCATE 13, 4: PRINT USING s$; buffer6n$; buffer6$
COLOR buffer5c
LOCATE 14, 4: PRINT USING s$; buffer5n$; buffer5$
COLOR buffer4c
LOCATE 15, 4: PRINT USING s$; buffer4n$; buffer4$
COLOR buffer3c
LOCATE 16, 4: PRINT USING s$; buffer3n$; buffer3$
COLOR buffer2c
LOCATE 17, 4: PRINT USING s$; buffer2n$; buffer2$
COLOR buffer1c
LOCATE 18, 4: PRINT USING s$; buffer1n$; buffer1$
COLOR mycolor
RETURN

'********************
Change.Color:
'********************
TIMER OFF
GOSUB draw.menu
GOSUB menu.loop
GOSUB draw.program
IF online <> 1 THEN GOSUB welcome.message
TIMER ON
RETURN

'********************
draw.menu:
'********************
COLOR mycolor
LOCATE 6, 24: PRINT CHR$(218); STRING$(30, 196); CHR$(191)
FOR m = 7 TO 18
 LOCATE m, 24: PRINT CHR$(179); SPACE$(30); CHR$(179)
NEXT m
LOCATE 19, 24: PRINT CHR$(192); STRING$(30, 196); CHR$(217)
COLOR 15
LOCATE 7, 29: PRINT "Network Graffiti Color"
LOCATE 18, 26: PRINT "[TAB] Choose, [ENTER] Select"
COLOR 7
LOCATE 9, 27: PRINT "Dark Blue"
LOCATE 10, 27: PRINT "Dark Green"
LOCATE 11, 27: PRINT "Dark Cyan"
LOCATE 12, 27: PRINT "Dark Red"
LOCATE 13, 27: PRINT "Magenta"
LOCATE 14, 27: PRINT "Brown"
LOCATE 15, 27: PRINT "Dark White"
LOCATE 16, 27: PRINT "Gray"
LOCATE 9, 41: PRINT "Bright Blue"
LOCATE 10, 41: PRINT "Bright Green"
LOCATE 11, 41: PRINT "Bright Cyan"
LOCATE 12, 41: PRINT "Bright Red"
LOCATE 13, 41: PRINT "Pink"
LOCATE 14, 41: PRINT "Yellow"
LOCATE 15, 41: PRINT "Bright White"
RETURN

'****************
menu.loop:
'****************
menu.line = mycolor
COLOR menu.line, 0
GOSUB menu.lines
COLOR 7, 0
DO WHILE endloop$ <> "true"
 k& = _KEYHIT
 SELECT CASE k&
  CASE 13: endloop$ = "true"                              ' ENTER
  CASE 9: menu$ = "down": GOSUB menu2                     ' TAB
  CASE 25: menu$ = "up": GOSUB menu2                      ' SHIFT+TAB
  CASE 20480, 18432                                       ' DOWN, UP arrows
   IF k& = 20480 THEN menu$ = "down" ELSE menu$ = "up"
   GOSUB menu2
  CASE 19712, 19200                                       ' RIGHT, LEFT arrows
   IF k& = 19712 THEN
    IF menu.line <= 7 THEN menu.line = menu.line + 8: GOSUB draw.menu: COLOR menu.line, 0: GOSUB menu.lines
   ELSE
    IF menu.line >= 9 THEN menu.line = menu.line - 8: GOSUB draw.menu: COLOR menu.line, 0: GOSUB menu.lines
   END IF
 END SELECT
 _LIMIT 60
LOOP
endloop$ = ""
kepress$ = ""
IF menu.line = 1 THEN mycolor = 1
IF menu.line = 2 THEN mycolor = 2
IF menu.line = 3 THEN mycolor = 3
IF menu.line = 4 THEN mycolor = 4
IF menu.line = 5 THEN mycolor = 5
IF menu.line = 6 THEN mycolor = 6
IF menu.line = 7 THEN mycolor = 7
IF menu.line = 8 THEN mycolor = 8
IF menu.line = 9 THEN mycolor = 9
IF menu.line = 10 THEN mycolor = 10
IF menu.line = 11 THEN mycolor = 11
IF menu.line = 12 THEN mycolor = 12
IF menu.line = 13 THEN mycolor = 13
IF menu.line = 14 THEN mycolor = 14
IF menu.line = 15 THEN mycolor = 15
RETURN

'****************
menu2:
'****************
GOSUB draw.menu
IF menu$ = "down" THEN
 menu.line = menu.line + 1
 IF menu.line >= 16 THEN menu.line = 1
ELSEIF menu$ = "up" THEN
 menu.line = menu.line - 1
 IF menu.line <= 0 THEN menu.line = 15
END IF
COLOR menu.line, 0
GOSUB menu.lines
RETURN

'****************
menu.lines:
'****************
IF menu.line < 9 THEN LOCATE menu.line - 1 + 9, 26: PRINT CHR$(16)
IF menu.line > 8 THEN LOCATE menu.line, 40: PRINT CHR$(16)
IF menu.line = 1 THEN LOCATE 9, 27: PRINT "Dark Blue"
IF menu.line = 2 THEN LOCATE 10, 27: PRINT "Dark Green"
IF menu.line = 3 THEN LOCATE 11, 27: PRINT "Dark Cyan"
IF menu.line = 4 THEN LOCATE 12, 27: PRINT "Dark Red"
IF menu.line = 5 THEN LOCATE 13, 27: PRINT "Magenta"
IF menu.line = 6 THEN LOCATE 14, 27: PRINT "Brown"
IF menu.line = 7 THEN LOCATE 15, 27: PRINT "Dark White"
IF menu.line = 8 THEN LOCATE 16, 27: PRINT "Gray"
IF menu.line = 9 THEN LOCATE 9, 41: PRINT "Bright Blue"
IF menu.line = 10 THEN LOCATE 10, 41: PRINT "Bright Green"
IF menu.line = 11 THEN LOCATE 11, 41: PRINT "Bright Cyan"
IF menu.line = 12 THEN LOCATE 12, 41: PRINT "Bright Red"
IF menu.line = 13 THEN LOCATE 13, 41: PRINT "Pink"
IF menu.line = 14 THEN LOCATE 14, 41: PRINT "Yellow"
IF menu.line = 15 THEN LOCATE 15, 41: PRINT "Bright White"
COLOR 7, 0
RETURN

'*********************
time.loop:
'*********************
time = time + 1
minutes = INT(time / 60)
seconds = INT(time - (60 * minutes))
COLOR 7, 0
LOCATE 1, 3: PRINT SPACE$(70)
IF minutes = 0 THEN
 LOCATE 1, 3: PRINT "Connected for"; seconds; "seconds(s)"
ELSE
 LOCATE 1, 3: PRINT "Connected for"; minutes; "minute(s),"; seconds; "seconds(s)"
END IF
T$ = TIME$
Hr = VAL(T$)
IF Hr < 12 THEN Ampm$ = " AM" ELSE Ampm$ = " PM"
IF Hr > 12 THEN Hr = Hr - 12
LOCATE 1, 68: PRINT STR$(Hr); RIGHT$(T$, 6); Ampm$
IF mycount <> 0 THEN
 IF minutes = 0 THEN
  per = INT((mycount / seconds) * 60)
 ELSE
  per = INT((mycount / time) * 60)
 END IF
ELSE
 per = 0
END IF
mympm1$ = STR$(per) + " Messages Per Minute   "
mympm$ = STR$(per) + " MPM"
LOCATE 23, 2: PRINT mympm1$
COLOR 8
GOSUB flashit
COLOR mycolor, 0
GOSUB chat.log.loop
RETURN

'****************
input.prompts:
'****************
DO WHILE ender2$ <> "true"
 k& = _KEYHIT
 SELECT CASE k&
  CASE 13                                                ' ENTER
   ender2$ = "true"
  CASE 8                                                 ' BACKSPACE
   IF LEN(current2$) > 0 THEN
    current2$ = LEFT$(current2$, LEN(current2$) - 1)
    COLOR mycolor
    LOCATE by, bx: PRINT "[ " + SPACE$(10) + " ]"
    COLOR 8
    LOCATE py, px: PRINT STRING$(10, 250)
    COLOR mycolor
    LOCATE py, px: PRINT current2$
   END IF
  CASE 32 TO 126                                         ' Printable ASCII
   IF k& <> 34 THEN                                      ' Not quote char
    IF LEN(current2$) < 10 THEN
     current2$ = current2$ + CHR$(k&)
     LOCATE py, px: PRINT current2$
    ELSE
     BEEP
    END IF
   END IF
  CASE 0                                                 ' No key pressed
   p1 = p1 + 2
   IF p1 >= 10 THEN
    p1 = 0
    cool1$ = CHR$(177)
    LOCATE fy, fx: PRINT SPACE$(10)
   ELSE
    cool1$ = cool1$ + CHR$(177) + CHR$(177)
   END IF
   COLOR 8
   LOCATE fy, fx: PRINT cool1$
   COLOR mycolor
   _LIMIT 60
 END SELECT
LOOP
RETURN

