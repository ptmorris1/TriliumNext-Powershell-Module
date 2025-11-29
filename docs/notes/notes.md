---
#title: Calendar
hide:
  - navigation
---

# Notes Functions

The TriliumNext PowerShell Module provides comprehensive functionality for managing notes in your TriliumNext instance. These functions allow you to create, read, update, delete, and manipulate notes programmatically.

!!! warning "Authentication Required"
    All note functions require authentication via `Connect-TriliumAuth` before use.

## Core Functions

### Note Management

| Function | Description |
|----------|-------------|
| [`New-TriliumNote`](New-TriliumNote.md) | Creates a new note with specified content, title, and type |
| [`Get-TriliumNoteDetail`](Get-TriliumNoteDetail.md) | Retrieves detailed information about a specific note |
| [`Get-TriliumNoteContent`](Get-TriliumNoteContent.md) | Gets the content of a specific note |
| [`Set-TriliumNoteContent`](Set-TriliumNoteContent.md) | Updates the content of an existing note |
| [`Set-TriliumNoteDetails`](Set-TriliumNoteDetails.md) | Updates note properties like title and type |
| [`Remove-TriliumNote`](Remove-TriliumNote.md) | Permanently deletes a note |

### Search and Discovery

| Function | Description |
|----------|-------------|
| [`Find-TriliumNote`](Find-TriliumNote.md) | Searches for notes by title, content, labels, and other criteria |

### Import/Export

| Function | Description |
|----------|-------------|
| [`Export-TriliumNote`](Export-TriliumNote.md) | Exports a note and its children to a zip file |
| [`Import-TriliumNoteZip`](Import-TriliumNoteZip.md) | Imports a note zip file into TriliumNext |

### Version Control

| Function | Description |
|----------|-------------|
| [`New-TriliumNoteRevision`](New-TriliumNoteRevision.md) | Creates a new revision for a note |

## Common Use Cases

### Creating Notes

```powershell
# Create a simple text note
New-TriliumNote -Title "My Note" -Content "This is my note content"

# Create a markdown note with math support
New-TriliumNote -Title "Technical Doc" -Content "# Header`n`nFormula: $E = mc^2$" -Markdown -Math

# Create a code note
New-TriliumNote -Title "PowerShell Script" -Content "Get-Process" -NoteType "powershell"
```

### Finding Notes

```powershell
# Search by title
Find-TriliumNote -Search "meeting"

# Search with filters
Find-TriliumNote -Search "project" -Label "work" -FastSearch

# Limited search with ordering
Find-TriliumNote -Search "api" -Limit 10 -OrderBy dateCreated
```

### Working with Note Content

```powershell
# Get note details
$note = Get-TriliumNoteDetail -NoteID "abc123"

# Get note content
$content = Get-TriliumNoteContent -NoteID "abc123"

# Update note content
Set-TriliumNoteContent -NoteID "abc123" -NoteContent "Updated content"

# Update note properties
Set-TriliumNoteDetails -NoteId "abc123" -Title "New Title" -NoteType "markdown"
```

## Note Types

TriliumNext supports various note types for different content:

!!! info "Supported Note Types"
    - **Text Types**: `text`, `html`, `markdown`
    - **Code Types**: `powershell`, `python`, `javascript`, `css`, `json`, `yaml`, `xml`, `sql`
    - **Special Types**: `book`, `canvas`, `mermaid`, `mindMap`, `relationMap`, `webview`
    - **File Types**: `image`, `file`

### Code Note Examples

```powershell
# PowerShell code note
New-TriliumNote -Title "PS Script" -Content "Get-Service" -NoteType "powershell"

# Python code note
New-TriliumNote -Title "Python Script" -Content "print('Hello World')" -NoteType "python"

# JSON data note
New-TriliumNote -Title "Config" -Content '{"setting": "value"}' -NoteType "json"
```