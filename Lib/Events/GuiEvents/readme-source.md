# Gui events  

* onSubmit  
* onEscape  
* onClose  
* onExit  

## Events methods  

| __onSubmit__( $callback, $params*, $params )	|Fired on gui is submitted.	|  
|:---	|:---	|  
|`@param string` $callback	|callback function "close|exit|false|customCallback"	|  
|`@param string` $params*	|	|  
|`@param mixed` $params	|any number of parameters	|  
|`@return self`	|	|  

##  

| __onClose__( $callback, $params* )	|Fired on gui close with "X" button.	|  
|:---	|:---	|  
|`@param string` $callback	|	|  
|`@param string` $params*	|	|  
|`@return self`	|	|  

##  

| __onExit__( $callback, $params* )	|Fired on gui is exiting script.	|  
|:---	|:---	|  
|`@param string` $callback	|	|  
|`@param string` $params*	|	|  
|`@return self`	|	|  

##  


__@pram $callback__  
$callback := __"customFunction"__ // custom callback function  
$callback := __"close|exit|false|callbackFn"__ // default callbacks, fired after custom callback  
$callback := __false__ // remove callbacks  

__@pram $params__  
Any number of parameters  
First parameter passed to callback is __[$Event](Documentation/events/event/)__ object  


## Examples  

[include:\Test\gui-events.ahk]  