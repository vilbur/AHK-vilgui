#SingleInstance, force

#Include %A_LineFile%\..\TrayMenu.ahk


$TrayMenu := new TrayMenu()

$TrayMenu.default(false)
	.item("trayMenuCallback", "trayMenuCallback")
	.item("&Exit")
	.item("&Reload")


$TrayMenu.show()

/** trayMenuCallback
*/
trayMenuCallback($param1:="", $param2:="", $param3:=""){
	MsgBox,262144,,trayMenuCallback ,2
	MsgBox,262144,, % $param1 "`n" $param2  "`n" $param3 ,5
}