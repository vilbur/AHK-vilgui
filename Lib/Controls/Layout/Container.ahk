/** Container is element which wraps Columns|Rows (Sections) of controls
	Container can be GUI, Tab or GroupBox


*/

Class Container_vgui
{
	_ctr_addr	:= ""
	;_Control	:= ""
	;_type	:= "container"	; type of container`s control "ui|container"
	;_hwnd	:= ""	; hwnd of GroupBox Or Tabs, needed for found origin position and resizing
	_layout	:= "row"	; "row|column" layout for sections in container
	;_resizable	:= false
	_origin	:= {"x":0, "y":0} ; Origin position of all sections in container
	Sections	:= []	; array of sections (Rows|Columns)
	/*---------------------------------------
		PROPERTY GETTERS
	-----------------------------------------
	*/
	/** hwnd
	*/
	hwnd($hwnd)
	{
		;Dump($hwnd, "hwnd", 1)
		this._hwnd := $hwnd
		return this
	}
	/** origin
	*/
	origin($origin)
	{
		this._origin	:= $origin
		return this
	}
	/** Set control associated with container, GroupBox or Tabs
	*/
	control($ctr_addr:="")
	{
		if(!$ctr_addr)
			return % Object(this._ctr_addr)

		this._ctr_addr	:= $ctr_addr
		return this
	}
	/** delete all sections from container
	 */
	deleteSectionsFromContainer()
	{
		For $k, $Section in this.Sections
			$Section.deleteAllControls()

		;object(this._ctr_addr).removeFromGui()

		this.Sections := []
	}
	
	/*---------------------------------------
		PUBLIC METHODS
	-----------------------------------------
	*/
	/** addContainer
	*/
	addContainer($Control)
	{

		;$Container_nested._hwnd	:= $Control.hwnd		
		this.sectionsLast().addContainer($Control)
	}
	/** Get last section, add first if not exists yet
		@return Object Section
	*/
	sectionsLast()
	{
		if(this._isSectionsEmpty())
			this.newSection(this._origin)
		return % this.Sections[this.Sections.MaxIndex()]
	}
	/** sortSections
	*/
	sortSections()
	{
		this.Bbox	:= new Bbox_vgui()
		this.Bbox.set(this._origin)
		;this.Sections.origin(this._origin)

		For $s, $Section in this.Sections
		{
			$next_section_pos	:= this._getNextSectionOrigin($s)
			$Section_Bbox	:= $Section.nextPosition( $next_section_pos ).sortControls()

			this.Bbox.add( $Section_Bbox )
		}
		return this
	}
	/** setOriginByPosition
		@param int $x|$y add margin to origin position
	*/
	setOriginByPosition($x:=0,$y:=0)
	{
		GuiControlGet, $pos, Pos, % this.control().hwnd

		this._origin	:= {"x": $posX+$x, "y": $posY+$y }
		this.Bbox.set(this._origin)
	
		return this
	}
	/** Resize Container To bounding box
		Add margins to right and bottom of bounding box
	*/
	resizeContainerToBBox()
	{
		if(!this._isSectionsEmpty())
			this.control().size(this.Bbox.x - this._origin.x + $_GUI_margin.control.x(), this.Bbox.y - this._origin.y + 5 )
	}
	/** Add new section_vgui if last section is not empty
	*/
	newSection()
	{
		if(this._isSectionsEmpty() || !this._isLastSectionEmpty())
			this.Sections.push( new Section_vgui()
										.type(this._type=="ui"?"container":"control")
										.layout(this._layout) )
	}
	/*---------------------------------------
		PRIVATE METHODS
	-----------------------------------------
	*/
	/** _getNextSectionOrigin
	*/
	_getNextSectionOrigin($index)
	{
		$control_type	:= this.control()._type

		$margin_x	:= !$control_type ? $_GUI_margin.ui.x()	: $_GUI_margin.control.x()
		$margin_y	:= !$control_type ? $_GUI_margin.container.y()	: $_GUI_margin.control.y()

		;;; /* Add extra margin to top of Groupbox & Tabs */
		$margin_y += $control_type && $_GUI_margin.control.y()<12 && (this._layout == "column" || $index == 1) ? 12 : 0 ; if container is groupBox or tabs && margin in less then 12 && first control of column || first control of row

		return %	{"x": (this._layout == "row"	? this._origin.x	: this.Bbox.x) +$margin_x
			,"y": (this._layout == "column"	? this._origin.y	: this.Bbox.y) +$margin_y }
	}

	/*---------------------------------------
		Sections info
	-----------------------------------------
	*/
	/** _isSectionsEmpty
	*/
	_isSectionsEmpty()
	{
		return % !this.Sections.MaxIndex()
	}
	/** _isLastSectionEmpty
	*/
	_isLastSectionEmpty()
	{
		return % !this.Sections[this.Sections.MaxIndex()].Controls.MaxIndex()
	}

}
