function New-TriliumBackup {
    <#
    .SYNOPSIS
    Creates a new backup for a specific Trilium instance.

    .DESCRIPTION
    This function creates a new backup for a specific Trilium instance based on the provided backup ID.

    .PARAMETER BackupID
    The backup ID to create a new backup for.

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
    New-TriliumBackup -BackupID "MyBackup"

    .NOTES
    This function requires that the authentication has been set using Connect-TriliumAuth.

    .LINK
    https://github.com/ptmorris1/TriliumNext-Powershell-Module
    #>
    [CmdletBinding(SupportsShouldProcess = $true)]
    param (
        [Parameter(Mandatory = $true)][ValidateNotNullOrEmpty()][string]$BackupID,
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
                $uri = "$($TriliumCreds.URL)/backup/$BackupID"
                if ($PSCmdlet.ShouldProcess($uri, 'Create backup')) {
                    Invoke-RestMethod -Uri $uri -Headers $TriliumHeaders -Method Put -SkipHeaderValidation
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