# Class Controls  
## Create controls  

## Common Methods  
Methods shared with all control types  



__add__( [string __$id__] ) // @return object __Control__  
    // add control to gui with given id, $id is used as value if value is not defined  
__callback__( $string __$fnName__, __$params__* ) // @return object __Control__  
    // callback fn for control, any number of parameters  
__options__( string __$options__ ) // @return object __Control__  
    // @param __$options__ strings of [options](https://autohotkey.com/docs/commands/Gui.htm#Controls_Uncommon_Styles_and_Options)  
    // E.G: "w256 h64 x+16 y+32 border"  
------------------------------------------------------------------------------------------------------------------------------------  
## Basic controls  
* Button  
* Edit  
* Text  
* Checkbox  
#### Methods  
__value__( string __$value__ ) // @return object __Control__  
// value of control  

``` php  
/* Button  */  $Gui.Controls      .Button().add()      .Button()          .value("Callback Button")                             ; text of button          .callback("callbackFnCtrs", "Paramater 1", "Paramater 2") ; callback function          .options("w96 x+16")                                  ; set options to control          .add("Button 2")                                      ; add control with name "Button 2"      /* Edit      */      .Edit()          .value("Edit Control")          .options("x-16 y+32")          .callback("callbackFnCtrs", "Paramater 1", "Paramater 2") ; BUG: on event has type "leftclick"          .add()      /* Text      */      .Text()          .options("border")          .add("Bordered Text")      .Text()          .value("Bar Text")          .add()      /* Checkbox      */      .Checkbox().add()      .Checkbox()          .value("Callback Checkbox").add()          .callback("callbackFnCtrs", "Paramater 1", "Paramater 2")          .add() ; TODO: Send value with event  /** Callback  */  callbackFnCtrs($Event, $params*){      $Event.message(100)      MsgBox,262144,, % $params[1] "`n" $params[2] "`n" $params[3],5  }  
```  
![alt text](https://github.com/vilbur/ahk-vilgui/blob/master/Documentation/controls/controls-main/controls-basic.jpeg?raw=true)  
------------------------------------------------------------------------------------------------------------------------------------  
## Items controls  
* Dropdown  
* Radio  
* ListBox  
### Methods  
__items__( string\|array\|object __$items__ ) // @return object __Control__  
    // items in control  
    // selected item in array & object is marked with pipe "|" on end of item E.G: __"A\|BC"__  
    // selected item in string is maked with doublepipe "||"  E.G: __["A", "B|", "C"]__  
__checked__( int\|string __$key__ ) // @return object __Control__  
    // key or index of seleted item  
    // overides items selection, in listbox add to selection  
__clear__() // @return object __Control__  
    // remove items  

## Examples  

``` php  
/* Items for controls  */  $items := {"1_string":               "String A selected||String B\|String C"            ,"2_array":                ["Array item A|", "Array item B", "Array item C"]            ,"3_object":               {"key1":"item A", "key2":"item B", "key3":"item C"}            ,"4_empty_item_multi_sel": [ "", "List with empty item|",    "Foo selected", "Bar"]            ,"5_nothing_selected":     [ "1 nothing selected", "2", "3"]}  $Gui.Controls      /* Dropdown      */      .Dropdown()          .items($items["1_string"]) ; checked by pipe "||"          .add()      /* Radio      */      .Radio()          .items($items["2_array"])          .checked(3) ; checked by array index          .add()      /* ListBox      */      .ListBox()          .items($items["3_object"])          .checked("key2") ; checked by object key          .add()  
```  
![alt text](https://github.com/vilbur/ahk-vilgui/blob/master/Documentation/controls/controls-main/controls-items.jpeg?raw=true)  

  