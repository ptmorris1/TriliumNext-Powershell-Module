function New-TriliumAttribute {
    <#
    .SYNOPSIS
    Creates or updates a Trilium attribute (label or relation) for a note.

    .DESCRIPTION
    This function creates or updates an attribute (label or relation) on a Trilium note using the ETAPI. You must specify the note ID, attribute name, and value. The attribute type can be 'label' or 'relation'. Use the -IsInheritable switch to make the attribute inheritable. Optionally, specify an AttributeId to update an existing attribute.

    .PARAMETER NoteID
    The ID of the note to which the attribute will be added or updated.

    .PARAMETER Name
    The name of the attribute (label or relation). For labels, tab-completion is available for common Trilium labels.

    .PARAMETER Value
    The value to assign to the attribute.

    .PARAMETER Type
    The type of the attribute. Must be 'label' or 'relation'. Default is 'label'.

    .PARAMETER IsInheritable
    If specified, the attribute will be inheritable by child notes.

    .PARAMETER AttributeId
    (Optional) The ID of the attribute to update. If not specified, a new attribute will be created.

    .EXAMPLE
    New-TriliumAttribute -NoteID "abc123" -Name "archived" -Value "true"
    Adds the 'archived' label to the note with ID 'abc123'.

    .EXAMPLE
    New-TriliumAttribute -NoteID "abc123" -Name "color" -Value "#ff0000" -IsInheritable
    Adds an inheritable 'color' label to the note with ID 'abc123'.

    .NOTES
    Requires authentication via Connect-TriliumAuth.
    #>
    [CmdletBinding()]
    param(
        [Parameter(Mandatory = $true)]
        [string]$NoteID,
        [Parameter(Mandatory = $true)]
        [string]$Name,
        [Parameter(Mandatory = $true)]
        [string]$Value,
        [ValidateSet('label','relation')]
        [string]$Type = 'label',
        [switch]$IsInheritable,
        [string]$AttributeId
    )

    if (!$global:TriliumCreds) { Write-Error -Message 'Need to run: Connect-TriliumAuth'; exit }
    $TriliumHeaders = @{}
    $TriliumHeaders.Add('Authorization', "$($TriliumCreds.Authorization)")
    $baseUrl = $TriliumCreds.URL -replace '/etapi/?$',''
    $uri = "$baseUrl/etapi/attributes/"

    $body = @{
        noteId = $NoteID
        type = $Type
        name = $Name
        value = $Value
    }
    if ($IsInheritable) { $body.isInheritable = $true } else { $body.isInheritable = $false }
    if ($AttributeId) { $body.attributeId = $AttributeId }
    $jsonBody = $body | ConvertTo-Json

    $response = Invoke-RestMethod -Uri $uri -Headers $TriliumHeaders -Method Post -Body $jsonBody -ContentType 'application/json'
    return $response
}

# Argument completer for -Name when -Type is 'label'
Register-ArgumentCompleter -CommandName New-TriliumAttribute -ParameterName Name -ScriptBlock {
    param($commandName, $parameterName, $wordToComplete, $commandAst, $fakeBoundParameters)
    $labelNames = @(
        'disableVersioning','versioningLimit','calendarRoot','archived','excludeFromExport','run','runOnInstance','runAtHour',
        'disableInclusion','sorted','sortDirection','sortFoldersFirst','top','hidePromotedAttributes','readOnly','autoReadOnlyDisabled',
        'appCss','appTheme','appThemeBase','cssClass','iconClass','pageSize','customRequestHandler','customResourceProvider','widget',
        'searchHome','workspace','inbox','sqlConsoleHome','bookmarked','bookmarkFolder','share','displayRelations','hideRelations',
        'titleTemplate','template','toc','color','keyboardShortcut','keepCurrentHoisting','executeButton','executeDescription',
        'excludeFromNoteMap','newNotesOnTop','hideHighlightWidget','hideChildrenOverview','printLandscape','printPageSize','geolocation','viewType'
    )
    if ($fakeBoundParameters.ContainsKey('Type') -and $fakeBoundParameters['Type'] -eq 'label') {
        $labelNames | Where-Object { $_ -like "$wordToComplete*" } | ForEach-Object {
            [System.Management.Automation.CompletionResult]::new($_, $_, 'ParameterValue', $_)
        }
    }
}