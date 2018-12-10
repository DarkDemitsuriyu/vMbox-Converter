;_SearchMbox.au3
Func _SearchMbox($sPath)
	Local $idItem, $aTreeItemsList[0], $aFileList = _FO_FileSearch($sPath, "eml|dat|msf", False, 125, 1, 2, 2)
	_GUICtrlTreeView_DeleteAll ( $idMboxList )
	For $sFilePath In $aFileList
		Local $sFileString = FileRead( $sFilePath, 10 )
		If StringInStr( $sFileString, $sSearchText ) Then
			$idItem = GUICtrlCreateTreeViewItem($sFilePath, $idMboxList)
			GUICtrlSetState(-1, $GUI_CHECKED)
			
			_ArrayAdd($aTreeItemsList, $idItem)
		EndIf
	Next
	Return $aTreeItemsList
EndFunc