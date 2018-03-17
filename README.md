__GUI__  
__[Create GUI](/Documentation/gui)__  

__Events__  
__[GUI Events](/Documentation/events/gui)__  

__Controls__  
__[Button, Edit, Text, Checkbox](Documentation/controls/controls-basic/)__  
__[Dropdown, Radio, ListBox](Documentation/controls/controls-items/)__  
  
``` php
#SingleInstance force#Include %A_LineFile%\..\..\..\..\VilGUIv3.ahk/* GUI*/$Gui := new VilGUIv3("ItemTypeControls")/* Items for controls*/$items := {"1_string":               "String A selected||String B|String C"          ,"2_array":                ["Array item A|", "Array item B", "Array item C"]          ,"3_object":               {"key1":"item A", "key2":"item B", "key3":"item C"}          ,"4_empty_item_multi_sel": [ "", "List with empty item|",	"Foo selected", "Bar"]          ,"5_nothing_selected":     [ "1 nothing selected", "2", "3"]}$Gui.Controls	/* Dropdown	*/	.Dropdown()		.items($items["1_string"])		.add()	/* Radio	*/	.Radio()		.items($items["2_array"])		.checked(3)					.add()	/* ListBox	*/	.ListBox()		.items($items["3_object"])		.checked("key2")		.add()/* Show GUI*/$Gui.Gui.show()
```  
  
``` php
#SingleInstance force#Include %A_LineFile%\..\..\..\..\VilGUIv3.ahk/* GUI*/$Gui := new VilGUIv3("BasicControls")/* Button*/$Gui.Controls	.Button().add()	.Button()		.value("Button Text")	; text of button		.callback("callbackFN", "Paramater 1", "Paramater 2")	; callback function		.options("w96 x+16")	; set options to control 		.add("Button 2")	; add control with name "Button 2", used as value of if value() is not defined/* Edit*/$Gui.Controls	.Edit()		.value("Edit Control")		.options("x-16 y+32")		.callback("callbackFN", "Paramater 1", "Paramater 2") ; BUG: on write event has type "leftclick"		.add()/* Text*/$Gui.Controls	.Text()		.options("border")		.add("Bordered Text")	.Text()		.value("Bar Text")		.add()/* Checkbox*/$Gui.Controls	.Checkbox().add()	.Checkbox()		.value("Callback Checkbox").add()		.callback("callbackFN", "Paramater 1", "Paramater 2")		.add() ; TODO: Send value with event/* Show GUI*/$Gui.Gui.show()/** Callback*/callbackFN($Event, $params*){	$Event.message(100)	MsgBox,262144,, % $params[1] "`n" $params[2] "`n" $params[3],5}
```  
  