---
document type: cmdlet
external help file: Trilium-Help.xml
HelpUri: https://github.com/ptmorris1/TriliumNext-Powershell-Module
Locale: en-US
Module Name: Trilium
ms.date: 07/19/2025
PlatyPS schema version: 2024-05-01
title: Set-TriliumNoteDetails
---

# Set-TriliumNoteDetails

## SYNOPSIS

Patch (update) a TriliumNext note's type, title, or both by noteId.

## SYNTAX

### __AllParameterSets

```
Set-TriliumNoteDetails [-NoteId] <string> [[-NoteType] <string>] [[-Title] <string>]
 [-SkipCertCheck] [<CommonParameters>]
```

## ALIASES

None

## DESCRIPTION

Updates a TriliumNext note's type and/or title using the PATCH /notes/{noteId} endpoint.
You must provide the noteId.
Optionally, you can provide a new note type (from the supported list) and/or a new title.
For certain types, a corresponding mime value will be set in the body.
If -NoteType is not specified, the note will default to type 'text' and mime 'text/html'.

## EXAMPLES

### EXAMPLE 1

```powershell
Set-TriliumNoteDetails -NoteId "evnnmvHTCgIn" -NoteType PlainText -Title "New Note Title"
```

Updates the note with the specified ID, sets the type to 'code' and mime to 'text/plain', and updates the title.

### EXAMPLE 2

```powershell
Set-TriliumNoteDetails -NoteId "evnnmvHTCgIn" -Title "Updated Title Only"
```

Updates only the title of the note with the specified ID.

### EXAMPLE 3

```powershell
Set-TriliumNoteDetails -NoteId "evnnmvHTCgIn" -NoteType markdown
```

Updates only the type of the note with the specified ID to 'code' with mime 'text/x-markdown'.

## PARAMETERS

### -NoteId

The ID of the note to update.
This parameter is required.

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

### -NoteType

The type to set for the note.
Optional.
Must be one of:
    text, book, canvas, mermaid, geoMap, mindMap, relationMap, renderNote, webview,
    PlainText, CSS, html, http, JSbackend, JSfrontend, json, markdown, powershell, python, ruby, shellBash, sql, sqliteTrilium, xml, yaml
If not specified, defaults to 'text' with mime 'text/html'.

    Required?                    false
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
Optional.
Use this if you are connecting to a Trilium server with a self-signed certificate.

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

### -Title

The new title to set for the note.
Optional.
If not specified, the title will not be changed.

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

### CommonParameters

This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable,
-InformationAction, -InformationVariable, -OutBuffer, -OutVariable, -PipelineVariable,
-ProgressAction, -Verbose, -WarningAction, and -WarningVariable. For more information, see
[about_CommonParameters](https://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

None

## OUTPUTS

System.Object

Returns the API response from Trilium containing information about the updated note.

## NOTES

!!! note
    This function requires that authentication has been set using Connect-TriliumAuth.
    
    - If -NoteType is not specified, the note will default to type 'text' and mime 'text/html'.
    - If -Title is not specified, the title will not be changed.


## RELATED LINKS

- [](https://github.com/ptmorris1/TriliumNext-Powershell-Module)
