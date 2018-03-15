/** Class GroupBox_vgui
*/
Class GroupBox_vgui extends Control_vgui{

	_layout := "row"

	/** Add to GUI
	*/
	add($name:=""){
		this.name($name)
		return % this.Controls().add(this) ; clone added object if user insert one object multiple times
	}
	/**  Executed by Controls() class after adding to Gui
		 Proceed methods necessary ADTER adding of object to GUI
	*/
	postAdd(){
		this.Controls()._groupbox_layout := this._layout ; store last used layout of group box for nex groupboxes
	}
	/** Set layout of Controls in GroupBox
		@param "row|column" $layout
	*/
	layout($layout){
		this._layout := $layout
		return this
	}
}
