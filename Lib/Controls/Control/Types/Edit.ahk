/** Class Edit_vgui
*/
Class Edit_vgui extends Control_vgui{

	/** add
	*/
	add($name:=""){
		this.name($name)
		return % this.Controls().add(this) ; clone added object if user insert one object multiple times
	}

}
