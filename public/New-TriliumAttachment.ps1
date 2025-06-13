function New-TriliumAttachment {
    <#
    .SYNOPSIS
    Creates a new attachment for a note in TriliumNext using the /attachments endpoint.

    .DESCRIPTION
    Uploads a file as an attachment to a note using the /attachments endpoint (application/json),
    then uploads the file content separately to /attachments/{attachmentId}/content.

    .PARAMETER OwnerId
    The note ID to attach the file to.

    .PARAMETER FilePath
    The path to the file to upload as an attachment.

    .PARAMETER Role
    (Optional) The role of the attachment.

    .PARAMETER Mime
    (Optional) The MIME type of the attachment. If not specified, will try to detect from file extension.

    .PARAMETER Title
    (Optional) The title of the attachment. Defaults to the file name.

    .PARAMETER Position
    (Optional) The position of the attachment.

    .EXAMPLE
    New-TriliumAttachment -OwnerId "12345" -FilePath "C:\path\to\file.png"
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
    # Basic MIME type map
    $mimeMap = @{
        ".png"  = "image/png"
        ".jpg"  = "image/jpeg"
        ".jpeg" = "image/jpeg"
        ".gif"  = "image/gif"
        ".bmp"  = "image/bmp"
        ".svg"  = "image/svg+xml"
        ".txt"  = "text/plain"
        ".md"   = "text/markdown"
        ".pdf"  = "application/pdf"
        ".zip"  = "application/zip"
        ".json" = "application/json"
        ".csv"  = "text/csv"
        ".xml"  = "application/xml"
        ".html" = "text/html"
    }
    if (-not $Title) { $Title = [System.IO.Path]::GetFileName($FilePath) }
    if (-not $Mime) {
        $ext = [System.IO.Path]::GetExtension($FilePath).ToLower()
        $Mime = $mimeMap[$ext]
    }
    if (-not $Mime) { $Mime = 'image/png' }
    if (-not $Role) {
        if ($Mime -like 'image*') { $Role = 'image' } else { $Role = 'file' }
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
        Set-TriliumNoteContent -NoteID $OwnerId -NoteContent $html
    }
    return $res
}
