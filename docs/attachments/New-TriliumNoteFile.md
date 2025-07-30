---
document type: cmdlet
external help file: Trilium-Help.xml
HelpUri: ''
Locale: en-US
Module Name: Trilium
ms.date: 07/19/2025
PlatyPS schema version: 2024-05-01
title: New-TriliumNoteFile
---

# New-TriliumNoteFile

## SYNOPSIS

Creates a new Trilium note with a file (binary content) as its content.

## SYNTAX

### __AllParameterSets

```
New-TriliumNoteFile [-ParentNoteId] <string> [-FilePath] <string> [[-Type] <string>]
 [[-Mime] <string>] [[-NotePosition] <int>] [[-Prefix] <string>] [[-IsExpanded] <string>]
 [[-NoteId] <string>] [[-BranchId] <string>] [[-Title] <string>] [<CommonParameters>]
```

## ALIASES

None

## DESCRIPTION

This function creates a note, sets the original file name as an attribute, and uploads the file content as binary.
The note type and content are determined automatically based on the file extension.

## EXAMPLES

### EXAMPLE 1

```powershell
New-TriliumNoteFile -ParentNoteId "abc123" -FilePath "C:\docs\file.pdf"
```

Creates a new note with the PDF file content under the parent note with ID "abc123". The note title will be "file.pdf" and the type will be automatically determined as "file".

### EXAMPLE 2

```powershell
New-TriliumNoteFile -ParentNoteId "abc123" -FilePath "C:\images\photo.jpg" -Title "My Photo" -Type "image"
```

Creates a new image note with a custom title "My Photo" under the parent note with ID "abc123".

## PARAMETERS

### -BranchId

(Optional) ID for the branch.

```yaml
Type: System.String
DefaultValue: ''
SupportsWildcards: false
Aliases: []
ParameterSets:
- Name: (All)
  Position: 8
  IsRequired: false
  ValueFromPipeline: false
  ValueFromPipelineByPropertyName: false
  ValueFromRemainingArguments: false
DontShow: false
AcceptedValues: []
HelpMessage: ''
```

### -FilePath

The path to the file to upload.

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

### -IsExpanded

(Optional) Whether the note is expanded.

```yaml
Type: System.String
DefaultValue: ''
SupportsWildcards: false
Aliases: []
ParameterSets:
- Name: (All)
  Position: 6
  IsRequired: false
  ValueFromPipeline: false
  ValueFromPipelineByPropertyName: false
  ValueFromRemainingArguments: false
DontShow: false
AcceptedValues: []
HelpMessage: ''
```

### -Mime

(Optional) The MIME type of the file.
If not specified, it is determined from the file extension.

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

### -NoteId

(Optional) ID for the note.

```yaml
Type: System.String
DefaultValue: ''
SupportsWildcards: false
Aliases: []
ParameterSets:
- Name: (All)
  Position: 7
  IsRequired: false
  ValueFromPipeline: false
  ValueFromPipelineByPropertyName: false
  ValueFromRemainingArguments: false
DontShow: false
AcceptedValues: []
HelpMessage: ''
```

### -NotePosition

(Optional) The position of the note.

```yaml
Type: System.Int32
DefaultValue: 0
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

### -ParentNoteId

The ID of the parent note.

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

### -Prefix

(Optional) Prefix for the note.

```yaml
Type: System.String
DefaultValue: ''
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

### -Title

(Optional) Title for the note.
If not provided, the file name (with extension) is used as the title.

```yaml
Type: System.String
DefaultValue: ''
SupportsWildcards: false
Aliases: []
ParameterSets:
- Name: (All)
  Position: 9
  IsRequired: false
  ValueFromPipeline: false
  ValueFromPipelineByPropertyName: false
  ValueFromRemainingArguments: false
DontShow: false
AcceptedValues: []
HelpMessage: ''
```

### -Type

(Optional) The type of the note ('file', 'image', etc.).
If not specified, determined from file extension.

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

### CommonParameters

This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable,
-InformationAction, -InformationVariable, -OutBuffer, -OutVariable, -PipelineVariable,
-ProgressAction, -Verbose, -WarningAction, and -WarningVariable. For more information, see
[about_CommonParameters](https://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

### None

You cannot pipe objects to New-TriliumNoteFile.

## OUTPUTS

### PSCustomObject

Returns the created note object with the following properties:

- **NoteId**: The unique identifier of the created note
- **Title**: The title of the note
- **Type**: The note type (file, image, etc.)
- **Mime**: The MIME type of the file content
- **ParentNoteId**: The ID of the parent note
- **IsExpanded**: Whether the note is expanded in the tree view
- **NotePosition**: The position of the note among its siblings

## NOTES

- Requires authentication via Connect-TriliumAuth.
- This function creates a note with binary file content and sets the original filename as an attribute.
- The note type and MIME type are automatically determined from the file extension if not specified.
- Supported file types include images, PDFs, documents, and other binary files.
- The created note will appear in the Trilium tree structure under the specified parent note.
- Author: P. Morris
- Module: TriliumNext-Powershell-Module

## RELATED LINKS

[TriliumNext PowerShell Module](https://github.com/ptmorris1/TriliumNext-Powershell-Module)

