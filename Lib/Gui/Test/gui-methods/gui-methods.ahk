#SingleInstance force
#Include %A_LineFile%\..\..\gui-setup\gui-construct.ahk
#Include %A_LineFile%\..\..\gui-setup\gui-create.ahk

$Gui.gui("Add", "Text","", "Added text") ; // Apply any Gui command
	.show("w512")                        ; // Apply any Gui, Show command
	.alwaysOnTop(false)                  ; // Set window always on top On\Off
	.hide()
	.restore()
	.submit()
	.close()
	.exit()