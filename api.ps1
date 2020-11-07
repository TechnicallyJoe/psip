[CmdletBinding()]
param (
    [Parameter()]
    [string] $Port = 8080
)

Import-Module Polaris
$BaseUrl = "/api"

function Get-DataFromUrl
{
    [CmdletBinding()]
    param (
        # RawUrl
        [Parameter(Mandatory)]
        [string] $RawUrl,

        # Object to examine
        [Parameter(Mandatory)]
        [Object] $DataObj
    )

    $params = $RawUrl.Split('/')
    ForEach ($param in $params)
    {
        if ($null -eq $resp)
        {
            $resp = $DataObj.$param
        }
        else
        {
            $resp = $resp.$param
        }
    }
    Write-Verbose "Response: $resp"
    $resp
}

New-PolarisRoute -Path "/" -Method GET -Force -Scriptblock {
    $Response.Send($Request.ClientIP)
}

New-PolarisRoute -Path "$BaseUrl" -Method GET -Force -Scriptblock {
    $Response.Json(($Request | ConvertTo-Json))
}

New-PolarisRoute -Path "$BaseUrl/:name" -Method GET -Force -Scriptblock {

    # Remove BaseUrl
    $rawUrl = $Request.RawRequest.RawUrl.Replace($BaseUrl, '')
    # Remove url parameters
    $rawUrl = $rawUrl.Split('?')[0]

    $Response.Json(((Get-DataFromUrl -RawUrl $rawUrl -DataObj $Request) | ConvertTo-Json))
}

#$Response.Json(($Request.($Request.Parameters.name) | ConvertTo-Json))
$app = Start-Polaris -Port $Port -MinRunspaces 1 -MaxRunspaces 5 -UseJsonBodyParserMiddleware -Verbose

while ($app.Listener.IsListening)
{
    Wait-Event callbackcomplete
}