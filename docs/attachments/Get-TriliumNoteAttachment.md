---
document type: cmdlet
external help file: Trilium-Help.xml
HelpUri: https://github.com/ptmorris1/TriliumNext-Powershell-Module
Locale: en-US
Module Name: Trilium
ms.date: 07/19/2025
PlatyPS schema version: 2024-05-01
title: Get-TriliumNoteAttachment
---

# Get-TriliumNoteAttachment

## SYNOPSIS

Retrieves all attachments for a specific Trilium Notes note by note ID.

## SYNTAX

### __AllParameterSets

```
Get-TriliumNoteAttachment [-NoteID] <string> [-SkipCertCheck] [<CommonParameters>]
```

## ALIASES

This cmdlet has the following aliases,
  {{Insert list of aliases}}

## DESCRIPTION

Gets the metadata for all attachments associated with a specific Trilium Notes note, using the provided note ID.
Returns an array of attachment metadata objects.
Requires prior authentication with Connect-TriliumAuth.

## EXAMPLES

### EXAMPLE 1

Get-TriliumNoteAttachment -NoteID "jfkls7klusi"
Retrieves all attachment metadata for the note with the specified ID.

### EXAMPLE 2

Get-TriliumNoteAttachment -NoteID "jfkls7klusi" -SkipCertCheck
Retrieves all attachment metadata for the note while skipping SSL certificate validation.

## PARAMETERS

### -NoteID

The unique ID of the note to retrieve attachments for.
This value can be found in the note's metadata or via Find-TriliumNote.

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

### System.Object[]
Returns an array of attachment metadata objects for the specified note. Each object includes properties such as attachmentId

{{ Fill in the Description }}

## NOTES

- Requires authentication via Connect-TriliumAuth.
- This function returns only the metadata for the attachments, not the file or binary content.
To download the actual content, use Get-TriliumAttachmentContent.
- If the note or attachments are not found or an error occurs, the function returns the error response from the server.
- For more information on finding note IDs, see Find-TriliumNote or the Trilium Notes API documentation.


## RELATED LINKS

- [](https://github.com/ptmorris1/TriliumNext-Powershell-Module)
