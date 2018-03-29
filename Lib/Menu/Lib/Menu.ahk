/** Class Menu
*/
Class Menu {

	static  _defaults	:= {}
	_items	:= []


	/*---------------------------------------
		DEFAULT MENU ITEMS
	-----------------------------------------
	*/
	name($name:=""){
		this._name	:= $name
		return this
	}
	/** parent
	*/
	parent($Parent:=""){
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
	menu($name){
		$name_sanitized	:= this._sanitizeName($name)
		this[$name_sanitized]	:= new this().name($name).parent(this).defaults(this._defaults)
		this._items.push( $name_sanitized )
		return % this[$name_sanitized]
	}
	/** Add menu item or submenu
	*/
	item($name:="-", $callback:=""){
		$default_item	:= this._sanitizeName($name)
		$item	:= this._defaults[$default_item] ? this._defaults[$default_item] : new Item_vgui($name, $callback)
		;Dump($item, "item", 1)
		this._items.push($item)
		return this
	}
	/*---------------------------------------
		DEFAULT ITEMS METHODS
	-----------------------------------------
	*/
	/** Set default items to menu
	*/
	defaults($param1, $param2:=""){
		this._defaults[this._sanitizeName($param1)] := new Item_vgui($param1, $param2)
		return this
	}

	/*---------------------------------------
		SHOW METHODS
	-----------------------------------------
	*/
	/** Show menu
	*/
	show($hwnd:=""){
		if(this._items.MaxIndex()){
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
	createMenu(){
		For $i, $Item in this._items
			if(!isObject($Item) )
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
Class Item_vgui {

	_name	:= ""
	_callback	:= ""
	__New($name, $callback:=""){
		this._name	:= $name
		if($callback)
			this._callback	:= new Callback($callback)
	}

	/** _addItem
	*/
	addItem($menu_name){

		if(this._name!="-"){
			fn := this._onClickCallback.bind( this )
			Menu, %$menu_name%, Add, % this._name, % fn
		}else
			this._addSeparator($menu_name)
	}
	/** _addSeparator
	*/
	_addSeparator($menu_name){
		;MsgBox,262144,% this._name, %$menu_name% ,2
		Menu, %$menu_name%, Add
	}

	_onClickCallback($params*){
		this._callback.call()
	}


}
