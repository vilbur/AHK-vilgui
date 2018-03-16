# Gui events

## Event Buttons

* Submit button
* Close button
* Exit button

### Button methods

__submit__( [string __$button_text__] )  
//  mnakes submit button  

__close__( [string __$button_text__] )  
//  mnakes close gui button  

__exit__( [string __$button_text__] )  
//  mnakes exit script button  

__Produce this buttons__  
![event-buttons](https://github.com/vilbur/ahk-vilgui/blob/master/Documentation/events/gui/eventn-buttons.jpeg?raw=true "Event buttons")  

## Gui events

* onSubmit
* onEscape
* onClose
* onExit

### Events methods

__onSubmit__( string|boolean __$callback__, mixin __$parameters*__ )  
// fired on gui is submitted  

__onEscape__( string|boolean __$callback__, mixin __$parameters*__ )  
// fired on escape pressed  

__onClose__( string|boolean __$callback__, mixin __$parameters*__ )  
// fired on gui close with "X"  

__onExit__( string|boolean __$callback__, mixin __$parameters*__ )  
// fired on gui is exiting script  

__@pram $callback__  
$callback := __"customFunction"__ custom callback function  
$callback := __"close|exit"__ default callbacks, fired after custom callback  
$callback := __false__ remove callbacks  

__@pram $parameters__  
Any number of parameters  
First parameter passed to callback is __[$Event](Documentation/events/event/)__ object  


``` php  
/* GUI setup 1  
*/  
$GuiEvents := new VilGUIv3("GuiEvents")  

	$GuiEvents.Controls.layout("row")  
		.Edit().value("Lorem ipsum").label("Test Input").add().section()  
		.GroupBox().layout("row").add("Event Buttons")  

		; EVENT BUTTONS  
		.Button().submit()  
		.Button().close()  
		.Button().exit()  

	$GuiEvents.Events.Gui  
		.onEscape("callbackFunction", "onEscape", "Custom") ; 1) Call this function on Escape pressed  
		.onEscape("close")                                  ; 2) Then close gui window  

		.onSubmit("callbackFunction", "onSubmit", "Custom") ; 1) Call this function on onSubmit pressed  
		.onSubmit("close")                               ; 2) then exit script  

		.onClose("callbackFunction", "onClose", "Custom")	; 1) Call this function on window closed  
		.onClose("exit")  

		.onExit("callbackFunction", "onExit", "Custom")	; 1) Call this function on exiting script  
		;.onExit(false)	; remove callbacks  

$GuiEvents.show()  


/** callbackFunction  
*/  
callbackFunction($Event:="", $params*){  
	MsgBox,262144,callbackFunction, % $params[1] "`n" $params[2] "`n" $params[3],5  
	$Event.message()  
}  
```  