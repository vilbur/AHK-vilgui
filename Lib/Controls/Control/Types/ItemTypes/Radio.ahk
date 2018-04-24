/** Radio buttons
  * 
  * Radio buttons is set of controls added individually to gui
  *
  * They are grouped to RadioGroup which is accessable via Controls
  *		@example $Gui.Controls.get("Radio_1").get("Button 1")
  *   
  *
  */
Class Radio_vgui extends ControlItems_vgui
{
	_RadioGroup := {}

	/** Add to GUI
	*/
	add($name:="")
	{
		this.name($name)
		
		this.RadioGroup := this._name ; name of radio group
		
		this.preAdd()
		return % this.Controls()
	}
	/** Proceed methods necessary BEFORE adding of object to GUI
	*/
	preAdd()
	{
		this._setRadionGroup()
		this._addEachRadiobutton()		
		this._addRadioGroupToControlsList()
		
		this._resetControlInParent()
	}
	/** Get configured Control object which is able passed to Controls.add()
	*/
	get()
	{
		this.preAdd()
		return this
	}
	/**
	 */
	_setRadionGroup()
	{
		this._RadioGroup 	:= new RadioGroup()
		this._RadioGroup.hwnd 	:= this._name
		this._RadioGroup._name 	:= this._name		
		;Dump(this._RadioGroup, "this._RadioGroup", 1)
	} 
	
	/** _addEachRadiobutton
	*/
	_addEachRadiobutton()
	{
		$options := this._Options.get()
		
		For $key, $item in this._items.array
			if($item)
			{
				$button_name := this._getButtonName($key, $item)
				
				$Button := this.clone()
								.name( $button_name )
								;.name( this._getButtonName($key, $item) )														
								.value(RegExReplace( $item, "i)\|+$", "" )) ; remove "|" of selected item
								.options( (A_Index==1 ? " Group ":" ") $options " checked" this._isItemPiped($item) )
				
				$Button_added := this.Controls()
									.add($Button)
									.get()
				
				
				this._RadioGroup.addButton($Button_added)
			}
		;Dump(this._RadioGroup, "this._RadioGroup", 1)
	}
	/** Add object with radio buttons to List
	  *
	  * Allows access to each buttons via name of group
	  *
	*/
	_addRadioGroupToControlsList()
	{
		this.Controls()._List.set(this._RadioGroup)
	}

	/** Get name of radio button
		If items are string or array, name is value without whitepsace	E.G: IF items= "Item A|Item B" OR ["Item A", "Item B"]	THEN keys are "ItemA|ItemB"
		If items are object the return key	E.G: IF items= {"key1":"Item A", "key2":"Item A"}	THEN keys are "key1|key2"
		@return string
	*/
	_getButtonName($key, $value){
		
		;return % $key is number ? $value : $key
		;return % $key is number ? RegExReplace( $value, "\s+", "" ) : $key
		
		$name := $key is number ? $value : $key

		return %  RegExReplace( $name, "\|+", "" )
	}
	

}

/** Radio buttons
  * 
  * Radio buttons is set of controls added individually
  *
  *
  */
Class RadioGroup
{
	_type	:= "RadioGroup"
	hwnd	:= ""
	_name	:= ""
	_buttons	:= {}
	
	addButton(ByRef $Button)
	{
		this._buttons[$Button._name] := &$Button
	}
	
	get($button_name)
	{
		return object(this._buttons[$button_name])
	}
	
	
}
	

