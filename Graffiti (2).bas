'**********************
'*  Network Graffiti  *
'**********************
CLS
GOSUB Initial.Settings
GOSUB computer.name
GOSUB key.setup
GOSUB draw.program
GOSUB welcome.message
DO
COLOR 8
GOSUB flashit
SLEEP 1
LOOP

'*********************
Initial.Settings:
'*********************
RANDOMIZE TIMER
mycolor = INT(RND * 15) + 1                   'Random Program Color
host.color = 7                                'NWG HOST color setup
myrandom$ = STR$(INT(RND * 100000) + 1)       'Users Random Code
normname$ = "\\pdc1\temp\graffiti\chat.log"   '[Normal]
safefile$ = "z:\???"                          '[Anti-Hack]
filename$ = normname$                         'Setup Inititial Log File
RETURN

'*********************
computer.name:
'*********************
CLS
SHELL "net name"
number = SCREEN(4, 1)
mycomputer$ = mycomputer$ + CHR$(number)
number = SCREEN(4, 2)
mycomputer$ = mycomputer$ + CHR$(number)
number = SCREEN(4, 3)
mycomputer$ = mycomputer$ + CHR$(number)
number = SCREEN(4, 4)
mycomputer$ = mycomputer$ + CHR$(number)
number = SCREEN(4, 5)
mycomputer$ = mycomputer$ + CHR$(number)
number = SCREEN(4, 6)
mycomputer$ = mycomputer$ + CHR$(number)
number = SCREEN(4, 7)
mycomputer$ = mycomputer$ + CHR$(number)
number = SCREEN(4, 8)
mycomputer$ = mycomputer$ + CHR$(number)
number = SCREEN(4, 9)
mycomputer$ = mycomputer$ + CHR$(number)
RETURN

'*********************
key.setup:
'*********************
ON KEY(1) GOSUB help.screen     'Trap F1
KEY(1) ON
ON KEY(2) GOSUB shell.command   'Trap F2
KEY(2) ON
ON KEY(3) GOSUB type.command    'Trap F3
KEY(3) ON
KEY 17, CHR$(&H4) + CHR$(&H1E)
ON KEY(17) GOSUB anti.command
KEY(17) ON                      'Trap CTRL + A
KEY 18, CHR$(&H4) + CHR$(&H31)
ON KEY(18) GOSUB rename.command
KEY(18) ON                      'Trap CTRL + N
KEY 19, CHR$(&H4) + CHR$(&H23)
ON KEY(19) GOSUB hack.command
KEY(19) ON                      'Trap CTRL + H
KEY 20, CHR$(&H4) + CHR$(&H2D)
ON KEY(20) GOSUB exit.chat
KEY(20) ON                      'Trap CTRL + X
KEY 21, CHR$(&H4) + CHR$(&H11)
ON KEY(21) GOSUB who.command
KEY(21) ON                      'Trap CTRL + W
KEY 22, CHR$(&H4) + CHR$(&H2E)
ON KEY(22) GOSUB Change.Color
KEY(22) ON                      'Trap CTRL + C
KEY 23, CHR$(&H4) + CHR$(&H26)
ON KEY(23) GOSUB logon.command
KEY(23) ON                      'Trap CTRL + L
KEY 24, CHR$(&H4) + CHR$(&H24)
ON KEY(24) GOSUB join.command
KEY(24) ON                      'Trap CTRL + J
KEY 25, CHR$(&H4) + CHR$(&H19)
ON KEY(25) GOSUB punt.command
KEY(25) ON                      'Trap CTRL + P
RETURN

'*********************
keys.off:
'*********************
KEY(1) OFF
KEY(2) OFF
KEY(3) OFF
KEY(17) OFF
KEY(18) OFF
KEY(19) OFF
KEY(20) OFF
KEY(21) OFF
KEY(22) OFF
KEY(23) OFF
KEY(24) OFF
KEY(25) OFF
RETURN

'*********************
keys.on:
'*********************
KEY(1) ON
KEY(2) ON
KEY(3) ON
KEY(17) ON
KEY(18) ON
KEY(19) ON
KEY(20) ON
KEY(21) ON
KEY(22) ON
KEY(23) ON
KEY(24) ON
KEY(25) ON
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
GOSUB keys.off
COLOR mycolor
LOCATE 3, 6: PRINT "ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿"
FOR h = 4 TO 22
 LOCATE h, 6: PRINT "³                                                                    ³"
NEXT h
COLOR 7
LOCATE 5, 10: PRINT "                 NETWORK GRAFFITI HELP SCREEN"
LOCATE 7, 10: PRINT "CTRL + L           Logon to Network Graffiti"
LOCATE 8, 10: PRINT "CTRL + N           Changes username if logged on"
LOCATE 9, 10: PRINT "CTRL + A           Enter Anti-Punt Password"
LOCATE 10, 10: PRINT "CTRL + P           Punts an unprotected user out of the chatroom"
LOCATE 11, 10: PRINT "CTRL + C           Changes Network Graffiti user color"
LOCATE 12, 10: PRINT "CTRL + J           Joins a channel"
LOCATE 13, 10: PRINT "CTRL + X           Exits Network Graffiti"
LOCATE 14, 10: PRINT "CTRL + W           Lists connected users and details"
LOCATE 15, 10: PRINT "CTRL + H           Switches to [Anti-Hack Mode]"
LOCATE 17, 10: PRINT "F1                 Displays this Help Screen"
LOCATE 18, 10: PRINT "F2                 MS-DOS command prompt"
LOCATE 19, 10: PRINT "F3                 Display the log file"
LOCATE 21, 10: PRINT "Network Graffiti - Copyright (c) 1999 QB_god"
COLOR mycolor
LOCATE 23, 6: PRINT "ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ"
DO WHILE INKEY$ = ""
LOOP
GOSUB keys.on
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
GOSUB keys.off
COLOR mycolor
LOCATE 10, 15: PRINT "ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿"
LOCATE 11, 15: PRINT "³                             ÚÄÄÄÄÄÄÄÄÄÄÄÄ¿   ³"
LOCATE 12, 15: PRINT "³                             ³            ³   ³"
LOCATE 13, 15: PRINT "³                             ÀÄÄÄÄÄÄÄÄÄÄÄÄÙ   ³"
LOCATE 14, 15: PRINT "ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ"
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
GOSUB keys.on
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
 GOSUB keys.off
 TIMER OFF
 COLOR mycolor
 LOCATE 10, 15: PRINT "ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿"
 LOCATE 11, 15: PRINT "³                             ÚÄÄÄÄÄÄÄÄÄÄÄÄ¿   ³"
 LOCATE 12, 15: PRINT "³                             ³            ³   ³"
 LOCATE 13, 15: PRINT "³                             ÀÄÄÄÄÄÄÄÄÄÄÄÄÙ   ³"
 LOCATE 14, 15: PRINT "ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ"
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
 GOSUB keys.on
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
END IF
RETURN

'*********************
shell.command:
'*********************
COLOR 7
CLS
SHELL
GOSUB draw.program
IF online <> 1 THEN GOSUB welcome.message
RETURN

'*********************
type.command:
'*********************
TIMER OFF
GOSUB keys.off
COLOR 7
CLS
prmpt$ = "type " + filename$
SHELL prmpt$
DO WHILE INKEY$ = ""
LOOP
GOSUB draw.program
IF online <> 1 THEN GOSUB welcome.message
GOSUB keys.on
TIMER ON
RETURN

'*********************
join.command:
'*********************
IF online = 1 THEN
GOSUB keys.off
TIMER OFF
mychannel.old$ = mychannel$
COLOR mycolor
LOCATE 10, 15: PRINT "ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿"
LOCATE 11, 15: PRINT "³                             ÚÄÄÄÄÄÄÄÄÄÄÄÄ¿   ³"
LOCATE 12, 15: PRINT "³                             ³            ³   ³"
LOCATE 13, 15: PRINT "³                             ÀÄÄÄÄÄÄÄÄÄÄÄÄÙ   ³"
LOCATE 14, 15: PRINT "ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ"
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
GOSUB keys.on
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
 GOSUB keys.off
 write.who.messages = 1
 GOSUB keys.on
END IF
RETURN

'*********************
punt.command:
'*********************
IF online = 1 THEN
GOSUB keys.off
TIMER OFF
mychannel.old$ = mychannel$
COLOR mycolor
LOCATE 10, 15: PRINT "ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿"
LOCATE 11, 15: PRINT "³                             ÚÄÄÄÄÄÄÄÄÄÄÄÄ¿   ³"
LOCATE 12, 15: PRINT "³                             ³            ³   ³"
LOCATE 13, 15: PRINT "³                             ÀÄÄÄÄÄÄÄÄÄÄÄÄÙ   ³"
LOCATE 14, 15: PRINT "ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ"
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
GOSUB keys.on
 IF them$ <> "" THEN
  write.punt.message = 1
 END IF
 GOSUB keys.on
END IF
RETURN

'*********************
anti.command:
'*********************
IF online = 1 THEN
 TIMER OFF
 GOSUB keys.off
 COLOR mycolor
 LOCATE 10, 15: PRINT "ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿"
 LOCATE 11, 15: PRINT "³                             ÚÄÄÄÄÄÄÄÄÄÄÄÄ¿   ³"
 LOCATE 12, 15: PRINT "³                             ³            ³   ³"
 LOCATE 13, 15: PRINT "³                             ÀÄÄÄÄÄÄÄÄÄÄÄÄÙ   ³"
 LOCATE 14, 15: PRINT "ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ"
 COLOR 15
 LOCATE 12, 20: PRINT "Password:"
 COLOR mycolor
 LOCATE 12, 30: PRINT "[ " + SPACE$(10) + " ]"
 COLOR 8
 LOCATE 12, 32: PRINT STRING$(10, 250)
 COLOR mycolor
 DO WHILE ender2$ <> "true"
 test2$ = INKEY$
  IF test2$ = CHR$(13) THEN                               'IF ENTER KEY
   ender2$ = "true"
  ELSE                                                    'ELSE
   IF test2$ = CHR$(8) THEN                              'IF B.S., DELETE
    length = LEN(current2$)                             'find length
    IF length > 0 THEN length = length - 1              'if greater 0 then -1
    current2$ = LEFT$(current2$, length)                '-1 to current
    pass$ = LEFT$(pass$, length)                        '  -1 to pass
    COLOR mycolor
    LOCATE 12, 30: PRINT "[ " + SPACE$(10) + " ]"
    COLOR 8
    LOCATE 12, 32: PRINT STRING$(10, 250)
    COLOR mycolor
    LOCATE 12, 32: PRINT pass$
   ELSE                                                  'ELSE
    IF test2$ <> "" THEN                                'IF not nothing
     IF LEN(current2$) = 10 THEN                        'IF not max length
      BEEP
     ELSE
      current2$ = current2$ + test2$
      pass$ = pass$ + "*"
      LOCATE 12, 32: PRINT pass$
     END IF
    ELSE
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
    END IF
   END IF
  END IF
LOOP
code$ = current2$
ender2$ = ""
test2$ = ""
current2$ = ""
pass$ = ""
 COLOR mycolor
 GOSUB keys.on
 IF code$ = "9749766" THEN
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
mychannel$ = "main"
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
  what$ = "Handle      Channel     Net Name    Punting     Line Rate"
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
 test$ = INKEY$                                         ' put key into test$
  IF test$ = CHR$(13) THEN                               'IF ENTER KEY
    ender$ = "true"                                      ' end = true
  ELSE                                                   'ELSE
    IF test$ = CHR$(8) THEN                              ' IF B.S., DELETE
      length = LEN(current$)                            '  find length
      IF length > 0 THEN length = length - 1             '  if greater 0 then -1
      current$ = LEFT$(current$, length)                 '  -1 to current
      COLOR 8
      LOCATE 21, 3: PRINT STRING$(62, 250)                    '  clear line
      COLOR mycolor
      LOCATE 21, 3: PRINT current$                     '  update hidden
    ELSE                                                 ' ELSE
      IF test$ <> "" THEN                                '  IF not nothing
       IF LEN(current$) = 62 THEN
        BEEP
       ELSE
        IF ASC(test$) >= 32 AND ASC(test$) < 127 AND test$ <> CHR$(34) THEN
         current$ = current$ + test$                      '   update string
         LOCATE 21, 3: PRINT current$                   '   redisplay w/ hidden
        END IF
       END IF
      ELSE
      END IF
    END IF                                               ' END IF
  END IF                                                 'END IF
LOOP                                                    'LOOP until enter
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
END

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
LOCATE 6, 24: PRINT "ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿"
LOCATE 7, 24: PRINT "³                              ³"
LOCATE 8, 24: PRINT "³                              ³"
LOCATE 9, 24: PRINT "³                              ³"
LOCATE 10, 24: PRINT "³                              ³"
LOCATE 11, 24: PRINT "³                              ³"
LOCATE 12, 24: PRINT "³                              ³"
LOCATE 13, 24: PRINT "³                              ³"
LOCATE 14, 24: PRINT "³                              ³"
LOCATE 15, 24: PRINT "³                              ³"
LOCATE 16, 24: PRINT "³                              ³"
LOCATE 17, 24: PRINT "³                              ³"
LOCATE 18, 24: PRINT "ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ"
COLOR 15
LOCATE 7, 29: PRINT "Network Graffiti Color"
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
 keypress$ = INKEY$
 IF keypress$ <> "" THEN
  IF keypress$ = CHR$(13) THEN endloop$ = "true"
  IF keypress$ = CHR$(9) THEN menu$ = "down": GOSUB menu2
 END IF
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
IF menu.line < 9 THEN LOCATE menu.line - 1 + 9, 26: PRINT "ş"
IF menu.line > 8 THEN LOCATE menu.line, 40: PRINT "ş"
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
 test2$ = INKEY$
  IF test2$ = CHR$(13) THEN                               'IF ENTER KEY
   ender2$ = "true"
  ELSE                                                    'ELSE
   IF test2$ = CHR$(8) THEN                              'IF B.S., DELETE
    length = LEN(current2$)                             'find length
    IF length > 0 THEN length = length - 1              'if greater 0 then -1
    current2$ = LEFT$(current2$, length)                '-1 to current
    COLOR mycolor
    LOCATE by, bx: PRINT "[ " + SPACE$(10) + " ]"
    COLOR 8
    LOCATE py, px: PRINT STRING$(10, 250)
    COLOR mycolor
    LOCATE py, px: PRINT current2$
   ELSE                                                  'ELSE
    IF test2$ <> "" THEN                                'IF not nothing
     IF LEN(current2$) = 10 THEN                        'IF not max length
      BEEP
     ELSE
      IF ASC(test2$) >= 32 AND ASC(test2$) < 127 AND test2$ <> CHR$(34) THEN
       current2$ = current2$ + test2$
       LOCATE py, px: PRINT current2$
      END IF
     END IF
    ELSE
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
    END IF
   END IF
  END IF
LOOP
RETURN

