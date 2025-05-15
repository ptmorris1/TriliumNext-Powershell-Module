function Set-TriliumNoteContent {
    <#
    .SYNOPSIS
    Sets the content of a specific Trilium note.

    .DESCRIPTION
    This function updates the content of a specific Trilium note based on the provided note ID and content.

    .PARAMETER NoteID
    The note ID to set content for.

        Required?                    true
        Position?                    0
        Default value                None
        Accept pipeline input?       false
        Accept wildcard characters?  false

    .PARAMETER NoteContent
    The html content to set for the note.

        Required?                    true
        Position?                    1
        Default value                None
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
    Set-TriliumNoteContent -NoteID "root" -NoteContent "Updated content for the root note."

    .NOTES
    This function requires that the authentication has been set using Connect-TriliumAuth.

    .LINK
    https://github.com/ptmorris1/TriliumNext-Powershell-Module
    #>
    [CmdletBinding(SupportsShouldProcess = $true)]
    param (
        [Parameter(Mandatory = $true)][ValidateNotNullOrEmpty()][string]$NoteID,
        [Parameter(Mandatory = $true)][ValidateNotNullOrEmpty()][string]$NoteContent,
        [switch]$SkipCertCheck
    )

    process {
        try {
            if ($SkipCertCheck -eq $true) {
                $PSDefaultParameterValues = @{'Invoke-RestMethod:SkipCertificateCheck' = $true }
            }
            $TriliumHeaders = @{}
            $TriliumHeaders.Add('Authorization', "$($TriliumCreds.Authorization)")
            # API call run
            try {
                $uri = "$($TriliumCreds.URL)/notes/$NoteID/content"
                $body = $NoteContent
                if ($PSCmdlet.ShouldProcess($uri, 'Update note order')) {
                    Invoke-RestMethod -Uri $uri -Headers $TriliumHeaders -Method Put -SkipHeaderValidation -Body $body -ContentType 'text/plain'
                }
            } catch {
                $_.Exception.Response
            }
        } catch {
            $_.Exception.Response
        }
    }
    begin {
        if (!$global:TriliumCreds) { Write-Error -Message 'Need to run: Connect-TriliumAuth'; exit }

    }
    end {
        return
    }
}