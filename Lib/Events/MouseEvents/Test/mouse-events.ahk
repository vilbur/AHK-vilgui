#SingleInstance force
#Include %A_LineFile%\..\..\..\..\Gui\Test\gui-setup\gui-construct.ahk
		
$Gui.Events.Mouse
    .on("enter",                "onMouse")
    .on("move",                 "onMouse")
    .on("leftClick",            "onMouse")
    .on("leftClickUp",          "onMouse")
    .on("leftDoubleclick",      "onMouse")
    .on("rightClick",           "onMouse")
    .on("rightClickUp",         "onMouse")
    .on("rightDoubleclick",     "onMouse")
    .on("middleClick",          "onMouse")
    .on("middleClickUp",        "onMouse")
    .on("middleDoubleclick",    "onMouse")
    .on("mouseWheel",           "onMouse")
    .on("mouseWheelHorizontal", "onMouse")
	
/** onMouse
*/
onMouse($Event:="", $params*)
{
	$Event.message()
	MsgBox,262144,onMouse, % $params[1] "`n" $params[2] "`n" $params[3],5
}

#Include %A_LineFile%\..\..\..\..\Gui\Test\gui-setup\gui-create.ahk