#cs ----------------------------------------------------------------------------

 AutoIt Version: 3.3.12.0
 Author:         Marvin Baral

 Script Function:
	manage workinghours

#ce ----------------------------------------------------------------------------
#include "startStopWorkingIncludes.au3"

$lastLine = _FileCountLines($FILENAME)
$line = FileReadLine($FILENAME, $lastLine)
$matches = StringRegExp($line, "^.{10} .{8}$", $STR_REGEXPARRAYMATCH)
If $matches = 0 Then
   MsgBox($MB_OK + $MB_ICONERROR, "Invalid Input", "Invalid Input")
   Exit
EndIf
$startingTime = $matches[0]
$endingTime = _NowCalc()
MsgBox(0, "starting time", "You started working at " & $startingTime)
$endingTime = _MsgBoxWithTimeEditOption($endingTime)
$topic = _GetTopic($TOPIC_LIST)
$comment = InputBox("Comment", "You entered """ & $topic & """ as topic. Please neter a comment or a subtopic here to specfy what you did work.", "none")
$pauseMinutes = InputBox("pause time", "Enter the time [minutes], which you didn't work in the specified time.", "0")
$pauseSeconds = $pauseMinutes * 60

$timeDiff = _DateDiff("s", $startingTime, $endingTime)
$seconds = $timeDiff - $pauseSeconds
$hours = Floor($seconds/3600)
$minutes = Round(($seconds - $hours * 3600)/ 60)

$readableTime = $hours & "h " & $minutes & "min"

;file entry
$head = "start;stop;pause;time;topic;readable_time"
$line = $startingTime & ";" & $endingTime & ";" & $pauseSeconds & ";" & $seconds & ";" & $topic & ";" & $comment & ";" & $readableTime
_FileWriteToLine($FILENAME, $lastLine, $line , 1)

$msgBoxString = "worked from " & $startingTime & " to " & $endingTime & @CRLF
$msgBoxString &= "paused " & $pauseMinutes & " minutes (" & $pauseSeconds & "s)" & @CRLF
$msgBoxString &= "worked for " & $topic & " (" & $comment & ") " & @CRLF
$msgBoxString &=  @CRLF
$msgBoxString &= "total time: " & $readableTime & " (" & $seconds & "s)"

MsgBox(0, "Info", $msgBoxString)
