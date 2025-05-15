function Export-TriliumNote {
    <#
    .SYNOPSIS
    Exports a TriliumNext note to a zip file.

    .DESCRIPTION
    This function exports a TriliumNext note to a zip file based on the provided note ID and optional path.

    .PARAMETER NoteID
    The note ID to export.

        Required?                    true
        Position?                    0
        Default value                None
        Accept pipeline input?       false
        Accept wildcard characters?  false

    .PARAMETER Path
    Optional path to save the exported file.

        Required?                    false
        Position?                    1
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
    Export-TriliumNote -NoteID "12345" -Path "C:\temp\export.zip"

    .NOTES
    This function requires that the authentication has been set using Connect-TriliumAuth.
    Ensure that the provided path is valid and writable.

    .LINK
    https://github.com/ptmorris1/TriliumNext-Powershell-Module
    #>
    [CmdletBinding()]
    param (
        # Note ID to export
        [Parameter(Mandatory = $True)]
        [ValidateNotNullOrEmpty()]
        [string]$NoteID,

        # Optional path to save the exported file
        [Parameter(Mandatory = $false)]
        [ValidateNotNullOrEmpty()]
        [string]$Path,

        [switch]$SkipCertCheck,

        [switch]$Markdown
    )
    # Get note details and check if path is specified
    process {
        try {
            if ($SkipCertCheck -eq $true) {
                $PSDefaultParameterValues = @{'Invoke-RestMethod:SkipCertificateCheck' = $true }
            }
            $details = Get-TriliumNoteDetail -NoteID $NoteID
            if ([string]::IsNullOrEmpty($Path)) {
                $Path = "c:\temp\$($details.title + '_' + $NoteID).zip"
            } elseif ($Path -notmatch '.zip') {
                Write-Error 'Full path needed with filename and .zip extension:  C:\temp\export.zip'
            }

            if ($Markdown = $true){
                $uri = "$($TriliumCreds.URL)/notes/$NoteID/export?format=markdown"
            } else {
                $uri = "$($TriliumCreds.URL)/notes/$NoteID/export"
            }

            # Set headers and make request to export note
            $TriliumHeaders = @{}
            $TriliumHeaders.Add('Authorization', "$($TriliumCreds.Authorization)")
            
            Invoke-RestMethod -Uri $uri -Headers $TriliumHeaders -SkipHeaderValidation -ContentType 'application/zip' -OutFile $Path
            Write-Output "$($details.title) exported to $Path"
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