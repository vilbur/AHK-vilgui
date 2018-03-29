#Include %A_LineFile%\..\..\Callback.ahk



/** callBackFunction
*/
callBackFunction($param1:="", $param2:="", $param3:=""){
	MsgBox,262144,, % $param1 "`n" $param2  "`n" $param3 ,5
}

/** submitCustomCallback
*/
Class CallbackObject{
	/** submitCallback
	*/
	callBackMethod($param1:="", $param2:="", $param3:=""){
		MsgBox,262144,, % $param1 "`n" $param2  "`n" $param3 ,5
		Dump($param1, "param1", 1)
		Dump($param2, "param2", 1)
	}
}



/* Call callback function

*/
new Callback_vgui("callBackFunction").call()
new Callback_vgui("callBackFunction", "param1", "param2").call()
new Callback_vgui().callback("callBackFunction").params("param1", "param2", "param3").call()

/* Call callback Object method

*/
$CallbackObject := new CallbackObject()
new Callback_vgui( &$CallbackObject ".callBackMethod", "callBackMethod`nParam 1", "Param 2").call()
new Callback_vgui( &$CallbackObject ".callBackMethod").params({"p1":"val1","p2":"val2"},  "Param 2" ).call()