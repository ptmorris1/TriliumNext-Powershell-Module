function Set-TriliumNoteDetails {
    <#
    .SYNOPSIS
    Patch (update) a TriliumNext note's type by noteId.

    .DESCRIPTION
    This function updates a TriliumNext note's type using the PATCH /notes/{noteId} endpoint. You must provide the noteId and select a note type from the supported list. Optionally, you can provide a new title for the note. For certain types, a corresponding mime value will be set in the body.

    .PARAMETER NoteId
    The ID of the note to update.

        Required?                    true
        Position?                    0
        Accept pipeline input?       false
        Accept wildcard characters?  false

    .PARAMETER NoteType
    The type to set for the note. Must be one of:
        text, book, canvas, mermaid, geoMap, mindMap, relationMap, renderNote, webview,
        PlainText, CSS, html, http, JSbackend, JSfrontend, json, markdown, powershell, python, ruby, 'shell bash', sql, 'sqlite trilium', xml, yaml

        Required?                    false
        Position?                    1
        Accept pipeline input?       false
        Accept wildcard characters?  false

    .PARAMETER Title
    The new title to set for the note.

        Required?                    false
        Position?                    2
        Accept pipeline input?       false
        Accept wildcard characters?  false

    .PARAMETER SkipCertCheck
    Option to skip certificate check.

        Required?                    false
        Position?                    Named
        Default value                None
        Accept pipeline input?       false
        Accept wildcard characters?  false

    .EXAMPLE
    Set-TriliumNoteDetails -NoteId "evnnmvHTCgIn" -NoteType PlainText -Title "New Note Title"

    .NOTES
    This function requires that the authentication has been set using Connect-TriliumAuth.

    .LINK
    https://github.com/ptmorris1/TriliumNext-Powershell-Module
    #>
    [CmdletBinding()]
    param (
        [Parameter(Mandatory = $true)][ValidateNotNullOrEmpty()][string]$NoteId,
        [Parameter(Mandatory = $false)][ValidateSet('text','book','canvas','mermaid','geoMap','mindMap','relationMap','renderNote','webview',
            'PlainText','CSS','html','http','JSbackend','JSfrontend','json','markdown','powershell','python','ruby','shell bash','sql','sqlite trilium','xml','yaml')][string]$NoteType,
        [Parameter(Mandatory = $false)][string]$Title,
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
            $mimeMap = @{
                'PlainText' = 'text/plain'
                'CSS' = 'text/css'
                'html' = 'text/html'
                'http' = 'message/http'
                'JSbackend' = 'application/javascript;env=backend'
                'JSfrontend' = 'application/javascript;env=frontend'
                'json' = 'application/json'
                'markdown' = 'text/x-markdown'
                'powershell' = 'application/x-powershell'
                'python' = 'text/x-python'
                'ruby' = 'text/x-ruby'
                'shell bash' = 'text/x-sh'
                'sql' = 'text/x-sql'
                'sqlite trilium' = 'text/x-sqlite;schema=trilium'
                'xml' = 'text/xml'
                'yaml' = 'text/x-yaml'
            }
            $jsonBody = @{}
            if ($NoteType) {
                if ($mimeMap.ContainsKey($NoteType)) {
                    $jsonBody.type = 'code'
                    $jsonBody.mime = $mimeMap[$NoteType]
                } else {
                    $jsonBody.type = $NoteType
                }
            }
            if ($Title) { $jsonBody.title = $Title }
            $jsonBody = $jsonBody | ConvertTo-Json
            Invoke-RestMethod -Uri $uri -Headers $TriliumHeaders -Method Patch -Body $jsonBody -ContentType 'application/json' -SkipHeaderValidation
        } catch {
            $_.Exception.Response
        }
    }
    end {
        return
    }
}
