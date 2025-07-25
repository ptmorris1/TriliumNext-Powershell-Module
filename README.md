# 🚀 Trilium PowerShell Module

![PowerShell Gallery Version](https://img.shields.io/powershellgallery/v/Trilium)
![Downloads](https://img.shields.io/powershellgallery/dt/Trilium)
![PSGallery Quality](https://img.shields.io/powershellgallery/p/Trilium)  
[![Trilium Notes](https://img.shields.io/badge/Trilium-ETAPI-blue?logo=read-the-docs)](https://github.com/TriliumNext/trilium)  
[![License: MIT](https://img.shields.io/badge/license-MIT-green.svg)](LICENSE)

> Manage your [Trilium Notes](https://github.com/TriliumNext/trilium) instance via PowerShell using the ETAPI

---

## 🦾 Description

**Trilium** is a PowerShell module that enables you to interact with your Trilium server programmatically.
It provides functions to:

* Authenticate and manage sessions
* Search and manage notes
* Export and import notes
* Manage note attributes and branches
* And more!

---

## 🛠 Requirements

* PowerShell 7 or higher
* Trilium instance with ETAPI enabled
* HTTP(S) access to your Trilium server

---

## 📦 Installation

Install from the PowerShell Gallery:

```powershell
Install-PSResource -Name Trilium -Scope CurrentUser
```

---

## 🔐 Authentication

All functions require 1 time authentication 1st. Use a `PSCredential` object to store the password or ETAPI token.
 Username does not matter but required for Get-Credential.  We only use the stored password.

### 🔐 Authenticate with Password

Authenticate using your Trilium username and password:

> [!TIP]
> Since Trilium doesn't need a username, anything will do.


```powershell
$creds = Get-Credential -UserName 'admin'
Connect-TriliumAuth -BaseUrl "https://trilium.myDomain.net" -Password $creds
```
```powershell
appVersion             : 0.96.0
dbVersion              : 232
nodeVersion            : v22.17.0
syncVersion            : 36
buildDate              : 6/7/2025 9:45:40 AM
buildRevision          : 7cbff47078012e32279c110c49b904bd24dcecb3
dataDirectory          : /home/node/trilium-data
clipperProtocolVersion : 1.0
utcDateTime            : 7/4/2025 4:07:48 AM
```
> [!TIP]
> This output confirms successful connection and shows server environment details.


### 🔐 Authenticate with ETAPI Token

Authenticate using your ETAPI token (enter token as password):

> [!TIP]
> Since Trilium doesn't need a username, anything will do.

```powershell
$token = Get-Credential -UserName 'admin' # Enter your ETAPI token as the password
Connect-TriliumAuth -BaseUrl "https://trilium.myDomain.net" -EtapiToken $token
```

### ⚠️ Skip Certificate Check (Self-Signed Certs)

If your Trilium instance uses a self-signed certificate, you can skip certificate validation with any cmdlet using `-SkipCertCheck`:

```powershell
Connect-TriliumAuth -BaseUrl "https://trilium.myDomain.net" -Password $creds -SkipCertCheck
```
> [!TIP]
> All Trilium module cmdlets support the `-SkipCertCheck` parameter for self-signed certificates.

> [!WARNING]
> Ensure your BaseUrl is correct and accessible. Use `-SkipCertCheck` only if you trust the server.

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
| POST   | /attachments | [New-TriliumAttachment](/public/New-TriliumAttachment.ps1) | Create a new attachment for a note |
| GET    | /attachments/{attachmentId} | [Get-TriliumAttachment](/public/Get-TriliumAttachment.ps1) | Get attachment metadata |
| PATCH  | /attachments/{attachmentId} |  | |
| DELETE | /attachments/{attachmentId} | [Remove-TriliumAttachment](/public/Remove-TriliumAttachment.ps1) | Delete an attachment |
| GET    | /attachments/{attachmentId}/content | [Get-TriliumAttachmentContent](/public/Get-TriliumAttachmentContent.ps1) | Download attachment content |
| PUT    | /attachments/{attachmentId}/content | [New-TriliumNoteFile](/public/New-TriliumNoteFile.ps1) | Create a new note from a local file (uploads file content) |
| N/A    | N/A | [Format-TriliumHtml](/public/Format-TriliumHtml.ps1) | Helper function to beautify HTML content with improved header spacing and code block formatting |
| POST   | /attributes | [Create-TriliumAttribute](/public/Create-TriliumAttribute.ps1) | Create a new attribute |
| GET    | /attributes/{attributeId} | [Get-TriliumAttribute](/public/Get-TriliumAttribute.ps1) | Get attribute details |
| PATCH  | /attributes/{attributeId} |  | |
| DELETE | /attributes/{attributeId} | [Remove-TriliumAttribute](/public/Remove-TriliumAttribute.ps1) | Delete an attribute |
| POST   | /refresh-note-ordering/{parentNoteId} | [Update-TriliumNoteOrder](/public/Update-TriliumNoteOrder.ps1) | Refresh note ordering |
| GET    | /inbox/{date} | [Get-TriliumInbox](/public/Get-TriliumInbox.ps1) | Get or create inbox note for a date |
| GET    | /calendar/days/{date} | [Get-TriliumDayNote](/public/Get-TriliumDayNote.ps1) | Get or create day note for a date |
| GET    | /calendar/weeks/{date} | [Get-TriliumWeekNote](/public/Get-TriliumWeekNote.ps1) | (Broken: appears to be a bug in Trilium) |
| GET    | /calendar/months/{month} | [Get-TriliumMonthNote](/public/Get-TriliumMonthNote.ps1) | Get or create month note for a month |
| GET    | /calendar/years/{year} | [Get-TriliumYearNote](/public/Get-TriliumYearNote.ps1) | Get or create year note for a year |
| POST   | /auth/login | [Connect-TriliumAuth](/public/Connect-TriliumAuth.ps1) | Authenticate to Trilium (now uses 'Bearer' for ETAPI) |
| POST   | /auth/logout | [Disconnect-TriliumAuth](/public/Disconnect-TriliumAuth.ps1) | Logout from Trilium |
| GET    | /app-info | [Get-TriliumInfo](/public/Get-TriliumInfo.ps1) | Get Trilium server info |
| PUT    | /backup/{backupName} | [New-TriliumBackup](/public/New-TriliumBackup.ps1) | Create a new backup |
| GET    | /notes/root | [Get-TriliumRootNote](/public/Get-TriliumRootNote.ps1) | Get root note details (requires Connect-TriliumAuth, no params; every root note has id 'root'). |
| GET    | /notes/{noteId}/attachments | [Get-TriliumNoteAttachment](/public/Get-TriliumNoteAttachment.ps1) | Retrieves attachments for a specific note (Undocumented API) |

---

## 📖 Getting Help in PowerShell

You can view detailed help for any function in this module directly from PowerShell using the `Get-Help` cmdlet. This displays usage, parameters, examples, and notes for each function.

**Examples:**

```powershell
Get-Help Connect-TriliumAuth -Full
Get-Help New-TriliumNote -Examples
Get-Help Get-TriliumAttachment
```


---

## 🧩 Notable Dependencies & Inspiration

- 📝 [Markdig](https://github.com/xoofx/markdig): Used for converting Markdown to HTML in this module.
- 🐍 [trilium-py](https://github.com/Nriver/trilium-py): Python library for Trilium ETAPI, used for some inspiration.

---

## 📣 Contributions & Issues

Feel free to open issues, submit pull requests, or suggest features!

---

## 📄 License

This project is licensed under the MIT License.

---

## 📅 Changelog

See [CHANGELOG.md](/docs/CHANGELOG.md) for release history.

---

## 🔗 Resources

- 🌐 [Trilium on GitHub](https://github.com/Trilium/Notes)
- 📜 [ETAPI OpenAPI YAML](https://github.com/Trilium/Notes/blob/develop/apps/server/src/assets/etapi.openapi.yaml)

---

🧠 _Made with ❤️ for scripting your notes._
