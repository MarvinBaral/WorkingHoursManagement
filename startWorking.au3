#cs ----------------------------------------------------------------------------

 AutoIt Version: 3.3.12.0
 Author:         Marvin Baral

 Script Function:
	manage working hours

#ce ----------------------------------------------------------------------------
#include "includes/startStopWorkingIncludes.au3"

$time = _NowCalc()
$time = _MsgBoxWithTimeEditOption($time)
FileWriteLine($FILENAME, $time)
MsgBox($MB_OK + $MB_ICONINFORMATION, "Success", "Started working at " & $time & ".")
