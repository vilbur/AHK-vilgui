#SingleInstance force
#Include %A_LineFile%\..\..\..\VilGUI.ahk
/* GUI setup
*/
$Gui := new VilGUI("Gui first")

$Gui.create()
	;.alwaysOnTop()	; default false
	;;.resizeable()	; default unresizable
	.minSize(500, 500 )	; min size of gui if resizable
	;.maxSize(1000, 1000 )	; max size of gui if resizable
	;.size(360, 720)	; initial size of gui ( width, height )
	;.center("window")      ; center to active window
	
/* GUI setup 2
*/
/*$Gui2 := new VilGUI("Gui2")

$Gui2.create()
	.resizeable()
	.autosize() 	; autoresize gui by content
	.fixedWidth()	; with of gui is fixed
	.center("x")	; center to monitor on init horizontal
	.center("y")	; */center to monitor on init vertically

