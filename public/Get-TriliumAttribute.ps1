function Get-TriliumAttribute {
    <#
    .SYNOPSIS
    Gets details of a specific Trilium attribute.

    .DESCRIPTION
    This function retrieves the details of a specific Trilium attribute based on the provided attribute ID.

    .PARAMETER AttributeID
    The attribute ID to get details for.

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
    Get-TriliumAttribute -AttributeID "12345"

    .NOTES
    This function requires that the authentication has been set using Connect-TriliumAuth.

    .LINK
    https://github.com/ptmorris1/TriliumNext-Powershell-Module
    #>
    [CmdletBinding(SupportsShouldProcess = $true)]
    param (
        [Parameter(Mandatory = $true)]
        [ValidateNotNullOrEmpty()]
        [string]$AttributeID,
        [switch]$SkipCertCheck
    )

    process {
        try {
            if ($SkipCertCheck -eq $true) {
                $PSDefaultParameterValues = @{'Invoke-RestMethod:SkipCertificateCheck' = $true }
            }
            $TriliumHeaders = @{}
            $TriliumHeaders.Add('Authorization', "$($TriliumCreds.Authorization)")
            $uri = "$($TriliumCreds.URL)/attributes/$AttributeID"
            if ($PSCmdlet.ShouldProcess($uri, 'Update note order')) {
                Invoke-RestMethod -Uri $uri -Headers $TriliumHeaders -SkipHeaderValidation
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