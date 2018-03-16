### Items controls  
  
* Dropdown  
* Radio  
* ListBox  
  
  
## Methods  
 __add__( [string __$id__] ) // @return object __Control__  
	// add control to gui with given id, $id is used as value if value is not defined  
  
__items__( string|array|object __$items__ )  
    // items in control  
    // selected item in array & object is marked with pipe "|" on end of item E.G: __"A|B||C"__  
    // selected item in string is maked with doublepipe "||"  E.G: __["A", "B|", "C"]__  
  
__checked__( int|string __$key__ )  
    // key or index of seleted item  
    // overides items selection, in listbox add to selection  
  
__callback__( $string __$fnName__, __$params__* )  
    // callback fn for control, any number of parameters  
  
__options__( string __$options__ )  
    // string of options [options](https://autohotkey.com/docs/commands/Gui.htm#Controls_Uncommon_Styles_and_Options)  
    // E.G: "w256 h64 x+16 y+32 border"  
  
## Examples  
  
``` php  
/* GUI  
*/  
$Gui := new VilGUIv3("ItemTypeControls")  
  
/* Items for controls  
*/  
$items := {"1_string":  "String A selected||String B|String C"  
          ,"2_array":   ["Array item A|", "Array item B", "Array item C"]  
          ,"3_object":  {"key1":"item A", "key2":"item B", "key3":"item C"}  
          ,"4_empty_item_multi_sel":    [ "", "List with empty item|",  "Foo selected", "Bar"]  
          ,"5_nothing_selected":    [ "1 nothing selected", "2", "3"]}  
  
  
$Gui.Controls  
    /* Dropdown  
    */  
    .Dropdown()  
        .items($items["1_string"])  
        .add()  
    /* Radio  
    */  
    .Radio()  
        .items($items["2_array"])  
        .checked(3)  
        .add()  
    /* ListBox  
    */  
    .ListBox()  
        .items($items["3_object"])  
        .checked("key2")  
        .add()  
  
/* Show GUI  
*/  
$Gui.Gui.show()  
```  
![alt text](https://github.com/vilbur/ahk-vilgui/blob/master/Documentation/controls/controls-basic/controls-items.jpeg?raw=true)  
  