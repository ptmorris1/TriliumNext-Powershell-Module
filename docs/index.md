---
title: Home
hide:
  - navigation
---

# Trilium PowerShell Module Docs

Welcome to the documentation for the Trilium PowerShell module. This module provides functions to interact with [Trilium ETAPI](https://github.com/TriliumNext/Trilium/blob/main/apps/server/src/assets/etapi.openapi.yaml) to automate tasks, and manage your notes.

Trilium is an advanced hierarchical note-taking application. Learn more at [Trilium on GitHub](https://github.com/TriliumNext/Trilium).

## ✨ Features

This module enables you to:

- Connect and disconnect from your TriliumNext instance
- Search, create, update, and delete notes
- Export and import notes as ZIP files
- Manage note attributes, branches, and attachments
- Create notes by day, week, month, year, and inbox
- Backup your Trilium instance
- Update note order and details
- Create note using Markdown content
- Upload files as note attachments and create notes from files
- Retrieve application info and root note details
- And more!

## 🗂️ API Endpoints and Functions

| Method | Endpoint | Function | Notes |
|--------|----------|----------|-------|
| POST   | /create-note | [New-TriliumNote](notes/New-TriliumNote.md) | Create a new note |
| GET    | /notes | [Find-TriliumNote](notes/Find-TriliumNote.md) | Search for notes |
| GET    | /notes/{noteId} | [Get-TriliumNoteDetails](notes/Get-TriliumNoteDetail.md) | Get note details |
| PATCH  | /notes/{noteId} | [Set-TriliumNoteDetails](notes/Set-TriliumNoteDetails.md) | Update note details (PATCH) |
| DELETE | /notes/{noteId} | [Remove-TriliumNote](notes/Remove-TriliumNote.md) | Delete a note |
| GET    | /notes/{noteId}/content | [Get-TriliumNoteContent](notes/Get-TriliumNoteContent.md) | Get note content |
| PUT    | /notes/{noteId}/content | [Set-TriliumNoteContent](notes/Set-TriliumNoteContent.md) | Update note content |
| GET    | /notes/{noteId}/export | [Export-TriliumNote](notes/Export-TriliumNote.md) | Export note(s) as zip (HTML/Markdown) |
| POST   | /notes/{noteId}/import | [Import-TriliumNoteZip](notes/Import-TriliumNoteZip.md) | Import notes from ZIP |
| POST   | /notes/{noteId}/revision | [New-TriliumNoteRevision](notes/New-TriliumNoteRevision.md) | Create a new note revision |
| POST   | /branches | [Copy-TriliumNote](clone/Copy-TriliumNote.md) | Copy a note to a new branch |
| GET    | /branches/{branchId} | [Get-TriliumBranch](clone/Get-TriliumBranch.md) | Get branch details |
| PATCH  | /branches/{branchId} | [Set-TriliumBranch](clone/Set-TriliumBranch.md) | Update branch prefix and/or note position (PATCH) |
| DELETE | /branches/{branchId} | [Remove-TriliumBranch](clone/Remove-TriliumBranch.md) | Delete a branch |
| POST   | /attachments | [New-TriliumAttachment](attachments/New-TriliumAttachment.md) | Create a new attachment for a note |
| GET    | /attachments/{attachmentId} | [Get-TriliumAttachment](attachments/Get-TriliumAttachment.md) | Get attachment metadata |
| PATCH  | /attachments/{attachmentId} |  | |
| DELETE | /attachments/{attachmentId} | [Remove-TriliumAttachment](attachments/Remove-TriliumAttachment.md) | Delete an attachment |
| GET    | /attachments/{attachmentId}/content | [Get-TriliumAttachmentContent](attachments/Get-TriliumAttachmentContent.md) | Download attachment content |
| PUT    | /attachments/{attachmentId}/content | [New-TriliumNoteFile](attachments/New-TriliumNoteFile.md) | Create a new note from a local file (uploads file content) |
| N/A    | N/A | [Format-TriliumHtml](misc/Format-TriliumHtml.md) | Helper function to beautify HTML content with improved header spacing and code block formatting |
| POST   | /attributes | [New-TriliumAttribute](attributes/New-TriliumAttribute.md) | Create a new attribute |
| GET    | /attributes/{attributeId} | [Get-TriliumAttribute](attributes/Get-TriliumAttribute.md) | Get attribute details |
| PATCH  | /attributes/{attributeId} |  | |
| DELETE | /attributes/{attributeId} | [Remove-TriliumAttribute](attributes/Remove-TriliumAttribute.md) | Delete an attribute |
| POST   | /refresh-note-ordering/{parentNoteId} | [Update-TriliumNoteOrder](misc/Update-TriliumNoteOrder.md) | Refresh note ordering |
| GET    | /inbox/{date} | [Get-TriliumInbox](calendar/Get-TriliumInbox.md) | Get or create inbox note for a date |
| GET    | /calendar/days/{date} | [Get-TriliumDayNote](calendar/Get-TriliumDayNote.md) | Get or create day note for a date |
| GET    | /calendar/weeks/{date} | [Get-TriliumWeekNote](calendar/Get-TriliumWeekNote.md) | (Broken: appears to be a bug in Trilium) |
| GET    | /calendar/months/{month} | [Get-TriliumMonthNote](calendar/Get-TriliumMonthNote.md) | Get or create month note for a month |
| GET    | /calendar/years/{year} | [Get-TriliumYearNote](calendar/Get-TriliumYearNote.md) | Get or create year note for a year |
| POST   | /auth/login | [Connect-TriliumAuth](auth/Connect-TriliumAuth.md) | Authenticate to Trilium (now uses 'Bearer' for ETAPI) |
| POST   | /auth/logout | [Disconnect-TriliumAuth](auth/Disconnect-TriliumAuth.md) | Logout from Trilium |
| GET    | /app-info | [Get-TriliumInfo](misc/Get-TriliumInfo.md) | Get Trilium server info |
| PUT    | /backup/{backupName} | [New-TriliumBackup](misc/New-TriliumBackup.md) | Create a new backup |
| GET    | /notes/root | [Get-TriliumRootNote](misc/Get-TriliumRootNote.md) | Get root note details (requires Connect-TriliumAuth, no params; every root note has id 'root'). |
| GET    | /notes/{noteId}/attachments | [Get-TriliumNoteAttachment](attachments/Get-TriliumNoteAttachment.md) | Retrieves attachments for a specific note (Undocumented API) |


## 📦 Installation

To install the module, run:

```powershell
Install-PSResource Trilium -Scope CurrentUser
```

## 📥 Importing the Module

After installation, import the module with:

```powershell
Import-Module Trilium
```

## 🌐 [Connect to Trilium](./auth/auth.md)

## 🛠️ Start using the other [functions](Trilium.md)