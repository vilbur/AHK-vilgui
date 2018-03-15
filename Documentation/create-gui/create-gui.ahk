#SingleInstance force
#Include %A_LineFile%\..\..\..\VilGUIv3.ahk

/* GUI setup 1
*/
$GuiTest_1 := new VilGUIv3("GuiTest_1")

$GuiTest_1.Gui.show()
			.alwaysOnTop()	; default false
			.resizeable()	; default unresizable
			.minSize("500", "500" )	; min size of gui if resizable
			.maxSize("1000", "1000" )	; max size of gui if resizable
			.size(360, 720)	; initial size of gui ( width, height )
			.center("x")	; center to monitor on init horizontal
			.center("y")	; center to monitor on init vertically

/* GUI setup 1
*/
$GuiTest_2 := new VilGUIv3("GuiTest_2")

$GuiTest_2.Gui.show()
		.resizeable()
		.autosize()	; autoresize gui by content
		.fixedWidth()	; with of gui is fixed