#SingleInstance force
#Include %A_LineFile%\..\..\..\VilGUI.ahk

/* GUI Default
*/
$GuiDefault := new VilGUI("Gui Default")

$GuiDefault.Controls
	.Button().add()
	.Button().add()
	.Button().add()
	
$GuiDefault.create()

/* GUI 
*/	
new VilGUI("Gui Centered")
		.alwaysOnTop()
		.resizeable()
		;.fixedWidth(512)
		.options("+MaximizeBox")
		.center("window")      ; center to active window
		;.create()


/** GUI SETUP EXAMPLE
 *		RESIZABLE
 *		INIT position
 *		INIT size
 * 		MIN & MAX height & width 
 *		
 */
new VilGUI("Gui size & position")
	.resizeable()
	.position(512,512)
	.size(320, 320 )
	.minSize(128, 128 )
	.maxSize(1024, 1024 )						
	;.center("window")      ; center to active window
	;.create()


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