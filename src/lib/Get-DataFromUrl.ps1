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