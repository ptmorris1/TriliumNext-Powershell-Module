function Disconnect-TriliumAuth {
    <#
    .SYNOPSIS
        Removes authentication for TriliumNext and clears stored credentials.

    .DESCRIPTION
        This function removes authentication for TriliumNext by clearing the global credential variable `$Global:TriliumCreds`. If you authenticated using a password, it will also log you out of Trilium via the API. If you authenticated using an ETAPI token, it will only remove the global variable (no logout API call is made).

    .PARAMETER SkipCertCheck
        If specified, SSL certificate errors will be ignored (useful for self-signed certificates). Optional.

        Required?                    false
        Position?                    Named
        Default value                false
        Accept pipeline input?       false
        Accept wildcard characters?  false

    .INPUTS
        None. You cannot pipe objects to Disconnect-TriliumAuth.

    .OUTPUTS
        None. This function performs logout and/or clears credentials.

    .EXAMPLE
        Disconnect-TriliumAuth

        Logs out (if using password authentication) and clears credentials.

    .NOTES
        - Use this function to clear your credentials from the session, especially if you switch users or finish automation tasks.
        - If you authenticated with a password, this will log you out of Trilium. If you used an ETAPI token, it only clears the session variable.
        - Use -SkipCertCheck for self-signed or untrusted SSL certificates.
        - Author: P. Morris
        - Module: TriliumNext-Powershell-Module

    .LINK
        https://github.com/ptmorris1/TriliumNext-Powershell-Module
    #>
    [CmdletBinding()]
    param(
        [switch]$SkipCertCheck
    )
    # Check if using password authentication and log out, otherwise display error
    process {
        try {
            if ($SkipCertCheck -eq $true) {
                $PSDefaultParameterValues = @{'Invoke-RestMethod:SkipCertificateCheck' = $true }
            }
            if ($TriliumCreds.token -eq 'pass') {
                $TriliumHeaders = @{}
                $TriliumHeaders.Add('Authorization', "$($TriliumCreds.Authorization)")
                Invoke-RestMethod -Uri "$($TriliumCreds.URL)/auth/logout" -Headers $TriliumHeaders -SkipHeaderValidation -Method Post
                Remove-Variable TriliumCreds -ErrorAction SilentlyContinue
                Write-Output 'Removed ETAPI token and global variable'
            } else {
                Write-Output 'Using ETAPI key, will remove global variable'
                Remove-Variable TriliumCreds -ErrorAction SilentlyContinue
            }
        } catch {
            $_.Exception.Response
        }
    }

    begin {

    }

    end {
        return
    }
}