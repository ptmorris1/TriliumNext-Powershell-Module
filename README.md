# 🚀 Trilium PowerShell Module

![PowerShell Gallery Version](https://img.shields.io/powershellgallery/v/Trilium)
![Downloads](https://img.shields.io/powershellgallery/dt/Trilium)
![PSGallery Quality](https://img.shields.io/powershellgallery/p/Trilium)  
[![TriliumNext](https://img.shields.io/badge/TriliumNext-ETAPI-blue?logo=read-the-docs)](https://github.com/TriliumNext/Notes)  
[![License: MIT](https://img.shields.io/badge/license-MIT-green.svg)](LICENSE)

> Manage your [TriliumNext](https://github.com/TriliumNext/Notes) instance via PowerShell using the ETAPI

---

## 📖 Table of Contents <!-- omit in toc -->
- [🚀 Trilium PowerShell Module](#-trilium-powershell-module)
  - [🦾 Description](#-description)
  - [🛠 Requirements](#-requirements)
  - [📦 Installation](#-installation)
  - [🔐 Authentication](#-authentication)
  - [🗂️ API Endpoints and Functions](#️-api-endpoints-and-functions)
  - [📣 Contributions \& Issues](#-contributions--issues)
  - [📄 License](#-license)
  - [📅 Changelog](#-changelog)
  - [🔗 Resources](#-resources)

---

## 🦾 Description

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
| POST   | /create-note | [New-TriliumNote](/public/New-TriliumNote.ps1) | Function to create a new note. |
| GET    | /notes | [Find-TriliumNote](/public/Find-TriliumNote.ps1) | |
| GET    | /notes/{noteId} | [Get-TriliumNoteDetails](/public/Get-TriliumNoteDetails.ps1) | |
| PATCH  | /notes/{noteId} |  | |
| DELETE | /notes/{noteId} | [Remove-TriliumNote](/public/Remove-TriliumNote.ps1) | |
| GET    | /notes/{noteId}/content | [Get-TriliumNoteContent](/public/Get-TriliumNoteContent.ps1) | |
| PUT    | /notes/{noteId}/content | [Set-TriliumNoteContent](/public/Set-TriliumNoteContent.ps1) | |
| GET    | /notes/{noteId}/export | [Export-TriliumNote](/public/Export-TriliumNote.ps1) | exports a zip file with a single or multiple notes in html or markdown |
| POST   | /notes/{noteId}/import | [Import-TriliumNoteZip](/public/Import-TriliumNoteZip.ps1) | Imports a ZIP file to a note. |
| POST   | /notes/{noteId}/revision | [New-TriliumNoteRevision](/public/New-TriliumNoteRevision.ps1) | |
| POST   | /branches | [Copy-TriliumNote](/public/Copy-TriliumNote.ps1) | |
| GET    | /branches/{branchId} | [Get-TriliumBranch](/public/Get-TriliumBranch.ps1) | |
| PATCH  | /branches/{branchId} |  | |
| DELETE | /branches/{branchId} | [Remove-TriliumBranch](/public/Remove-TriliumBranch.ps1) | |
| POST   | /attachments |  | |
| GET    | /attachments/{attachmentId} | [Get-TriliumAttachment](/public/Get-TriliumAttachment.ps1) | |
| PATCH  | /attachments/{attachmentId} |  | |
| DELETE | /attachments/{attachmentId} |  | |
| GET    | /attachments/{attachmentId}/content | [Get-TriliumAttachmentContent](/public/Get-TriliumAttachmentContent.ps1) | |
| PUT    | /attachments/{attachmentId}/content |  | |
| POST   | /attributes |  | |
| GET    | /attributes/{attributeId} | [Get-TriliumAttribute](/public/Get-TriliumAttribute.ps1) | |
| PATCH  | /attributes/{attributeId} |  | |
| DELETE | /attributes/{attributeId} | [Remove-TriliumAttribute](/public/Remove-TriliumAttribute.ps1) | |
| POST   | /refresh-note-ordering/{parentNoteId} | [Update-TriliumNoteOrder](/public/Update-TriliumNoteOrder.ps1) | |
| GET    | /inbox/{date} |  | |
| GET    | /calendar/days/{date} |  | |
| GET    | /calendar/weeks/{date} |  | |
| GET    | /calendar/months/{month} |  | |
| GET    | /calendar/years/{year} |  | |
| POST   | /auth/login | [Connect-TriliumAuth](/public/Connect-TriliumAuth.ps1) | |
| POST   | /auth/logout | [Disconnect-TriliumAuth](/public/Disconnect-TriliumAuth.ps1) | |
| GET    | /app-info | [Get-TriliumInfo](/public/Get-TriliumInfo.ps1) | |
| PUT    | /backup/{backupName} | [New-TriliumBackup](/public/New-TriliumBackup.ps1) | |

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