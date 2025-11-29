function Set-TriliumAttribute {
    <#
    .SYNOPSIS
    Updates an existing Trilium attribute (label or relation).

    .DESCRIPTION
    Updates an existing attribute in Trilium Notes by patching the attribute identified by the attributeId. For labels, only value and position can be updated. For relations, only position can be updated. If you want to modify other properties, you need to delete the old attribute and create a new one.

    .PARAMETER AttributeId
    The ID of the attribute to update.
        Required?                    true
        Position?                    0
        Accept pipeline input?       false
        Accept wildcard characters?  false

    .PARAMETER Value
    (Optional) The new value for the attribute. Only applicable for labels.
        Required?                    false
        Position?                    1
        Accept pipeline input?       false
        Accept wildcard characters?  false

    .PARAMETER Position
    (Optional) The new position of the attribute in the note's attribute list.
        Required?                    false
        Position?                    2
        Accept pipeline input?       false
        Accept wildcard characters?  false

    .INPUTS
    None. You cannot pipe objects to Set-TriliumAttribute.

    .OUTPUTS
    PSCustomObject. Returns the updated attribute object.

    .EXAMPLE
    Set-TriliumAttribute -AttributeId "evnnmvHTCgIn" -Value "new value"
    Updates the value of a label attribute with ID evnnmvHTCgIn.

    .EXAMPLE
    Set-TriliumAttribute -AttributeId "evnnmvHTCgIn" -Position 5
    Updates the position of an attribute (works for both labels and relations).

    .EXAMPLE
    Set-TriliumAttribute -AttributeId "evnnmvHTCgIn" -Value "updated" -Position 3
    Updates both the value and position of a label attribute.

    .NOTES
    - Requires authentication via Connect-TriliumAuth.
    - For labels: only value and position can be updated.
    - For relations: only position can be updated.
    - At least one property (Value or Position) must be specified.
    - To modify other properties, delete the old attribute and create a new one.
    - Author: P. Morris
    - Module: TriliumNext-Powershell-Module

    .LINK
    https://github.com/ptmorris1/TriliumNext-Powershell-Module
    #>
    [CmdletBinding()]
    param (
        [Parameter(Mandatory = $true)]
        [string]$AttributeId,
        [string]$Value,
        [int]$Position
    )

    if (!$global:TriliumCreds) { 
        Write-Error -Message 'Need to run: Connect-TriliumAuth'
        return
    }

    # Check if at least one property is provided
    if (-not ($PSBoundParameters.ContainsKey('Value') -or 
              $PSBoundParameters.ContainsKey('Position'))) {
        throw "At least one property (Value or Position) must be specified to update."
    }

    # Build the body with only the properties that were specified
    $body = @{}
    
    if ($PSBoundParameters.ContainsKey('Value')) {
        $body.value = $Value
    }
    
    if ($PSBoundParameters.ContainsKey('Position')) {
        $body.position = $Position
    }

    $TriliumHeaders = @{}
    $TriliumHeaders.Add('Authorization', "$($TriliumCreds.Authorization)")
    $baseUrl = $TriliumCreds.URL -replace '/etapi/?$',''
    $uri = "$baseUrl/etapi/attributes/$AttributeId"

    $jsonBody = $body | ConvertTo-Json -Compress

    try {
        $response = Invoke-RestMethod -Uri $uri -Headers $TriliumHeaders -Method Patch -Body $jsonBody -ContentType 'application/json'
        return $response
    }
    catch {
        Write-Error "Failed to update attribute: $($_.Exception.Message)"
        throw
    }
}