[CmdletBinding()]
param (
    # Port the api runs on.
    [Parameter()]
    [string] $Port = 8080,

    # Base uri for the api.
    [Parameter()]
    [string] $BaseUrl = "/api"
)

# Importing used modules
Import-Module Polaris

# Importing private functions
Get-ChildItem -Path "$PSScriptRoot/lib" | ForEach-Object {
    Write-Verbose "Loading: $($_.FullName)"
    . $_.FullName
}

# Loading routes
. $PSScriptRoot/routes.ps1

# Start the app
$app = Start-Polaris -Port $Port -MinRunspaces 1 -MaxRunspaces 5 -UseJsonBodyParserMiddleware -Verbose

while ($app.Listener.IsListening)
{
    Wait-Event callbackcomplete
}