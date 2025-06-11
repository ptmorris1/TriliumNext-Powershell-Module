function Get-TriliumAttachmentID {
    <#
    .SYNOPSIS
    Extracts Trilium attachment IDs from provided HTML content.

    .DESCRIPTION
    Parses the input HTML string and returns all Trilium attachment IDs found in 'api/attachments/{AttachmentID}/' URLs.

    .PARAMETER Html
    The HTML content to search for attachment IDs.

    .OUTPUTS
    [string[]] Array of found attachment IDs.

    .EXAMPLE
    $ids = Get-TriliumAttachmentID -Html $htmlContent
    Returns all attachment IDs found in the provided HTML.

    .EXAMPLE
    # Get content from a note and extract attachment IDs
    $c = Get-TriliumNoteContent -NoteID 'PNI9pPdh0tws'
    $ids = Get-TriliumAttachmentID -Html $c
    #>
    param(
        [Parameter(Mandatory=$true)]
        [string]$Html
    )
    # Regex to match 'api/attachments/{AttachmentID}/'
    $regex = [regex]'/attachments/([^/]+)/'
    # Find all matches
    $foundMatches = $regex.Matches($Html)
    # Extract and output each AttachmentID
    $AttachmentIDs = $foundMatches | ForEach-Object { $_.Groups[1].Value }
    return $AttachmentIDs
}