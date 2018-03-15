/** Class Folder_vgui
*/
Class Folder_vgui extends PathBrowse_vgui{

	/** Add to GUI
	*/
	add($name:=""){
		this.name($name)
		return % this.addInputSet()
	}

}
