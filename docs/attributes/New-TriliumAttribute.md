---
title: New-TriliumAttribute
description: Creates or updates a Trilium attribute (label or relation) for a note
document_type: cmdlet
external_help_file: Trilium-Help.xml
help_uri: https://github.com/ptmorris1/TriliumNext-Powershell-Module
locale: en-US
module_name: Trilium
date: 2025-07-19
platyps_schema_version: 2024-05-01
---

# New-TriliumAttribute

## SYNOPSIS

Creates or updates a Trilium attribute (label or relation) for a note.

## SYNTAX

### __AllParameterSets

```powershell
New-TriliumAttribute [-NoteID] <string> [-Name] <string> [-Value] <string> [[-Type] <string>]
 [[-AttributeId] <string>] [-IsInheritable] [<CommonParameters>]
```

## ALIASES

None

## DESCRIPTION

This function creates or updates an attribute (label or relation) on a Trilium note using the ETAPI.
You must specify the note ID, attribute name, and value.
The attribute type can be 'label' or 'relation'.
Use the -IsInheritable switch to make the attribute inheritable.
Optionally, specify an AttributeId to update an existing attribute.

## EXAMPLES

### EXAMPLE 1

```powershell
New-TriliumAttribute -NoteID "abc123" -Name "archived" -Value "true"
```

Adds the 'archived' label to the note with ID 'abc123'.

### EXAMPLE 2

```powershell
New-TriliumAttribute -NoteID "abc123" -Name "color" -Value "#ff0000" -IsInheritable
```

Adds an inheritable 'color' label to the note with ID 'abc123'.

## PARAMETERS

### -AttributeId

(Optional) The ID of the attribute to update.
If not specified, a new attribute will be created.

```yaml
Type: System.String
DefaultValue: ''
SupportsWildcards: false
Aliases: []
ParameterSets:
- Name: (All)
  Position: 4
  IsRequired: false
  ValueFromPipeline: false
  ValueFromPipelineByPropertyName: false
  ValueFromRemainingArguments: false
DontShow: false
AcceptedValues: []
HelpMessage: ''
```

### -IsInheritable

If specified, the attribute will be inheritable by child notes.

```yaml
Type: System.Management.Automation.SwitchParameter
DefaultValue: False
SupportsWildcards: false
Aliases: []
ParameterSets:
- Name: (All)
  Position: Named
  IsRequired: false
  ValueFromPipeline: false
  ValueFromPipelineByPropertyName: false
  ValueFromRemainingArguments: false
DontShow: false
AcceptedValues: []
HelpMessage: ''
```

### -Name

The name of the attribute (label or relation).
For labels, tab-completion is available for common Trilium labels.

```yaml
Type: System.String
DefaultValue: ''
SupportsWildcards: false
Aliases: []
ParameterSets:
- Name: (All)
  Position: 1
  IsRequired: true
  ValueFromPipeline: false
  ValueFromPipelineByPropertyName: false
  ValueFromRemainingArguments: false
DontShow: false
AcceptedValues: []
HelpMessage: ''
```

### -NoteID

The ID of the note to which the attribute will be added or updated.

```yaml
Type: System.String
DefaultValue: ''
SupportsWildcards: false
Aliases: []
ParameterSets:
- Name: (All)
  Position: 0
  IsRequired: true
  ValueFromPipeline: false
  ValueFromPipelineByPropertyName: false
  ValueFromRemainingArguments: false
DontShow: false
AcceptedValues: []
HelpMessage: ''
```

### -Type

The type of the attribute.
Must be 'label' or 'relation'.
Default is 'label'.

```yaml
Type: System.String
DefaultValue: label
SupportsWildcards: false
Aliases: []
ParameterSets:
- Name: (All)
  Position: 3
  IsRequired: false
  ValueFromPipeline: false
  ValueFromPipelineByPropertyName: false
  ValueFromRemainingArguments: false
DontShow: false
AcceptedValues: []
HelpMessage: ''
```

### -Value

The value to assign to the attribute.

```yaml
Type: System.String
DefaultValue: ''
SupportsWildcards: false
Aliases: []
ParameterSets:
- Name: (All)
  Position: 2
  IsRequired: true
  ValueFromPipeline: false
  ValueFromPipelineByPropertyName: false
  ValueFromRemainingArguments: false
DontShow: false
AcceptedValues: []
HelpMessage: ''
```

### CommonParameters

This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable,
-InformationAction, -InformationVariable, -OutBuffer, -OutVariable, -PipelineVariable,
-ProgressAction, -Verbose, -WarningAction, and -WarningVariable. For more information, see
[about_CommonParameters](https://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

### System.String

The note ID, attribute name, value, type, and optional attribute ID as strings.

### System.Management.Automation.SwitchParameter

The IsInheritable switch parameter.

## OUTPUTS

### System.Object

Returns the created or updated Trilium attribute object.

## NOTES

!!! note
    Requires authentication via Connect-TriliumAuth.


## RELATED LINKS

- [TriliumNext PowerShell Module](https://github.com/ptmorris1/TriliumNext-Powershell-Module)

