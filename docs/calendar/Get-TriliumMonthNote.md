---
document type: cmdlet
external help file: Trilium-Help.xml
HelpUri: https://github.com/ptmorris1/TriliumNext-Powershell-Module
Locale: en-US
Module Name: Trilium
ms.date: 07/19/2025
PlatyPS schema version: 2024-05-01
title: Get-TriliumMonthNote
---

# Get-TriliumMonthNote

## SYNOPSIS

Gets (or creates) the TriliumNext month note for a specific month.

## SYNTAX

### __AllParameterSets

```
Get-TriliumMonthNote [[-Month] <datetime>] [-SkipCertCheck] [<CommonParameters>]
```

## ALIASES

None

## DESCRIPTION

This function retrieves the TriliumNext month note using the provided month.
If the note does not exist, it will be created.
The month note is typically used for monthly journaling or planning.

## EXAMPLES

### Example 1

```powershell
Get-TriliumMonthNote -Month "2022-02"
```

Gets the month note for February 2022, or creates it if it doesn't exist.

## PARAMETERS

### -Month

The month for which to retrieve the month note.
Accepts a [datetime] object.
Format sent to API: yyyy-MM.
Defaults to the current month if not specified.

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

None. You cannot pipe objects to Get-TriliumMonthNote.

## OUTPUTS

System.Object

Returns the TriliumNext month note object for the specified month.

## NOTES

This function requires that the authentication has been set using Connect-TriliumAuth.
If the month note for the specified month does not exist, it will be created automatically.

## RELATED LINKS

[TriliumNext PowerShell Module](https://github.com/ptmorris1/TriliumNext-Powershell-Module)
