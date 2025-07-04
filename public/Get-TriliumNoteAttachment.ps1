function Get-TriliumNoteAttachment {
    <#
    .SYNOPSIS
    Retrieves all attachments for a specific Trilium Notes note by note ID.

    .DESCRIPTION
    Gets the metadata for all attachments associated with a specific Trilium Notes note, using the provided note ID. Returns an array of attachment metadata objects. Requires prior authentication with Connect-TriliumAuth.

    .PARAMETER NoteID
    The unique ID of the note to retrieve attachments for. This value can be found in the note's metadata or via Find-TriliumNote.

        Required?                    true
        Position?                    0
        Accept pipeline input?       false
        Accept wildcard characters?  false

    .PARAMETER SkipCertCheck
    If specified, skips SSL certificate validation for the request. Useful for self-signed certificates or development environments.

        Required?                    false
        Position?                    Named
        Accept pipeline input?       false
        Accept wildcard characters?  false

    .OUTPUTS
    System.Object[]
    Returns an array of attachment metadata objects for the specified note. Each object includes properties such as attachmentId, mime, title, ownerId, size, and other details, but not the file or binary content itself.

    .EXAMPLE
    Get-TriliumNoteAttachment -NoteID "jfkls7klusi"
    Retrieves all attachment metadata for the note with the specified ID.

    .EXAMPLE
    Get-TriliumNoteAttachment -NoteID "jfkls7klusi" -SkipCertCheck
    Retrieves all attachment metadata for the note while skipping SSL certificate validation.

    .NOTES
    - Requires authentication via Connect-TriliumAuth.
    - This function returns only the metadata for the attachments, not the file or binary content. To download the actual content, use Get-TriliumAttachmentContent.
    - If the note or attachments are not found or an error occurs, the function returns the error response from the server.
    - For more information on finding note IDs, see Find-TriliumNote or the Trilium Notes API documentation.

    .LINK
    https://github.com/ptmorris1/TriliumNext-Powershell-Module
    #>
    [CmdletBinding()]
    param (
        # Note ID to get attachments for
        [Parameter(Mandatory = $True)][ValidateNotNullOrEmpty()][string]$NoteID,
        [switch]$SkipCertCheck
    )
    process {
        try {
            if ($SkipCertCheck -eq $true) {
                $PSDefaultParameterValues = @{'Invoke-RestMethod:SkipCertificateCheck' = $true }
            }
            # Set headers and make request to get note attachments
            $TriliumHeaders = @{}
            $TriliumHeaders.Add('Authorization', "$($TriliumCreds.Authorization)")
            $uri = "$($TriliumCreds.URL)/notes/$NoteID/attachments"
            Invoke-RestMethod -Uri $uri -Headers $TriliumHeaders -SkipHeaderValidation
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
