function New-TriliumNote {
    <#
    .SYNOPSIS
    Creates a new Trilium note.

    .DESCRIPTION
    This function creates a new Trilium note under the specified parent note ID with the provided title and content.

    .PARAMETER ParentNoteId
    The parent note ID to create the new note under.

        Required?                    true
        Position?                    0
        Default value                None
        Accept pipeline input?       false
        Accept wildcard characters?  false

    .PARAMETER Title
    The title of the new note.

        Required?                    true
        Position?                    1
        Default value                None
        Accept pipeline input?       false
        Accept wildcard characters?  false

    .PARAMETER Content
    The content of the new note.

        Required?                    true
        Position?                    2
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
    New-TriliumNote -ParentNoteId "root" -Title "New Note" -Content "This is a new note."

    .NOTES
    This function requires that the authentication has been set using Connect-TriliumAuth.

    .LINK
    https://github.com/ptmorris1/TriliumNext-Powershell-Module
    #>
    [CmdletBinding(SupportsShouldProcess = $true)]
    param (
        # Parent note ID to create the new note under
        [Parameter(Mandatory = $true)][ValidateNotNullOrEmpty()][string]$ParentNoteId,
        # Title of the new note
        [Parameter(Mandatory = $true)][ValidateNotNullOrEmpty()][string]$Title,
        # Content of the new note
        [Parameter(Mandatory = $true)][ValidateNotNullOrEmpty()][string]$Content,
        [switch]$SkipCertCheck
    )
    process {
        try {
            if ($SkipCertCheck -eq $true) {
                $PSDefaultParameterValues = @{'Invoke-RestMethod:SkipCertificateCheck' = $true }
            }
            # Set headers and make request to create new note
            $TriliumHeaders = @{}
            $TriliumHeaders.Add('Authorization', "$($TriliumCreds.Authorization)")
            $uri = "$($TriliumCreds.URL)/create-note"
            $body = @{
                parentNoteId = $ParentNoteId
                title        = $Title
                content      = $Content
                type         = 'text'
            }
            $body = $body | ConvertTo-Json
            if ($PSCmdlet.ShouldProcess($uri, 'Update note order')) {
                Invoke-RestMethod -Uri $uri -Headers $TriliumHeaders -SkipHeaderValidation -ContentType 'application/json' -Body $body -Method Post
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