---
document type: cmdlet
external help file: Trilium-Help.xml
HelpUri: https://github.com/ptmorris1/TriliumNext-Powershell-Module
Locale: en-US
Module Name: Tri## RELATED LINKS

[TriliumNext PowerShell Module](https://github.com/ptmorris1/TriliumNext-Powershell-Module)m
ms.date: 07/19/2025
PlatyPS schema version: 2024-05-01
title: Export-TriliumNote
---

# Export-TriliumNote

## SYNOPSIS

Exports a TriliumNext note to a zip file.

## SYNTAX

### __AllParameterSets

```
Export-TriliumNote [-NoteID] <string> [[-Path] <string>] [-SkipCertCheck] [-Markdown]
 [<CommonParameters>]
```

## ALIASES

None

## DESCRIPTION

This function exports a TriliumNext note to a zip file based on the provided note ID and optional path.

## EXAMPLES

### EXAMPLE 1

```powershell
Export-TriliumNote -NoteID "12345" -Path "C:\temp\export.zip"
```

Exports the note with ID "12345" to the specified zip file path.

## PARAMETERS

### -Markdown

Exports the note in Markdown format instead of the default format.

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

### -NoteID

The note ID to export.

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

### -Path

Optional path to save the exported file.

    Required?                    false
    Position?                    1
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
  Position: 1
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

!!! note
    This function requires that the authentication has been set using Connect-TriliumAuth.
    Ensure that the provided path is valid and writable.


## RELATED LINKS

- [](https://github.com/ptmorris1/TriliumNext-Powershell-Module)
