/** Class Checkbox_vgui
*/
Class Checkbox_vgui extends Control_vgui{


	/** checked
		@param int|string $key of checked item
	*/
	checked($checked:=true){
		;this.is_checked := $checked
		this._Options.options .= " checked" ($checked == true)
		return this
	}


}