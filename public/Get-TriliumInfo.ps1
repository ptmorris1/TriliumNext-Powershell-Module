function Get-TriliumInfo {
    <#
    .SYNOPSIS
    Gets the application info for TriliumNext.

    .DESCRIPTION
    This function retrieves the application info for TriliumNext.

    .PARAMETER SkipCertCheck
    Option to skip certificate check.

        Required?                    false
        Position?                    Named
        Default value                None
        Accept pipeline input?       false
        Accept wildcard characters?  false

    .EXAMPLE
    Get-TriliumInfo

    .NOTES
    This function requires that the authentication has been set using Connect-TriliumAuth.

    .LINK
    https://github.com/ptmorris1/TriliumNext-Powershell-Module
    #>
    [CmdletBinding()]
    param(
        [switch]$SkipCertCheck
    )
    # Set headers and make request to get app info
    process {
        try {
            if ($SkipCertCheck -eq $true) {
                $PSDefaultParameterValues = @{'Invoke-RestMethod:SkipCertificateCheck' = $true }
            }
            $TriliumHeaders = @{}
            $TriliumHeaders.Add('Authorization', "$($TriliumCreds.Authorization)")
            try {
                Invoke-RestMethod -Uri "$($TriliumCreds.URL)/app-info" -Headers $TriliumHeaders -SkipHeaderValidation
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