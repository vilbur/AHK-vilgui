#SingleInstance force

#Include %A_LineFile%\..\..\..\..\Callback\Callback.ahk
#Include %A_LineFile%\..\..\Menu.ahk
#Include %A_LineFile%\..\TrayMenu.ahk


$TrayMenu := new TrayMenu()

$TrayMenu
	.defaults()	; turn on default items, default is without defaults
	.icon("\..\..\Test\Icons\Menus.ico")
	.tooltip("Custom tooltip")
	.item("Test Callback", "trayMenuCallback" ,"Pram 1","Pram 2")
	.menu("Menu1")
		.item("Sub Item 1","trayMenuCallback")
		.item("Sub Item 2","trayMenuCallback")
		.parent()
	.item("-")
	.item("&Reload", "trayMenuCallback")	; reload with custom callback
	.item("&Reload")
	.item("&Exit")
			
$TrayMenu.show()

/** trayMenuCallback
*/
trayMenuCallback($param1:="", $param2:="", $param3:="")
{
	;MsgBox,262144,,trayMenuCallback ,2
	MsgBox,262144,, % "trayMenuCallback`n`n" $param1 "`n" $param2  "`n" $param3 ,5
}