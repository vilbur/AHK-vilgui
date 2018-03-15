/** Class Tab_vgui
*/
Class Tab_vgui {
	tab_num	:= ""
	_name	:= ""
	__New($tab_num){
		this.tab_num := $tab_num
	}
	/** set name
	*/
	name($name){
		this._name	:= $name
		return this
	}
	/** setControls
	*/
	setControls($Tabs){
		;this.Controls	:= new Controls_vgui().parent(this).hwnd($hwnd)
		;Dump($Controls()._hwnd, "Controls()._hwnd", 1)
		;Dump($Tab2.Controls()._hwnd, "", 1)
		;MsgBox,262144,, % $Tab2.hwnd,2

		this.Controls	:= new Controls_vgui().parent(this).hwnd($Tabs.Controls()._hwnd)
		this.Controls._Layout.ContainerMain.control(&$Tabs)
		;Dump(this.Controls, "this.Controls", 0)
		return this
	}


}
