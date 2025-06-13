function New-TriliumAttribute {
    [CmdletBinding()]
    param(
        [Parameter(Mandatory = $true)]
        [string]$NoteID,
        [Parameter(Mandatory = $true)]
        [string]$Name,
        [Parameter(Mandatory = $true)]
        [string]$Value,
        [ValidateSet('label','relation')]
        [string]$Type = 'label',
        [bool]$IsInheritable,
        [string]$AttributeId
    )

    if (!$global:TriliumCreds) { Write-Error -Message 'Need to run: Connect-TriliumAuth'; exit }
    $TriliumHeaders = @{}
    $TriliumHeaders.Add('Authorization', "$($TriliumCreds.Authorization)")
    $baseUrl = $TriliumCreds.URL -replace '/etapi/?$',''
    $uri = "$baseUrl/etapi/attributes/"

    $body = @{
        noteId = $NoteID
        type = $Type
        name = $Name
        value = $Value
        isInheritable = $IsInheritable
    }
    if ($AttributeId) { $body.attributeId = $AttributeId }
    $jsonBody = $body | ConvertTo-Json

    $response = Invoke-RestMethod -Uri $uri -Headers $TriliumHeaders -Method Post -Body $jsonBody -ContentType 'application/json'
    return $response
}