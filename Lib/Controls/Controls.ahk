/** Class Controls
*/
Class Controls_vgui extends ControlsTypes_vgui{

	_Layout	:= new Layout_vgui()
	_OptionsDefaults	:= new OptionsDefault_vgui()
	_Control	:= "" ; Store last added control

	/** add
	*/
	add($Control){
		$Control.addLabel()
		this.setControl($Control)
		;Dump(this._Control, this._Control._type " A", 0)
		this._setDefaultName()
		this._addControlToGui()
		this._Control.postAdd()
		this._Control.bindMainCallback()
		this._Control.bindKeypressEvent()
		this._addToControlsList()
		this._addToLayout()

		;SetFormat, Integer, D
		;Hex := this._Control.hwnd
		;Dec := Hex + 0

		this._Control	:= &this._Control
		return this
	}
	/** setControl
	*/
	setControl($Control)
	{
		this._Control	:= this.ControlsList().controlClassExists($Control) ? $Control.clone() : $Control ; clone object if user insert one object multiple times
	}
	/** Get current (last) control, new control object or existing control from list
		$param string $ctrl type of control, or name of control
			E .G:
			 	get()	- return this._Control	( last control )
		 		get("Button")	- return this.Button()	( new control )
				get("ButtonFoo")	- return this.List.ButtonFoo	( existing control )

		@return object $Control
	*/
	get($control_name:="")
	{
		;Dump(this.ControlsList(), "this.ControlsList()", 1)
		if( $control_name=="" )
			return % Object(this._Control) ; return Last created Control
			
		else if( this.ControlsList()._ControlsTypes.hasKey($control_name) )
			return % this[$control_name]() ; return NEW Control object
			
		else
			return % this.ControlsList().get($control_name) ; return Control object from list

	}
	/*---------------------------------------
		OPTIONS
	-----------------------------------------
	*/
	/** Set default options
	*/
	options($control_type, $param1, $param2:="")
	{
		this._OptionsDefaults.set($control_type, $param1, $param2)
		return this
	}
	/*---------------------------------------
		Layout
	-----------------------------------------
	*/
	/** new section_vgui in layout
		This method allows chaining when controls are added
		@param boolean $section
	*/
	section($section:=true){
		if($section)
			this._Layout.next_section	:= true
		return this
	}
	/** End of groupbox, Next control will be added to main container
	*/
	groupEnd(){
		this._Layout.groupbox_close := true
		return this
	}
	/** Set layout of Main Container
		@param "row|column" $layout
	*/
	layout($layout:=""){
		if($layout!="")
			this._Layout.layout($layout)

		return % $layout ? this : this._Layout.ContainerMain._layout
	}
	/*---------------------------------------
		ADD CONTROL PRIVATE METHODS
	-----------------------------------------
	*/
	/** addControlToGui
	*/
	_addControlToGui()
	{
		this._tabActivate()
		;Dump(this._Control._getValueOrItems(), "this._Control._getValueOrItems()", 1)
		;Dump(this._Control, "this._Control", 0)
		Gui, % this._hwnd ":Add", % this._getAddControlType(), % "hwndCtrlHWND " this._getOptions(),  % this._Control._getValueOrItems()
		this._Control.hwnd := CtrlHWND + 0
		this._tabDeactivate()
	}
	/** _setDefaultName
		1) sanitize name
		2) if not defined use value as name
		3) if not defined value and name, use control type
	*/
	_setDefaultName()
	{
		;;;/* GET DEFAULT NAME */
		if( ! this._Control._name )
			this._Control._name := this._Control._value && RegExMatch( this._Control._type, "i)button|text|checkbox", "" ) ? this._Control._value : this._Control._type "1"

		if( ! this._Control._value )
			this._setDefaultValue() ; set value as not sanitized name

		;;;/* GET UNIQUE NAME */
		this._Control._name := this.ControlsList().getUniqueName(this._Control._sanitizeName())
	}
	/** 	_set Default Value
	*/
	_setDefaultValue()
	{
		
		$set_value := true
		
		if(RegExMatch(this._Control._type, "i)edit|radio")) ; type is Edit|Radio
			$set_value := false
		
		if(this.List._ControlsTypes.hasKey( RegExReplace( this._Control._name, "\d+$", "" ))) ; if value is control type E.G: "button"
			$set_value := false
		
		if(RegExMatch(this._Control._name, "i)groupbox") ) ; Groupbox without value
			$set_value := false

		if($set_value)
		    this._Control._value := this._Control._name
	}
	/** _getAddControlType
	*/
	_getAddControlType(){

		if(this._Control._type=="Dropdown")
			return % "DropdownList"
		else if(this._Control._type=="Tabs")
			return % "Tab2"
		else if(this._Control._type=="Label")
			return % "Text"
		else if(this._Control._type=="ListBoxView")
			return % "ListBox"
		else if(this._Control._type=="Keypress")
			return % "Edit"
		return % this._Control._type
	}
	/** _getOptions
	*/
	_getOptions(){
		return % this._OptionsDefaults.get(this._Control._type) " " this._Control._Options.get()
	}
	/*---------------------------------------
		ADD TO LISTS AND LAYOUT
	-----------------------------------------
	*/
	/** _addToControlsList
	*/
	_addToControlsList()
	{
		this.ControlsList().set(this._Control)
	}
	/** _addToLayout
	*/
	_addToLayout()
	{
		this._Layout.addControl(this._Control)
	}
	/*---------------------------------------
		PARENTS
	-----------------------------------------
	*/
	/** parent
	*/
	Parent($Parent:=""){
		if($Parent)
			this._Parent	:= &$Parent
		return % $Parent ? this : Object(this._Parent)
	}
	ControlsList()
	{
		return % $_GUI[this._hwnd].List
	}
	/** hwnd of gui
	*/
	hwnd($hwnd:="")
	{
		;MsgBox,262144,, IS THIS METHOD USED `nControls_vgui.hwnd()? ,2
		if($hwnd)
			this._hwnd	:= $hwnd
		return % $hwnd ? this : this._hwnd
	}
	/*---------------------------------------
		Tabs
	-----------------------------------------
	*/
	/** _tabActivate
	*/
	_tabActivate(){
		;MsgBox,262144, _tabActivate, % this._name,2
		if(this.parent().tab_num)
			Gui, % this._hwnd ":Tab", % this.parent().tab_num
	}
	/** _tabDeactivate
	*/
	_tabDeactivate(){
		;MsgBox,262144, _tabActivate, % this._name,2
		if(this.parent().tab_num)
			Gui, % this._hwnd ":Tab"
	}
	/** get values of GUI controls
	*/
	values(){
		;MsgBox,262144,, values,2
		$values_types	:= {"Edit":"", "Checkbox":"", "ListBox":"", "Dropdown":"", "Radio":"", "File":"", "Folder":"", "ListView":""  }
		$form_data	:= {}
		;Dump(this.ControlsList(), "this.ControlsList()", 0)
		For $control_name, $control in  this.ControlsList()                       ; for each control of control type
			if($values_types.hasKey($control._type))                    ; control can has value
				if(!($control._type=="Radio" && $control.value()==0))   ; if not unselected RADIO or CHECKBOX button
					$form_data[$control_name]	:= $control.value()
		;Dump($form_data, "form_data", 1)
		;sleep 100000
 		return % $form_data.GetCapacity() ? $form_data : false
	}
}
