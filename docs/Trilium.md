---
document type: module
Help Version: 1.0.0.0
HelpInfoUri: 
Locale: en-US
Module Guid: 5d0452a3-0c40-4681-b12c-070eccc905dc
Module Name: Trilium
ms.date: 07/19/2025
PlatyPS schema version: 2024-05-01
title: Functions
---

# Trilium Module

## Description

Powershell wrapper for the Trilium Notes API

## Trilium

### [Connect-TriliumAuth](auth/Connect-TriliumAuth.md)

Authenticates to a TriliumNext instance for API calls.

### [Copy-TriliumNote](clone/Copy-TriliumNote.md)

Creates a clone (branch) of a Trilium note in another note.

### [Disconnect-TriliumAuth](auth/Disconnect-TriliumAuth.md)

Removes authentication for TriliumNext and clears stored credentials.

### [Export-TriliumNote](notes/Export-TriliumNote.md)

Exports a TriliumNext note to a zip file.

### [Find-TriliumNote](notes/Find-TriliumNote.md)

Searches for TriliumNext notes by title, label, or other criteria.

### [Format-TriliumHtml](misc/Format-TriliumHtml.md)

Formats and beautifies HTML content for Trilium Notes.

### [Get-TriliumAttachment](attachments/Get-TriliumAttachment.md)

Retrieves metadata for a specific Trilium Notes attachment by its ID.

### [Get-TriliumAttachmentContent](attachments/Get-TriliumAttachmentContent.md)

Gets the content of a specific TriliumNext attachment by its ID.

### [Get-TriliumAttribute](attributes/Get-TriliumAttribute.md)

Gets details of a specific Trilium attribute.

### [Get-TriliumBranch](clone/Get-TriliumBranch.md)

Gets details of a specific Trilium branch.

### [Get-TriliumDayNote](calendar/Get-TriliumDayNote.md)

Gets (or creates) the TriliumNext day note for a specific date.

### [Get-TriliumInbox](calendar/Get-TriliumInbox.md)

Gets (or creates) the TriliumNext inbox note for a specific date.

### [Get-TriliumInfo](misc/Get-TriliumInfo.md)

Gets the application info for TriliumNext.

### [Get-TriliumMonthNote](calendar/Get-TriliumMonthNote.md)

Gets (or creates) the TriliumNext month note for a specific month.

### [Get-TriliumNoteAttachment](attachments/Get-TriliumNoteAttachment.md)

Retrieves all attachments for a specific Trilium Notes note by note ID.

### [Get-TriliumNoteContent](notes/Get-TriliumNoteContent.md)

Gets the content of a specific Trilium note.

### [Get-TriliumNoteDetail](notes/Get-TriliumNoteDetail.md)

Gets details of a specific TriliumNext note.

### [Get-TriliumRootNote](misc/Get-TriliumRootNote.md)

Gets the root note details from the TriliumNext instance.

### [Get-TriliumWeekNote](calendar/Get-TriliumWeekNote.md)

Gets (or creates) the TriliumNext week note for a specific date.

### [Get-TriliumYearNote](calendar/Get-TriliumYearNote.md)

Gets (or creates) the TriliumNext year note for a specific year.

### [Import-TriliumNoteZip](notes/Import-TriliumNoteZip.md)

Imports a Trilium note zip file to a specific Trilium note.

### [New-TriliumAttachment](attachments/New-TriliumAttachment.md)

Uploads a file as an attachment to a Trilium Notes note and appends a reference link or image to the end of the note's content.

### [New-TriliumAttribute](attributes/New-TriliumAttribute.md)

Creates or updates a Trilium attribute (label or relation) for a note.

### [New-TriliumBackup](misc/New-TriliumBackup.md)

Creates a new backup for a specific Trilium instance.

### [New-TriliumNote](notes/New-TriliumNote.md)

Creates a new note in Trilium Notes.

### [New-TriliumNoteFile](attachments/New-TriliumNoteFile.md)

Creates a new Trilium note with a file (binary content) as its content.

### [New-TriliumNoteRevision](notes/New-TriliumNoteRevision.md)

Creates a new revision for a specific Trilium note.

### [Remove-TriliumAttachment](attachments/Remove-TriliumAttachment.md)

Removes a specific Trilium attachment by its ID.

### [Remove-TriliumAttribute](attributes/Remove-TriliumAttribute.md)

Removes a specific Trilium attribute.

### [Remove-TriliumBranch](clone/Remove-TriliumBranch.md)

Removes a specific Trilium branch.

### [Remove-TriliumNote](notes/Remove-TriliumNote.md)

Removes a Trilium note.

### [Set-TriliumBranch](clone/Set-TriliumBranch.md)

Patch (update) a TriliumNext branch's prefix or note position by branchId.

### [Set-TriliumNoteContent](notes/Set-TriliumNoteContent.md)

Sets the content of a specific Trilium note.

### [Set-TriliumNoteDetails](notes/Set-TriliumNoteDetails.md)

Patch (update) a TriliumNext note's type, title, or both by noteId.

### [Update-TriliumNoteOrder](misc/Update-TriliumNoteOrder.md)

Updates the order of notes under a specific parent note.

