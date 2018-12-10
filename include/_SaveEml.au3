;_SaveEml.au3
Func _SaveEml($sDir, $sEmlBody, $iEmlNumber)
	Local $hFile = FileOpen($sDir & "\mail" & $iEmlNumber & ".eml", $FO_OVERWRITE + $FO_CREATEPATH + $FO_BINARY )
	FileWrite($hFile, $sEmlBody)
	FileClose($hFile)
EndFunc