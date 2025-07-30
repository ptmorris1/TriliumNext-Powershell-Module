---
document type: cmdlet
external help file: Trilium-Help.xml
HelpUri: https://github.com/ptmorris1/TriliumNext-Powershell-Module
Locale: en-US
Module Name: Trilium
ms.date: 07/19/2025
PlatyPS schema version: 2024-05-01
title: Get-TriliumInfo
---

# Get-TriliumInfo

## SYNOPSIS

Gets the application info for TriliumNext.

## SYNTAX

### __AllParameterSets

```
Get-TriliumInfo [-SkipCertCheck] [<CommonParameters>]
```

## DESCRIPTION

This function retrieves the application info for TriliumNext.

## EXAMPLES

### EXAMPLE 1

```powershell
Get-TriliumInfo
```

## PARAMETERS

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

None

## OUTPUTS

System.Object

## NOTES

This function requires that the authentication has been set using Connect-TriliumAuth.


## RELATED LINKS

[TriliumNext PowerShell Module](https://github.com/ptmorris1/TriliumNext-Powershell-Module)
