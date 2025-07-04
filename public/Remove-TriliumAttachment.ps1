function Remove-TriliumAttachment {
    <#
    .SYNOPSIS
    Removes a specific Trilium attachment by its ID.

    .DESCRIPTION
    Deletes a Trilium attachment using the provided AttachmentID. Supports pipeline input for AttachmentID. Requires authentication via Connect-TriliumAuth.

    .PARAMETER AttachmentID
    The ID of the attachment to remove. Accepts input from the pipeline.

        Required?                    true
        Position?                    0
        Default value                None
        Accept pipeline input?       true
        Accept wildcard characters?  false

    .PARAMETER SkipCertCheck
    If specified, skips SSL certificate validation for the request.

        Required?                    false
        Position?                    Named
        Default value                None
        Accept pipeline input?       false
        Accept wildcard characters?  false

    .EXAMPLE
    Remove-TriliumAttachment -AttachmentID "evnnmvHTCgIn"
    
    Removes the attachment with the specified ID.

    .EXAMPLE
    "evnnmvHTCgIn", "abc123" | Remove-TriliumAttachment
    
    Removes multiple attachments by piping their IDs to the function.

    .NOTES
    This function requires that authentication has been set using Connect-TriliumAuth.

    .LINK
    https://github.com/ptmorris1/TriliumNext-Powershell-Module
    #>
    [CmdletBinding(SupportsShouldProcess = $true)]
    [Alias('Delete-TriliumAttachment', 'dta', 'rta')]
    param (
        [Parameter(Mandatory = $true, ValueFromPipeline = $true)]
        [ValidateNotNullOrEmpty()]
        [string]$AttachmentID,
        [switch]$SkipCertCheck
    )

    process {
        try {
            if ($SkipCertCheck -eq $true) {
                $PSDefaultParameterValues = @{'Invoke-RestMethod:SkipCertificateCheck' = $true }
            }
            $TriliumHeaders = @{}
            $TriliumHeaders.Add('Authorization', "$($TriliumCreds.Authorization)")
            $uri = "$($TriliumCreds.URL)/attachments/$AttachmentID"
            if ($PSCmdlet.ShouldProcess($uri, 'Remove attachment')) {
                Invoke-RestMethod -Uri $uri -Headers $TriliumHeaders -SkipHeaderValidation -Method Delete
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
