function Get-TriliumAttachment {
    <#
    .SYNOPSIS
    Retrieves metadata for a specific Trilium Notes attachment by its ID.

    .DESCRIPTION
    Gets the metadata (properties and details) for a Trilium Notes attachment using the provided attachment ID. This does not return the raw file or binary content, but rather the attachment's metadata as a PowerShell object. Requires prior authentication with Connect-TriliumAuth.

    .PARAMETER AttachmentID
    The unique ID of the attachment to retrieve metadata for. This value can be found in the note's attachment metadata or via Find-TriliumNote.

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
    System.Object
    Returns the attachment metadata as a PowerShell object. This includes properties such as attachmentId, mime, title, ownerId, size, and other details, but not the file or binary content itself.

    .EXAMPLE
    Get-TriliumAttachment -AttachmentID "evnnmvHTCgIn"
    Retrieves the metadata for the attachment with the specified ID and outputs it as a PowerShell object.

    .EXAMPLE
    Get-TriliumAttachment -AttachmentID "evnnmvHTCgIn" -SkipCertCheck
    Retrieves the attachment metadata while skipping SSL certificate validation.

    .NOTES
    - Requires authentication via Connect-TriliumAuth.
    - This function returns only the metadata for the attachment, not the file or binary content. To download the actual content, use Get-TriliumAttachmentContent.
    - If the attachment is not found or an error occurs, the function returns the error response from the server.
    - For more information on finding attachment IDs, see Get-TriliumAttachment.

    .LINK
    https://github.com/ptmorris1/TriliumNext-Powershell-Module
    #>
    [CmdletBinding()]
    param (
        # Attachment ID to retrieve
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
            $uri = "$($TriliumCreds.URL)/attachments/$AttachmentID"
            Invoke-RestMethod -Uri $uri -Headers $TriliumHeaders -SkipHeaderValidation
        } catch {
            $_.Exception.Response
        }
    }
    end {
        return
    }
}
