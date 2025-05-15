function Update-TriliumNoteOrder {
    <#
    .SYNOPSIS
    Updates the order of notes under a specific parent note.

    .DESCRIPTION
    This function updates the order of notes under a specific parent note based on the provided parent note ID.

    .PARAMETER ParentNoteId
    The parent note ID to update the order for.

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
    Update-TriliumNoteOrder -ParentNoteId "root"

    .NOTES
    This function requires that the authentication has been set using Connect-TriliumAuth.

    .LINK
    https://github.com/ptmorris1/TriliumNext-Powershell-Module
    #>
    [CmdletBinding(SupportsShouldProcess = $true)]
    [Alias('utno')]
    param (
        [Parameter(Mandatory = $true)]
        [ValidateNotNullOrEmpty()]
        [string]$ParentNoteId,
        [switch]$SkipCertCheck
    )

    process {
        try {
            if ($SkipCertCheck -eq $true) {
                $PSDefaultParameterValues = @{'Invoke-RestMethod:SkipCertificateCheck' = $true }
            }
            $TriliumHeaders = @{}
            $TriliumHeaders.Add('Authorization', "$($TriliumCreds.Authorization)")
            $uri = "$($TriliumCreds.URL)/refresh-note-ordering/$ParentNoteId"
            if ($PSCmdlet.ShouldProcess($uri, 'Update note order')) {
                Invoke-RestMethod -Uri $uri -Headers $TriliumHeaders -SkipHeaderValidation -Method Post
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