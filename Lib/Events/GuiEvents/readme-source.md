# Gui events  

* onSubmit  
* onEscape  
* onClose  
* onExit  


## Events methods  

| __onSubmit__( $callback, $params* )	|Fired on gui is submitted.	|  
|:---	|:---	|  
|`@param string` $callback	|callback function "close|exit|false|customCallback"	|  
|`@param mixed` $params*	|any number of parameters	|  
|`@return self`	|	|  

##  

| __onClose__( $callback, $params* )	|Fired on gui close with "X" button.	|  
|:---	|:---	|  
|`@param string` $callback	|callback function "close|exit|false|customCallback"	|  
|`@param mixed` $params*	|any number of parameters	|  
|`@return self`	|	|  

##  

| __onExit__( $callback, $params* )	|Fired on gui is exiting script.	|  
|:---	|:---	|  
|`@param string` $callback	|callback function "close|exit|false|customCallback"	|  
|`@param mixed` $params*	|any number of parameters	|  
|`@return self`	|	|  


## Examples  

[include:\Test\gui-events.ahk]  