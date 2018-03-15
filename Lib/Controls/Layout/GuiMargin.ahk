/** Class GuiMargin_vgui
*/
Class GuiMargin_vgui {

	_x := 10
	_y := 10

	ui	:= new MarginSetter_vgui("ui")
	container	:= new MarginSetter_vgui("container")
	control	:= new MarginSetter_vgui("control")

	/** __New
	*/
	__New(){
		this._setAllTypesMargins("x",this._x)
		this._setAllTypesMargins("y",this._y)
	}
	/** Get\Set All types X
	*/
	x($x:=""){
		if(!$x && $x!=0)
			return % this._x
		this._setAllTypesMargins("x",$x)
		return this
	}
	/** Get\Set All types Y
	*/
	y($y:=""){
		if(!$y && $y!=0)
			return % this._y
		this._setAllTypesMargins("y",$y)
		return this
	}

	/** _setAllTypesMargins
	*/
	_setAllTypesMargins($xy,$value){

		this["_" $xy]	:= $value
		this["ui"][$xy]($value)
		this["container"][$xy]($value)
		this["control"][$xy]($value)
	}
	;/** _setGuiMargin
	;*/
	;_setGuiMargin($_xy, $value){
	;	if(this.type=="ui"){
	;		if($_xy=="_x")
	;			Gui, % this.guihwnd() ":Margin", $value
	;		else if($_xy=="_y")
	;			Gui, % this.guihwnd() ":Margin",, $value
	;	}
	;}

}

/*
*/
Class MarginSetter_vgui {

	;_y := 999
	type := ""
	/** @param ui|container|control $type of margin
	*/
	__New($type){
		this.type := $type
	}
	/** Get\Set
	*/
	x($x:=""){
		if(!$x && $x!=0)
			return % this._x
		return % this.set("_x", $x)
	}
	/** Get\Set
	*/
	y($y:=""){
		if(!$y && $y!=0)
			return % this._y
		return % this.set("_y", $y)
	}
	/** set
	*/
	set($_xy, $value){
		this[$_xy] := $value
		;this._setGuiMargin($_xy, $value)
		return this
	}




}