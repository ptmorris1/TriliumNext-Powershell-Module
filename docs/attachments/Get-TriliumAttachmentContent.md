---
document type: cmdlet
external help file: Trilium-Help.xml
HelpUri: https://github.com/ptmorris1/TriliumNext-Powershell-Module
Locale: en-US
Module Name: Trilium
ms.date: 07/19/2025
PlatyPS schema version: 2024-05-01
title: Get-TriliumAttachmentContent
---

# Get-TriliumAttachmentContent

## SYNOPSIS

Gets the content of a specific TriliumNext attachment by its ID.

## SYNTAX

### __AllParameterSets

```
Get-TriliumAttachmentContent [-AttachmentID] <string> [-SkipCertCheck] [<CommonParameters>]
```

## ALIASES

None

## DESCRIPTION

This function retrieves the content of a TriliumNext attachment using the provided attachment ID.

## EXAMPLES

### EXAMPLE 1

```powershell
Get-TriliumAttachmentContent -AttachmentID "evnnmvHTCgIn"
```

Retrieves the content of the attachment with the specified ID and returns it as binary data.

### EXAMPLE 2

```powershell
Get-TriliumAttachmentContent -AttachmentID "abc123" -SkipCertCheck
```

Retrieves the content of the attachment while skipping SSL certificate validation (useful for self-signed certificates).

## PARAMETERS

### -AttachmentID

The attachment ID to retrieve content for.

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

### None

You cannot pipe objects to Get-TriliumAttachmentContent.

## OUTPUTS

### System.Byte[]

Returns the raw binary content of the attachment as a byte array. This can be used to save the attachment to disk or process the content programmatically.

## NOTES

- Requires authentication via Connect-TriliumAuth.
- This function returns raw binary data that can be used to save files or process content programmatically.
- Use `-SkipCertCheck` parameter when working with self-signed certificates.
- The returned byte array can be written to a file using `[System.IO.File]::WriteAllBytes()` or similar methods.
- Author: P. Morris
- Module: TriliumNext-Powershell-Module


## RELATED LINKS

[TriliumNext PowerShell Module](https://github.com/ptmorris1/TriliumNext-Powershell-Module)
