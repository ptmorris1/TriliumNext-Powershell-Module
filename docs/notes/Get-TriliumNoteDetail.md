---
document type: cmdlet
external help file: Trilium-Help.xml
HelpUri: https://github.com/ptmorris1/TriliumNext-Powershell-Module
Locale: en-US
Module Name: Trilium
ms.date: 07/19/2025
PlatyPS schema version: 2024-05-01
title: Get-TriliumNoteDetail
---

# Get-TriliumNoteDetail

## SYNOPSIS

Gets details of a specific TriliumNext note.

## SYNTAX

### __AllParameterSets

```
Get-TriliumNoteDetail [-NoteID] <string> [-SkipCertCheck] [<CommonParameters>]
```

## ALIASES

This cmdlet has the following aliases,
  {{Insert list of aliases}}

## DESCRIPTION

This function retrieves the details of a specific TriliumNext note based on the provided note ID.

## EXAMPLES

### EXAMPLE 1

Get-TriliumNoteDetails -NoteID "12345"

## PARAMETERS

### -NoteID

The note ID to get details for.

    Required?                    true
    Position?                    0
    Default value                None
    Accept pipeline input?       false
    Accept wildcard characters?  false

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

### -SkipCertCheck

Option to skip certificate check.

    Required?                    false
    Position?                    Named
    Default value                None
    Accept pipeline input?       false
    Accept wildcard characters?  false

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

### CommonParameters

This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable,
-InformationAction, -InformationVariable, -OutBuffer, -OutVariable, -PipelineVariable,
-ProgressAction, -Verbose, -WarningAction, and -WarningVariable. For more information, see
[about_CommonParameters](https://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

## OUTPUTS

## NOTES

This function requires that the authentication has been set using Connect-TriliumAuth.


## RELATED LINKS

- [](https://github.com/ptmorris1/TriliumNext-Powershell-Module)
