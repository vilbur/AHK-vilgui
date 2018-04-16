#SingleInstance force
#Include %A_LineFile%\..\..\..\..\Gui\Test\gui-setup\gui-construct.ahk

$Gui.Controls
	.Button().submit()
	.Button().close()
	.Button().exit()			

#Include %A_LineFile%\..\..\..\..\Gui\Test\gui-setup\gui-create.ahk