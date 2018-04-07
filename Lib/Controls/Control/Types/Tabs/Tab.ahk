/** Class Tab_vgui
*/
Class Tab_vgui {
	
	Controls	:= {}
	tab_num	:= ""	
	_name	:= ""	
	
	__New($tab_num)
	{
		this.tab_num := $tab_num
	}
	
	/** Get\ Set name of tab
	  
		TODO: GETTING Should be done by SendMessage dynamically
	*/
	name($name:="~null")
	{
		if($name=="~null"){
			return % RegExReplace( this._name, "\|+", "" ) 
		}
		this._name := $name
		return this
	}

	/** setControls
	*/
	setControls($Tabs)
	{
		this.Controls	:= new Controls_vgui().parent(this).hwnd($Tabs.Controls()._hwnd)
		this.Controls._Layout.ContainerMain.control(&$Tabs)
		;Dump(this.Controls, "this.Controls", 0)
		return this
	}


}
