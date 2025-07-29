---
document type: cmdlet
external help file: Trilium-Help.xml
HelpUri: https://github.com/ptmorris1/TriliumNext-Powershell-Module
Locale: en-US
Module Name: Trilium
ms.date: 07/19/2025
PlatyPS schema version: 2024-05-01
title: New-TriliumAttachment
---

# New-TriliumAttachment

## SYNOPSIS

Uploads a file as an attachment to a Trilium Notes note and appends a reference link or image to the end of the note's content.

## SYNTAX

### __AllParameterSets

```
New-TriliumAttachment [-OwnerId] <string> [-FilePath] <string> [[-Role] <string>] [[-Mime] <string>]
 [[-Title] <string>] [[-Position] <int>] [<CommonParameters>]
```

## ALIASES

None

## DESCRIPTION

Creates a new attachment for a note in Trilium Notes.
The function uploads the file as an attachment, then appends a reference link (for files) or an image (for images) to the end of the note's content.
Supports specifying role, MIME type, title, and position.
Automatically detects MIME type from file extension if not specified.
For images, includes width, height, and aspect ratio in the HTML snippet.

## EXAMPLES

### EXAMPLE 1

```powershell
New-TriliumAttachment -OwnerId "12345" -FilePath "C:\path\to\file.png"
```

Uploads file.png as an attachment to the note with ID 12345 and appends an image or reference link to the note's content.

### EXAMPLE 2

```powershell
New-TriliumAttachment -OwnerId "12345" -FilePath "C:\path\to\file.pdf" -Title "My PDF" -Mime "application/pdf"
```

Uploads file.pdf as an attachment with a custom title and MIME type.

## PARAMETERS

### -FilePath

The path to the file to upload as an attachment.
    Required?                    true
    Position?                    1
    Accept pipeline input?       false
    Accept wildcard characters?  false

```yaml
Type: System.String
DefaultValue: ''
SupportsWildcards: false
Aliases: []
ParameterSets:
- Name: (All)
  Position: 1
  IsRequired: true
  ValueFromPipeline: false
  ValueFromPipelineByPropertyName: false
  ValueFromRemainingArguments: false
DontShow: false
AcceptedValues: []
HelpMessage: ''
```

### -Mime

(Optional) The MIME type of the attachment.
If not specified, will try to detect from file extension.
    Required?                    false
    Position?                    3
    Accept pipeline input?       false
    Accept wildcard characters?  false

```yaml
Type: System.String
DefaultValue: ''
SupportsWildcards: false
Aliases: []
ParameterSets:
- Name: (All)
  Position: 3
  IsRequired: false
  ValueFromPipeline: false
  ValueFromPipelineByPropertyName: false
  ValueFromRemainingArguments: false
DontShow: false
AcceptedValues: []
HelpMessage: ''
```

### -OwnerId

The note ID to attach the file to.
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

### -Position

(Optional) The position of the attachment in the note's attachment list.
    Required?                    false
    Position?                    5
    Accept pipeline input?       false
    Accept wildcard characters?  false

```yaml
Type: System.Int32
DefaultValue: 0
SupportsWildcards: false
Aliases: []
ParameterSets:
- Name: (All)
  Position: 5
  IsRequired: false
  ValueFromPipeline: false
  ValueFromPipelineByPropertyName: false
  ValueFromRemainingArguments: false
DontShow: false
AcceptedValues: []
HelpMessage: ''
```

### -Role

(Optional) The role of the attachment (e.g., image, file).
If not specified, will be set to 'image' for image MIME types, otherwise 'file'.
    Required?                    false
    Position?                    2
    Accept pipeline input?       false
    Accept wildcard characters?  false

```yaml
Type: System.String
DefaultValue: ''
SupportsWildcards: false
Aliases: []
ParameterSets:
- Name: (All)
  Position: 2
  IsRequired: false
  ValueFromPipeline: false
  ValueFromPipelineByPropertyName: false
  ValueFromRemainingArguments: false
DontShow: false
AcceptedValues: []
HelpMessage: ''
```

### -Title

(Optional) The title of the attachment.
Defaults to the file name.
    Required?                    false
    Position?                    4
    Accept pipeline input?       false
    Accept wildcard characters?  false

```yaml
Type: System.String
DefaultValue: ''
SupportsWildcards: false
Aliases: []
ParameterSets:
- Name: (All)
  Position: 4
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

You cannot pipe objects to New-TriliumAttachment.

## OUTPUTS

### PSCustomObject

Returns the new attachment object with the following properties:

- **Id**: The unique identifier of the attachment
- **OwnerId**: The note ID that owns the attachment
- **Title**: The title of the attachment
- **Role**: The role of the attachment (image, file, etc.)
- **Mime**: The MIME type of the attachment
- **Position**: The position of the attachment in the note's attachment list

## NOTES

- Requires authentication via Connect-TriliumAuth.
- This function uploads the file, creates the attachment, and appends a reference link or image to the note's content.
- For images, the HTML snippet includes width, height, and aspect ratio.
- For files, the HTML snippet is a reference link.
- Author: P.
Morris
- Module: TriliumNext-Powershell-Module


## RELATED LINKS

[TriliumNext PowerShell Module](https://github.com/ptmorris1/TriliumNext-Powershell-Module)
