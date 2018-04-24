/** Class Control
*/
Class ControlItems_vgui extends Control_vgui
{

	_items := {"string":"", "array":[]}

	/** Get\Set items for radio buttons or tabs
	 *  
	 *  NOTE: THIS METHOD SHOULD BE IN EVERY CONTROL TYPE, AND GETTING OF ITEMS SHOUD BE DONE DYNAMICALLY
	 *  
	 *  @param	string|array	$items items for control E.G.: "A||B|C" OR ["A", "B", "C"]
	 *  
	 *  @return	self|array	return self when setting, or array when getting items  
	 */
	items($items:="~null")
	{
		return % $items!="~null" ? this._setItems($items) : this._items.array
	}
	
	/** set items for radio buttons or tabs
	*/
	_setItems($items)
	{
		if( isObject($items) )
			$items := $items.clone() ; clone object, otherwise it will modify original array
	
		this._items.string	:= !isObject($items) ? $items : this._getItemsString($items)
		this._items.array	:=  isObject($items) ? $items : this._getItemsArray($items)

		return this
	}
	/** Set checked item
		Add "|" suffix to selected item

		@param int|string $checked key or value of checked item
	*/
	checked($checked)
	{
		For $checked_key, $checked in (isObject($checked)?$checked:[$checked])
			For $key, $item in this._items.array
				if(this._checkedMatchKeyOrValue($checked, $key, $item) && !this._isItemPiped($item) )
					this._items.array[$key] := $item "|" (A_Index==this.items_length?"|":"")

		this._items.string	:= this._getItemsString(this._items.array)
		return this
	}
	/** clear values in item types control
	  * TODO: Tested on Dropdown, needs to be tesed on others
	 */
	clear()
	{
		return % this.edit("|")
	}
	/** Select item in ListBox, DropDownList, ComboBox, or Tab
		wrapper: https://www.autohotkey.com/docs/commands/GuiControl.htm
			"GuiControl, Choose" 
	 */
	select( $index )
	{
		;GuiControl, Choose, ControlID, N
		this.guiControl( "Choose", $index )
	}
	/*---------------------------------------
		PROCESS ITEMS ARRAY & STRING
	-----------------------------------------
	*/
	/** Get string of items E.G: "A|B||C"
	*/
	_getItemsString($items)
	{
		this._setItemsLenght($items)
		For $key, $item in $items
			$string .=  $item (A_Index<this.items_length?"|":"")
		return %$string%
	}
	/** Get array of items
		Add "|" suffix to selected item
	*/
	_getItemsArray($items)
	{
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
	_setItemsLenght($items)
	{
		this.items_length :=	$items.maxIndex() ? $items.maxIndex() : $items.GetCapacity()
	}

	/*---------------------------------------
		CHECKED ITEM METHODS
	-----------------------------------------
	*/
	/** _checkedMatchKeyOrValue
	*/
	_checkedMatchKeyOrValue($checked, $key, $item)
	{
		return % $checked == $key || $checked == $item
	}
	/** _isItemPiped
	*/
	_isItemPiped($item)
	{
		return % RegExMatch( $item, "i)\|$" )?1:0
	}
	/** isNextItemEmpty
	*/
	_isNextItemEmpty($key)
	{
		if $key is number
			return %  $key<this.items_length && this._items[$key+1] == ""

	}

}
