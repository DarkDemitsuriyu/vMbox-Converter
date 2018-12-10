;_MboxToEML.au3
Func _MboxToEML($sPathFrom, $sPathTo, $sFilePath, $sFileName, $sDirName)
	Local $sSubDir = StringReplace($sFilePath, $sPathFrom, "")
	$sSubDir = StringReplace($sSubDir, ".sbd", "")

	Local $sDir = $sPathTo & $sSubDir & $sDirName
	Local $hFileMbox = FileOpen($sFilePath & $sFileName, $FO_ANSI )

	FileSetPos($hFileMbox, -1, $FILE_END)
	Local $iMailsCount, $sFileString, $sEmlBody, $iEmlNumber = 1, $i = 0, $aRray[0], $iTotalString = FileGetPos($hFileMbox)
	FileSetPos($hFileMbox, 0, $FILE_BEGIN)

	While 1
		$sFileString = FileRead( $hFileMbox, $iStep )
		Local $error = @error

		Local $aFind = StringRegExp( $sFileString, $sSearchText , 3)
		For $j = 1 To UBound($aFind) Step 1
			_ArrayAdd($aRray, StringInStr( $sFileString, $sSearchText , 0, $j ) + $iStep*$i)
		Next
		If $error = -1 Then ExitLoop
		$i = $i + 1
	WEnd
	
	$iMailsCount = UBound($aRray)
	
	For $i = 0 To $iMailsCount-1 Step 1
		Local $iStepLetter = 0
		GUICtrlSetData($idMailNumber, "Письмо: " & $iEmlNumber & " из " & $iMailsCount)
		FileSetPos($hFileMbox, $aRray[$i]-1, $FILE_BEGIN)

		If $i == $iMailsCount-1 Then
			$sFileString = FileRead( $hFileMbox )
		Else
			$sFileString = FileRead( $hFileMbox, $aRray[$i+1] - $aRray[$i] )
		EndIf
		
		_SaveEml($sDir, $sFileString, $iEmlNumber)
		GUICtrlSetData($idProgressbar, (($aRray[$i]-1) / $iTotalString)*100)
		$iEmlNumber = $iEmlNumber + 1
	Next
	
	FileClose($hFileMbox)
EndFunc