/** Class GuiEvents_vgui
*/
Class Events_vgui{


	Gui	:= new GuiEvents_vgui().parent(this)
	Mouse	:= new MouseEvents_vgui()
	Key	:= new KeyEvents_vgui()
	Window	:= new WindowEvents_vgui()


	/** parent
	*/
	parent($Parent:=""){

		if($Parent)
			this._Parent	:= &$Parent
		return % $Parent ? this : Object(this._Parent)
	}




}
