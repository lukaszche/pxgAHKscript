;PBPosX = 	1103
;PBPosY = 	358
;POPosX = 	960
;POPosY = 	210
ReviveKey =	F12
UPotKey =	F11
AutoRevive:=0
WSADBool:=0

IniRead, PBPosX, settings.ini,section1, PBX
IniRead, PBPosY, settings.ini,section1, PBY
IniRead, POPosX, settings.ini,section1, POX 
IniRead, POPosY, settings.ini,section1, POY 
IniRead, SCRX, settings.ini,section1, SCRX
IniRead, SCRY, settings.ini,section1, SCRY
IniRead, SCRX1, settings.ini,section1, SCRX1e
IniRead, SCRY1, settings.ini,section1, SCRY1

;================================================GUIGUI
Gui, Show , w501 h250, PokeHaxy
Gui, Add, Button, x1 y1 w100 h50 vFIRSTBUTTON gSTARTHAXY,Start
Gui, Add, Button, x101 y1 w100 h50 vWSADBUTTON gWSADFunc, WSAD
Gui, Add, Button, x201 y1 w100 h50 vAREVBUTTON gARevFunc, AutoRevive
Gui, Add, Button, x301 y1 w100 h50 vBLANK1BUTTON , 
Gui, Add, Button, x401 y1 w100 h50 vBLANK2BUTTON , 
Gui, Add, Text, x20 y62 w150 h20 cRed vAutoRevive, AUTO REVIVE DISABLED
Gui, Add, Text, x20 y92 w150 h20 cRed vWSADText, WSAD DISABLED
Gui, Color, Silver


return
;================================================GUIGUI

;=========================================================================================================================

;================================================================================================================================================
STARTHAXY:
{
	WinActivate, PXG Client
CoordMode Pixel
ImageSearch, FoundX,  FoundY, 0, 0, A_ScreenWidth, A_ScreenHeight, *45 revive.bmp
if ErrorLevel = 2
    MsgBox Could not conduct the search.
else if ErrorLevel = 1
    MsgBox PokemonStatusBox could not be found on the screen.
else{
    MsgBox The icon was found at %FoundX%x%FoundY%.
    MouseClick, right,  FoundX-130,  FoundY+20
	a:=130
	b:=20
	POPosX:=FoundX-a
	POPosY:=FoundY+b
    IniWrite, %POPosX%, settings.ini,section1, POX 
    IniWrite, %POPosY%, settings.ini,section1, POY 
	
}

ImageSearch, FoundBtX,  FoundBtY, 0, 0, A_ScreenWidth, A_ScreenHeight, *70 battle.bmp
if ErrorLevel = 2
    MsgBox Could not conduct the search.
else if ErrorLevel = 1
    MsgBox BattleList could not be found on the screen.
else{
    MsgBox The icon was found at %FoundBtX%x%FoundBtY%.
    MouseClick, right,  FoundBtX+165,  FoundBtY+40
	a:=165
	b:=40
	PBPosX:=FoundBtX+a
	PBPosY:=FoundBtY+b
    IniWrite, %PBPosX%, settings.ini,section1, PBX 
    IniWrite, %PBPosY%, settings.ini,section1, PBY 
}
return
}
;================================================================================================================================================
WSADFunc:
{
if WSADBool=0
{
	GuiControl, +c008000, WSADText
	GuiControl,, WSADText, WSAD ENABLED
     	WSADBool:=1
}
else
{
	GuiControl, +cRed, WSADText
	GuiControl,, WSADText, WSAD DISABLED
    	WSADBool:=0
}
return
}


;================================================================================================================================================
GuiClose: 
ExitApp
;================================================GUIGUI



*d::
if WSADBool=1
	{
		SetKeyDelay -1   ; If the destination key is a mouse button, SetMouseDelay is used instead.
		Send {Blind}{Right DownTemp}  ; DownTemp is like Down except that other Send commands in the script won't assume "b" should stay down during their Send.
	}
else if WSADBool=0
		SendInput d

return

*d up::
SetKeyDelay -1  ; See note below for why press-duration is not specified with either of these SetKeyDelays.
Send {Blind}{Right Up}
return


*a::
if WSADBool=1
	{
		SetKeyDelay -1   ; If the destination key is a mouse button, SetMouseDelay is used instead.
		Send {Blind}{Left DownTemp}  ; DownTemp is like Down except that other Send commands in the script won't assume "b" should stay down during their Send.
	}
else if WSADBool=0
		SendInput a

return

*a up::
SetKeyDelay -1  ; See note below for why press-duration is not specified with either of these SetKeyDelays.
Send {Blind}{Left Up}
return

*s::
if WSADBool=1
	{
		SetKeyDelay -1   ; If the destination key is a mouse button, SetMouseDelay is used instead.
		Send {Blind}{Down DownTemp}  ; DownTemp is like Down except that other Send commands in the script won't assume "b" should stay down during their Send.
	}
else if WSADBool=0
		SendInput s

return

*s up::
SetKeyDelay -1  ; See note below for why press-duration is not specified with either of these SetKeyDelays.
Send {Blind}{Down Up}
return

*w::
if WSADBool=1
	{
		SetKeyDelay -1   ; If the destination key is a mouse button, SetMouseDelay is used instead.
		Send {Blind}{Up DownTemp}  ; DownTemp is like Down except that other Send commands in the script won't assume "b" should stay down during their Send.
	}
else if WSADBool=0
		SendInput w

return

*w up::
SetKeyDelay -1  ; See note below for why press-duration is not specified with either of these SetKeyDelays.
Send {Blind}{Up Up}
return

:*:s::{Down}
:*:a::{Left}
:*:d::{Right}


NumpadDown::
;MouseClick, right,  999,  213
SendInput, {%ReviveKey%}
Sleep, 100
MouseClick, left,  POPosX,  POPosY
Sleep, 180
MouseClick, right,  POPosX,  POPosY
return


$z::
MouseClick, right,  POPosX,  POPosY
Sleep, 320
SendInput, {%ReviveKey%}
;Sleep, 150
MouseClick, left,  POPosX,  POPosY
Sleep, 200
MouseClick, right,  POPosX,  POPosY
return

NumpadDel::
SendInput, {%UPotKey%}
MsgBox
MouseClick, left,  PBPosX-50,  PBPosY
return

^u::
MouseClick, right,  PBPosX,  PBPosY
Sleep, 5000
MouseClick, right,  POPosX,  POPosY
return

^y::
;sysget, Uuuu, 16
;sysget, Yyy, 17
;MsgBox, %Uuuu%, %Yyy%
MouseGetPos, xpos, ypos 
Msgbox, The cursor is at X%xpos% Y%ypos%
return

^+y::
MouseGetPos, xpos, ypos
IniWrite, %xpos%, settings.ini,section1, POX 
IniWrite, %ypos%, settings.ini,section1, POY 
return

^+t::
MouseGetPos, xpos, ypos
IniWrite, %xpos%, settings.ini,section1, PBX 
IniWrite, %ypos%, settings.ini,section1, PBY 
return


ARevFunc:
	{
	WinActivate, PXG Client
	PixelGetColor, pbcolor , PBPosX, PBPosY
	PixelGetColor, hpcolor , POPosX +50,  POPosY -30
	;MouseClick, right,  1104,  352
	AutoRevivee := (AutoRevivee) ? False : True
	If (AutoRevivee){
		GuiControl, +c008000, AutoRevive
		GuiControl,, AutoRevive, AUTO REVIVE ENABLED
		SetTimer, AutoRevivee, 30
	}

	Else{
		GuiControl, +cRed, AutoRevive
		GuiControl,, AutoRevive, AUTO REVIVE DISABLED
		SetTimer, AutoRevivee, Off
	}
	Return


return




AutoRevivee:
	IfWinActive, PXG Client
	{
		;ImageSearch, FoundX,  FoundY, 0, 0, A_ScreenWidth, A_ScreenHeight, *100 pokeball.bmp
		PixelSearch, FoundoX, FoundoY, PBPosX, PBPosY, PBPosX, PBPosY, %pbcolor%, 0, Fast
		if ErrorLevel =0
		{
			PixelSearch, FoundoX, FoundoY, POPosX +50,  POPosY -30, POPosX +50,  POPosY -30, %hpcolor%, 0, Fast
			if ErrorLevel =1
			{
				SendInput, {%ReviveKey%}
				;Sleep, 100
				MouseClick, left,  POPosX,  POPosY
				Sleep, 180
				MouseClick, right,  POPosX,  POPosY
			}
	
		}	
	}
return

}


NumpadRight::
	Reload
return


NumpadUp::
	MouseClick, right,  POPosX,  POPosY
	MouseClickDrag, left, POPosX,  POPosY, POPosX+30,  POPosY, 0
	Sleep, 80
	MouseClick, right,  POPosX,  POPosY
return
















