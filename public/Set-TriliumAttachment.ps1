function Set-TriliumAttachment {
    <#
    .SYNOPSIS
    Updates an existing attachment in Trilium Notes.

    .DESCRIPTION
    Updates an existing attachment in Trilium Notes by patching the attachment identified by the attachmentId. Only role, mime, title, and position properties can be updated. This function does not modify the attachment's content or file data.

    .PARAMETER AttachmentId
    The ID of the attachment to update.
        Required?                    true
        Position?                    0
        Accept pipeline input?       false
        Accept wildcard characters?  false

    .PARAMETER Role
    (Optional) The role of the attachment (e.g., image, file).
        Required?                    false
        Position?                    1
        Accept pipeline input?       false
        Accept wildcard characters?  false

    .PARAMETER Mime
    (Optional) The MIME type of the attachment.
        Required?                    false
        Position?                    2
        Accept pipeline input?       false
        Accept wildcard characters?  false

    .PARAMETER Title
    (Optional) The title of the attachment.
        Required?                    false
        Position?                    3
        Accept pipeline input?       false
        Accept wildcard characters?  false

    .PARAMETER Position
    (Optional) The position of the attachment in the note's attachment list.
        Required?                    false
        Position?                    4
        Accept pipeline input?       false
        Accept wildcard characters?  false

    .INPUTS
    None. You cannot pipe objects to Set-TriliumAttachment.

    .OUTPUTS
    PSCustomObject. Returns the updated attachment object.

    .EXAMPLE
    Set-TriliumAttachment -AttachmentId "evnnmvHTCgIn" -Title "Updated Title"
    Updates the title of the attachment with ID evnnmvHTCgIn.

    .EXAMPLE
    Set-TriliumAttachment -AttachmentId "evnnmvHTCgIn" -Role "image" -Mime "image/png" -Position 1
    Updates multiple properties of the attachment.

    .NOTES
    - Requires authentication via Connect-TriliumAuth.
    - Only role, mime, title, and position properties can be updated.
    - At least one property must be specified to update.
    - Author: P. Morris
    - Module: TriliumNext-Powershell-Module

    .LINK
    https://github.com/ptmorris1/TriliumNext-Powershell-Module
    #>
    [CmdletBinding()]
    param (
        [Parameter(Mandatory = $true)]
        [string]$AttachmentId,
        [string]$Role,
        [string]$Mime,
        [string]$Title,
        [int]$Position
    )

    # Check if at least one property is provided
    if (-not ($PSBoundParameters.ContainsKey('Role') -or 
              $PSBoundParameters.ContainsKey('Mime') -or 
              $PSBoundParameters.ContainsKey('Title') -or 
              $PSBoundParameters.ContainsKey('Position'))) {
        throw "At least one property (Role, Mime, Title, or Position) must be specified to update."
    }

    # Build the body with only the properties that were specified
    $body = @{}
    
    if ($PSBoundParameters.ContainsKey('Role')) {
        $body.role = $Role
    }
    
    if ($PSBoundParameters.ContainsKey('Mime')) {
        $body.mime = $Mime
    }
    
    if ($PSBoundParameters.ContainsKey('Title')) {
        $body.title = $Title
    }
    
    if ($PSBoundParameters.ContainsKey('Position')) {
        $body.position = $Position
    }

    $jsonBody = $body | ConvertTo-Json -Compress
    $uri = "$($TriliumCreds.URL)/attachments/$AttachmentId"
    $headers = @{ 
        'Authorization' = $TriliumCreds.Authorization
        'Content-Type' = 'application/json'
    }

    try {
        $res = Invoke-RestMethod -Uri $uri -Method Patch -Headers $headers -Body $jsonBody
        return $res
    }
    catch {
        Write-Error "Failed to update attachment: $($_.Exception.Message)"
        throw
    }
}