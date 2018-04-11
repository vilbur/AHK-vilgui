#Include %A_LineFile%\..\..\Callback\Callback.ahk
#Include %A_LineFile%\..\Lib\Menu.ahk
#Include %A_LineFile%\..\Lib\Tray\TrayMenu.ahk

/** Class Menu
*/
Class Menus extends Menu
{
	Main	:= new Menu().menu("Main") ; .parent(this)
	Tray	:= new TrayMenu().menu("Tray") ; .parent(this)

	/*---------------------------------------
		DEFAULT MENU ITEMS
	-----------------------------------------
	*/
	__New()
	{
		;MsgBox,262144,, Test,2
		;this._bindDefaultItemsMenu()
	}
	;
	;/** _bindDefaultItemsMenu
	;*/
	;_bindDefaultItemsMenu()
	;{
	;	this.defaults("Reload",	&this ".reload")
	;	this.defaults("Exit",	&this ".exit")
	;}
	;/** reload
	;	@param string $label
	;*/
	;reload()
	;{
	;	;MsgBox,262144,, reload,2
	;	Reload
	;}
	;/** exit
	;	@param string $label
	;*/
	;exit()
	;{
	;	;MsgBox,262144,, exit,2
	;	ExitApp
	;}

}