/** Class Menu
*/
Class Menu
{
	static  _defaults	:= {"Exit": "_TrayMenuDefaulExit", "Reload": "_TrayMenuDefaultReload"}
	_items	:= []

	/*---------------------------------------
		DEFAULT MENU ITEMS
	-----------------------------------------
	*/
	name($name:="")
	{
		this._name	:= $name
		return this
	}
	/** parent
	*/
	parent($Parent:="")
	{
		if($Parent!=""){
			this._parent := &$Parent
			return this
		} else
			return % Object(this._parent)
	}
	/*---------------------------------------
		ADD ITEMS METHODS
	-----------------------------------------
	*/
	/** menu
	*/
	menu($name)
	{
		$name_sanitized	:= this._sanitizeName($name)
		this[$name_sanitized]	:= new this()
					.name($name)
					.parent(this)
					;.defaults(this._defaults) ; adding custom defaults is not supported currently 
		
		this._items.push( $name_sanitized )
		
		return % this[$name_sanitized]
	}
	/** Add menu item or submenu
	*/
	item($name:="-", $callback:="", $params*)
	{
		$default_item	:= this._getDefaultItem( $name, $callback )
		
		$item	:= $default_item ?  $default_item  : new Item_vgui($name, $callback, $params*)
		;Dump($item, "item", 1)
		this._items.push($item)
		
		return this
	}
	/**
	 */
	_getDefaultItem( $name, $callback )
	{
		$default_item	:= this._sanitizeName($name)
		
		if( ! $callback && this._defaults.hasKey($default_item) )
			return % new Item_vgui($name, this._defaults[$default_item])		
	} 
	
	/*---------------------------------------
		SHOW METHODS
	-----------------------------------------
	*/
	/** Show menu
	*/
	show($hwnd:="")
	{
		if(this._items.MaxIndex())
		{
			$menu_name := this.createMenu()

			if($hwnd)
				Gui, % $hwnd ":Menu", %$menu_name% ; Attach MyMainMenu to the GUI
			else
				Menu, %$menu_name%, Show
		}
		
	}

	/** add Items to menu
		@return string menu name
	*/
	createMenu()
	{
		;MsgBox,262144,createMenu, % this._name,3

		For $i, $Item in this._items
			if( ! isObject($Item) )
				this._addSubmenu($Item)
			else
				$Item.addItem(this._name)

		return % this._name
	}

	/*---------------------------------------
		PRIVATE METHODS
	-----------------------------------------
	*/
	/** _addSubmenu
	*/
	_addSubmenu($Item){
		Menu, % this._name, Add, % this[$Item]._name, % ":" this[$Item].createMenu()
	}
	/** Remove everything but numbers, letters and underscores
	*/
	_sanitizeName($name){
		;return % RegExReplace( $name, "[&\s]+", "" )
		return % RegExReplace( $name, "i)[^A-Z0-9_-]+", "" )
	}	
	

}


/** Class Menu
*/
Class Item_vgui
{
	_name	:= ""
	_callback	:= ""
	
	__New($name, $callback:="", $params*)
	{
		this._name	:= $name
		
		if($callback)
			this._callback	:= new Callback_vgui($callback, $params*)
	}

	/** _addItem
	*/
	addItem($menu_name)
	{
		if(this._name!="-")
		{
			fn := this._onClickCallback.bind( this )
			Menu, %$menu_name%, Add, % this._name, % fn
			
		}else
			this._addSeparator($menu_name)
	}
	/** _addSeparator
	*/
	_addSeparator($menu_name)
	{
		Menu, %$menu_name%, Add
	}

	_onClickCallback($params*)
	{
		this._callback.call()
	}


}

/*---------------------------------------
	DEFAULT CALLBACKS METHODS
-----------------------------------------
*/
	
/** reload
	@param string $label
*/
_TrayMenuDefaultReload()
{
	;MsgBox,262144,, reload,2
	Reload
}
/** exit
	@param string $label
*/
_TrayMenuDefaulExit()
{
	;MsgBox,262144,, exit,2
	ExitApp
}