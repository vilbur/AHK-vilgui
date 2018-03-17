# Gui events  

## Event Buttons  

* Submit button  
* Close button  
* Exit button  

### Button methods  

__submit__( [string __$button_text__] )  
//  makes submit button  

__close__( [string __$button_text__] )  
//  makes close gui button  

__exit__( [string __$button_text__] )  
//  makes exit script button  

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
$callback := __"customFunction"__ // custom callback function  
$callback := __"close|exit"__ // default callbacks, fired after custom callback  
$callback := __false__ // remove callbacks  

__@pram $parameters__  
Any number of parameters  
First parameter passed to callback is __[$Event](Documentation/events/event/)__ object  

## Examples  

``` php
$Gui.Controls.layout("row")	.Edit().value("Lorem ipsum").label("Test Input").add().section()	.GroupBox().layout("row").add("Event Buttons")	; EVENT BUTTONS	.Button().submit()	.Button().close()	.Button().exit()				$Gui.Events.Gui	.onEscape("callbackGui", "onEscape", "Custom") 	.onEscape("close")		.onSubmit("callbackGui", "onSubmit", "Custom") 	.onSubmit("close")		.onClose("callbackGui", "onClose", "Custom")		.onClose("exit")	.onExit("callbackGui", "onExit", "Custom")		;.onExit(false) ; remove callbacks/** callbackGui*/callbackGui($Event:="", $params*){	MsgBox,262144,callbackGui, % $params[1] "`n" $params[2] "`n" $params[3],5	$Event.message()}
```  