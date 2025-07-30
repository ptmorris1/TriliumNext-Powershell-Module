---
title: Remove-TriliumAttribute
description: Removes a specific Trilium attribute
document_type: cmdlet
external_help_file: Trilium-Help.xml
help_uri: https://github.com/ptmorris1/TriliumNext-Powershell-Module
locale: en-US
module_name: Trilium
date: 2025-07-19
platyps_schema_version: 2024-05-01
---

# Remove-TriliumAttribute

## SYNOPSIS

Removes a specific Trilium attribute.

## SYNTAX

### __AllParameterSets

```powershell
Remove-TriliumAttribute [-AttributeID] <string> [-SkipCertCheck] [-WhatIf] [-Confirm]
 [<CommonParameters>]
```

## ALIASES

None

## DESCRIPTION

This function removes a specific Trilium attribute based on the provided attribute ID.

## EXAMPLES

### EXAMPLE 1

```powershell
Remove-TriliumAttribute -AttributeID "12345"
```

This command removes the Trilium attribute with ID "12345".

## PARAMETERS

### -AttributeID

The attribute ID to remove.

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

### -Confirm

Prompts you for confirmation before running the cmdlet.

```yaml
Type: System.Management.Automation.SwitchParameter
DefaultValue: ''
SupportsWildcards: false
Aliases:
- cf
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

### -SkipCertCheck

Option to skip certificate check.

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

### -WhatIf

Tells PowerShell to run the command in a mode that only reports what would happen, but not actually let the command run or make changes.

```yaml
Type: System.Management.Automation.SwitchParameter
DefaultValue: ''
SupportsWildcards: false
Aliases:
- wi
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

### CommonParameters

This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable,
-InformationAction, -InformationVariable, -OutBuffer, -OutVariable, -PipelineVariable,
-ProgressAction, -Verbose, -WarningAction, and -WarningVariable. For more information, see
[about_CommonParameters](https://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

### System.String

The attribute ID as a string.

## OUTPUTS

### System.Object

Returns confirmation of the removed attribute.

## NOTES

!!! note
    This function requires that the authentication has been set using Connect-TriliumAuth.


## RELATED LINKS

- [TriliumNext PowerShell Module](https://github.com/ptmorris1/TriliumNext-Powershell-Module)
