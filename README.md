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
  - [📚 Available Functions](#-available-functions)
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

## 📚 Available Functions

- [Connect-TriliumAuth](#-connect-triliumauth)
- [Disconnect-TriliumAuth](#-disconnect-triliumnote)
- [Find-TriliumNote](#-find-triliumnote)
- [Get-TriliumNoteDetails](#-get-triliumnotedetails)
- [New-TriliumNote](#-new-triliumnote)
- [Set-TriliumNoteContent](#-set-triliumnotecontent)
- [Get-TriliumNoteContent](#-get-triliumnotecontent)
- [Remove-TriliumNote](#-remove-triliumnote)
- [Export-TriliumNote](#-export-triliumnote)
- [Import-TriliumNoteZip](#-import-triliumnotezip)
- [New-TriliumNoteRevision](#-new-triliumnoterevision)
- [Copy-TriliumNote](#-copy-triliumnote)
- [Get-TriliumRootNote](#-get-triliumrootnote)
- [New-TriliumBackup](#-new-triliumbackup)
- [Get-TriliumAttribute](#-get-triliumattribute)
- [Remove-TriliumAttribute](#-remove-triliumattribute)
- [Get-TriliumBranch](#-get-triliumbranch)
- [Remove-TriliumBranch](#-remove-triliumbranch)
- [Update-TriliumNoteOrder](#-update-triliumnoteorder)

---

## 🗂️ API Endpoints and Functions

| Method | Endpoint | Function | Notes |
|--------|----------|----------|-------|
| POST   | /create-note | [New-TriliumNote](#-new-triliumnote) | Function to create a new note. |
| GET    | /notes | [Find-TriliumNote](#-find-triliumnote) | |
| GET    | /notes/{noteId} | [Get-TriliumNoteDetails](#-get-triliumnotedetails) | |
| PATCH  | /notes/{noteId} |  | |
| DELETE | /notes/{noteId} | [Remove-TriliumNote](#-remove-triliumnote) | |
| GET    | /notes/{noteId}/content | [Get-TriliumNoteContent](#-get-triliumnotecontent) | |
| PUT    | /notes/{noteId}/content | [Set-TriliumNoteContent](#-set-triliumnotecontent) | |
| GET    | /notes/{noteId}/export | [Export-TriliumNote](#-export-triliumnote) | exports a zip file with a single or multiple notes in html or markdown |
| POST   | /notes/{noteId}/import | [Import-TriliumNoteZip](#-import-triliumnotezip) | Imports a ZIP file to a note. |
| POST   | /notes/{noteId}/revision | [New-TriliumNoteRevision](#-new-triliumnoterevision) | |
| POST   | /branches | [Copy-TriliumNote](#-copy-triliumnote) | |
| GET    | /branches/{branchId} | [Get-TriliumBranch](#-get-triliumbranch) | |
| PATCH  | /branches/{branchId} |  | |
| DELETE | /branches/{branchId} | [Remove-TriliumBranch](#-remove-triliumbranch) | |
| POST   | /attachments |  | |
| GET    | /attachments/{attachmentId} |  | |
| PATCH  | /attachments/{attachmentId} |  | |
| DELETE | /attachments/{attachmentId} |  | |
| GET    | /attachments/{attachmentId}/content |  | |
| PUT    | /attachments/{attachmentId}/content |  | |
| POST   | /attributes |  | |
| GET    | /attributes/{attributeId} | [Get-TriliumAttribute](#-get-triliumattribute) | |
| PATCH  | /attributes/{attributeId} |  | |
| DELETE | /attributes/{attributeId} | [Remove-TriliumAttribute](#-remove-triliumattribute) | |
| POST   | /refresh-note-ordering/{parentNoteId} | [Update-TriliumNoteOrder](#-update-triliumnoteorder) | |
| GET    | /inbox/{date} |  | |
| GET    | /calendar/days/{date} |  | |
| GET    | /calendar/weeks/{date} |  | |
| GET    | /calendar/months/{month} |  | |
| GET    | /calendar/years/{year} |  | |
| POST   | /auth/login | [Connect-TriliumAuth](#-connect-triliumauth) | |
| POST   | /auth/logout | [Disconnect-TriliumAuth](#-disconnect-triliumnote) | |
| GET    | /app-info | Get-TriliumInfo | |
| PUT    | /backup/{backupName} | [New-TriliumBackup](#-new-triliumbackup) | |

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