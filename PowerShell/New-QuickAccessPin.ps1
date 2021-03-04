$folder = "C:\Path\to\folder"
$QuickAccess = New-Object -ComObject shell.application
$QuickAccess.Namespace($folder).Self.InvokeVerb("pintohome")