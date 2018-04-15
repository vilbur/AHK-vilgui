#Include %A_LineFile%\..\..\..\..\..\VilGui.ahk
global $Gui

$gui_name := "Gui " RegExReplace( A_ScriptName, ".ahk", "" ) 

/* GUI setup
*/
$Gui := new VilGUI( $gui_name )