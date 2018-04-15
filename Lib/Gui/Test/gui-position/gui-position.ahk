#SingleInstance force
#Include %A_LineFile%\..\..\gui-setup\gui-construct.ahk
#Include %A_LineFile%\..\..\gui-setup\gui-create.ahk

$Gui.position("+512", "+256") ; move relative to current position
	.position("", 128)        ; move only y position
	.center("x")              ; center x on screen
	.center("xy")             ; center xy
	.center("window")         ; center to last active window 