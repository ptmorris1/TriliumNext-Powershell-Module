---
document type: cmdlet
external help file: Trilium-Help.xml
HelpUri: https://github.com/ptmorris1/TriliumNext-Powershell-Module
Locale: en-US
Module Name: Trilium
ms.date: 07/19/2025
PlatyPS schema version: 2024-05-01
title: Get-TriliumYearNote
---

# Get-TriliumYearNote

## SYNOPSIS

Gets (or creates) the TriliumNext year note for a specific year.

## SYNTAX

### __AllParameterSets

```
Get-TriliumYearNote [[-Year] <datetime>] [-SkipCertCheck] [<CommonParameters>]
```

## ALIASES

None

## DESCRIPTION

This function retrieves the TriliumNext year note using the provided year.
If the note does not exist, it will be created.
The year note is typically used for yearly journaling or planning.

## EXAMPLES

### Example 1

```powershell
Get-TriliumYearNote -Year "2022"
```

Gets the year note for 2022, or creates it if it doesn't exist.

## PARAMETERS

### -Year

The year for which to retrieve the year note.
Accepts a [datetime] object.
Format sent to API: yyyy.
Defaults to the current year if not specified.

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

None. You cannot pipe objects to Get-TriliumYearNote.

## OUTPUTS

System.Object

Returns the TriliumNext year note object for the specified year.

## NOTES

This function requires that the authentication has been set using Connect-TriliumAuth.
If the year note for the specified year does not exist, it will be created automatically.

## RELATED LINKS

[TriliumNext PowerShell Module](https://github.com/ptmorris1/TriliumNext-Powershell-Module)
