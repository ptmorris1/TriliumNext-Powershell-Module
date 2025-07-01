function Get-TriliumRootNote {
    <#
    .SYNOPSIS
        Gets the root note details from the TriliumNext instance.

    .DESCRIPTION
        Retrieves the root note of your TriliumNext instance, including its ID, title, and metadata. Useful for obtaining the top-level note structure for navigation or automation.

    .PARAMETER SkipCertCheck
        If specified, SSL certificate errors will be ignored (useful for self-signed certs).

        Required?                    false
        Position?                    named
        Default value                false
        Accept pipeline input?       false
        Accept wildcard characters?  false

    .INPUTS
        None. You cannot pipe objects to Get-TriliumRootNote.

    .OUTPUTS
        System.Management.Automation.PSCustomObject
        Returns the root note object from Trilium, including its ID, title, and metadata.

    .EXAMPLE
        Get-TriliumRootNote

        Retrieves the root note details from the connected Trilium instance.

    .EXAMPLE
        Get-TriliumRootNote -SkipCertCheck

        Retrieves the root note details, skipping SSL certificate validation (for self-signed certs).

    .NOTES
        - Requires authentication using Connect-TriliumAuth before use.
        - Author: P. Morris
        - Module: TriliumNext-Powershell-Module

    .LINK
        Online version: https://github.com/ptmorris1/TriliumNext-Powershell-Module
    .LINK
        Connect-TriliumAuth
    #>
    [CmdletBinding()]
    param(
        [switch]$SkipCertCheck
    )
    # Set headers and make request to get root note
    process {
        try {
            if ($SkipCertCheck -eq $true) {
                $PSDefaultParameterValues = @{'Invoke-RestMethod:SkipCertificateCheck' = $true }
            }
            $TriliumHeaders = @{}
            $TriliumHeaders.Add('Authorization', "$($TriliumCreds.Authorization)")
            Invoke-RestMethod -Uri "$($TriliumCreds.URL)/notes/root" -Headers $TriliumHeaders -SkipHeaderValidation
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