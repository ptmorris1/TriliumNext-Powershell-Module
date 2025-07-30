---
document type: cmdlet
external help file: Trilium-Help.xml
HelpUri: ''
Locale: en-US
Module Name: Trilium
ms.date: 07/19/2025
PlatyPS schema version: 2024-05-01
title: Format-TriliumHtml
---

# Format-TriliumHtml

## SYNOPSIS

Formats and beautifies HTML content for Trilium Notes.

## SYNTAX

### __AllParameterSets

```
Format-TriliumHtml [-Content] <string> [<CommonParameters>]
```

## DESCRIPTION

This function formats and beautifies HTML content before sending to Trilium Notes.
It fixes spacing issues, improves header formatting, and cleans up HTML structure
to ensure proper display in Trilium Notes.

The function performs several improvements to the HTML:
- Fixes redundant empty paragraph tags before headings
- Adds proper spacing between code blocks and headings
- Ensures consistent new lines before headings
- Fixes spacing issues with images and code blocks
- Removes redundant empty lines and excessive whitespace
- Improves overall HTML structure for better rendering in Trilium

## EXAMPLES

### EXAMPLE 1

```powershell
$html = Format-TriliumHtml -Content "<h2>Header</h2><p>Text</p>"
```

Beautifies the HTML by adding proper spacing and formatting.

### EXAMPLE 2

```powershell
$markdownHtml = [Markdig.Markdown]::ToHtml($markdown)
$beautifiedHtml = Format-TriliumHtml -Content $markdownHtml
```

Processes HTML generated from markdown to ensure proper formatting in Trilium Notes.

```powershell
$html = "<pre><code>Get-Process</code></pre><h2>Results</h2>"
Format-TriliumHtml -Content $html
```

Adds proper spacing between the code block and the heading.

### EXAMPLE 3

```powershell
# Example of retrieving note content, beautifying it, and updating the note
$noteId = "abc123def456"
$originalContent = Get-TriliumNoteContent -NoteID $noteId
$beautifiedContent = Format-TriliumHtml -Content $originalContent
Set-TriliumNoteContent -NoteID $noteId -NoteContent $beautifiedContent
```

This example shows a complete workflow: retrieving a note's content with Get-TriliumNoteContent, beautifying the HTML with Format-TriliumHtml, and then saving the improved content back to the note with Set-TriliumNoteContent.

## PARAMETERS

### -Content

The HTML content to beautify.

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

### CommonParameters

This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable,
-InformationAction, -InformationVariable, -OutBuffer, -OutVariable, -PipelineVariable,
-ProgressAction, -Verbose, -WarningAction, and -WarningVariable. For more information, see
[about_CommonParameters](https://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

None

You cannot pipe objects to Format-TriliumHtml. Format-TriliumHtml only accepts the -Content parameter as direct input.

## OUTPUTS

System.String

Format-TriliumHtml returns a string with the beautified HTML content. The output is a formatted HTML string suitable for Trilium Notes.

## NOTES

This function is used internally by New-TriliumNote to format HTML content. It performs several improvements to the HTML structure to ensure proper display in Trilium Notes.

**Author:** Patrick Morris  
**Module:** Trilium


## RELATED LINKS

[TriliumNext PowerShell Module](https://github.com/ptmorris1/TriliumNext-Powershell-Module)
