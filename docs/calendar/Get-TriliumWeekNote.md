---
document type: cmdlet
external help file: Trilium-Help.xml
HelpUri: https://github.com/ptmorris1/TriliumNext-Powershell-Module
Locale: en-US
Module Name: Trilium
ms.date: 07/19/2025
PlatyPS schema version: 2024-05-01
title: Get-TriliumWeekNote
---

# Get-TriliumWeekNote

## SYNOPSIS

Gets (or creates) the TriliumNext week note for a specific date.

## SYNTAX

### __AllParameterSets

```
Get-TriliumWeekNote [[-Date] <datetime>] [-SkipCertCheck] [<CommonParameters>]
```

## ALIASES

None

## DESCRIPTION

This function retrieves the TriliumNext week note using the provided date.
If the note does not exist, it will be created.
The week note is typically used for weekly journaling or planning.

## EXAMPLES

### Example 1

```powershell
Get-TriliumWeekNote -Date "2022-02-22"
```

Gets the week note for the week containing February 22, 2022, or creates it if it doesn't exist.

## PARAMETERS

### -Date

The date for which to retrieve the week note.
Accepts a [datetime] object.
Format sent to API: yyyy-MM-dd.
Defaults to today if not specified.

```yaml
Type: System.DateTime
DefaultValue: (Get-Date)
SupportsWildcards: false
Aliases: []
ParameterSets:
- Name: (All)
  Position: 0
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

### CommonParameters

This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable,
-InformationAction, -InformationVariable, -OutBuffer, -OutVariable, -PipelineVariable,
-ProgressAction, -Verbose, -WarningAction, and -WarningVariable. For more information, see
[about_CommonParameters](https://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

None. You cannot pipe objects to Get-TriliumWeekNote.

## OUTPUTS

System.Object

Returns the TriliumNext week note object for the week containing the specified date.

## NOTES

This function requires that the authentication has been set using Connect-TriliumAuth.
If the week note for the specified date does not exist, it will be created automatically.

## RELATED LINKS

[TriliumNext PowerShell Module](https://github.com/ptmorris1/TriliumNext-Powershell-Module)
