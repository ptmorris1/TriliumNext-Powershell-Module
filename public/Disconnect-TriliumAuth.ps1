function Disconnect-TriliumAuth {
    <#
    .SYNOPSIS
    Removes the authentication for TriliumNext.

    .DESCRIPTION
    This function removes the authentication for TriliumNext. If using password authentication, it logs out. If using ETAPI token, it displays an error.

    .PARAMETER SkipCertCheck
    Option to skip certificate check.

        Required?                    false
        Position?                    Named
        Default value                None
        Accept pipeline input?       false
        Accept wildcard characters?  false

    .EXAMPLE
    Disconnect-TriliumAuth

    .NOTES
    This function should be called when you want to clear the stored credentials. It will also log out if password authentication was used.

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