
/** Class Layout_vgui
*/
Class Layout_vgui {
/*
	LAYOUT                       GUI or Tab
		CONTAINERS               Container of sections with one origin - Groupbox
			Sections             Row or Column of controls
				controls	       Gui controls


	GUI
		Container
			Section
				Container - Groupbox
					Section
						Control
*/
	next_section	:= false ; next control will be in new section
	groupbox_close	:= false ; next control will be in main gui if group box open
	ContainerMain	:= new Container_vgui()

	/** setParentGui
	*/
	__New()
	{
		this._firstContainer()
		return this
	}
	/** add new GroupBox_vgui OR Control to last GroupBox
	*/
	addControl($Control)
	{
		;Dump($Control,  $Control._name, 0)
		this._openNewSectionIfNeeded($Control)

		if(RegExMatch( $Control._type, "i)GroupBox"))
			this.ContainerMain.addContainer($Control)
		else if ($Control._type=="Tabs" || !this._isGroupBoxOpen() || this.groupbox_close )
			this.ContainerMain.sectionsLast().addControl($Control)
		else
			this._lastGroupBox().sectionsLast().addControl($Control)

		this.groupbox_close := false
	}

	;/**
	; */
	;deleteControl( $Control )
	;{
	;	this.ContainerMain.deleteControlFromSection($Control)
	;}

	/** Set layout of Containers
		@param "row|column" $layout*
	*/
	layout($layout)
	{
		;this.ContainerMain.layout($layout)
		this.ContainerMain._layout := $layout
		return this
	}
	/** sort
	*/
	sort()
	{
		;Dump(this.ContainerMain, "this.ContainerMain", 0)
		this.ContainerMain.sortSections()
		return this
	}
	/** _openNewSectionIfNeeded
	*/
	_openNewSectionIfNeeded($Control){
		if(this.next_section){
			if(RegExMatch( $Control._type, "i)GroupBox|Tab")){
				;if(!this._sectionsIsEmpty()) ; Do not open new section_vgui if Sections does not exists yet
					this.ContainerMain.newSection()
			}else
				this._lastGroupBox().newSection()

			this.next_section	:= false
		}
	}

	/*---------------------------------------
		PRIVATE METHODS
	-----------------------------------------
	*/
	/** _isGroupBoxOpen
	*/
	_isGroupBoxOpen()
	{
		return % isObject(this._lastGroupBox())
	}
	/** _lastGroupBox
	*/
	_lastGroupBox()
	{
		return % this.ContainerMain.sectionsLast()._ControlLast()
	}
	/** _sectionsIsEmpty
	*/
	_sectionsIsEmpty()
	{
		return % this.ContainerMain.Sections.MaxIndex()==""
	}
	/** Add new container_vgui
		Bind Layout in tabs to outer Layout.Containers.Tabs
	*/
	_firstContainer()
	{
		;MsgBox,262144,Layout_vgui, %  $_GUI_margin.ui.x(),5
		this.ContainerMain._layout	:= "column"
		this.ContainerMain._type	:= "ui"
	}



}
