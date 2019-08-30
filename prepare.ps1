$ErrorActionPreference = "Stop"
$vsixLocation = if ($env:PGC_SHARE -and (Test-Path $env:PGC_SHARE)) { $env:PGC_SHARE } else { 'c:\vsix\' }
[Environment]::SetEnvironmentVariable('vsix_location', $vsixLocation, [EnvironmentVariableTarget]::Machine)
net start pgc