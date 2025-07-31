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

None

## DESCRIPTION

This function retrieves the TriliumNext inbox note. If a note with #inbox label exists, it returns that note regardless of the date parameter. If no #inbox label is set, it behaves like a day note function, creating or retrieving a note for the current date (or specified date) at #calendarRoot.

## EXAMPLES

### Example 1

```powershell
Get-TriliumInbox
```

Gets the inbox note. If #inbox label exists, returns that note. Otherwise creates/gets today's day note.

### Example 2

```powershell
Get-TriliumInbox -Date "2022-02-22"
```

Gets the inbox note for February 22, 2022. Only applies if no #inbox label is set.

## PARAMETERS

### -Date

The date for which to retrieve the inbox note when no #inbox label exists.
Accepts a [datetime] object.
Format sent to API: yyyy-MM-dd.
Defaults to today if not specified.
Ignored if #inbox label is set.

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

None. You cannot pipe objects to Get-TriliumInbox.

## OUTPUTS

System.Object

Returns the TriliumNext inbox note object for the specified date.

## NOTES

This function requires that the authentication has been set using Connect-TriliumAuth.
If the inbox note for the specified date does not exist, it will be created at #calendarRoot.

## RELATED LINKS

[TriliumNext PowerShell Module](https://github.com/ptmorris1/TriliumNext-Powershell-Module)
