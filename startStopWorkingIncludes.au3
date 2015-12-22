#include-once
#include <Date.au3>
#include <File.au3>
#include <Constants.au3>
#include <GUIConstants.au3>

Global Const $FILENAME = "saveWorkingHours.csv"
Global Const $TOPIC_FILE = "topics.txt"
If Not FileExists($TOPIC_FILE) Then
   FileWrite($TOPIC_FILE, "software" & @CRLF & "hardware" & @CRLF & "other")
EndIf
Global Const $TOPIC_LIST = FileReadToArray($TOPIC_FILE)

Func _MsgBoxWithTimeEditOption($time, $heading = "Workinghours-Management", $content = "Is this time correct: " & $time)
   $response = MsgBox($MB_YESNOCANCEL , $heading, $content)
   If $response = $IDNO Then
	  $time = InputBox($heading, "Enter correct time here. Please inherit the syntax below", $time)
   ElseIf $response = $IDCANCEL Then
	  Exit
   EndIf


   Return $time
EndFunc

Func _GetTopic($topicList, $fontSize = 18)
   $arraySize = UBound($topicList)

   $buttonHeight = 80
   $buttonWidth = 200
   $height = $buttonHeight * $arraySize
   $width = $buttonWidth

   $gui = GUICreate("Choose Topic", $width, $height)
   GUISetState(@SW_SHOW)
   GUISetFont($fontSize)
   Local $buttons[$arraySize]

   For $index = 0 To $arraySize - 1
	  $buttons[$index] = GUICtrlCreateButton($topicList[$index], 0, $index * $buttonHeight, $buttonWidth, $buttonHeight)
   Next


   Do
	  $message = GUIGetMsg()
	  For $index = 0 To $arraySize - 1
		 If $message = $buttons[$index] Then
			Return $topicList[$index]
		 EndIf
	  Next
   Until $message = $GUI_EVENT_CLOSE
EndFunc

; _GetTopic($TOPIC_LIST)
