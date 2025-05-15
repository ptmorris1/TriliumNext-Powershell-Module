function New-TriliumNoteRevision {
    <#
    .SYNOPSIS
    Creates a new revision for a specific Trilium note.

    .DESCRIPTION
    This function creates a new revision for a specific Trilium note based on the provided note ID.

    .PARAMETER NoteID
    The note ID to create a new revision for.

        Required?                    true
        Position?                    0
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
    New-TriliumNoteRevision -NoteID "12345"

    .NOTES
    This function requires that the authentication has been set using Connect-TriliumAuth.

    .LINK
    https://github.com/ptmorris1/TriliumNext-Powershell-Module
    #>
    [CmdletBinding(SupportsShouldProcess = $true)]
    param (
        [Parameter(Mandatory = $true)]
        [ValidateNotNullOrEmpty()]
        [string]$NoteID,
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
                $uri = "$($TriliumCreds.URL)/notes/$NoteID/revision"
                if ($PSCmdlet.ShouldProcess($uri, 'Creating revision')) {
                    Invoke-RestMethod -Uri $uri -Headers $TriliumHeaders -Method Post -SkipHeaderValidation
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