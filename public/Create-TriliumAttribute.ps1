function Create-TriliumAttribute {
    [CmdletBinding()]
    param(
        [ValidateSet('label','relation')]
        [string]$Type,
        [string]$Name,
        [string]$Value,
        [string]$NoteID,
        [bool]$IsInheritable
    )

    $body = @{
        type = $Type
        name = $Name
        value = $Value
        isInheritable = $IsInheritable
    }
    if ($NoteID) { $body.noteId = $NoteID }
    $jsonBody = $body | ConvertTo-Json

    $response = Invoke-RestMethod -Uri "http://<trilium-server>/attributes" -Method Post -Body $jsonBody -ContentType 'application/json'
    return $response
}