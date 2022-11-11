'Resets the Taskbar settings to default
'This script can be used in Windows Vista, 7, 8 and 10.
'© Ramesh Srinivasan - https://www.winhelponline.com/blog
'Created on March 24, 2016; Reviewed on April 24, 2021.
'--------------------------------------------------------

Set WshShell = WScript.CreateObject("WScript.Shell")
strRegPath = "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\"
strkey0 = "HKCU\Software\Classes\Local Settings\Software\Microsoft\Windows\CurrentVersion\TrayNotify\"
strkey1 = strRegPath & "StuckRects2\"
strkey2 = strRegPath & "StuckRects3\"
strkey3 = strRegPath & "Taskband\"
strkey4 = strRegPath & "Streams\Desktop\TaskbarWinXP"

sMsgTitle = "Taskbar Settings Reset"
sMsgCompleted = "Taskbar settings have been reset."

ExitExplorerShell
WScript.Sleep(3000)
ClearTaskbarSettings
WScript.Sleep(2000)
StartExplorerShell

Sub ExitExplorerShell()
	strmsg = "Explorer Shell will be terminated now. Click Yes to continue."
	rtnStatus = MsgBox (strmsg, vbYesNo, sMsgTitle)
	If rtnStatus = vbYes Then
		For Each Process in GetObject("winmgmts:"). _
			ExecQuery ("select * from Win32_Process where name='explorer.exe'")
	   		Process.terminate(1)
		Next
	ElseIf rtnStatus = vbNo Then
		WScript.Quit
	End If
End Sub

Sub StartExplorerShell()
	WshShell.Run "explorer.exe"
	strWelcome = "For more tips and articles on Windows, visit us at:" & Chr(10) & Chr(10) & vbtab & "https://www.winhelponline.com/blog"
	MsgBox "Completed!" & Chr(10) & Chr(10) & strWelcome & Chr(10),64, sMsgCompleted
End Sub

Sub ClearTaskbarSettings()
	On Error resume Next	
	WshShell.Regdelete strkey0 & "IconStreams"
	WshShell.Regdelete strkey0 & "PastIconsStream"
	WshShell.Regdelete strkey1
	WshShell.Regdelete strkey2
	WshShell.Regdelete strkey3
	WshShell.Regdelete strkey4
	On Error goto 0
End Sub