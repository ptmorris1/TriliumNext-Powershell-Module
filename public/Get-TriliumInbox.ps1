function Get-TriliumInbox {
    <#
    .SYNOPSIS
    Gets (or creates) the TriliumNext inbox note for a specific date.

    .DESCRIPTION
    This function retrieves the TriliumNext inbox note using the provided date. If the note does not exist, it will be created at #calendarRoot. The inbox may be a fixed note (with #inbox label) or a day note in a journal, depending on the date parameter.

    .PARAMETER Date
    The date for which to retrieve the inbox note. Accepts a [datetime] object. Format sent to API: yyyy-MM-dd. Defaults to today if not specified.

        Required?                    false
        Position?                    0
        Default value                Today
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
    Get-TriliumInbox -Date "2022-02-22"

    .NOTES
    This function requires that the authentication has been set using Connect-TriliumAuth.
    If the inbox note for the specified date does not exist, it will be created at #calendarRoot.

    .LINK
    https://github.com/ptmorris1/TriliumNext-Powershell-Module
    #>
    [CmdletBinding()]
    param (
        # Date for which to retrieve the inbox note (accepts [datetime], defaults to today)
        [Parameter(Mandatory = $false)][ValidateNotNullOrEmpty()][datetime]$Date = (Get-Date),
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
            $dateString = $Date.ToString('yyyy-MM-dd')
            $uri = "$($TriliumCreds.URL)/inbox/$dateString"
            Invoke-RestMethod -Uri $uri -Headers $TriliumHeaders -SkipHeaderValidation
        } catch {
            $_.Exception.Response
        }
    }
    end {
        return
    }
}
