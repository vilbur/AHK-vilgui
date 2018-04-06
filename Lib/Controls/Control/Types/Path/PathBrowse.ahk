/** Class Path_vgui
 
*/
Class PathBrowse_vgui extends Control_vgui{

	default_value	:= "Set path..."
	width_browse_btn	:= 96
	root_file_or_dir	:= A_WorkingDir
	_prompt	:= ""
	_filter	:= ""
	_select_options	:= ""

	/*---------------------------------------
		PUBLIC METHODS
	-----------------------------------------
	*/
	/** root
	*/
	root($root_file_or_dir)
	{
		this.root_file_or_dir := Path($root_file_or_dir).getPath()
		return this
	}
	/** filter
	*/
	filter($filter)
	{
		this._filter := $filter
		return this
	}
	/** prompt
	*/
	prompt($prompt)
	{
		this._prompt := $prompt
		return this
	}
	/** options for picker
	  
		HELP: section OPTIONS
			https://autohotkey.com/docs/commands/FileSelectFile.htm
			https://autohotkey.com/docs/commands/FileSelectFolder.htm
	 */
	selectOptions( $options:="" )
	{
		this._select_options := $options
		return this
	}
	/*---------------------------------------
		PRIVATE METHODS
	-----------------------------------------
	*/
	/** Proceed methods necessary BEFORE adding of object to GUI
	*/
	preAdd()
	{
		this.addInputSet()
	}
	/** Path
	*/
	addInputSet()
	{
		;MsgBox,262144,, addInputSet,2
		this.setLabel()
		this.addEdit()
		this.addBrowseButton()
		return % this.Controls()	; Return Parent GUI, it allows chaining when controls are added
	}
	/** set default Label if not defined
	*/
	setLabel()
	{
		if(!this._label && this._label!=false)
			this.label(this._type)
	}
	/** addEdit
	*/
	addEdit()
	{
		$options	:= this._Options.get() " left " this._getEditWidth()
		;Dump($options, "options", 1)
		$EditControl := this.Controls().Edit()
								.name( this._name ? this._name : this._type )
								.value(this.root_file_or_dir)
								.options( $options )
		if(this._label)
			$EditControl := $EditControl.label(this._label)
			
		this.EditControl := &$EditControl.add().get()
	}
	/** add Browse Button
	*/
	addBrowseButton()
	{		
		;Dump(this.EditControl, "this.EditControl", 1)
		this.Controls().Button()
					.value("Browse...")
					.callback("browseCallback", this._type, this._getSelectOptions(), this.root_file_or_dir, this._getPrompt(), this._filter,  this.EditControl)
					.options("w" this.width_browse_btn)
					.add(this._name "Browse")
	}
	/**
	 */
	_getPrompt()
	{
		StringLower, $type, % this._type
		return % this._prompt ? this._prompt : "Browse a " $type
	} 
	/**
	 */
	_getSelectOptions()
	{
		return % this._select_options ? this._select_options : ( this._type=="File" ? 3 : 3 )
	} 
	/*---------------------------------------
		PRIVATE METHODS
	-----------------------------------------
	*/
	/** Remove widths of "label" and "browse button"
	*/
	_getEditWidth(){
		$width_of_set	:= this._Options.get("w") ? this._Options.get("w") : this.Controls()._OptionsDefaults.getDefaultOption(this._type, "w")
		$width_label	:= this._Label ? (this._Label._Options.get("w") ? this._Label._Options.get("w") : this.Controls()._OptionsDefaults.getDefaultOption("Label", "w")) : -5
		;Dump($width_of_set, "width_of_set", 1)
		;Dump($width_label, "width_label", 1)
		;Dump(this._Label._Options.get("w"), "this._Label._Options.get()", 1)
		;Dump(this._Label, "this._Label", 1)
		;return % " w" $width_of_set -  this.width_browse_btn - (this._label ? this._Label._Options.get("w") : - $_GUI_margin.control.x()  ) + $_GUI_margin.control.x()
		return % " w" $width_of_set - this.width_browse_btn - $width_label + $_GUI_margin.control.x()
	}

}

/** browseCallback
*/
browseCallback($Event, $type, $options, $root, $prompt, $filter, $Control_edit){
	if($type=="File")
		FileSelectFile, $browsed_path, %$options%, %$root%, %$prompt%, %$filter%
	else
		FileSelectFolder, $browsed_path, %$root%, %$options%,%$prompt%

	if($browsed_path)
		Object($Control_edit).edit($browsed_path)

}
