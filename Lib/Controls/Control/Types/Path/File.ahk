/** Class File_vgui
*/
Class File_vgui extends PathBrowse_vgui{

	/** Add to GUI
	*/
	add($name:=""){
		this.name($name)
		return % this.addInputSet()
	}


}
