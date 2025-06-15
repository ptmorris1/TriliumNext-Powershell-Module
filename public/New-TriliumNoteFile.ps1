function New-TriliumNoteFile {
    <#
    .SYNOPSIS
    Creates a new Trilium note with a file (binary content) as its content.

    .DESCRIPTION
    This function creates a note, sets the original file name as an attribute, and uploads the file content as binary. The note type and content are determined automatically based on the file extension.

    .PARAMETER ParentNoteId
    The ID of the parent note.

    .PARAMETER FilePath
    The path to the file to upload.

    .PARAMETER Type
    (Optional) The type of the note ('file', 'image', etc.). If not specified, determined from file extension.

    .PARAMETER Mime
    (Optional) The MIME type of the file. If not specified, it is determined from the file extension.

    .PARAMETER NotePosition
    (Optional) The position of the note.

    .PARAMETER Prefix
    (Optional) Prefix for the note.

    .PARAMETER IsExpanded
    (Optional) Whether the note is expanded.

    .PARAMETER NoteId
    (Optional) ID for the note.

    .PARAMETER BranchId
    (Optional) ID for the branch.

    .PARAMETER Title
    (Optional) Title for the note. If not provided, the file name (with extension) is used as the title.

    .EXAMPLE
    New-TriliumNoteFile -ParentNoteId "abc123" -FilePath "C:\docs\file.pdf"
    #>
    [CmdletBinding()]
    param(
        [Parameter(Mandatory = $true)][string]$ParentNoteId,
        [Parameter(Mandatory = $true)][string]$FilePath,
        [string]$Type,
        [string]$Mime,
        [int]$NotePosition,
        [string]$Prefix,
        [string]$IsExpanded,
        [string]$NoteId,
        [string]$BranchId,
        [string]$Title
    )
    # MIME type table
    $mimeTable = @{
        '.pdf'  = 'application/pdf'
        '.txt'  = 'text/plain'
        '.md'   = 'text/markdown'
        '.jpg'  = 'image/jpeg'
        '.jpeg' = 'image/jpeg'
        '.png'  = 'image/jpeg'
        '.gif'  = 'image/gif'
        '.bmp'  = 'image/bmp'
        '.mp3'  = 'audio/mpeg'
        '.wav'  = 'audio/wav'
        '.mp4'  = 'video/mp4'
        '.avi'  = 'video/x-msvideo'
        '.mov'  = 'video/quicktime'
        '.csv'  = 'text/csv'
        '.json' = 'application/json'
        '.xml'  = 'application/xml'
        '.zip'  = 'application/zip'
        '.7z'   = 'application/x-7z-compressed'
        '.doc'  = 'application/msword'
        '.docx' = 'application/vnd.openxmlformats-officedocument.wordprocessingml.document'
        '.xls'  = 'application/vnd.ms-excel'
        '.xlsx' = 'application/vnd.openxmlformats-officedocument.spreadsheetml.sheet'
        '.ppt'  = 'application/vnd.ms-powerpoint'
        '.pptx' = 'application/vnd.openxmlformats-officedocument.presentationml.presentation'
    }
    $imageExts = @('.jpg','.jpeg','.png','.gif','.bmp')
    if (-not $Type) {
        $ext = [System.IO.Path]::GetExtension($FilePath).ToLower()
        if ($imageExts -contains $ext) {
            $Type = 'image'
        } else {
            $Type = 'file'
        }
    }
    if (-not $Mime) {
        $ext = [System.IO.Path]::GetExtension($FilePath).ToLower()
        $Mime = $mimeTable[$ext]
        if (-not $Mime) { $Mime = 'application/octet-stream' }
    }
    # Set title to provided value or file name (with extension) if not provided
    if (-not $Title) {
        $Title = [System.IO.Path]::GetFileName($FilePath)
    }
    # Set content internally based on type
    if ($Type -eq 'image') {
        $Content = 'image'
    } else {
        $Content = '<p></p>'
    }
    # Create the note using New-TriliumNote
    $noteParams = @{
        ParentNoteId = $ParentNoteId
        Title        = $Title
        NoteType     = $Type
        Mime         = $Mime
        Content      = $Content
    }
    if ($NotePosition) { $noteParams.NotePosition = $NotePosition }
    if ($Prefix) { $noteParams.Prefix = $Prefix }
    if ($IsExpanded) { $noteParams.IsExpanded = $IsExpanded }
    if ($NoteId) { $noteParams.NoteId = $NoteId }
    if ($BranchId) { $noteParams.BranchId = $BranchId }
    $res_note = New-TriliumNote @noteParams
    $new_noteId = $res_note.note.noteId
    # Set original file name attribute using New-TriliumAttribute
    $fileName = [System.IO.Path]::GetFileName($FilePath)
    $null = New-TriliumAttribute -NoteID $new_noteId -Name 'originalFileName' -Value $fileName -Type 'label' -IsInheritable:$false
    # Upload file content
    $contentUri = "$($TriliumCreds.URL)/notes/$new_noteId/content"
    $fileBytes = [System.IO.File]::ReadAllBytes($FilePath)
    $binHeaders = @{ 'Authorization' = $TriliumCreds.Authorization; 'Content-Type' = 'application/octet-stream'; 'Content-Transfer-Encoding' = 'binary' }
    $res = Invoke-RestMethod -Uri $contentUri -Method Put -Headers $binHeaders -Body $fileBytes -SkipHeaderValidation
    if ($res_note -and $res.StatusCode -eq 204) {
        return $res_note
    } else {
        return $null
    }
}
