
### Create gui

``` php  
#SingleInstance force
#Include %A_LineFile%\..\..\..\VilGUIv3.ahk

/* GUI setup 1
*/  
$GuiEvents := new VilGUIv3("GuiEvents")  

	$GuiEvents.Controls  
		.Edit().value("Lorem ipsum").add()  

		.GroupBox().layout("row").add("ButtonsTest")  
			; BUTTONS  
			.Button().submit("Submit Button")  
			.Button().close("Close button")  


		$GuiEvents.Events.Gui  
			.escape("guiEventTest", "On escape event", "Gui will be destroyed")  ;  1)  
			.escape("close")  

		$GuiEvents.Events.Gui  
			.submit("submitGuiCallbackTest", "EVENT", "BY", "GUI")  
			.submit("close")  

		 $GuiEvents.Events.Gui  
			 ;.close("guiEventTest", "On close event", "Script will exit")  
			 .close("exit")  


$GuiEvents.Gui.show()  
			;.size(360, 720)	; initial size of gui ( width, height )  
			;.alwaysOnTop()	; default false  
			;.resizeable()	; default unresizable  
			;.minSize("500", "500" )	; min size of gui if resizable  
			;.maxSize("1000", "1000" )	; max size of gui if resizable  
			;.center("x")	; center to monitor on init horizontal  
			;.center("y")	; center to monitor on init vertically  


/** guiEventTest
*/  
guiEventTest($Event:="", $params*){  
	MsgBox,262144,, guiEventTest,3  
	$Event.message()  
}  
/** buttonCallbackTest
*/  
submitGuiCallbackTest($Event, $params*){  
	MsgBox,262144,, submitGuiCallbackTest,3  
	$Event.message()  
	MsgBox,262144,, % $params[1] "`n" $params[2] "`n" $params[3],5  
}  
```  