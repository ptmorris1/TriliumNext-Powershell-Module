function Import-TriliumNoteZip {
    <#
    .SYNOPSIS
    Imports a Trilium note zip file to a specific Trilium note.

    .DESCRIPTION
    This function uploads a zip file to a specific Trilium note based on the provided note ID and zip file path.
    The zip file is an export of a note from Trilium.
    You can use Export-TriliumNote to create this zip if needed or the Trilium GUI

    .PARAMETER NoteID
    The note ID to add the zip file to.

        Required?                    true
        Position?                    0
        Default value                None
        Accept pipeline input?       false
        Accept wildcard characters?  false

    .PARAMETER ZipPath
    The path to the zip file to upload.

        Required?                    true
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
    Import-TriliumNoteZip -NoteID "root" -ZipPath "C:\temp\import.zip"

    .NOTES
    This function requires that the authentication has been set using Connect-TriliumAuth.
    Ensure that the provided path is valid and points to a zip file.

    .LINK
    https://github.com/ptmorris1/TriliumNext-Powershell-Module
    #>
    [CmdletBinding(SupportsShouldProcess = $true)]
    param (
        [Parameter(Mandatory = $true)]
        [ValidateNotNullOrEmpty()]
        [string]$NoteID,
        [Parameter(Mandatory = $true)]
        [ValidateNotNullOrEmpty()]
        [string]$ZipPath,
        [switch]$SkipCertCheck
    )

    process {
        try {
            if ($SkipCertCheck -eq $true) {
                $PSDefaultParameterValues = @{'Invoke-RestMethod:SkipCertificateCheck' = $true }
            }
            $TriliumHeaders = @{}
            $TriliumHeaders.Add('Authorization', "$($TriliumCreds.Authorization)")
            # Read the zip file content as byte array
            $fileBytes = [System.IO.File]::ReadAllBytes($ZipPath)
            # API call run
            try {
                $uri = "$($TriliumCreds.URL)/notes/$NoteID/import"
                $TriliumHeaders.Add('Content-Transfer-Encoding', 'binary')
                if ($PSCmdlet.ShouldProcess($uri, 'Importing')) {
                    Invoke-RestMethod -Uri $uri -Headers $TriliumHeaders -Method Post -SkipHeaderValidation -Body $fileBytes -ContentType 'application/octet-stream'
                }
            } catch {
                $_.Exception.Response
            }
        } catch {
            $_.Exception.Response
        }
    }
    begin {
        if (!$global:TriliumCreds) { Write-Error -Message 'Need to run: Connect-TriliumAuth'; exit }
        # Validate that the ZipPath is a correct Windows path with .zip extension
        if ($ZipPath -notmatch '^[a-zA-Z]:\\(?:[^\\\/:*?"<>|\r\n]+\\)*[^\\\/:*?"<>|\r\n]+\.(zip)$') {
            throw 'Invalid path. Please provide a valid Windows path with a .zip extension. `nExample: C:\temp\import.zip'
        }
    }
    end {
        return
    }
}