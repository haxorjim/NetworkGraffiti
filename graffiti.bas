'**********************
'*  Network Graffiti  *
'**********************
$Resize:Stretch
Cls
GoSub Initial.Settings
GoSub computer.name
GoSub draw.program
GoSub welcome.message
framecount = 0
ctrlDown = 0
Do
    k& = _KeyHit
    ctrlDown = _KeyDown(100305) Or _KeyDown(100306) ' Left or Right CTRL
    Select Case k&
        Case 15104: GoSub help.screen ' F1
        Case 108, 76: If ctrlDown Then GoSub logon.command ' CTRL+L
        Case 120, 88: If ctrlDown Then GoSub exit.chat ' CTRL+X
    End Select
    framecount = framecount + 1
    If framecount >= 30 Then ' Every ~0.5 sec at 60fps
        Color 8
        GoSub flashit
        framecount = 0
    End If
    _Limit 60
Loop
'just in case loop dies
Cls
End

'*********************
Initial.Settings:
'*********************
Randomize Timer
mycolor = Int(Rnd * 15) + 1 'Random Program Color
host.color = 7 'NWG HOST color setup
myrandom$ = Str$(Int(Rnd * 100000) + 1) 'Users Random Code

' Parse command line arguments
sharepath$ = ""
username$ = ""
showhelp = 0

If _CommandCount = 0 Then
    showhelp = 1
Else
    i = 1
    While i <= _CommandCount
        arg$ = Command$(i)
        Select Case arg$
            Case "--help", "-h"
                showhelp = 1
            Case "--share"
                If i + 1 <= _CommandCount Then
                    i = i + 1
                    sharepath$ = Command$(i)
                End If
            Case "--user"
                If i + 1 <= _CommandCount Then
                    i = i + 1
                    username$ = Command$(i)
                End If
        End Select
        i = i + 1
    Wend
End If

' Show help if requested or missing required args
If showhelp = 1 Or sharepath$ = "" Then
    Color 7
    Print "Network Graffiti"
    Print
    Print "Usage: graffiti --share <path> [options]"
    Print
    Print "Required:"
    Print "  --share <path>    Path to shared network directory"
    Print
    Print "Options:"
    Print "  --user <name>     Set chat nickname (skips login prompt)"
    Print "  --help, -h        Show this help message"
    Print
    Print "Example:"
    Print "  graffiti --share /mnt/network/chat"
    Print "  graffiti --share \\server\share"
    Print
    End
End If

' Detect path separator from share path
If InStr(sharepath$, "\") > 0 Then
    pathsep$ = "\"
Else
    pathsep$ = "/"
End If
filename$ = sharepath$ + pathsep$ + "chat.log"
normname$ = filename$
safefile$ = ""
Return

'*********************
computer.name:
'*********************
Shell _Hide "hostname > _hostname.tmp"
Open "_hostname.tmp" For Input As #99
Line Input #99, mycomputer$
Close #99
Kill "_hostname.tmp"
If mycomputer$ = "" Then mycomputer$ = "UNKNOWN"
Return

'*********************
welcome.message:
'*********************
Color host.color
s$ = "\         \ \                                                            \"
what$ = "        ____,wggggMMMM0MM@@@@@@@MMMMMM0Mgggyy,____"
Locate 6, 4: Print Using s$; "NWG HOST"; what$
what$ = "   __wmM#$$g#@MM@''`                    `''MMMMMMMMMMgy__"
Locate 7, 4: Print Using s$; "NWG HOST"; what$
what$ = "  y0@OwDMMMMMMM                               ^QMMMMMMMMMM0g"
Locate 8, 4: Print Using s$; "NWG HOST"; what$
what$ = "   #@g2$0MMMMMf                                 jMNEMMMMMMMM0"
Locate 9, 4: Print Using s$; "NWG HOST"; what$
what$ = "    '90#MMMMMMMg                             _jMM#0MMMMMMMM'"
Locate 10, 4: Print Using s$; "NWG HOST"; what$
what$ = "      `''9MMMMMm                    __,yM$ZW0MM@M''`"
Locate 11, 4: Print Using s$; "NWG HOST"; what$
what$ = "          ```^~        __ygMMMMMMMMMMMMMM'^^`              "
Locate 12, 4: Print Using s$; "NWG HOST"; what$
what$ = "                    jgQ#j&MMMMMM0Am,"
Locate 13, 4: Print Using s$; "NWG HOST"; what$
what$ = "                         ``````     "
Locate 14, 4: Print Using s$; "NWG HOST"; what$
what$ = "                       _,wawyywy_   "
Locate 15, 4: Print Using s$; "NWG HOST"; what$
what$ = "                       9NMMMMMM@M`"
Locate 16, 4: Print Using s$; "NWG HOST"; what$
what$ = "                        9NM2$M@M"
Locate 17, 4: Print Using s$; "NWG HOST"; what$
what$ = "                          ~'~~~'"
Locate 18, 4: Print Using s$; "NWG HOST"; what$
Color mycolor
Return

'*********************
draw.program:
'*********************
Cls
Color 7
Color 15
Locate 2, 3: Print "      __ ___        __  ____          __  ____  __  ___ ___   ___  "
Locate 3, 3: Print "#\ # #__  #  # # # #  # #__/ #_/     # __ #__/ #__# #_  #_  #  #  #"
Locate 4, 3: Print "# \# #__  #  #_#_# #__# #  \ # \     #__# #  \ #  # #   #   #  #  #"
Color mycolor
Locate 5, 2: Print Chr$(218); String$(76, 196); Chr$(191)
For y = 6 To 18
    Locate y, 2: Print Chr$(179); Spc(76); Chr$(179)
Next y
Locate 19, 2: Print Chr$(192); String$(76, 196); Chr$(217)
Locate 20, 2: Print Chr$(218); String$(62, 196); Chr$(191)
Locate 21, 2: Print Chr$(179)
Color 8
Locate 21, 3: Print String$(62, 250)
Color mycolor
Locate 21, 65: Print Chr$(179)
Locate 22, 2: Print Chr$(192); String$(62, 196); Chr$(217)
Locate 20, 66: Print Chr$(218); String$(12, 196); Chr$(191)
Locate 21, 66: Print Chr$(179); Space$(12); Chr$(179)
Locate 22, 66: Print Chr$(192); String$(12, 196); Chr$(217)
Color 7
If hack = 0 Then
    Locate 23, 30: Print "[Normal Mode]"
Else
    Locate 23, 30: Print "[Anti-Hack Mode]"
End If
If online <> 1 Then Locate 23, 3: Print "NOT CONNECTED"
Locate 23, 48: Print "[ F1: Help ] [ CTRL + X: Exit ]"
Color mycolor
Return

'*********************
help.screen:
'*********************
Timer Off
Color mycolor
Locate 3, 6: Print Chr$(218); String$(68, 196); Chr$(191)
For h = 4 To 22
    Locate h, 6: Print Chr$(179); Space$(68); Chr$(179)
Next h
Color 15
Locate 5, 10: Print "                 NETWORK GRAFFITI HELP SCREEN"
Color 7
Locate 7, 10: Print "CTRL + L           Connect to Network Graffiti"
Locate 8, 10: Print "CTRL + N           Change your Alias while Connected"
Locate 9, 10: Print "CTRL + A           Enter the Anti-Punt Password [ANTI]"
Locate 10, 10: Print "CTRL + P           Punts an Unprotected User out of NWG"
Locate 11, 10: Print "CTRL + C           Changes Network Graffiti User Color"
Locate 12, 10: Print "CTRL + G           Joins a Channel [Default: #MAIN]"
Locate 13, 10: Print "CTRL + X           Exits Network Graffiti"
Locate 14, 10: Print "CTRL + W           Lists Connected Users and Details"
Locate 15, 10: Print "CTRL + H           Switches to [Anti-Hack Mode]"
Locate 17, 10: Print "F1                 Displays this Help Screen"
Color 15
Locate 21, 10: Print "        NWG - Copyright (C)1999-"; Right$(Date$, 4); " haxorjim"
Color mycolor
Locate 23, 6: Print Chr$(192); String$(68, 196); Chr$(217)
Do: _Limit 60: k& = _KeyHit: Loop Until k& > 0 ' Wait for new keypress (ignore releases)
Timer On
GoSub draw.program
If online <> 1 Then GoSub welcome.message
Return

'*********************
channel.message:
'*********************
Open filename$ For Append Shared As #1
what$ = ""
Write #1, what$, "NWG HOST", host.color, mychannel$, myrandom$
what$ = ""
Write #1, what$, "NWG HOST", host.color, mychannel$, myrandom$
what$ = "      ^\/^"
Write #1, what$, "NWG HOST", host.color, mychannel$, myrandom$
what$ = "      (Oo)"
Write #1, what$, "NWG HOST", host.color, mychannel$, myrandom$
what$ = "       ()                  Welcome to the "
Write #1, what$, "NWG HOST", host.color, mychannel$, myrandom$
what$ = "    oOO__OOo          Network Graffiti Chat Room!"
Write #1, what$, "NWG HOST", host.color, mychannel$, myrandom$
what$ = "     \/\/\/"
Write #1, what$, "NWG HOST", host.color, mychannel$, myrandom$
what$ = "      \/\/            Channel: #" + mychannel$
Write #1, what$, "NWG HOST", host.color, mychannel$, myrandom$
what$ = "       ~~"
Write #1, what$, "NWG HOST", host.color, mychannel$, myrandom$
what$ = "       ||"
Write #1, what$, "NWG HOST", host.color, mychannel$, myrandom$
what$ = "<>=-=-/__\=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=<>"
Write #1, what$, "NWG HOST", host.color, mychannel$, myrandom$
what$ = ""
Write #1, what$, "NWG HOST", host.color, mychannel$, myrandom$
what$ = ""
Write #1, what$, "NWG HOST", host.color, mychannel$, myrandom$
Close #1
Return

'*********************
logon.command:
'*********************
' Use --user if provided, otherwise prompt
If username$ <> "" Then
    myclient$ = username$
Else
    Color mycolor
    Locate 10, 15: Print Chr$(218); String$(44, 196); Chr$(191)
    Locate 11, 15: Print Chr$(179); Space$(29); Chr$(218); String$(12, 196); Chr$(191); Space$(1); Chr$(179)
    Locate 12, 15: Print Chr$(179); Space$(29); Chr$(179); Space$(12); Chr$(179); Space$(1); Chr$(179)
    Locate 13, 15: Print Chr$(179); Space$(29); Chr$(192); String$(12, 196); Chr$(217); Space$(1); Chr$(179)
    Locate 14, 15: Print Chr$(192); String$(44, 196); Chr$(217)
    Color 15
    Locate 12, 20: Print "Handle:"
    Color mycolor
    Locate 12, 29: Print "[ " + Space$(10) + " ]"
    Color 8
    Locate 12, 31: Print String$(10, 250)
    Color mycolor
    fy = 12: fx = 47
    py = 12: px = 31
    by = 12: bx = 29
    GoSub input.prompts
    myclient$ = current2$
    ender2$ = ""
    test2$ = ""
    current2$ = ""
End If
If myclient$ <> "" And myclient$ <> " " Then
    online = 1
    mylevel$ = "VULNERABLE"
    GoSub join.channel
    GoTo message.loop
Else
    GoSub draw.program
    GoSub welcome.message
End If
Return

'*********************
rename.command:
'*********************
If online = 1 Then
    Timer Off
    Color mycolor
    Locate 10, 15: Print Chr$(218); String$(44, 196); Chr$(191)
    Locate 11, 15: Print Chr$(179); Space$(29); Chr$(218); String$(12, 196); Chr$(191); Space$(1); Chr$(179)
    Locate 12, 15: Print Chr$(179); Space$(29); Chr$(179); Space$(12); Chr$(179); Space$(1); Chr$(179)
    Locate 13, 15: Print Chr$(179); Space$(29); Chr$(192); String$(12, 196); Chr$(217); Space$(1); Chr$(179)
    Locate 14, 15: Print Chr$(192); String$(44, 196); Chr$(217)
    Color 15
    Locate 12, 20: Print "Handle:"
    Color mycolor
    Locate 12, 29: Print "[ " + Space$(10) + " ]"
    Color 8
    Locate 12, 31: Print String$(10, 250)
    Color mycolor
    fy = 12: fx = 47
    py = 12: px = 31
    by = 12: bx = 29
    GoSub input.prompts
    myclient2$ = current2$
    ender2$ = ""
    test2$ = ""
    current2$ = ""
    Timer On
    If myclient2$ <> "" And myclient2$ <> " " Then
        myclient.old$ = myclient$
        write.rename.message = 1
        myclient$ = myclient2$
    Else
        GoSub draw.program
    End If
End If
Return

'*********************
hack.command:
'*********************
If safefile$ = "" Then
    Beep
    Return
End If
If hack <> 1 Then
    filename$ = safefile$
    Open filename$ For Append Shared As #1
    For i = 1 To 6
        Write #1, "", "NWG HOST", host.color, mychannel$, myrandom$
    Next i
    what$ = "             [Anti-Hack Mode] has been enabled"
    Write #1, what$, "NWG HOST", host.color, mychannel$, myrandom$
    For i = 1 To 6
        Write #1, "", "NWG HOST", host.color, mychannel$, myrandom$
    Next i
    Close #1
    hack = 1
    GoSub draw.program
    If online <> 1 Then GoSub welcome.message
Else
    filename$ = normname$
    hack = 0
    GoSub draw.program
    If online <> 1 Then GoSub welcome.message
End If
Return

'*********************
join.command:
'*********************
If online = 1 Then
    Timer Off
    mychannel.old$ = mychannel$
    Color mycolor
    Locate 10, 15: Print Chr$(218); String$(44, 196); Chr$(191)
    Locate 11, 15: Print Chr$(179); Space$(29); Chr$(218); String$(12, 196); Chr$(191); Space$(1); Chr$(179)
    Locate 12, 15: Print Chr$(179); Space$(29); Chr$(179); Space$(12); Chr$(179); Space$(1); Chr$(179)
    Locate 13, 15: Print Chr$(179); Space$(29); Chr$(192); String$(12, 196); Chr$(217); Space$(1); Chr$(179)
    Locate 14, 15: Print Chr$(192); String$(44, 196); Chr$(217)
    Color 15
    Locate 12, 20: Print "Channel:"
    Color mycolor
    Locate 12, 30: Print "[ " + Space$(10) + " ]"
    Color 8
    Locate 12, 32: Print String$(10, 250)
    Color mycolor
    fy = 12: fx = 47
    py = 12: px = 32
    by = 12: bx = 30
    GoSub input.prompts
    mychannel$ = current2$
    ender2$ = ""
    test2$ = ""
    current2$ = ""
    Timer On
    If mychannel$ <> "" Then
        write.join.message = 1
    Else
        mychannel$ = mychannel.old$
    End If
End If
Return

'*********************
who.command:
'*********************
If online = 1 Then
    write.who.messages = 1
End If
Return

'*********************
punt.command:
'*********************
If online = 1 Then
    Timer Off
    mychannel.old$ = mychannel$
    Color mycolor
    Locate 10, 15: Print Chr$(218); String$(44, 196); Chr$(191)
    Locate 11, 15: Print Chr$(179); Space$(29); Chr$(218); String$(12, 196); Chr$(191); Space$(1); Chr$(179)
    Locate 12, 15: Print Chr$(179); Space$(29); Chr$(179); Space$(12); Chr$(179); Space$(1); Chr$(179)
    Locate 13, 15: Print Chr$(179); Space$(29); Chr$(192); String$(12, 196); Chr$(217); Space$(1); Chr$(179)
    Locate 14, 15: Print Chr$(192); String$(44, 196); Chr$(217)
    Color 15
    Locate 12, 20: Print "Punt:"
    Color mycolor
    Locate 12, 30: Print "[ " + Space$(10) + " ]"
    Color 8
    Locate 12, 32: Print String$(10, 250)
    Color mycolor
    fy = 12: fx = 47
    py = 12: px = 32
    by = 12: bx = 30
    GoSub input.prompts
    them$ = current2$
    ender2$ = ""
    test2$ = ""
    current2$ = ""
    Timer On
    If them$ <> "" Then
        write.punt.message = 1
    End If
End If
Return

'*********************
anti.command:
'*********************
If online = 1 Then
    Timer Off
    Color mycolor
    Locate 10, 15: Print Chr$(218); String$(44, 196); Chr$(191)
    Locate 11, 15: Print Chr$(179); Space$(29); Chr$(218); String$(12, 196); Chr$(191); Space$(1); Chr$(179)
    Locate 12, 15: Print Chr$(179); Space$(29); Chr$(179); Space$(12); Chr$(179); Space$(1); Chr$(179)
    Locate 13, 15: Print Chr$(179); Space$(29); Chr$(192); String$(12, 196); Chr$(217); Space$(1); Chr$(179)
    Locate 14, 15: Print Chr$(192); String$(44, 196); Chr$(217)
    Color 15
    Locate 12, 20: Print "Password:"
    Color mycolor
    Locate 12, 30: Print "[ " + Space$(10) + " ]"
    Color 8
    Locate 12, 32: Print String$(10, 250)
    Color mycolor
    Do While ender2$ <> "true"
        k& = _KeyHit
        Select Case k&
            Case 13 ' ENTER
                ender2$ = "true"
            Case 8 ' BACKSPACE
                length = Len(current2$)
                If length > 0 Then length = length - 1
                current2$ = Left$(current2$, length)
                pass$ = Left$(pass$, length)
                Color mycolor
                Locate 12, 30: Print "[ " + Space$(10) + " ]"
                Color 8
                Locate 12, 32: Print String$(10, 250)
                Color mycolor
                Locate 12, 32: Print pass$
            Case 32 To 126 ' Printable ASCII
                If Len(current2$) = 10 Then
                    Beep
                Else
                    current2$ = current2$ + Chr$(k&)
                    pass$ = pass$ + "*"
                    Locate 12, 32: Print pass$
                End If
            Case 0 ' No key pressed
                p1 = p1 + 2
                If p1 >= 10 Then
                    p1 = 0
                    cool1$ = Chr$(177)
                    Locate 12, 47: Print Space$(10)
                Else
                    cool1$ = cool1$ + Chr$(177) + Chr$(177)
                End If
                Color 8
                Locate 12, 47: Print cool1$
                Color mycolor
                _Limit 60
        End Select
    Loop
    code$ = current2$
    ender2$ = ""
    test2$ = ""
    current2$ = ""
    pass$ = ""
    Color mycolor
    If UCase$(code$) = "IDDQD" Then
        super.access = 1
        mylevel$ = "INVINCIBLE"
        spunts$ = "off"
        punts$ = "off"
        Do While Val(num$) < 10
            num$ = Right$(Str$(Int(Rnd * 19) + 1), 2)
        Loop
        mycomputer$ = "ET2898-" + num$
    ElseIf UCase$(code$) = "ANTI" Then
        mylevel$ = "PROTECTED"
        punts$ = "off"
    End If
    Timer On
End If
Return

'*********************
join.channel:
'*********************
Timer On
On Timer(1) GoSub time.loop
mychannel$ = "MAIN"
GoSub channel.message
Open filename$ For Append Shared As #1
a$ = myclient$ + " just entered the chat room..."
Write #1, a$, "NWG HOST", host.color, mychannel$, "not" + myrandom$
a$ = ""
Close #1
Return

'*********************
message.loop:
'*********************
Do
    GoSub input.message
    If say$ = "" Or say$ = " " Then
        Beep
    Else
        mycount = mycount + 1
        write.say.message = 1
    End If
    Message$ = ""
    current$ = ""
    test$ = ""
    ender$ = "false"
Loop

'*********************
chat.log.loop:
'*********************
If write.rename.message = 1 Then GoSub write.rename
If write.join.message = 1 Then GoSub write.join
If write.punt.message = 1 Then GoSub write.punt
If write.who.messages = 1 Then GoSub write.who
If write.say.message = 1 Then GoSub write.say
Open filename$ For Input Shared As #255
Do While Not EOF(255)
    Input #255, what$, Client$, ccolor, channel$, who$
    GoSub Message.Display
    GoSub Who.asked
Loop
Close #255
GoSub print.buffer
If punts$ <> "off" And who$ = "punt" + myclient$ Then GoTo punt.Em
If spunts$ <> "off" And who$ = "spunt" + myclient$ Then GoTo punt.Em
GoSub who.response
Return

'*********************
write.rename:
'*********************
Open filename$ For Append Shared As #1
what$ = "[ " + myclient.old$ + " ] changed their name to [ " + myclient$ + " ]"
Write #1, what$, "NWG HOST", host.color, mychannel$, "not" + myrandom$
Close #1
write.rename.message = 0
Return

'*********************
write.join:
'*********************
Open filename$ For Append Shared As #1
what$ = myclient$ + " left #" + mychannel.old$
Write #1, what$, "NWG HOST", host.color, mychannel.old$, "not" + myrandom$
what$ = myclient$ + " entered #" + mychannel$
Write #1, what$, "NWG HOST", host.color, mychannel$, "not" + myrandom$
Close #1
GoSub channel.message
write.join.message = 0
Return

'*********************
write.punt:
'*********************
Open filename$ For Append Shared As #1
If super.access = 1 Then
    Write #1, "", "NWG HOST", 6, mychannel$, "spunt" + them$
Else
    Write #1, "", "NWG HOST", 6, mychannel$, "punt" + them$
End If
Close #1
write.punt.message = 0
Return

'*********************
write.who:
'*********************
If who.n = 0 Then
    Open filename$ For Append Shared As #1
    Write #1, "", myrandom$, 0, mychannel$, "who"
    what$ = "Handle      Channel     Computer    Punting     Line Rate"
    Write #1, what$, "NWG HOST", host.color, mychannel$, myrandom$
    l$ = String$(10, 196)
    what$ = l$ + Space$(2) + l$ + Space$(2) + l$ + Space$(2) + l$ + Space$(2) + l$
    Write #1, what$, "NWG HOST", host.color, mychannel$, myrandom$
    l = 12 - Len(myclient$)
    l2 = 11 - Len(mychannel$)
    l3 = 12 - Len(mycomputer$)
    l4 = 13 - Len(mylevel$)
    what$ = myclient$ + Space$(l) + "#" + mychannel$ + Space$(l2) + mycomputer$ + Space$(l3) + mylevel$ + Space$(l4) + mympm$
    Write #1, what$, "NWG HOST", host.color, mychannel$, myrandom$
    Close #1
    who.n = 1
Else
    Open filename$ For Append Shared As #1
    Write #1, "", myrandom$, 0, mychannel$, "thanks"
    Close #1
    who.n = 0
    write.who.messages = 0
End If
Return

'*********************
write.say:
'*********************
Open filename$ For Append Shared As #1
Write #1, say$, myclient$, mycolor, mychannel$, "all"
Close #1
write.say.message = 0
Return

'*********************
Message.Display:
'*********************
If channel$ = mychannel$ Or channel$ = "all" Then
    If Left$(who$, 3) = "not" Then
        If Mid$(who$, 4) <> myrandom$ Then GoSub Create.Buffer
    End If
    If who$ = myrandom$ Then GoSub Create.Buffer
    If who$ = "all" Then GoSub Create.Buffer
End If
Return

'*********************
who.response:
'*********************
If tell = 1 Then
    Open filename$ For Append Shared As #1
    l = 12 - Len(myclient$)
    l2 = 11 - Len(mychannel$)
    l3 = 12 - Len(mycomputer$)
    l4 = 13 - Len(mylevel$)
    what$ = myclient$ + Space$(l) + "#" + mychannel$ + Space$(l2) + mycomputer$ + Space$(l3) + mylevel$ + Space$(l4) + mympm$
    Write #1, what$, "NWG HOST", host.color, tell.channel$, tell.who$
    Close #1
    tell = 0
    tell.who$ = ""
    tell.channel$ = ""
End If
Return

'*********************
Who.asked:
'*********************
If who$ = "who" Then
    tell = 1
    tell.who$ = Client$
    tell.channel$ = channel$
End If
l = 12 - Len(myclient$)
l2 = 11 - Len(mychannel$)
l3 = 12 - Len(mycomputer$)
l4 = 13 - Len(mylevel$)
this$ = myclient$ + Space$(l) + "#" + mychannel$ + Space$(l2) + mycomputer$ + Space$(l3) + mylevel$ + Space$(l4) + mympm$
If who$ = "thanks" Or what$ = this$ Then
    tell = 0
    tell.who$ = ""
    tell.channel$ = ""
End If
Return

'*********************
input.message:
'*********************
Do While ender$ <> "true" ' if not end go
    k& = _KeyHit
    ctrlDown = _KeyDown(100305) Or _KeyDown(100306) ' Left or Right CTRL
    Select Case k&
        Case 15104: GoSub help.screen: GoTo input.msg.resume ' F1
        Case 97, 65 ' A
            If ctrlDown Then GoSub anti.command: GoTo input.msg.resume Else GoTo type.char
        Case 110, 78 ' N
            If ctrlDown Then GoSub rename.command: GoTo input.msg.resume Else GoTo type.char
        Case 104, 72 ' H
            If ctrlDown Then GoSub hack.command: GoTo input.msg.resume Else GoTo type.char
        Case 120, 88 ' X
            If ctrlDown Then GoSub exit.chat Else GoTo type.char
        Case 119, 87 ' W
            If ctrlDown Then GoSub who.command: GoTo input.msg.resume Else GoTo type.char
        Case 99, 67 ' C
            If ctrlDown Then GoSub Change.Color: GoTo input.msg.resume Else GoTo type.char
        Case 103, 71 ' G (join/Go to channel)
            If ctrlDown Then GoSub join.command: GoTo input.msg.resume Else GoTo type.char
        Case 112, 80 ' P
            If ctrlDown Then GoSub punt.command: GoTo input.msg.resume Else GoTo type.char
        Case 8 ' BACKSPACE
            If Len(current$) > 0 Then
                current$ = Left$(current$, Len(current$) - 1)
                Color 8: Locate 21, 3: Print String$(62, 250)
                Color mycolor: Locate 21, 3: Print current$
            End If
        Case 13 ' ENTER
            ender$ = "true"
        Case 32 To 126 ' Printable ASCII
            type.char:
            If ctrlDown = 0 Then ' Only if CTRL not held
                If k& <> 34 Then ' Not quote char
                    If Len(current$) < 62 Then
                        current$ = current$ + Chr$(k&)
                        Locate 21, 3: Print current$
                    Else
                        Beep
                    End If
                End If
            End If
        Case 0 ' No key pressed
            _Limit 60
    End Select
Loop 'LOOP until enter
GoTo input.msg.done
input.msg.resume:
Locate 21, 3: Print current$ ' Redisplay after handler
GoTo input.message
input.msg.done:
say$ = current$
Color 8
Locate 21, 3: Print String$(62, 250)
Color mycolor
Return

'*********************
flashit:
'*********************
p = p + 2
If p >= 10 Then
    p = 0
    cool$ = Chr$(177)
    Locate 21, 68: Print Space$(10)
Else
    cool$ = cool$ + Chr$(177) + Chr$(177)
End If
Locate 21, 68: Print cool$
Return

'*********************
exit.chat:
'*********************
If online = 1 Then
    On Error GoTo 0
    Timer Off
    Sleep 1
    Close
    Open filename$ For Append Shared As #1
    Message$ = myclient$ + " left the chat room..."
    Write #1, Message$, "NWG HOST", host.color, mychannel$, "not" + myrandom$
    Close #1
End If
Color 7
Cls
System

'*********************
punt.Em:
'*********************
Timer Off
Open filename$ For Append Shared As #1
what$ = myclient$ + " was kicked out of the chat room..."
Write #1, what$, "NWG HOST", host.color, mychannel$, "not" + myrandom$
Close #1
what$ = "You've been kicked out of the chat room..."
Client$ = "NWG HOST"
ccolor = host.color
GoSub Create.Buffer
GoSub print.buffer
End

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
Return

'*********************
print.buffer:
'*********************
s$ = "\         \ \                                                            \"
Color buffer13c
Locate 6, 4: Print Using s$; buffer13n$; buffer13$
Color buffer12c
Locate 7, 4: Print Using s$; buffer12n$; buffer12$
Color buffer11c
Locate 8, 4: Print Using s$; buffer11n$; buffer11$
Color buffer10c
Locate 9, 4: Print Using s$; buffer10n$; buffer10$
Color buffer9c
Locate 10, 4: Print Using s$; buffer9n$; buffer9$
Color buffer8c
Locate 11, 4: Print Using s$; buffer8n$; buffer8$
Color buffer7c
Locate 12, 4: Print Using s$; buffer7n$; buffer7$
Color buffer6c
Locate 13, 4: Print Using s$; buffer6n$; buffer6$
Color buffer5c
Locate 14, 4: Print Using s$; buffer5n$; buffer5$
Color buffer4c
Locate 15, 4: Print Using s$; buffer4n$; buffer4$
Color buffer3c
Locate 16, 4: Print Using s$; buffer3n$; buffer3$
Color buffer2c
Locate 17, 4: Print Using s$; buffer2n$; buffer2$
Color buffer1c
Locate 18, 4: Print Using s$; buffer1n$; buffer1$
Color mycolor
Return

'********************
Change.Color:
'********************
Timer Off
GoSub draw.menu
GoSub menu.loop
GoSub draw.program
If online <> 1 Then GoSub welcome.message
Timer On
Return

'********************
draw.menu:
'********************
Color mycolor
Locate 6, 24: Print Chr$(218); String$(30, 196); Chr$(191)
For m = 7 To 18
    Locate m, 24: Print Chr$(179); Space$(30); Chr$(179)
Next m
Locate 19, 24: Print Chr$(192); String$(30, 196); Chr$(217)
Color 15
Locate 7, 29: Print "Network Graffiti Color"
Locate 18, 26: Print "[TAB] Choose, [ENTER] Select"
Color 7
Locate 9, 27: Print "Dark Blue"
Locate 10, 27: Print "Dark Green"
Locate 11, 27: Print "Dark Cyan"
Locate 12, 27: Print "Dark Red"
Locate 13, 27: Print "Magenta"
Locate 14, 27: Print "Brown"
Locate 15, 27: Print "Dark White"
Locate 16, 27: Print "Gray"
Locate 9, 41: Print "Bright Blue"
Locate 10, 41: Print "Bright Green"
Locate 11, 41: Print "Bright Cyan"
Locate 12, 41: Print "Bright Red"
Locate 13, 41: Print "Pink"
Locate 14, 41: Print "Yellow"
Locate 15, 41: Print "Bright White"
Return

'****************
menu.loop:
'****************
menu.line = mycolor
Color menu.line, 0
GoSub menu.lines
Color 7, 0
Do While endloop$ <> "true"
    k& = _KeyHit
    Select Case k&
        Case 13: endloop$ = "true" ' ENTER
        Case 9: menu$ = "down": GoSub menu2 ' TAB
        Case 25: menu$ = "up": GoSub menu2 ' SHIFT+TAB
        Case 20480, 18432 ' DOWN, UP arrows
            If k& = 20480 Then menu$ = "down" Else menu$ = "up"
            GoSub menu2
        Case 19712, 19200 ' RIGHT, LEFT arrows
            If k& = 19712 Then
                If menu.line <= 7 Then menu.line = menu.line + 8: GoSub draw.menu: Color menu.line, 0: GoSub menu.lines
            Else
                If menu.line >= 9 Then menu.line = menu.line - 8: GoSub draw.menu: Color menu.line, 0: GoSub menu.lines
            End If
    End Select
    _Limit 60
Loop
endloop$ = ""
kepress$ = ""
If menu.line = 1 Then mycolor = 1
If menu.line = 2 Then mycolor = 2
If menu.line = 3 Then mycolor = 3
If menu.line = 4 Then mycolor = 4
If menu.line = 5 Then mycolor = 5
If menu.line = 6 Then mycolor = 6
If menu.line = 7 Then mycolor = 7
If menu.line = 8 Then mycolor = 8
If menu.line = 9 Then mycolor = 9
If menu.line = 10 Then mycolor = 10
If menu.line = 11 Then mycolor = 11
If menu.line = 12 Then mycolor = 12
If menu.line = 13 Then mycolor = 13
If menu.line = 14 Then mycolor = 14
If menu.line = 15 Then mycolor = 15
Return

'****************
menu2:
'****************
GoSub draw.menu
If menu$ = "down" Then
    menu.line = menu.line + 1
    If menu.line >= 16 Then menu.line = 1
ElseIf menu$ = "up" Then
    menu.line = menu.line - 1
    If menu.line <= 0 Then menu.line = 15
End If
Color menu.line, 0
GoSub menu.lines
Return

'****************
menu.lines:
'****************
If menu.line < 9 Then Locate menu.line - 1 + 9, 26: Print Chr$(16)
If menu.line > 8 Then Locate menu.line, 40: Print Chr$(16)
If menu.line = 1 Then Locate 9, 27: Print "Dark Blue"
If menu.line = 2 Then Locate 10, 27: Print "Dark Green"
If menu.line = 3 Then Locate 11, 27: Print "Dark Cyan"
If menu.line = 4 Then Locate 12, 27: Print "Dark Red"
If menu.line = 5 Then Locate 13, 27: Print "Magenta"
If menu.line = 6 Then Locate 14, 27: Print "Brown"
If menu.line = 7 Then Locate 15, 27: Print "Dark White"
If menu.line = 8 Then Locate 16, 27: Print "Gray"
If menu.line = 9 Then Locate 9, 41: Print "Bright Blue"
If menu.line = 10 Then Locate 10, 41: Print "Bright Green"
If menu.line = 11 Then Locate 11, 41: Print "Bright Cyan"
If menu.line = 12 Then Locate 12, 41: Print "Bright Red"
If menu.line = 13 Then Locate 13, 41: Print "Pink"
If menu.line = 14 Then Locate 14, 41: Print "Yellow"
If menu.line = 15 Then Locate 15, 41: Print "Bright White"
Color 7, 0
Return

'*********************
time.loop:
'*********************
time = time + 1
minutes = Int(time / 60)
seconds = Int(time - (60 * minutes))
Color 7, 0
Locate 1, 3: Print Space$(70)
If minutes = 0 Then
    Locate 1, 3: Print "Connected for"; seconds; "seconds(s)"
Else
    Locate 1, 3: Print "Connected for"; minutes; "minute(s),"; seconds; "seconds(s)"
End If
T$ = Time$
Hr = Val(T$)
If Hr < 12 Then Ampm$ = " AM" Else Ampm$ = " PM"
If Hr > 12 Then Hr = Hr - 12
Locate 1, 68: Print Str$(Hr); Right$(T$, 6); Ampm$
If mycount <> 0 Then
    If minutes = 0 Then
        per = Int((mycount / seconds) * 60)
    Else
        per = Int((mycount / time) * 60)
    End If
Else
    per = 0
End If
mympm1$ = Str$(per) + " Messages Per Minute   "
mympm$ = Str$(per) + " MPM"
Locate 23, 2: Print mympm1$
Color 8
GoSub flashit
Color mycolor, 0
GoSub chat.log.loop
Return

'****************
input.prompts:
'****************
Do While ender2$ <> "true"
    k& = _KeyHit
    Select Case k&
        Case 13 ' ENTER
            ender2$ = "true"
        Case 8 ' BACKSPACE
            If Len(current2$) > 0 Then
                current2$ = Left$(current2$, Len(current2$) - 1)
                Color mycolor
                Locate by, bx: Print "[ " + Space$(10) + " ]"
                Color 8
                Locate py, px: Print String$(10, 250)
                Color mycolor
                Locate py, px: Print current2$
            End If
        Case 32 To 126 ' Printable ASCII
            If k& <> 34 Then ' Not quote char
                If Len(current2$) < 10 Then
                    current2$ = current2$ + Chr$(k&)
                    Locate py, px: Print current2$
                Else
                    Beep
                End If
            End If
        Case 0 ' No key pressed
            p1 = p1 + 2
            If p1 >= 10 Then
                p1 = 0
                cool1$ = Chr$(177)
                Locate fy, fx: Print Space$(10)
            Else
                cool1$ = cool1$ + Chr$(177) + Chr$(177)
            End If
            Color 8
            Locate fy, fx: Print cool1$
            Color mycolor
            _Limit 60
    End Select
Loop
Return

