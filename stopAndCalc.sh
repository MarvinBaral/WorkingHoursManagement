sStartingLine=$(tail -n1 saveWorkingHours.csv) 

if false; then
	echo "no starting entry found"
else  
	sDateStart=$(echo $sStartingLine | cut -f1 -d\;)
	sDateStop=$(date +"%Y/%m/%d %H:%M:%S")
	iSecondsStart=$(date "+%s" --date "$sDateStart")
	iSecondsStop=$(date "+%s" --date "$sDateStop")
	iDiff=$[$iSecondsStop-$iSecondsStart]
	echo "Start: $sDateStart"
	echo "Stop: $sDateStop"
	echo "Diff [s]: $iDiff"
	
	echo -n "Enter paused time [min]: "; read iMinutesPause
	iSecondsPause=$[$iMinutesPause * 60]
	iTotalWorkTime=$[$iDiff - $iSecondsPause]
	echo -n "Total [s]: $iTotalWorkTime"
	
	iHours=$[$iTotalWorkTime / 3600]
	iRemainingSeconds=$[$iTotalWorkTime - $iHours * 3600]
	iMinutes=$[$iRemainingSeconds / 60]
	iRemainingSeconds=$[$iRemainingSeconds - $iMinutes * 60]
	iSeconds=$iRemainingSeconds
	echo " => "$iHours"h "$iMinutes"min "$iSeconds"s"
	
	echo -n "Enter topic: "; read sTopic
	echo -n "Enter subtopic: "; read sSubtopic
	echo Topic: "$sTopic, $sSubtopic"
	line=";"$sDateStop";"$iSecondsPause";"$iTotalWorkTime";"$sTopic";"$sSubtopic";"$iHours"h "$iMinutes"min"
	echo "Attached line: $line"
	echo $line >>saveWorkingHours.csv
fi