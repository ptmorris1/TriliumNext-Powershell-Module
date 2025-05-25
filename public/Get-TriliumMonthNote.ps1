function Get-TriliumMonthNote {
    <#
    .SYNOPSIS
    Gets (or creates) the TriliumNext month note for a specific month.

    .DESCRIPTION
    This function retrieves the TriliumNext month note using the provided month. If the note does not exist, it will be created. The month note is typically used for monthly journaling or planning.

    .PARAMETER Month
    The month for which to retrieve the month note. Accepts a [datetime] object. Format sent to API: yyyy-MM. Defaults to the current month if not specified.

        Required?                    false
        Position?                    0
        Default value                Current month
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
    Get-TriliumMonthNote -Month "2022-02"

    .NOTES
    This function requires that the authentication has been set using Connect-TriliumAuth.
    If the month note for the specified month does not exist, it will be created automatically.

    .LINK
    https://github.com/ptmorris1/TriliumNext-Powershell-Module
    #>
    [CmdletBinding()]
    param (
        # Month for which to retrieve the month note (accepts [datetime], defaults to current month)
        [Parameter(Mandatory = $false)][ValidateNotNullOrEmpty()][datetime]$Month = (Get-Date),
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
            $monthString = $Month.ToString('yyyy-MM')
            $uri = "$($TriliumCreds.URL)/calendar/months/$monthString"
            Invoke-RestMethod -Uri $uri -Headers $TriliumHeaders -SkipHeaderValidation
        } catch {
            $_.Exception.Response
        }
    }
    end {
        return
    }
}
