 /** Wrapper for LBEX Library https://github.com/AHK-just-me/LBEX
  *		
  */
Class ListBoxLBEX_vgui extends ControlItems_vgui
{
	/** Adds a string to a list box.
	 *
	*/
	LBEX_Add( ByRef String ) 
	{
		return % LBEX_Add( this.hwnd, ByRef String ) 
	}
	/** Calculates the ideal width of a list box needed to display the current content.
	 *
	*/
	CalcIdealWidth( Content := "", Delimiter := "|", FontOptions := "", FontName := "" ) 
	{
		return % LBEX_CalcIdealWidth( this.hwnd, Content := "", Delimiter := "|", FontOptions := "", FontName := "" ) 
	}
	/** Deletes an item (row) in a list box.
	 *
	*/
	Delete( Index ) 
	{
		return % LBEX_Delete( this.hwnd, Index ) 
	}
	/** Removes all items from a list box.
	 *
	*/
	DeleteAll() 
	{
		return % LBEX_DeleteAll( this.hwnd ) 
	}
	/** Finds the first string in a list box that begins with the specified string.
	 *
	*/
	Find( ByRef String, Index := 0 ) 
	{
		return % LBEX_Find( this.hwnd, ByRef String, Index := 0 ) 
	}
	/** Finds the first list box string that exactly matches the specified string.
	 *
	*/
	FindExact( ByRef String, Index := 0 ) 
	{
		return % LBEX_FindExact( this.hwnd, ByRef String, Index := 0 ) 
	}
	/** Gets the number of items in a list box.
	 *
	*/
	GetCount() 
	{
		return % LBEX_GetCount( this.hwnd ) 
	}
	/** Gets the index of the currently selected item, if any, in a single-selection list box.
	 *
	*/
	GetCurrentSel() 
	{
		return % LBEX_GetCurrentSel( this.hwnd ) 
	}
	/** Gets the application-defined value associated with the specified list box item.
	 *
	*/
	GetData( Index ) 
	{
		return % LBEX_GetData( this.hwnd, Index ) 
	}
	/** Retrieves the index of the item that has the focus in a multiple-selection list box.
	 *
	*/
	GetFocus() 
	{
		return % LBEX_GetFocus( this.hwnd ) 
	}
	/** Gets the height of items in a list box.
	 *
	*/
	GetItemHeight() 
	{
		return % LBEX_GetItemHeight( this.hwnd ) 
	}
	/** Gets the total number of selected items in a multiple-selection list box.
	 *
	*/
	GetSelCount() 
	{
		return % LBEX_GetSelCount( this.hwnd ) 
	}
	/** Retrieves an array of selected items in a multiple-selection list box.
	 *
	*/
	GetSelItems( ByRef ItemArray, MaxItems := 0 ) 
	{
		return % LBEX_GetSelItems( this.hwnd, ByRef ItemArray, MaxItems := 0 ) 
	}
	/** Gets the index of the anchor item from which a multiple selection starts.
	 *
	*/
	GetSelStart() 
	{
		return % LBEX_GetSelStart( this.hwnd ) 
	}
	/** Gets the selection state of an item.
	 *
	*/
	GetSelState( Index ) 
	{
		return % LBEX_GetSelState( this.hwnd, Index ) 
	}
	/** Gets a string from a list box.
	 *
	*/
	GetText( Index ) 
	{
		return % LBEX_GetText( this.hwnd, Index ) 
	}
	/** Gets the length of a string in a list box.
	 *
	*/
	GetTextLen( Index )
	{
		return % LBEX_GetTextLen( this.hwnd, Index )
	}
	/** Gets the index of the first visible item in a list box.
	 *
	*/
	GetTopIndex( Index ) 
	{
		return % LBEX_GetTopIndex( this.hwnd, Index ) 
	}
	/** Inserts a string into a list box.
	 *
	*/
	Insert( Index, ByRef String ) 
	{
		return % LBEX_Insert( this.hwnd, Index, ByRef String ) 
	}
	/** Gets the index of the item nearest the specified point in a list box.
	 *
	*/
	ItemFromPoint( X, Y ) 
	{
		return % LBEX_ItemFromPoint( this.hwnd, X, Y ) 
	}
	/** Selects or deselects one or more consecutive items in a multiple-selection list box.
	 *
	*/
	SelectRange( First, Last, Select := True ) 
	{
		return % LBEX_SelectRange( this.hwnd, First, Last, Select := True ) 
	}
	/** Searches a list box for an item that begins with the characters in a specified string.
	 *
	*/
	SelectString( ByRef String, Index := 0 ) 
	{
		return % LBEX_SelectString( this.hwnd, ByRef String, Index := 0 ) 
	}
	/** Sets the tab stop positions according to the columns of a list box.
	 *
	*/
	SetColumnTabs( ColGap := 2 ) 
	{
		return % LBEX_SetColumnTabs( this.hwnd, ColGap := 2 ) 
	}
	/** Selects an item and scrolls it into view, if necessary.
	 *
	*/
	SetCurSel( Index ) 
	{
		return % LBEX_SetCurSel( this.hwnd, Index ) 
	}
	/** Sets the focus rectangle to the specified item in a multiple-selection list box.
	 *
	*/
	SetFocus( Index ) 
	{
		return % LBEX_SetFocus( this.hwnd, Index ) 
	}
	/** Sets a value associated with the specified item in a list box.
	 *
	*/
	SetItemData( Index, Data ) 
	{
		return % LBEX_SetItemData( this.hwnd, Index, Data ) 
	}
	/** Sets the height, in pixels, of items in a list box.
	 *
	*/
	SetItemHeight( Index, Height ) 
	{
		return % LBEX_SetItemHeight( this.hwnd, Index, Height ) 
	}
	/** Selects an item in a multiple-selection list box and scrolls the item into view, if necessary.
	 *
	*/
	SetSel( Index, Select := True ) 
	{
		return % LBEX_SetSel( this.hwnd, Index, Select := True ) 
	}
	/** Sets the anchor item, that is, the item from which a multiple selection starts.
	 *
	*/
	SetSelStart( Index ) 
	{
		return % LBEX_SetSelStart( this.hwnd, Index ) 
	}
	/** Sets the tab-stop positions in a list box.
	 *
	*/
	SetTabStops( TabArray ) 
	{
		return % LBEX_SetTabStops( this.hwnd, TabArray ) 
	}
	/** Ensures that the specified item in a list box is visible.
	 *
	*/
	SetTopIndex( Index ) 
	{
		return % LBEX_SetTopIndex( this.hwnd, Index ) 
	}


}