function Get-TriliumYearNote {
    <#
    .SYNOPSIS
    Gets (or creates) the TriliumNext year note for a specific year.

    .DESCRIPTION
    This function retrieves the TriliumNext year note using the provided year. If the note does not exist, it will be created. The year note is typically used for yearly journaling or planning.

    .PARAMETER Year
    The year for which to retrieve the year note. Accepts a [datetime] object. Format sent to API: yyyy. Defaults to the current year if not specified.

        Required?                    false
        Position?                    0
        Default value                Current year
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
    Get-TriliumYearNote -Year "2022"

    .NOTES
    This function requires that the authentication has been set using Connect-TriliumAuth.
    If the year note for the specified year does not exist, it will be created automatically.

    .LINK
    https://github.com/ptmorris1/TriliumNext-Powershell-Module
    #>
    [CmdletBinding()]
    param (
        # Year for which to retrieve the year note (accepts [datetime], defaults to current year)
        [Parameter(Mandatory = $false)][ValidateNotNullOrEmpty()][datetime]$Year = (Get-Date),
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
            $yearString = $Year.ToString('yyyy')
            $uri = "$($TriliumCreds.URL)/calendar/years/$yearString"
            Invoke-RestMethod -Uri $uri -Headers $TriliumHeaders -SkipHeaderValidation
        } catch {
            $_.Exception.Response
        }
    }
    end {
        return
    }
}
