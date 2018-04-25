#SingleInstance force
#Include %A_LineFile%\..\..\gui-setup\gui-construct.ahk	

Loop, 15
	$Gui.Controls.Text("Text " A_Index).add()

$Gui.resizeable()
	.create()

$toggle := true

/* Toggle size
*/
Loop
{
	if( $toggle==true )
		$Gui.size("",128)
	else
		$Gui.autosize()

	$toggle := $toggle!=true
	sleep, 2000
}


;Dump("!!! NOTE: IN SECOND LOOP SCROLL BAR APPEARS AFTER MOUSE SCROLL !!! THIS IS BUG, SCROLL BAR SHOULD  APPEAR WITHOUT ADDITIONAL SCROLLING", "", 1)