function Get-TriliumAttachmentContent {
    <#
    .SYNOPSIS
    Gets the content of a specific TriliumNext attachment by its ID.

    .DESCRIPTION
    This function retrieves the content of a TriliumNext attachment using the provided attachment ID.

    .PARAMETER AttachmentID
    The attachment ID to retrieve content for.

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
    Get-TriliumAttachmentContent -AttachmentID "evnnmvHTCgIn"

    .NOTES
    This function requires that the authentication has been set using Connect-TriliumAuth.

    .LINK
    https://github.com/ptmorris1/TriliumNext-Powershell-Module
    #>
    [CmdletBinding()]
    param (
        # Attachment ID to retrieve content for
        [Parameter(Mandatory = $True)][ValidateNotNullOrEmpty()][string]$AttachmentID,
        [switch]$SkipCertCheck
    )
    begin {
        if (!$global:TriliumCreds) { Write-Error -Message 'Need to run: Connect-TriliumAuth'; exit }
    }
    process {
        try {
            if ($SkipCertCheck -eq $true) {
                $PSDefaultParameterValues = @{'Invoke-RestMethod:SkipCertificateCheck' = $true }
            }
            $TriliumHeaders = @{}
            $TriliumHeaders.Add('Authorization', "$($TriliumCreds.Authorization)")
            $TriliumHeaders.Add('Accept', 'text/html')
            $uri = "$($TriliumCreds.URL)/attachments/$AttachmentID/content"
            Invoke-RestMethod -Uri $uri -Headers $TriliumHeaders -SkipHeaderValidation
        } catch {
            $_.Exception.Response
        }
    }
    end {
        return
    }
}
