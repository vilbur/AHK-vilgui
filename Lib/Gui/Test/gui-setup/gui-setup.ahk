#SingleInstance force
#Include %A_LineFile%\..\..\..\..\..\VilGui.ahk

/* Example 1
*/
new VilGUI("Gui Default").create()

/* Example 2
*/
new VilGUI("Gui size & position")
	.resizeable()
	.position(512,512)   ; init position
	.size(512)      ; init size
	.minSize(256, 128)   ; min height & width 
	.maxSize(1024, 1024)   ; max height
	.create()

/* Example 3
*/
new VilGUI("Gui Centered to window")
	.alwaysOnTop()
	.resizeable()
	.fixedWidth(320)         ; without parameter fixed to current size
	.options("+MaximizeBox") ; custom options
	.center("window")        ; center to last active window 
	.create()
	
/* Example 4
*/
$GUI_controls := new VilGUI("Gui autosized with controls")

$GUI_controls.Controls
	.text("Text 1").add()
	.text("Text 2").add()
	.text("Text 3").add()

$GUI_controls
	.Tabs("A|B|C").add()

$GUI_controls
	.position("",380)   ; init position
	.create()
