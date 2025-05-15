function Remove-TriliumNote {
    <#
    .SYNOPSIS
    Removes a Trilium note.

    .DESCRIPTION
    This function removes a Trilium note based on the provided note ID.

    .PARAMETER NoteID
    The note ID to remove.

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
    Remove-TriliumNote -NoteID "12345"

    .NOTES
    This function requires that the authentication has been set using Connect-TriliumAuth.

    .LINK
    https://github.com/ptmorris1/TriliumNext-Powershell-Module
    #>
    [CmdletBinding(SupportsShouldProcess = $true)]
    param (
        # Note ID to remove
        [Parameter(Mandatory = $true)][ValidateNotNullOrEmpty()][string]$NoteID,
        [switch]$SkipCertCheck
    )
    process {
        try {
            if ($SkipCertCheck -eq $true) {
                $PSDefaultParameterValues = @{'Invoke-RestMethod:SkipCertificateCheck' = $true }
            }
            # Set headers and make request to remove note
            $TriliumHeaders = @{}
            $TriliumHeaders.Add('Authorization', "$($TriliumCreds.Authorization)")
            $uri = "$($TriliumCreds.URL)/notes/$NoteID"
            if ($PSCmdlet.ShouldProcess($uri, 'Removing Note')) {
                Invoke-RestMethod -Uri $uri -Headers $TriliumHeaders -Method Delete -SkipHeaderValidation
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