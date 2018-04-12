
/* Class TrayMenu

	Default icon is set on init
	Remove default menu
	Add "Reload" & "Exit" items

	Tray menu MUST HAS NAME "Tray"
*/
Class TrayMenu extends Menu
{

	_script_name	:= RegExReplace( A_ScriptName, "i)\.(ahk|exe)$", "" )
	_options	:= {"icon": this._script_name ".ico", "defaults":false, "tooltip": this._script_name }
	static _name	:= "Tray" 
	
	/** show Main Menu
	*/
	show()
	{
		this.icon()
		this.tooltip()
		this.createMenu()
		this._setDefaultItems()
	}
	/** set Tray icon
		Icon is automatically set IF:
			Icon name is "ScriptName.ico"
			Path is "A_WorkingDir" dir, OR A_WorkingDir"\icons"

		@param string $icon_path
	*/
	icon($icon_path:="")
	{

		if($icon_path!="")
			this._options.icon:= $icon_path
		else if(this._options.icon)
			Menu, Tray, Icon, % this._getIconPath(),,0
		return this
	}
	/** Tray tooltip
	*/
	tooltip($tip:="")
	{
		if($tip!="")
			this._options.tooltip := $tip
		Menu, Tray, Tip, % this._options.tooltip
		return this
	}
	/** Disable default menu, add "Reload" & "Exit" items
		@param boolean $toggle

		default(false)	// remove default menu
		default(true)	// remove default menu AND add "Reload" & "Exit" items
	*/
	defaults($toggle:=true)
	{
		this._options.defaults := $toggle
		return this
	}
	/**
	 */
	_setDefaultItems()
	{
		$defaults := this._options.defaults  ? "Standard" : "NoStandard"
			
		Menu, Tray, % $defaults
		;return this		
	} 
	
	/** _get Icon Path
		Default icon name = ScriptName.ico

		1. Fullpath
		2. A_WorkingDir\icons\A_ScriptName.ico
		3. A_WorkingDir\A_ScriptName.ico

		@return string path to icon
	*/
	_getIconPath()
	{
		$paths := 	[this._options.icon
			,A_ScriptDir "\\Icons\\" this._options.icon
			,A_ScriptDir "\\" this._options.icon ]

		For $i, $path in $paths
			if(FileExist($path))
				return %$path%
	}

}
