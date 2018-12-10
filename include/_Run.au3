;_Run.au3
Func _Run($sPathFrom, $sPathTo, $aFileList)
	Local $sDirName, $iDirNumber = 1, $iFilesCount = UBound($aFileList)
	GUISetState(@SW_SHOW,$hProgress)
	GUISetState(@SW_DISABLE, $Main)
	For $sFullFilePath In $aFileList
		GUICtrlSetData($idMailNumber, "Обработка...")
		GUICtrlSetData($idProgressbar, 0)
		$sFileName = StringRight ( $sFullFilePath, StringLen($sFullFilePath) - StringInStr($sFullFilePath, "\", 0, -1) )
		$sFilePath = StringReplace( $sFullFilePath, $sFileName, "")
		$sDirName = StringReplace( $sFileName, ".mbox", "")
		If $bFoldersRename Then
			$sDirName = _FolderRename($sDirName)
		EndIf
		GUICtrlSetData($idTitle, "Папка: " & $iDirNumber & " из " & $iFilesCount & " - " & $sDirName)
		Switch $sFormat
			Case "EML"
				_MboxToEML($sPathFrom, $sPathTo, $sFilePath, $sFileName, $sDirName)
			Case "PST"
				MsgBox(4096, 'PST', "PST")
		EndSwitch
		$iDirNumber = $iDirNumber + 1
	Next
	_HideChildrenGui($hProgress)
	MsgBox(4096, 'Готово', "Готово")
EndFunc