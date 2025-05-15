function Remove-TriliumBranch {
    <#
    .SYNOPSIS
    Removes a specific Trilium branch.

    .DESCRIPTION
    This function removes a specific Trilium branch based on the provided branch ID.

    .PARAMETER BranchID
    The branch ID to remove.

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
    Remove-TriliumBranch -BranchID "A2PGuqZgT03z_sxhoPPMkVIuO"

    .NOTES
    This function requires that the authentication has been set using Connect-TriliumAuth.

    .LINK
    https://github.com/ptmorris1/TriliumNext-Powershell-Module
    #>
    [CmdletBinding(SupportsShouldProcess = $true)]
    param (
        [Parameter(Mandatory = $true)][ValidateNotNullOrEmpty()][string]$BranchID,
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
                $uri = "$($TriliumCreds.URL)/branches/$BranchID"
                if ($PSCmdlet.ShouldProcess($uri, 'Removing branch')) {
                    Invoke-RestMethod -Uri $uri -Headers $TriliumHeaders -SkipHeaderValidation -Method Delete
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