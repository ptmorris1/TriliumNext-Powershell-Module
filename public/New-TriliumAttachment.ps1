function New-TriliumAttachment {
    <#
    .SYNOPSIS
    Uploads a file as an attachment to a Trilium Notes note and appends a reference link or image to the end of the note's content.

    .DESCRIPTION
    Creates a new attachment for a note in Trilium Notes. The function uploads the file as an attachment, then appends a reference link (for files) or an image (for images) to the end of the note's content. Supports specifying role, MIME type, title, and position. Automatically detects MIME type from file extension if not specified. For images, includes width, height, and aspect ratio in the HTML snippet.

    .PARAMETER OwnerId
    The note ID to attach the file to.
        Required?                    true
        Position?                    0
        Accept pipeline input?       false
        Accept wildcard characters?  false

    .PARAMETER FilePath
    The path to the file to upload as an attachment.
        Required?                    true
        Position?                    1
        Accept pipeline input?       false
        Accept wildcard characters?  false

    .PARAMETER Role
    (Optional) The role of the attachment (e.g., image, file). If not specified, will be set to 'image' for image MIME types, otherwise 'file'.
        Required?                    false
        Position?                    2
        Accept pipeline input?       false
        Accept wildcard characters?  false

    .PARAMETER Mime
    (Optional) The MIME type of the attachment. If not specified, will try to detect from file extension.
        Required?                    false
        Position?                    3
        Accept pipeline input?       false
        Accept wildcard characters?  false

    .PARAMETER Title
    (Optional) The title of the attachment. Defaults to the file name.
        Required?                    false
        Position?                    4
        Accept pipeline input?       false
        Accept wildcard characters?  false

    .PARAMETER Position
    (Optional) The position of the attachment in the note's attachment list.
        Required?                    false
        Position?                    5
        Accept pipeline input?       false
        Accept wildcard characters?  false

    .INPUTS
    None. You cannot pipe objects to New-TriliumAttachment.

    .OUTPUTS
    PSCustomObject. Returns the new attachment object, including the HtmlSnippet used to add the link or image to the note's content.

    .EXAMPLE
    New-TriliumAttachment -OwnerId "12345" -FilePath "C:\path\to\file.png"
    Uploads file.png as an attachment to the note with ID 12345 and appends an image or reference link to the note's content.

    .EXAMPLE
    New-TriliumAttachment -OwnerId "12345" -FilePath "C:\path\to\file.pdf" -Title "My PDF" -Mime "application/pdf"
    Uploads file.pdf as an attachment with a custom title and MIME type.

    .NOTES
    - Requires authentication via Connect-TriliumAuth.
    - This function uploads the file, creates the attachment, and appends a reference link or image to the note's content.
    - For images, the HTML snippet includes width, height, and aspect ratio.
    - For files, the HTML snippet is a reference link.
    - Author: P. Morris
    - Module: TriliumNext-Powershell-Module

    .LINK
    https://github.com/ptmorris1/TriliumNext-Powershell-Module
    #>
    [CmdletBinding()]
    param (
        [Parameter(Mandatory = $true)]
        [string]$OwnerId,
        [Parameter(Mandatory = $true)]
        [string]$FilePath,
        [string]$Role,
        [string]$Mime,
        [string]$Title,
        [int]$Position
    )
    # Import MIME type map from JSON file
    $mimeTypeMapPath = Join-Path $PSScriptRoot '..\data\MimeTypeMap.json'
    $mimeTypeMap = Get-Content $mimeTypeMapPath -Raw | ConvertFrom-Json
    if (-not $Title) { $Title = [System.IO.Path]::GetFileName($FilePath) }
    if (-not $Mime) {
        $ext = [System.IO.Path]::GetExtension($FilePath).ToLower().TrimStart('.')
        Write-Verbose "[TriliumAttachment] Checking extension: '$ext'"
        $mimeEntry = $mimeTypeMap | Where-Object { $_.Extension -and ($_.Extension.ToLower().Trim() -eq $ext) } | Select-Object -First 1
        if ($mimeEntry -and $mimeEntry.Mime) {
            $Mime = $mimeEntry.Mime
            Write-Verbose "[TriliumAttachment] Found MIME type '$Mime' for extension '$ext'"
        } else {
            throw "[TriliumAttachment] No MIME type found for extension '$ext'. Please add it to MimeTypeMap.json."
        }
    }
    if (-not $Role) {
        if ($Mime -like 'image/*') {
            $Role = 'image'
        } else {
            $Role = 'file'
        }
    }
    $body = @{
        ownerId = $OwnerId
        role = $Role
        mime = $Mime
        title = $Title
        position = $Position
        content = ''
    }
    $jsonBody = $body | ConvertTo-Json -Compress
    $uri = "$($TriliumCreds.URL)/attachments"
    $headers = @{ 'Authorization' = $TriliumCreds.Authorization; 'Content-Type' = 'application/json' }
    $res = Invoke-RestMethod -Uri $uri -Method Post -Headers $headers -Body $jsonBody
    $attachmentId = $res.attachmentId
    # Upload content
    $content = [System.IO.File]::ReadAllBytes($FilePath)
    $contentUri = "$($TriliumCreds.URL)/attachments/$attachmentId/content"
    $contentHeaders = @{ 'Authorization' = $TriliumCreds.Authorization; 'Content-Type' = 'application/octet-stream' }
    Invoke-RestMethod -Uri $contentUri -Method Put -Headers $contentHeaders -Body $content
    # If image, output HTML snippet with dimensions
    if ($Mime -like 'image/*') {
        Add-Type -AssemblyName System.Drawing
        $img = [System.Drawing.Image]::FromFile($FilePath)
        $width = $img.Width
        $height = $img.Height
        $aspect = "$width/$height"
        $img.Dispose()
        $fileName = [System.IO.Path]::GetFileName($FilePath)
        $html = @"
<figure class="image">
    <img style="aspect-ratio:$aspect;" src="api/attachments/$attachmentId/image/$fileName" width="$width" height="$height">
</figure>
"@
        $res | Add-Member -MemberType NoteProperty -Name HtmlSnippet -Value $html
        # Get current note content and append image HTML
        $currentContent = Get-TriliumNoteContent -NoteID $OwnerId
        if ([string]::IsNullOrWhiteSpace($currentContent)) {
            $mergedContent = $html
        } else {
            $mergedContent = "$currentContent`r`n$html"
        }
        Set-TriliumNoteContent -NoteID $OwnerId -NoteContent $mergedContent
    } else {
        $fileName = [System.IO.Path]::GetFileName($FilePath)
        $fileHtml = @"
<p>
    <a class="reference-link" href="#root/$($OwnerId)?viewMode=attachments&amp;attachmentId=$($attachmentId)">
        $fileName
    </a>
    &nbsp;
</p>
"@
        $res | Add-Member -MemberType NoteProperty -Name HtmlSnippet -Value $fileHtml
        $currentContent = Get-TriliumNoteContent -NoteID $OwnerId
        if ([string]::IsNullOrWhiteSpace($currentContent)) {
            $mergedContent = $fileHtml
        } else {
            $mergedContent = "$currentContent`r`n$fileHtml"
        }
        Set-TriliumNoteContent -NoteID $OwnerId -NoteContent $mergedContent
    }
    return $res
}
