/** Class GuiEvents_vgui
*/
Class Events_vgui
{
	Gui	:= new GuiEvents_vgui().parent(this)
	Mouse	:= new MouseEvents_vgui().parent(this)
	Key	:= new KeyEvents_vgui().parent(this)
	Window	:= new WindowEvents_vgui().parent(this)

	/** parent
	*/
	parent($Parent:="")
	{
		if($Parent)
			this._Parent	:= &$Parent
		return % $Parent ? this : Object(this._Parent)
	}


}
