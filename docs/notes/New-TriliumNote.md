---
document type: cmdlet
external help file: Trilium-Help.xml
HelpUri: ''
Locale: en-US
Module Name: Trilium
ms.date: 07/19/2025
PlatyPS schema version: 2024-05-01
title: New-TriliumNote
---

# New-TriliumNote

## SYNOPSIS

Creates a new note in Trilium Notes.

## SYNTAX

### __AllParameterSets

```
New-TriliumNote [[-ParentNoteId] <string>] [[-Title] <string>] [-Content] <string>
 [[-NoteType] <string>] [[-Mime] <string>] [-SkipCertCheck] [-Markdown] [-Math] [-WhatIf] [-Confirm]
 [<CommonParameters>]
```

## ALIASES

This cmdlet has the following aliases,
  {{Insert list of aliases}}

## DESCRIPTION

Creates a new note in Trilium Notes with the specified content, title, type, and formatting options.
Supports a wide range of note types, including text, markdown, code, and special types like book, canvas, mermaid, and more.
When using `-Markdown`, the function converts markdown to HTML before sending to Trilium, with optional MathJax support via `-Math`.
HTML content is beautified before sending.
Requires authentication via `Connect-TriliumAuth`.

## EXAMPLES

### EXAMPLE 1

New-TriliumNote -Title "My Note" -Content "This is the content of my note"
Creates a new text note with the specified title and content under the root.

### EXAMPLE 2

New-TriliumNote -Title "Code Sample" -Content "Get-Process" -NoteType "powershell"
Creates a new PowerShell code note with syntax highlighting.

### EXAMPLE 3

New-TriliumNote -Title "Markdown Note" -Content "# Header`n`nThis is *markdown* content" -Markdown
Creates a new note by converting the markdown content to HTML.

### EXAMPLE 4

New-TriliumNote -Title "Math Example" -Content "When $a \ne 0$, there are two solutions to $ax^2 + bx + c = 0$" -Markdown -Math
Creates a note with markdown content that includes mathematical expressions.

### EXAMPLE 5

$parentId = (Get-TriliumNotes -Title "My Folder").noteId
New-TriliumNote -ParentNoteId $parentId -Title "Nested Note" -Content "This is a nested note"
Creates a new note inside an existing note folder by specifying its ID.

## PARAMETERS

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

### -Content

The content of the new note.
This is required.
For code notes, provide the code as plain text.
For markdown notes, provide markdown-formatted text.

Required?                    true
Position?                    2
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
  Position: 2
  IsRequired: true
  ValueFromPipeline: false
  ValueFromPipelineByPropertyName: false
  ValueFromRemainingArguments: false
DontShow: false
AcceptedValues: []
HelpMessage: ''
```

### -Markdown

If specified, the Content will be treated as markdown and converted to HTML.
When this parameter is used, NoteType must be 'text' or not specified.
Enables advanced markdown rendering including tables, task lists, and code blocks.

Required?                    false
Position?                    named
Default value                false
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

### -Math

If specified, adds support for mathematical expressions in markdown using MathJax.
Only used with the -Markdown parameter.
Math expressions can be included inline using $expression$ syntax or as blocks with $$ syntax.

Required?                    false
Position?                    named
Default value                false
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

### -Mime

The MIME type of the note content.
If not specified, it will be determined based on NoteType.
Only specify this if you need to override the default MIME type.

Required?                    false
Position?                    4
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
  Position: 4
  IsRequired: false
  ValueFromPipeline: false
  ValueFromPipelineByPropertyName: false
  ValueFromRemainingArguments: false
DontShow: false
AcceptedValues: []
HelpMessage: ''
```

### -NoteType

The type of note to create.
Tab completion is available for common types.
Supported values:
image, file, text, book, canvas, mermaid, geoMap, mindMap, relationMap, renderNote, webview, PlainText, CSS, html, http, JSbackend, JSfrontend, json, markdown, powershell, python, ruby, shellBash, sql, sqliteTrilium, xml, yaml
See Trilium documentation for more details.

Required?                    false
Position?                    3
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
  Position: 3
  IsRequired: false
  ValueFromPipeline: false
  ValueFromPipelineByPropertyName: false
  ValueFromRemainingArguments: false
DontShow: false
AcceptedValues: []
HelpMessage: ''
```

### -ParentNoteId

The ID of the parent note under which the new note will be created.
Defaults to 'root'.
Use `Get-TriliumNotes` to find IDs of existing notes.

Required?                    false
Position?                    0
Default value                'root'
Accept pipeline input?       false
Accept wildcard characters?  false

```yaml
Type: System.String
DefaultValue: root
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

If specified, certificate validation will be skipped when connecting to Trilium (useful for self-signed certificates).

Required?                    false
Position?                    named
Default value                false
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

The title of the new note.
Displayed in the Trilium Notes UI.

Required?                    false
Position?                    1
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
  Position: 1
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

### None. You cannot pipe objects to New-TriliumNote.

{{ Fill in the Description }}

## OUTPUTS

### System.Management.Automation.PSCustomObject
Returns the API response from Trilium

{{ Fill in the Description }}

## NOTES

Requires authentication via Connect-TriliumAuth before use.
Author: P.
Morris
Module: TriliumNext-Powershell-Module


## RELATED LINKS

- [Online version: https://github.com/ptmorris1/TriliumNext-Powershell-Module]()
- [Connect-TriliumAuth]()
- [Get-TriliumNotes]()
