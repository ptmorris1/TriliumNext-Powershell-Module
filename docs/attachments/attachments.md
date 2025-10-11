---
#title: Home
hide:
  - navigation
---

# 📎 Attachment Functions

This section covers PowerShell cmdlets for managing attachments in TriliumNext. Attachments allow you to associate files with your notes, whether as embedded images, downloadable files, or binary content.

!!! warning
    All functions require authentication via [`Connect-TriliumAuth`](../auth/Connect-TriliumAuth.md) before use.

---

## 📋 Available Cmdlets

### File Management
- **[`New-TriliumAttachment`](New-TriliumAttachment.md)** - Upload a file as an attachment to a note and append a reference link or image
- **[`New-TriliumNoteFile`](New-TriliumNoteFile.md)** - Create a new note with binary file content
- **[`Set-TriliumAttachment`](Set-TriliumAttachment.md)** - Update properties of an existing attachment (role, mime, title, position)
- **[`Remove-TriliumAttachment`](Remove-TriliumAttachment.md)** - Delete a specific attachment by its ID

### Content Retrieval
- **[`Get-TriliumAttachmentContent`](Get-TriliumAttachmentContent.md)** - Retrieve the binary content of an attachment
- **[`Get-TriliumAttachmentInfo`](Get-TriliumAttachmentInfo.md)** - Get metadata and information about an attachment
- **[`Get-TriliumNoteAttachment`](Get-TriliumNoteAttachment.md)** - Get all attachments for a specific note by note ID

---

## 🚀 Quick Start

### Upload an Image Attachment

```powershell
# Upload an image and append it to a note
New-TriliumAttachment -OwnerId "abc123" -FilePath "C:\images\screenshot.png"
```

### Create a File Note

```powershell
# Create a new note containing a PDF file
New-TriliumNoteFile -ParentNoteId "abc123" -FilePath "C:\documents\manual.pdf"
```

### Download Attachment Content

```powershell
# Get attachment content and save to disk
$content = Get-TriliumAttachmentContent -AttachmentID "evnnmvHTCgIn"
[System.IO.File]::WriteAllBytes("C:\downloads\file.pdf", $content)
```

### Update Attachment Properties

```powershell
# Update the title and role of an attachment
Set-TriliumAttachment -AttachmentId "evnnmvHTCgIn" -Title "Updated Title" -Role "image"
```

### List Note Attachments

```powershell
# Get all attachments for a specific note
Get-TriliumNoteAttachment -NoteID "jfkls7klusi"
```

---

## 💡 Key Concepts

### Attachment Types
- **Image attachments**: Automatically embedded as images in notes
- **File attachments**: Added as downloadable links
- **Binary content**: Raw file data stored in notes

### MIME Type Detection
Most cmdlets automatically detect MIME types from file extensions, but you can override this behavior:

```powershell
New-TriliumAttachment -OwnerId "abc123" -FilePath "file.dat" -Mime "application/octet-stream"
```

### Pipeline Support
Several cmdlets support pipeline input for batch operations:

```powershell
"att1", "att2", "att3" | Remove-TriliumAttachment
```

---