; Script generated by the Inno Setup Script Wizard.
; SEE THE DOCUMENTATION FOR DETAILS ON CREATING INNO SETUP SCRIPT FILES!

#define AppName "AppGet"
#define AppPublisher "AppGet"
#define AppURL "https://appget.net/"
#define SupportURL "https://github.com/appget/appget/issues"
#define UpdatesURL "https://github.com/appget/appget/releases"
#define AppExeName "appget.exe"
#define BuildNumber GetEnv('BUILD_NUMBER')
#define BranchName GetEnv('branch')
#define CopyRight "Apache License, Version 2.0"

[Setup]
; NOTE: The value of AppId uniquely identifies this application.
; Do not use the same AppId value in installers for other applications.
; (To generate a new GUID, click Tools | Generate GUID inside the IDE.)
AppId={{d9fda649-7b07-4197-a96b-5dc01ea10035}
AppName={#AppName}
AppVersion={#BuildNumber}
AppPublisher={#AppPublisher}
AppPublisherURL={#AppURL}
AppSupportURL={#SupportURL}
AppUpdatesURL={#UpdatesURL}
DefaultDirName={commonappdata}\{#AppName}\bin
DisableDirPage=yes
DefaultGroupName={#AppName}
DisableProgramGroupPage=yes
OutputBaseFilename={#AppName}.{#BranchName}.{#BuildNumber}
SolidCompression=yes
AppCopyright={#CopyRight}
AllowUNCPath=False
;UninstallDisplayIcon={app}\appget.exe
DisableReadyPage=True
CompressionThreads=2
Compression=lzma2/normal
AppContact={#SupportURL}
VersionInfoVersion={#BuildNumber}
UninstallDisplayName={#AppName}

[Languages]
Name: "english"; MessagesFile: "compiler:Default.isl"

[Files]
Source: "..\src\AppGet\bin\Release\*"; DestDir: "{app}"; Flags: ignoreversion recursesubdirs createallsubdirs
; NOTE: Don't use "Flags: ignoreversion" on any shared system files

[Registry]
Root: HKLM; Subkey: "SYSTEM\CurrentControlSet\Control\Session Manager\Environment";ValueType: expandsz;ValueName: "Path";ValueData: "{olddata};{app}";Check: NeedsAddPath('{app}')

[Code]
function NeedsAddPath(Param: string): boolean;
var
  OrigPath: string;
begin
  if not RegQueryStringValue(HKEY_LOCAL_MACHINE,
    'SYSTEM\CurrentControlSet\Control\Session Manager\Environment',
    'Path', OrigPath)
  then begin
    Result := True;
    exit;
  end;
  // look for the path with leading and trailing semicolon
  // Pos() returns 0 if not found
  Result := Pos(';' + UpperCase(Param) + ';', ';' + UpperCase(OrigPath) + ';') = 0;  
  if Result = True then
     Result := Pos(';' + UpperCase(Param) + '\;', ';' + UpperCase(OrigPath) + ';') = 0; 
end;
