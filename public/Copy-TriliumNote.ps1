function Copy-TriliumNote {
    <#
    .SYNOPSIS
    Creates a clone (branch) of a Trilium note in another note.

    .DESCRIPTION
    This function clones a Trilium note to a new parent note based on the provided note ID and parent note ID.

    .PARAMETER NoteID
    The note ID to clone.

        Required?                    true
        Position?                    0
        Default value                None
        Accept pipeline input?       false
        Accept wildcard characters?  false

    .PARAMETER ParentNoteID
    The parent note ID to clone the note to.

        Required?                    true
        Position?                    1
        Default value                None
        Accept pipeline input?       false
        Accept wildcard characters?  false

    .PARAMETER IsExpanded
    Option to expand the copied note.

        Required?                    false
        Position?                    2
        Default value                False
        Accept pipeline input?       false
        Accept wildcard characters?  false

    .PARAMETER Prefix
    Optional prefix for the copied note.

        Required?                    false
        Position?                    3
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
    Copy-TriliumNote -NoteID "sxhoPPMkVIuO" -ParentNoteID "A2PGuqZgT03z"

    .NOTES
    This function requires that the authentication has been set using Connect-TriliumAuth.

    .LINK
    https://github.com/ptmorris1/TriliumNext-Powershell-Module
    #>
    [CmdletBinding(SupportsShouldProcess = $true)]
    param (
        [Parameter(Mandatory = $true)][ValidateNotNullOrEmpty()][string]$NoteID,
        [Parameter(Mandatory = $true)][ValidateNotNullOrEmpty()][string]$ParentNoteID,
        [Parameter(Mandatory = $false)][switch]$IsExpanded,
        [Parameter(Mandatory = $false)][ValidateNotNullOrEmpty()][string]$Prefix,
        [switch]$SkipCertCheck
    )

    process {
        try {
            if ($SkipCertCheck -eq $true) {
                $PSDefaultParameterValues = @{'Invoke-RestMethod:SkipCertificateCheck' = $true }
            }
            $TriliumHeaders = @{}
            $TriliumHeaders.Add('Authorization', "$($TriliumCreds.Authorization)")
            $TriliumHeaders.Add('accept', 'application/json; charset=utf-8')
            # API call run
            try {
                $uri = "$($TriliumCreds.URL)/branches"
                $body = @{
                    noteId       = $NoteID
                    ParentNoteID = $ParentNoteID
                    isExpanded   = if ($IsExpanded -match 'false') { $false } else { $true }
                    prefix       = $Prefix
                }
                $body = $body | ConvertTo-Json
                if ($PSCmdlet.ShouldProcess($uri, 'Creating clone\branch')) {
                    Invoke-RestMethod -Uri $uri -Headers $TriliumHeaders -Method Post -SkipHeaderValidation -Body $body -ContentType 'application/json'
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

    }
    end {
        return
    }
}