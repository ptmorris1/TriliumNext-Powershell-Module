function Set-TriliumNoteDetails {
    <#
    .SYNOPSIS
    Patch (update) a TriliumNext note's type, title, or both by noteId.

    .DESCRIPTION
    Updates a TriliumNext note's type and/or title using the PATCH /notes/{noteId} endpoint. You must provide the noteId. Optionally, you can provide a new note type (from the supported list) and/or a new title. For certain types, a corresponding mime value will be set in the body. If -NoteType is not specified, the note will default to type 'text' and mime 'text/html'.

    .PARAMETER NoteId
    The ID of the note to update. This parameter is required.

        Required?                    true
        Position?                    0
        Accept pipeline input?       false
        Accept wildcard characters?  false

    .PARAMETER NoteType
    The type to set for the note. Optional. Must be one of:
        text, book, canvas, mermaid, geoMap, mindMap, relationMap, renderNote, webview,
        PlainText, CSS, html, http, JSbackend, JSfrontend, json, markdown, powershell, python, ruby, shellBash, sql, sqliteTrilium, xml, yaml
    If not specified, defaults to 'text' with mime 'text/html'.

        Required?                    false
        Position?                    1
        Accept pipeline input?       false
        Accept wildcard characters?  false

    .PARAMETER Title
    The new title to set for the note. Optional. If not specified, the title will not be changed.

        Required?                    false
        Position?                    2
        Accept pipeline input?       false
        Accept wildcard characters?  false

    .PARAMETER SkipCertCheck
    Option to skip certificate check. Optional. Use this if you are connecting to a Trilium server with a self-signed certificate.

        Required?                    false
        Position?                    Named
        Default value                None
        Accept pipeline input?       false
        Accept wildcard characters?  false

    .EXAMPLE
    Set-TriliumNoteDetails -NoteId "evnnmvHTCgIn" -NoteType PlainText -Title "New Note Title"
    Updates the note with the specified ID, sets the type to 'code' and mime to 'text/plain', and updates the title.

    .EXAMPLE
    Set-TriliumNoteDetails -NoteId "evnnmvHTCgIn" -Title "Updated Title Only"
    Updates only the title of the note with the specified ID.

    .EXAMPLE
    Set-TriliumNoteDetails -NoteId "evnnmvHTCgIn" -NoteType markdown
    Updates only the type of the note with the specified ID to 'code' with mime 'text/x-markdown'.

    .NOTES
    This function requires that authentication has been set using Connect-TriliumAuth.
    If -NoteType is not specified, the note will default to type 'text' and mime 'text/html'.
    If -Title is not specified, the title will not be changed.

    .LINK
    https://github.com/ptmorris1/TriliumNext-Powershell-Module
    #>
    [CmdletBinding()]
    param (
        [Parameter(Mandatory = $true)]
        [ValidateNotNullOrEmpty()]
        [string]$NoteId,
        [Parameter()]
        [ValidateSet('text','book','canvas','mermaid','geoMap','mindMap','relationMap','renderNote','webview',
            'PlainText','CSS','html','http','JSbackend','JSfrontend','json','markdown','powershell','python','ruby','shellBash','sql','sqliteTrilium','xml','yaml')]
        [string]$NoteType,
        [Parameter()]
        [string]$Title,
        [Parameter()]
        [switch]$SkipCertCheck
    )
    begin {
        if (!$global:TriliumCreds) { Write-Error -Message 'Need to run: Connect-TriliumAuth'; exit }
        if (-not $NoteType -and -not $Title) {
            throw 'You must specify at least one of -NoteType or -Title.'
        }
    }
    process {
        try {
            if ($SkipCertCheck -eq $true) {
                $PSDefaultParameterValues = @{'Invoke-RestMethod:SkipCertificateCheck' = $true }
            }
            $TriliumHeaders = @{}
            $TriliumHeaders.Add('Authorization', "$($TriliumCreds.Authorization)")
            $uri = "$($TriliumCreds.URL)/notes/$NoteId"
            $mimeMap = @(
                [PSCustomObject]@{ Note = 'PlainText'; Type = 'code'; Mime = 'text/plain' }
                [PSCustomObject]@{ Note = 'CSS'; Type = 'code'; Mime = 'text/css' }
                [PSCustomObject]@{ Note = 'html'; Type = 'code'; Mime = 'text/html' }
                [PSCustomObject]@{ Note = 'http'; Type = 'code'; Mime = 'message/http' }
                [PSCustomObject]@{ Note = 'JSbackend'; Type = 'code'; Mime = 'application/javascript;env=backend' }
                [PSCustomObject]@{ Note = 'JSfrontend'; Type = 'code'; Mime = 'application/javascript;env=frontend' }
                [PSCustomObject]@{ Note = 'json'; Type = 'code'; Mime = 'application/json' }
                [PSCustomObject]@{ Note = 'markdown'; Type = 'code'; Mime = 'text/x-markdown' }
                [PSCustomObject]@{ Note = 'powershell'; Type = 'code'; Mime = 'application/x-powershell' }
                [PSCustomObject]@{ Note = 'python'; Type = 'code'; Mime = 'text/x-python' }
                [PSCustomObject]@{ Note = 'ruby'; Type = 'code'; Mime = 'text/x-ruby' }
                [PSCustomObject]@{ Note = 'shellBash'; Type = 'code'; Mime = 'text/x-sh' }
                [PSCustomObject]@{ Note = 'sql'; Type = 'code'; Mime = 'text/x-sql' }
                [PSCustomObject]@{ Note = 'sqliteTrilium'; Type = 'code'; Mime = 'text/x-sqlite;schema=trilium' }
                [PSCustomObject]@{ Note = 'xml'; Type = 'code'; Mime = 'text/xml' }
                [PSCustomObject]@{ Note = 'yaml'; Type = 'code'; Mime = 'text/x-yaml' }
                [PSCustomObject]@{ Note = 'text'; Type = 'text'; Mime = 'text/html' }
                [PSCustomObject]@{ Note = 'book'; Type = 'book'; Mime = $null }
                [PSCustomObject]@{ Note = 'canvas'; Type = 'canvas'; Mime = 'application/json' }
                [PSCustomObject]@{ Note = 'mermaid'; Type = 'mermaid'; Mime = 'text/mermaid' }
                [PSCustomObject]@{ Note = 'geoMap'; Type = 'geoMap'; Mime = 'application/json' }
                [PSCustomObject]@{ Note = 'mindMap'; Type = 'mindMap'; Mime = 'application/json' }
                [PSCustomObject]@{ Note = 'relationMap'; Type = 'relationMap'; Mime = 'application/json' }
                [PSCustomObject]@{ Note = 'renderNote'; Type = 'renderNote'; Mime = $null }
                [PSCustomObject]@{ Note = 'webview'; Type = 'webview'; Mime = $null }
            )
            $jsonBody = @{}
            if ($NoteType) {
                $mimeObj = $mimeMap | Where-Object { $_.Note -eq $NoteType }
                if ($mimeObj) {
                    $jsonBody.type = $mimeObj.Type
                    if ($null -ne $mimeObj.Mime) {
                        $jsonBody.mime = $mimeObj.Mime
                    }
                } else {
                    $jsonBody.type = $NoteType
                }
            } else {
                $jsonBody.type = 'text'
                $jsonBody.mime = 'text/html'
            }
            if ($Title) { $jsonBody.title = $Title }
            $jsonBody = $jsonBody | ConvertTo-Json
            Invoke-RestMethod -Uri $uri -Headers $TriliumHeaders -Method Patch -Body $jsonBody -ContentType 'application/json' -SkipHeaderValidation
        } catch {
            $_.Exception.Response
        }
    }
}
