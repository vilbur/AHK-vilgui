#SingleInstance force
#Include %A_LineFile%\..\..\..\VilGUI.ahk
/* GUI setup
*/
$Gui := new VilGUI("Gui")

$Gui.show()
	.alwaysOnTop()	; default false
	;.resizeable()	; default unresizable
	.minSize(500, 500 )	; min size of gui if resizable
	.maxSize(1000, 1000 )	; max size of gui if resizable
	.size(360, 720)	; initial size of gui ( width, height )
	.center("x")	; center to monitor on init horizontal
	.center("y")	; center to monitor on init vertically

/* GUI setup 2
*/
$Gui2 := new VilGUI("Gui2")

$Gui2.show()
	.resizeable()
	.autosize()	; autoresize gui by content
	.fixedWidth()	; with of gui is fixed