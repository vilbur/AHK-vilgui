/** Class ListBoxTest
*/
Class ListBoxViewTest extends ListViewTest{


	;runMainTest(){
	;	;$GuiTest.Tabs("ListView 1|ListView 2").add("ListViewTabs")
	;	$listViewTest	:= new ListViewTest()
	;	$listView	:= $listViewTest.getListView()
	;
	;	;For $t, $tab in $GuiTest.ListViewTabs.Tabs {
	;
	;		$listViewLast  :=  $GuiTest.Controls.ListView()
	;										.columns(["Column A", "Column B", "Column C"])
	;										.data($listViewTest._getRowData(1))
	;										.options("h128")
	;										.get() ; !!!!!! IMPORTANT - GET CONFIGURED LISTVIEW OBJECT
	;
	;		$tab.Controls.add( $listViewLast )
	;		$listViewLast.addData($listViewTest._getRowData(A_Index*2,2))
	;
	;	;}
	;}


}
