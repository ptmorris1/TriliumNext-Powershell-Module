function Remove-TriliumAttribute {
    <#
    .SYNOPSIS
    Removes a specific Trilium attribute.

    .DESCRIPTION
    This function removes a specific Trilium attribute based on the provided attribute ID.

    .PARAMETER AttributeID
    The attribute ID to remove.

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
    Remove-TriliumAttribute -AttributeID "12345"

    .NOTES
    This function requires that the authentication has been set using Connect-TriliumAuth.

    .LINK
    https://github.com/ptmorris1/TriliumNext-Powershell-Module
    #>
    [CmdletBinding(SupportsShouldProcess = $true)]
    [Alias('Delete-TriliumAttribute', 'dta', 'rta')]
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
            if ($PSCmdlet.ShouldProcess($uri, 'Remove attribute')) {
                Invoke-RestMethod -Uri $uri -Headers $TriliumHeaders -SkipHeaderValidation -Method Delete
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