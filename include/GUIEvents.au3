;GUIEvents.au3

Func _HideChildrenGui($hGui)
	GUISetState(@SW_HIDE,$hGui)
	GUISetState(@SW_ENABLE, $Main)
	WinActivate($Main)
EndFunc

Func _BtnSettingsApplyClick()
	$iStep = GUICtrlRead ( $idInputStep )
	$bFoldersRename = BitAND(GUICtrlRead($idInputFoldersRename), $GUI_CHECKED)
	_HideChildrenGui($hSettings)
EndFunc

Func _RadioPSTClick()
	If BitAND(GUICtrlRead($idRadioPST), $GUI_CHECKED) = $GUI_CHECKED Then $sFormat = "PST"
EndFunc

Func _RadioEMLClick()
	If BitAND(GUICtrlRead($idRadioEML), $GUI_CHECKED) = $GUI_CHECKED Then $sFormat = "EML"
EndFunc

Func _BtnToClick()
	$sPathTo = FileSelectFolder('Выберите папку', @DocumentsCommonDir)
		If Not (@error Or Not StringInStr(FileGetAttrib($sPathTo), "D")) Then 
			GUICtrlSetData ( $idPathTo, $sPathTo )
		EndIf
EndFunc

Func _Exit()
	Switch @GUI_WinHandle
		Case $hSettings
			_HideChildrenGui($hSettings)
		Case $Main
			Exit
	EndSwitch
EndFunc

Func _WM_NOTIFY($hWndGUI, $MsgID, $wParam, $lParam)
	Local $tInfo = DllStructCreate($tagNMTTDISPINFO, $lParam)
	Local $tNMHDR = DllStructCreate($tagNMHDR, $lParam)
    Local $hWndFrom = DllStructGetData($tInfo, "hWndFrom")
    Local $idFrom = DllStructGetData($tInfo, "IDFrom")
    Local $iCode = DllStructGetData($tInfo, "Code")
	If $iCode = $TTN_GETDISPINFOW Then
        Switch $idFrom
			Case $idOpenBtn
				DllStructSetData($tInfo, "aText", "Открыть")
			Case $idConvertBtn
				DllStructSetData($tInfo, "aText", "Выполнить")
			Case $idSettingsBtn
				DllStructSetData($tInfo, "aText", "Настройки")
			Case $idAboutBtn
				DllStructSetData($tInfo, "aText", "О программе")
		EndSwitch
    EndIf
    Switch $hWndFrom
        Case $idToolbar
            Switch $iCode
                Case $NM_LDOWN
					Switch $g_iItem
						Case $idOpenBtn
							$sPathFrom = FileSelectFolder('Выберите папку', @DocumentsCommonDir)
							If Not (@error Or Not StringInStr(FileGetAttrib($sPathFrom), "D")) Then 
								$sPathTo = $sPathFrom & "\Output" 
								GUICtrlSetData ( $idPathTo, $sPathTo )
								$aTreeItemsList = _SearchMbox($sPathFrom)
								_GUICtrlToolbar_SetButtonState ( $idToolbar, $idConvertBtn, $TBSTATE_ENABLED )
								GUICtrlSetState ( $idBtnTo, $GUI_ENABLE )
								GUICtrlSetState ( $idPathTo, $GUI_ENABLE )
							EndIf
						Case $idConvertBtn
							Local $iState =  _GUICtrlToolbar_GetButtonState( $idToolbar, $g_iItem )
							If Not (BitAND($iState, $TBSTATE_INDETERMINATE) = $TBSTATE_INDETERMINATE) Then 
								Local $aMboxList[0]
								For $idItem In $aTreeItemsList
									If _GUICtrlTreeView_GetChecked( $idMboxList, $idItem ) Then
										_ArrayAdd($aMboxList, _GUICtrlTreeView_GetText ( $idMboxList, $idItem  ))
									EndIf
								Next
								_Run($sPathFrom, $sPathTo, $aMboxList)
							EndIf							
						Case $idSettingsBtn
							GUICtrlSetData( $idInputStep, $iStep )
							GUICtrlSetState( $idInputFoldersRename, $bFoldersRename )			
							GUISetState(@SW_DISABLE, $Main)
							GUISetState(@SW_SHOW,$hSettings)
						Case $idAboutBtn
							MsgBox($MB_ICONINFORMATION, "О программе", "Версия 1.0" & $sFormat & @CRLF & "Волхонцев Д.А." & @CRLF & @CRLF & "2018 год")
					EndSwitch
				Case $TBN_HOTITEMCHANGE
                    Local $tNMTBHOTITEM = DllStructCreate($tagNMTBHOTITEM, $lParam)
                    $g_iItem = DllStructGetData($tNMTBHOTITEM, "idNew")
            EndSwitch		
    EndSwitch
    Return $GUI_RUNDEFMSG
EndFunc   ;==>_WM_NOTIFY

