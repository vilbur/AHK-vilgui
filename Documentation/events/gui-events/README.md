# Events  
## Event Buttons  
* Submit button  
* Close button  
* Exit button  
### Button methods  
| __submit__( [$text] )    |Makes submit button    |  
|:---    |:---    |  
|`@param string` [ $text="Submit" ]    |    |  
##  
| __close__( [$text] )    |Makes close button    |  
|:---    |:---    |  
|`@param string` [ $text="Close" ]    |    |  
##  
| __exit__( [$text] )    |Makes exit button    |  
|:---    |:---    |  
|`@param string` [ $text="Exit" ]    |    |  
##  

__Produce this buttons__  
![event-buttons](https://github.com/vilbur/ahk-vilgui/blob/master/Documentation/events/gui/event-buttons.jpeg?raw=true "Event buttons")  
## Gui events  
* onSubmit  
* onEscape  
* onClose  
* onExit  
### Events methods  

| __onSubmit__( $callback, $params* )    |Fired on gui is submitted.    |  
|:---    |:---    |  
|    |    |  
##  
| __onClose__( $callback, $params* )    |Fired on gui close with "X" button.    |  
|:---    |:---    |  
|    |    |  
##  
| __onExit__( $callback, $params* )    |Fired on gui is exiting script.    |  
|:---    |:---    |  
|    |    |  
##  
__@pram $callback__  
$callback := __"customFunction"__ // custom callback function  
$callback := __"close __\|__ exit __\|__ false __\|__ callbackFn"__ // default callbacks, fired after custom callback  
$callback := __false__ // remove callbacks  
__@pram $params__  
Any number of parameters  
First parameter passed to callback is __[$Event](Documentation/events/event/)__ object  

## Examples  
``` php
$Gui.Controls.layout("row")    .Edit().value("Lorem ipsum").label("Test Input").add().section()    .GroupBox().layout("row").add("Event Buttons")/* EVENT BUTTONS*/    .Button().submit()    .Button().close()    .Button().exit()                /* GUI EVENTS*/$Gui.Events.Gui    .onSubmit("callbackGui", "onSubmit Custom", "param")     .onSubmit("close")        .onClose("callbackGui", "onClose Custom", "param")        .onClose("exit")        .onExit("callbackGui", "onExit Custom", "param")        ;.onExit(false) ; remove callback/** callbackGui*/callbackGui($Event:="", $params*){    MsgBox,262144,callbackGui, % $params[1] "`n" $params[2] "`n" $params[3],5    $Event.message()}
```  