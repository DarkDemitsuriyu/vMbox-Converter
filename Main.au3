#Region ;**** Directives created by AutoIt3Wrapper_GUI ****
#AutoIt3Wrapper_Icon=Icon.ico
#AutoIt3Wrapper_Compression=4
#EndRegion ;**** Directives created by AutoIt3Wrapper_GUI ****
#include <GuiTreeView.au3>
#include <FileOperations.au3>
#include <Array.au3>
#include <File.au3>

#include "Forms\Main.isf"
#include "Forms\Progress.isf"
#include "Forms\Settings.isf"
#include "include\_SearchMbox.au3"
#include "include\_FolderRename.au3"
#include "include\_MboxToEML.au3"
#include "include\_SaveEml.au3"
#include "include\_Run.au3"
#include "include\GUIEvents.au3"

AutoItSetOption("TrayIconHide", 1)
Opt("GUIOnEventMode", 1)

Global $g_iItem, $iStep = 10000, $bFoldersRename = True, $sSearchText = "From - ", $sFormat = "EML"
Local $aTreeItemsList[0], $sPathFrom, $sPathTo
Local $hProgress, $hSettings, $Main
GUISetState(@SW_SHOW,$Main)
GUIRegisterMsg($WM_NOTIFY, "_WM_NOTIFY")
GUICtrlSetOnEvent($idBtnTo, "_BtnToClick")
GUICtrlSetOnEvent($idRadioEML, "_RadioEMLClick")
GUICtrlSetOnEvent($idRadioPST, "_RadioPSTClick")
GUICtrlSetOnEvent($idBtnSettingsApply, "_BtnSettingsApplyClick")

While 1
    Sleep(100)
WEnd