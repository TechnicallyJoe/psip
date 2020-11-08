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