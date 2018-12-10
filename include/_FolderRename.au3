;_FolderRename.au3
Func _FolderRename($sName)
	Switch $sName
		Case "Archives"
			Return "Архив"
		Case "Inbox"
			Return "Входящие"
		Case "Junk"
			Return "Спам"
		Case "Trash"
			Return "Удаленные"
		Case "Sent"
			Return "Отправленные"
		Case "Drafts"
			Return "Черновики"
		Case "Templates"
			Return "Шаблоны"
	EndSwitch
	Return $sName
EndFunc