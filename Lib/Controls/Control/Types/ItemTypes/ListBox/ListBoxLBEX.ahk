 /** Wrapper for LBEX Library https://github.com/AHK-just-me/LBEX
  *		
  */
Class ListBoxLBEX_vgui extends ControlItems_vgui
{
	/** Adds a string to a list box.
	 *
	 * @param	string|arra|object	$string	Item for adding
	 *
	 * @return self
	*/
	LBEX_Add( $items ) 
	{
		if( ! isObject($items) )
			$items	:= StrSplit( $items, "|") 
		
		For $i, $item in $items
			LBEX_Add( this.hwnd, $item )

		return this 
	}
	/** Calculates the ideal width of a list box needed to display the current content.
	 *
	 * @param	string	$Content
	 * @param	string	$Delimiter
	 * @param	string	$FontOptions
	 * @param	string	$FontName	 	 	 
	 *	 	 	 
	*/
	CalcIdealWidth( $Content := "", $Delimiter := "|", $FontOptions := "", $FontName := "" ) 
	{
		return % LBEX_CalcIdealWidth( this.hwnd, $Content := "", $Delimiter := "|", $FontOptions := "", $FontName := "" ) 
	}
	/** Deletes an item (row) in a list box.
	 *
	 * @param	int	$index Index of row
	 *
	 * @return self
	*/
	Delete( $index ) 
	{
		LBEX_Delete( this.hwnd, $index ) 
		return this 
	}
	/** Removes all items from a list box.
	 *
	 * @return self
	*/
	DeleteAll() 
	{
		LBEX_DeleteAll( this.hwnd ) 
		return this 
	}
	/** Finds the first string in a list box that begins with the specified string.
	 *
	 * @param	String	$string	Item to search
	 * @param	int	$index Index of row
	 */
	Find( ByRef $string, $index := 0 ) 
	{
		return % LBEX_Find( this.hwnd, $string, $index ) 
	}
	/** Finds the first list box string that exactly matches the specified string.
	 *
	 * @param	String	$string	Item to search
	 * @param	int	$index	Index of row
	 */
	FindExact( ByRef $string, $index := 0 ) 
	{
		return % LBEX_FindExact( this.hwnd, $string, $index ) 
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
	 * @param	int	$index Index of row
	 */
	GetData( $index ) 
	{
		return % LBEX_GetData( this.hwnd, $index ) 
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
	 * @param	int	$max_items	Max count of returned items
	 *
	 * @return	[int]	Indexes of selected items	 
	*/
	GetSelItems( $max_items := 0 ) 
	{
		$selected := []
		LBEX_GetSelItems( this.hwnd, $selected, $max_items )
		return $selected
	}
	/** Gets the index of the anchor item from which a multiple selection starts.
	 *
	*/
	GetSelStart() 
	{
		;;;return % LBEX_GetSelStart( this.hwnd ) ; THIS DOES NOT WORK IN TEST, GetSelItems() is used as hotfix
		return % this.GetSelItems(1)[1] 
	}
	/** Gets the selection state of an item.
	 *
	 * @param	int	$index Index of row
	 */
	GetSelState( $index ) 
	{
		return % LBEX_GetSelState( this.hwnd, $index ) 
	}
	/** Gets a string from a list box.
	 *
	 * @param	int	$index Index of row
	 */
	GetText( $index ) 
	{
		return % LBEX_GetText( this.hwnd, $index ) 
	}
	/** Gets the length of a string in a list box.
	 *
	 * @param	int	$index Index of row
	 */
	GetTextLen( $index )
	{
		return % LBEX_GetTextLen( this.hwnd, $index )
	}
	/** Gets the index of the first visible item in a list box.
	 *
	 * @param	int	$index Index of row
	 */
	GetTopIndex( $index:=1 ) 
	{
		return % LBEX_GetTopIndex( this.hwnd, $index ) 
	}
	/** Inserts a string into a list box.
	 *
	 * @param	int	$index	Index of row
	 * @param	String	$string	Item to search
	 *
	 * @return self
	*/
	Insert( $index, ByRef $string ) 
	{
		LBEX_Insert( this.hwnd, $index, $string ) 
		return this 
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
	 * @param	int	$first	First item
	 * @param	int	$last	Last item
	 *
	 * @return self
	*/
	SelectRange( $first, $last ) 
	{
		LBEX_SelectRange( this.hwnd, $first, $last, $select := true) ; $slect has no efffect
		return this 
	}
	/** Searches a list box for an item that begins with the characters in a specified string.
	 *  
	 *  @param	String	$string	Item to search
	 *  @param	int	$index	Index of row
	 *
	 * @return self
	*/
	SelectString( $string, $index := 0 ) 
	{
		;;LBEX_SelectString( this.hwnd, $string, $index := 0 )  ; THIS DOES NOT WORK IN TEST, used hotfix
		$index := this.Find( $string, $index )
		this.SetCurSel($index)
		return this 
	}
	/** Sets the tab stop positions according to the columns of a list box.
	 *  
	 *  NOT TESTED ON LISTBOX WITH COLUMNS	 
	 *
	 * @return self
	*/
	SetColumnTabs( ColGap := 2 ) 
	{
		LBEX_SetColumnTabs( this.hwnd, ColGap := 2 )
		return this
	}
	/** Selects an item and scrolls it into view, if necessary.
	 *
	 * @param	int	$index Index of row
	 *
	 * @return self
	*/
	SetCurSel( $index ) 
	{
		;;return % LBEX_SetCurSel( this.hwnd, $index ) ; THIS DOES NOT WORK IN TEST, SelectRange() is used as hotfix
		this.SelectRange($index, $index)
		return this 
	}
	/** Sets the focus rectangle to the specified item in a multiple-selection list box.
	 *
	 * @param	int	$index Index of row
	 *
	 * @return self
	*/
	SetFocus( $index ) 
	{
		LBEX_SetFocus( this.hwnd, $index ) 
		return this 
	}
	/** Sets a value associated with the specified item in a list box.
	 *
	 * @param	int	$index Index of row
	 * @param	int	$data	Set data to item, works only intyeger values 
	 *
	 * @return self
	*/
	SetItemData( $index, $data ) 
	{
		LBEX_SetItemData( this.hwnd, $index, $data ) 
		return this 
	}
	/** Sets the height, in pixels, of items in a list box.
	 *
	 * @param	int	$index  Index of row
	 * @param	int	$height Height of row
	 *
	 * @return self
	*/
	SetItemHeight( $index, $height ) 
	{
		LBEX_SetItemHeight( this.hwnd, $index, $height ) 
		return this 
	}
	/** Selects an item in a multiple-selection list box and scrolls the item into view, if necessary.
	 *
	 * @param	int	$index Index of row
	 *
	 * @return self
	*/
	SetSel( $index, $select := true ) 
	{
		LBEX_SetSel( this.hwnd, $index, $select ) 
		return this 
	}
	/** Sets the anchor item, that is, the item from which a multiple selection starts.
	 *  
	 *   THIS FUNCTION SEEMS TO BE NOT WORKING
	 *  
	 *   @param	int	$index Index of row
	 */
	SetSelStart( $index ) 
	{
		return % LBEX_SetSelStart( this.hwnd, $index ) 
	}
	/** Sets the tab-stop positions in a list box.
	 *  
	 *  NOT TESTED
	 *  
	 *  @param	int	$index Index of row
	 */
	SetTabStops( TabArray ) 
	{
		return % LBEX_SetTabStops( this.hwnd, TabArray ) 
	}
	/** Ensures that the specified item in a list box is visible.
	 *
	 * @param	int	$index Index of row
	 *
	 * @return self
	*/
	SetTopIndex( $index ) 
	{
		LBEX_SetTopIndex( this.hwnd, $index ) 
		return this 
	}


}