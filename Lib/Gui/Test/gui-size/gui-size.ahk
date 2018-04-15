#SingleInstance force
#Include %A_LineFile%\..\..\gui-setup\gui-construct.ahk
#Include %A_LineFile%\..\..\gui-setup\gui-create.ahk

$Gui.size("", "+128")    ; // resize vertically relative
	.size(512, 128)      ; // resize gui
	.resizeable()        ; // make gui resizable
	.resizeable(false)   ; // make gui un-resizable	
	.minSize(512, 512)   ; // set min size
	.maxSize(1024, 1024) ; // set max size
	.fixedWidth()        ; // fix width on current size
	.fixedWidth(1024)    ; // fix width on 1024 px
	.autosize()          ; // autosize by content