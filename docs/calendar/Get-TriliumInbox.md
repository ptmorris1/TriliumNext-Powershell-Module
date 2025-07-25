---
document type: cmdlet
external help file: Trilium-Help.xml
HelpUri: https://github.com/ptmorris1/TriliumNext-Powershell-Module
Locale: en-US
Module Name: Trilium
ms.date: 07/19/2025
PlatyPS schema version: 2024-05-01
title: Get-TriliumInbox
---

# Get-TriliumInbox

## SYNOPSIS

Gets (or creates) the TriliumNext inbox note for a specific date.

## SYNTAX

### __AllParameterSets

```
Get-TriliumInbox [[-Date] <datetime>] [-SkipCertCheck] [<CommonParameters>]
```

## ALIASES

This cmdlet has the following aliases,
  {{Insert list of aliases}}

## DESCRIPTION

This function retrieves the TriliumNext inbox note using the provided date.
If the note does not exist, it will be created at #calendarRoot.
The inbox may be a fixed note (with #inbox label) or a day note in a journal, depending on the date parameter.

## EXAMPLES

### EXAMPLE 1

Get-TriliumInbox -Date "2022-02-22"

## PARAMETERS

### -Date

The date for which to retrieve the inbox note.
Accepts a [datetime] object.
Format sent to API: yyyy-MM-dd.
Defaults to today if not specified.

    Required?                    false
    Position?                    0
    Default value                Today
    Accept pipeline input?       false
    Accept wildcard characters?  false

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
If the inbox note for the specified date does not exist, it will be created at #calendarRoot.


## RELATED LINKS

- [](https://github.com/ptmorris1/TriliumNext-Powershell-Module)
