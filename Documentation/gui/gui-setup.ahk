#SingleInstance force
#Include %A_LineFile%\..\..\..\VilGUI.ahk
/* GUI setup
*/
$Gui := new VilGUI("Gui first")


$Gui.Controls
	.Button().add()
	.Button().add()
	.Button().add()		
	

$Gui
	.alwaysOnTop()	; default false
	;.minSize(256, 256 )	; min size of gui if resizable
	;.maxSize(1024, 1024 )	; max size of gui if resizable
	;.size(360, 720)	; initial size of gui ( width, height )
	;.resizeable(false)
	.create()
	.center("window")      ; center to active window
	
/* GUI setup 2this
*/
/*
$Gui2 := new VilGUI("Gui2")

$Gui2.create()
	.resizeable()
	.autosize() 	; autoresize gui by content
	.fixedWidth()	; with of gui is fixed
	.center("x")	; center to monitor on init horizontal
	.center("y")	; center to monitor on init vertically

/**
 */
TestX()
{
	MsgBox,262144,, % WinExist("A"),2 
}