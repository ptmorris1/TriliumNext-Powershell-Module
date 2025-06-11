# 🚀 Trilium PowerShell Module <!-- omit in toc -->

![PowerShell Gallery Version](https://img.shields.io/powershellgallery/v/Trilium)
![Downloads](https://img.shields.io/powershellgallery/dt/Trilium)
![PSGallery Quality](https://img.shields.io/powershellgallery/p/Trilium)  
[![TriliumNext](https://img.shields.io/badge/TriliumNext-ETAPI-blue?logo=read-the-docs)](https://github.com/TriliumNext/Notes)  
[![License: MIT](https://img.shields.io/badge/license-MIT-green.svg)](LICENSE)

> Manage your [TriliumNext](https://github.com/TriliumNext/Notes) instance via PowerShell using the ETAPI

---

## 📖 Table of Contents <!-- omit in toc -->
- [🛠 Requirements](#-requirements)
- [📦 Installation](#-installation)
- [🔐 Authentication](#-authentication)
- [🗂️ API Endpoints and Functions](#️-api-endpoints-and-functions)
- [📣 Contributions \& Issues](#-contributions--issues)
- [📄 License](#-license)
- [📅 Changelog](#-changelog)
- [🔗 Resources](#-resources)

---

## 🦾 Description <!-- omit in toc -->

**Trilium** is a PowerShell module that enables you to interact with your TriliumNext server programmatically.
It provides functions to:

* Authenticate and manage sessions
* Search and manage notes
* Export and import notes
* Manage note attributes and branches
* And more!

---

## 🛠 Requirements

* PowerShell 7 or higher
* TriliumNext instance with ETAPI enabled
* HTTP(S) access to your Trilium server

---

## 📦 Installation

Install from the PowerShell Gallery:

```powershell
Install-Module -Name Trilium -Scope CurrentUser
```

---

## 🔐 Authentication

All functions require authentication 1st. Use a `PSCredential` object to store the password or ETAPI token.
 Username does not matter but required for Get-Credential.  We only use the stored password.

```powershell
$creds = Get-Credential -UserName admin
Connect-TriliumAuth -BaseUrl 'https://trilium.domain.com' -Password $creds
```

---

## 🗂️ API Endpoints and Functions

| Method | Endpoint | Function | Notes |
|--------|----------|----------|-------|
| POST   | /create-note | [New-TriliumNote](/public/New-TriliumNote.ps1) | Create a new note |
| GET    | /notes | [Find-TriliumNote](/public/Find-TriliumNote.ps1) | Search for notes |
| GET    | /notes/{noteId} | [Get-TriliumNoteDetails](/public/Get-TriliumNoteDetails.ps1) | Get note details |
| PATCH  | /notes/{noteId} | [Set-TriliumNoteDetails](/public/Set-TriliumNoteDetails.ps1) | Update note details (PATCH) |
| DELETE | /notes/{noteId} | [Remove-TriliumNote](/public/Remove-TriliumNote.ps1) | Delete a note |
| GET    | /notes/{noteId}/content | [Get-TriliumNoteContent](/public/Get-TriliumNoteContent.ps1) | Get note content |
| PUT    | /notes/{noteId}/content | [Set-TriliumNoteContent](/public/Set-TriliumNoteContent.ps1) | Update note content |
| GET    | /notes/{noteId}/export | [Export-TriliumNote](/public/Export-TriliumNote.ps1) | Export note(s) as zip (HTML/Markdown) |
| POST   | /notes/{noteId}/import | [Import-TriliumNoteZip](/public/Import-TriliumNoteZip.ps1) | Import notes from ZIP |
| POST   | /notes/{noteId}/revision | [New-TriliumNoteRevision](/public/New-TriliumNoteRevision.ps1) | Create a new note revision |
| POST   | /branches | [Copy-TriliumNote](/public/Copy-TriliumNote.ps1) | Copy a note to a new branch |
| GET    | /branches/{branchId} | [Get-TriliumBranch](/public/Get-TriliumBranch.ps1) | Get branch details |
| PATCH  | /branches/{branchId} | [Set-TriliumBranch](/public/Set-TriliumBranch.ps1) | Update branch prefix and/or note position (PATCH) |
| DELETE | /branches/{branchId} | [Remove-TriliumBranch](/public/Remove-TriliumBranch.ps1) | Delete a branch |
| POST   | /attachments |  | |
| GET    | /attachments/{attachmentId} | [Get-TriliumAttachment](/public/Get-TriliumAttachment.ps1) | Get attachment metadata |
| PATCH  | /attachments/{attachmentId} |  | |
| DELETE | /attachments/{attachmentId} |  | |
| GET    | /attachments/{attachmentId}/content | [Get-TriliumAttachmentContent](/public/Get-TriliumAttachmentContent.ps1) | Download attachment content |
| PUT    | /attachments/{attachmentId}/content |  | |
| POST   | /attributes | [Create-TriliumAttribute](/public/Create-TriliumAttribute.ps1) | Create a new attribute |
| GET    | /attributes/{attributeId} | [Get-TriliumAttribute](/public/Get-TriliumAttribute.ps1) | Get attribute details |
| PATCH  | /attributes/{attributeId} |  | |
| DELETE | /attributes/{attributeId} | [Remove-TriliumAttribute](/public/Remove-TriliumAttribute.ps1) | Delete an attribute |
| POST   | /refresh-note-ordering/{parentNoteId} | [Update-TriliumNoteOrder](/public/Update-TriliumNoteOrder.ps1) | Refresh note ordering |
| GET    | /inbox/{date} | [Get-TriliumInbox](/public/Get-TriliumInbox.ps1) | Get or create inbox note for a date |
| GET    | /calendar/days/{date} | [Get-TriliumDayNote](/public/Get-TriliumDayNote.ps1) | Get or create day note for a date |
| GET    | /calendar/weeks/{date} | [Get-TriliumWeekNote](/public/Get-TriliumWeekNote.ps1) | (Broken: appears to be a bug in TriliumNext) |
| GET    | /calendar/months/{month} | [Get-TriliumMonthNote](/public/Get-TriliumMonthNote.ps1) | Get or create month note for a month |
| GET    | /calendar/years/{year} | [Get-TriliumYearNote](/public/Get-TriliumYearNote.ps1) | Get or create year note for a year |
| POST   | /auth/login | [Connect-TriliumAuth](/public/Connect-TriliumAuth.ps1) | Authenticate to TriliumNext |
| POST   | /auth/logout | [Disconnect-TriliumAuth](/public/Disconnect-TriliumAuth.ps1) | Logout from TriliumNext |
| GET    | /app-info | [Get-TriliumInfo](/public/Get-TriliumInfo.ps1) | Get Trilium server info |
| PUT    | /backup/{backupName} | [New-TriliumBackup](/public/New-TriliumBackup.ps1) | Create a new backup |
| GET    | /notes/root | [Get-TriliumRootNote](/public/Get-TriliumRootNote.ps1) | Get root note details (requires Connect-TriliumAuth, no params; every root note has id 'root'). |
|        | (utility)   | [Get-TriliumAttachmentID](/public/Get-TriliumAttachmentID.ps1) | Parse all attachment IDs from a note's contents (no direct API endpoint) |

---

## 📣 Contributions & Issues

Feel free to open issues, submit pull requests, or suggest features!

---

## 📄 License

This project is licensed under the MIT License.

---

## 📅 Changelog

See [CHANGELOG.md](./CHANGELOG.md) for release history.

---

## 🔗 Resources

- 🌐 [TriliumNext on GitHub](https://github.com/TriliumNext/Notes)
- 📖 [ETAPI Wiki](https://github.com/zadam/trilium/wiki/ETAPI)
- 📜 [ETAPI OpenAPI YAML](https://github.com/zadam/trilium/blob/master/src/etapi/etapi.openapi.yaml)

---

🧠 _Made with ❤️ for scripting your notes._