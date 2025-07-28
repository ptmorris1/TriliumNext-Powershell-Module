---
document type: cmdlet
external help file: Trilium-Help.xml
HelpUri: https://github.com/ptmorris1/TriliumNext-Powershell-Module
Locale: en-US
Module Name: Trilium
ms.date: 07/19/2025
PlatyPS schema version: 2024-05-01
title: Get-TriliumAttachment
---

# Get-TriliumAttachment

## SYNOPSIS

Retrieves metadata for a specific Trilium Notes attachment by its ID.

## SYNTAX

### __AllParameterSets

```
Get-TriliumAttachment [-AttachmentID] <string> [-SkipCertCheck] [<CommonParameters>]
```

## ALIASES

None

## DESCRIPTION

Gets the metadata (properties and details) for a Trilium Notes attachment using the provided attachment ID.
This does not return the raw file or binary content, but rather the attachment's metadata as a PowerShell object.
Requires prior authentication with Connect-TriliumAuth.

## EXAMPLES

### EXAMPLE 1

```powershell
Get-TriliumAttachment -AttachmentID "evnnmvHTCgIn"
```

Retrieves the metadata for the attachment with the specified ID and outputs it as a PowerShell object.

### EXAMPLE 2

```powershell
Get-TriliumAttachment -AttachmentID "evnnmvHTCgIn" -SkipCertCheck
```

Retrieves the attachment metadata while skipping SSL certificate validation.

## PARAMETERS

### -AttachmentID

The unique ID of the attachment to retrieve metadata for.
This value can be found in the note's attachment metadata or via Find-TriliumNote.

    Required?                    true
    Position?                    0
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

If specified, skips SSL certificate validation for the request.
Useful for self-signed certificates or development environments.

    Required?                    false
    Position?                    Named
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

### System.Object

Returns the attachment metadata as a PowerShell object. This includes properties such as attachmentId, title, dateModified, utcDateModified, dateCreated, utcDateCreated, mime, isProtected, blobId, and contentLength.

## NOTES

- Requires authentication via Connect-TriliumAuth.
- This function returns only the metadata for the attachment, not the file or binary content.
To download the actual content, use Get-TriliumAttachmentContent.
- If the attachment is not found or an error occurs, the function returns the error response from the server.
- For more information on finding attachment IDs, see Get-TriliumAttachment.


## RELATED LINKS

[TriliumNext PowerShell Module](https://github.com/ptmorris1/TriliumNext-Powershell-Module)
