# Events  

## Event Buttons  

* Submit button  
* Close button  
* Exit button  

### Button methods  

| __submit__( [$text] )	|Makes submit button	|  
|:---	|:---	|  
|`@param string` [ $text="Submit" ]	|	|  

##  

| __close__( [$text] )	|Makes close button	|  
|:---	|:---	|  
|`@param string` [ $text="Close" ]	|	|  

##  

| __exit__( [$text] )	|Makes exit button	|  
|:---	|:---	|  
|`@param string` [ $text="Exit" ]	|	|  

##  


__Produce this buttons__  
![event-buttons](https://github.com/vilbur/ahk-vilgui/blob/master/Documentation/events/gui/eventn-buttons.jpeg?raw=true "Event buttons")  

## Gui events  

* onSubmit  
* onEscape  
* onClose  
* onExit  

### Events methods  


| __onSubmit__( $callback, $params* )	|Fired on gui is submitted.	|  
|:---	|:---	|  
|	|	|  

##  

| __onClose__( $callback, $params* )	|Fired on gui close with "X" button.	|  
|:---	|:---	|  
|	|	|  

##  

| __onExit__( $callback, $params* )	|Fired on gui is exiting script.	|  
|:---	|:---	|  
|	|	|  

##  

__@pram $callback__  
$callback := __"customFunction"__ // custom callback function  
$callback := __"close|exit|false|callbackFn"__ // default callbacks, fired after custom callback  
$callback := __false__ // remove callbacks  

__@pram $params__  
Any number of parameters  
First parameter passed to callback is __[$Event](Documentation/events/event/)__ object  


## Examples  

[include:\gui-events.ahk]  