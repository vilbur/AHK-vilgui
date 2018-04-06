/** Radio buttons
  * 
  * Radio buttons is set of controls added individually
  *
  *
  */
Class Radio_vgui extends ControlItems_vgui{

	/** Add to GUI
	*/
	add($name:=""){
		;MsgBox,262144,, add,2
		this.name($name)
		this.preAdd()
		return % this.Controls()
	}
	/** Proceed methods necessary BEFORE adding of object to GUI
	*/
	preAdd(){
		this.addEachRadiobutton()
		this._resetControlInParent()
	}
	/** Get configured Control object which is able passed to Controls.add()
	*/
	get(){
		this.preAdd()
		return this
	}

	/** addEachRadiobutton
	  *
	  * name of each radio button = "RadioButtonsName.RadioButtonValue"
	*/
	addEachRadiobutton(){
		For $key, $item in this._items.array
			if($item){
				$Button := this.clone()
								;.name( this._name "-" this._getButtonName($key, $item) )
								.name( this._name "." this._getButtonName($key, $item) )						
								;.name( this._name )								
								.value(RegExReplace( $item, "i)\|+$", "" )) ; remove "|" of selected item
								.options( (A_Index==1 ? " Group ":" ") this._Options.get()  " checked" this._isItemPiped($item) )
				
				this.Controls()
					.add($Button)
			}
	}
	;;/** Set checked radio button key or number
	;;	@param int|string $key of checked item
	;;*/
	;;checked($key){
	;;	this.checked_key := $key
	;;	return this
	;;}
	;;/** Is radio button checked ?
	;;	If this.checked_key == key
	;;	Or if next item is empty because of items was entered as string E.G: "Item A||Item B|Item C"
	;;
	;;	@param int|string $key of checked radio button
	;;*/
	;;_isChecked($key, $item){
	;;	;;;;                 if set by key	          || if set by value           || if set by "|" in array       || if set by "|" in string E.G: "A||B|C"
	;;	return % " checked" (this.checked_key == $key || this.checked_key == $item || RegExMatch( $item, "i)\|$" ) || ( $key<this._items.MaxIndex() && this._items[$key+1] == "" ) )
	;;}
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



