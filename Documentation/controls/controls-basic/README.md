# Basic controls

* Button
* Edit
* Text
* Checkbox

### Methods
__add__( [string __$id__] ) // @return object __Control__  
    // add control to gui with given id, $id is used as value if value is not defined  

__value__( string __$value__ )  
// value of control  

__callback__( $string __$fnName__, __$params__* )  
// callback fn for control, any number of parameters  

__options__( string __$options__ )  
// @param __$options__ strings of [options](https://autohotkey.com/docs/commands/Gui.htm#Controls_Uncommon_Styles_and_Options)  
// E.G: "w256 h64 x+16 y+32 border"  


## Examples

``` php  
/* GUI  
*/  
$Gui := new VilGUIv3("BasicControls")  

/* Button  
*/  
$Gui.Controls  
    .Button().add()  
    .Button()  
        .value("Button Text")   ; text of button  
        .callback("callbackFN", "Paramater 1", "Paramater 2")   ; callback function  
        .options("w96 x+16")    ; set options to control  
        .add("Button 2")    ; add control with name "Button 2", used as value of if value() is not defined  

/* Edit  
*/  
$Gui.Controls  
    .Edit()  
        .value("Edit Control")  
        .options("x-16 y+32")  
        .callback("callbackFN", "Paramater 1", "Paramater 2") ; BUG: on write event has type "leftclick"  
        .add()  

/* Text  
*/  
$Gui.Controls  
    .Text()  
        .options("border")  
        .add("Bordered Text")  
    .Text()  
        .value("Bar Text")  
        .add()  


/* Checkbox  
*/  
$Gui.Controls  
    .Checkbox().add()  
    .Checkbox()  
        .value("Callback Checkbox").add()  
        .callback("callbackFN", "Paramater 1", "Paramater 2")  
        .add() ; TODO: Send value with event  

/* Show GUI  
*/  
$Gui.Gui.show()  

/** Callback  
*/  
callbackFN($Event, $params*){  
    $Event.message(100)  
    MsgBox,262144,, % $params[1] "`n" $params[2] "`n" $params[3],5  
}  
```  
![alt text](https://github.com/vilbur/ahk-vilgui/blob/master/Documentation/controls/controls-basic/controls-basic.jpeg?raw=true)  

  