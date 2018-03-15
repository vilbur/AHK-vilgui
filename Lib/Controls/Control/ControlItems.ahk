/** Class Control
*/
Class ControlItems_vgui extends Control_vgui{

	_items := {"string":"", "array":[]}

	/** set items for radio buttons or tabs
	*/
	items($items:=""){
		this._items.string	:= !isObject($items) ? $items : this._getItemsString($items)
		this._items.array	:=  isObject($items) ? $items : this._getItemsArray($items)
		;Dump(this._items, "this._items", 1)
		return this
	}
	/** Set checked item
		Add "|" suffix to selected item

		@param int|string $checked key or value of checked item
	*/
	checked($checked){

		For $checked_key, $checked in (isObject($checked)?$checked:[$checked])
			For $key, $item in this._items.array
				if(this._checkedMatchKeyOrValue($checked, $key, $item) && !this._isItemPiped($item) )
					this._items.array[$key] := $item "|" (A_Index==this.items_length?"|":"")

		;Dump(this._items, "this._items", 1)
		this._items.string	:= this._getItemsString(this._items.array)
		;Dump(this._items.string, "this._items", 1)
		return this
	}
	/*---------------------------------------
		PROCESS ITEMS ARRAY & STRING
	-----------------------------------------
	*/
	/** Get string of items E.G: "A|B||C"
	*/
	_getItemsString($items){
		this._setItemsLenght($items)
		For $key, $item in $items
			$string .=  $item (A_Index<this.items_length?"|":"")
		return %$string%
	}
	/** Get array of items
		Add "|" suffix to selected item
	*/
	_getItemsArray($items){
		$items := RegExReplace( $items, "\|\|", "~#~|" )
		$array := []
		For $key, $item in StrSplit($items, "|")
			if($item || A_Index==1)
				$array.push( RegExReplace( $item, "~#~", "|" ))
		this._setItemsLenght($array)
		return %$array%
	}
	/** GEt length of items
	*/
	_setItemsLenght($items){
		this.items_length :=	$items.maxIndex() ? $items.maxIndex() : $items.GetCapacity()
	}

	/*---------------------------------------
		CHECKED ITEM METHODS
	-----------------------------------------
	*/
	/** _checkedMatchKeyOrValue
	*/
	_checkedMatchKeyOrValue($checked, $key, $item){
		return % $checked == $key || $checked == $item
	}
	/** _isItemPiped
	*/
	_isItemPiped($item){
		return % RegExMatch( $item, "i)\|$" )?1:0
	}
	/** isNextItemEmpty
	*/
	_isNextItemEmpty($key){
		if $key is number
			return %  $key<this.items_length && this._items[$key+1] == ""

	}

}
