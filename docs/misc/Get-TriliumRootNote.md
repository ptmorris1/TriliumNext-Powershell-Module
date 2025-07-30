---
document type: cmdlet
external help file: Trilium-Help.xml
HelpUri: ''
Locale: en-US
Module Name: Trilium
ms.date: 07/19/2025
PlatyPS schema version: 2024-05-01
title: Get-TriliumRootNote
---

# Get-TriliumRootNote

## SYNOPSIS

Gets the root note details from the TriliumNext instance.

## SYNTAX

### __AllParameterSets

```
Get-TriliumRootNote [-SkipCertCheck] [<CommonParameters>]
```

## ALIASES

This cmdlet has no aliases.

## DESCRIPTION

Retrieves the root note of your TriliumNext instance, including its ID, title, and metadata.
Useful for obtaining the top-level note structure for navigation or automation.

## EXAMPLES

### EXAMPLE 1

```powershell
Get-TriliumRootNote
```

Retrieves the root note details from the connected Trilium instance.

### EXAMPLE 2

```powershell
Get-TriliumRootNote -SkipCertCheck
```

Retrieves the root note details, skipping SSL certificate validation (for self-signed certs).

## PARAMETERS

### -SkipCertCheck

If specified, SSL certificate errors will be ignored (useful for self-signed certs).

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

### None

You cannot pipe objects to Get-TriliumRootNote.

## OUTPUTS

### System.Management.Automation.PSCustomObject

Returns the root note object from Trilium.

## NOTES

- Requires authentication using Connect-TriliumAuth before use.
- Author: P. Morris
- Module: TriliumNext-Powershell-Module


## RELATED LINKS

- [Online version: https://github.com/ptmorris1/TriliumNext-Powershell-Module](https://github.com/ptmorris1/TriliumNext-Powershell-Module)
- [Connect-TriliumAuth]()
