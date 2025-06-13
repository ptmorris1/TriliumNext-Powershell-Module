function Get-TriliumNoteAttachment {
    <#
    .SYNOPSIS
    Gets attachments for a specific TriliumNext note.

    .DESCRIPTION
    This function retrieves the attachments of a specific TriliumNext note based on the provided note ID.

    .PARAMETER NoteID
    The note ID to get attachments for.

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
    Get-TriliumNoteAttachment -NoteID "12345"

    .NOTES
    This function requires that the authentication has been set using Connect-TriliumAuth.

    .LINK
    https://github.com/ptmorris1/TriliumNext-Powershell-Module
    #>
    [CmdletBinding()]
    param (
        # Note ID to get attachments for
        [Parameter(Mandatory = $True)][ValidateNotNullOrEmpty()][string]$NoteID,
        [switch]$SkipCertCheck
    )
    process {
        try {
            if ($SkipCertCheck -eq $true) {
                $PSDefaultParameterValues = @{'Invoke-RestMethod:SkipCertificateCheck' = $true }
            }
            # Set headers and make request to get note attachments
            $TriliumHeaders = @{}
            $TriliumHeaders.Add('Authorization', "$($TriliumCreds.Authorization)")
            $uri = "$($TriliumCreds.URL)/notes/$NoteID/attachments"
            Invoke-RestMethod -Uri $uri -Headers $TriliumHeaders -SkipHeaderValidation
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
