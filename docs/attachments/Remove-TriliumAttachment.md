---
document type: cmdlet
external help file: Trilium-Help.xml
HelpUri: https://github.com/ptmorris1/TriliumNext-Powershell-Module
Locale: en-US
Module Name: Trilium
ms.date: 07/19/2025
PlatyPS schema version: 2024-05-01
title: Remove-TriliumAttachment
---

# Remove-TriliumAttachment

## SYNOPSIS

Removes a specific Trilium attachment by its ID.

## SYNTAX

### __AllParameterSets

```
Remove-TriliumAttachment [-AttachmentID] <string> [-SkipCertCheck] [-WhatIf] [-Confirm]
 [<CommonParameters>]
```

## ALIASES

This cmdlet has the following aliases,
  {{Insert list of aliases}}

## DESCRIPTION

Deletes a Trilium attachment using the provided AttachmentID.
Supports pipeline input for AttachmentID.
Requires authentication via Connect-TriliumAuth.

## EXAMPLES

### EXAMPLE 1

Remove-TriliumAttachment -AttachmentID "evnnmvHTCgIn"

Removes the attachment with the specified ID.

### EXAMPLE 2

"evnnmvHTCgIn", "abc123" | Remove-TriliumAttachment

Removes multiple attachments by piping their IDs to the function.

## PARAMETERS

### -AttachmentID

The ID of the attachment to remove.
Accepts input from the pipeline.

    Required?                    true
    Position?                    0
    Default value                None
    Accept pipeline input?       true
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
  ValueFromPipeline: true
  ValueFromPipelineByPropertyName: false
  ValueFromRemainingArguments: false
DontShow: false
AcceptedValues: []
HelpMessage: ''
```

### -Confirm

Prompts you for confirmation before running the cmdlet.

```yaml
Type: System.Management.Automation.SwitchParameter
DefaultValue: ''
SupportsWildcards: false
Aliases:
- cf
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

### -SkipCertCheck

If specified, skips SSL certificate validation for the request.

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

### -WhatIf

Tells PowerShell to run the command in a mode that only reports what would happen, but not actually let the command run or make changes.

```yaml
Type: System.Management.Automation.SwitchParameter
DefaultValue: ''
SupportsWildcards: false
Aliases:
- wi
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

### System.String

{{ Fill in the Description }}

## OUTPUTS

## NOTES

This function requires that authentication has been set using Connect-TriliumAuth.


## RELATED LINKS

- [](https://github.com/ptmorris1/TriliumNext-Powershell-Module)
