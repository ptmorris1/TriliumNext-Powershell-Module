# 🚀 Trilium PowerShell Module

![PowerShell Gallery Version](https://img.shields.io/powershellgallery/v/Trilium)
![Downloads](https://img.shields.io/powershellgallery/dt/Trilium)
![PSGallery Quality](https://img.shields.io/powershellgallery/p/Trilium)  
[![TriliumNext](https://img.shields.io/badge/TriliumNext-ETAPI-blue?logo=read-the-docs)](https://github.com/TriliumNext/Notes)  
[![License: MIT](https://img.shields.io/badge/license-MIT-green.svg)](LICENSE)

> Manage your [TriliumNext](https://github.com/TriliumNext/Notes) instance via PowerShell using the ETAPI

---

## 📖 Table of Contents
- [Trilium PowerShell Module](#-trilium-powershell-module)
  - [📖 Table of Contents](#-table-of-contents)
  - [🦾 Description](#-description)
  - [🛠 Requirements](#-requirements)
  - [📦 Installation](#-installation)
  - [🔐 Authentication](#-authentication)
  - [📚 Available Functions](#-available-functions)
  - [📣 Contributions & Issues](#-contributions--issues)
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

### 🔐 Connect-TriliumAuth

Authenticates to a TriliumNext instance for API calls. Supports both password (PSCredential) and ETAPI token authentication. Optionally allows skipping SSL certificate checks. Credentials are stored globally for use by other module functions.

**Parameters:**

* `BaseUrl` – Base URL for the TriliumNext instance (e.g., `https://trilium.myDomain.net` or `https://1.2.3.4:443`)
* `Password` – PSCredential object containing your Trilium password (standard login)
* `EtapiToken` – PSCredential object containing your ETAPI token as the password (token-based login)
* `SkipCertCheck` – (Optional) Ignore SSL certificate errors (useful for self-signed certs)

**Examples:**

```powershell
Connect-TriliumAuth -BaseUrl "https://trilium.myDomain.net" -Password (Get-Credential -UserName 'admin')
# Prompts for password and authenticates using standard login.

Connect-TriliumAuth -BaseUrl "https://trilium.myDomain.net" -EtapiToken (Get-Credential -UserName 'admin')
# Prompts for ETAPI token and authenticates using an ETAPI token.
```

---

### 🔓 Disconnect-TriliumAuth

Removes stored authentication/session information for the current session.

```powershell
Disconnect-TriliumAuth
```

---

### 🏷 Find-TriliumNote

Searches for notes in TriliumNext using a search term and optional filters such as label, ancestor note, fast search, archived notes, debug mode, result limit, and sort order. Requires authentication via Connect-TriliumAuth.

**Parameters:**

* `Search` – (Required) Search term for note title/content
* `Label` – (Optional) Filter by label
* `FastSearch` – (Optional) Enables fast search mode
* `IncludeArchivedNotes` – (Optional) Includes archived notes in results
* `DebugOn` – (Optional) Enables debug mode
* `AncestorNoteId` – (Optional) Restrict search to a specific ancestor note (default: root)
* `Limit` – (Optional) Limit number of results (default: 10; requires OrderBy)
* `OrderBy` – (Optional) Sort results by field (used only with Limit)
* `SkipCertCheck` – (Optional) Ignore SSL certificate errors

**Examples:**

```powershell
Find-TriliumNote -Search "meeting notes"
Find-TriliumNote -Search "project" -Label "work" -FastSearch -IncludeArchivedNotes
Find-TriliumNote -Search "api" -Limit 5 -OrderBy dateCreated
```

---

### 📄 Get-TriliumNoteDetails

Retrieves details for a specific note by ID.

**Parameters:**

* `NoteId` – ID of the note

```powershell
Get-TriliumNoteDetails -NoteId 'abcdef'
```

---

### 📝 New-TriliumNote

Creates a new note under a specified parent note.

**Parameters:**

* `ParentNoteId` – ID of the parent note
* `Title` – Title of the new note
* `Type` – (Optional) Note type (default: text)
* `Content` – (Optional) Initial content

```powershell
New-TriliumNote -ParentNoteId 'root' -Title 'My Note' -Content 'Hello World'
```

---

### ✏️ Set-TriliumNoteContent

Updates the content of an existing note.

**Parameters:**

* `NoteId` – ID of the note
* `Content` – New content

```powershell
Set-TriliumNoteContent -NoteId 'abcdef' -Content 'Updated text'
```

---

### 📖 Get-TriliumNoteContent

Fetches the content of a note by ID.

**Parameters:**

* `NoteId` – ID of the note

```powershell
Get-TriliumNoteContent -NoteId 'abcdef'
```

---

### 🗑 Remove-TriliumNote

Deletes a note by ID.

**Parameters:**

* `NoteId` – ID of the note

```powershell
Remove-TriliumNote -NoteId 'abcdef'
```

---

### 📤 Export-TriliumNote

Exports a note to a `.zip` or Markdown/HTML file.

**Parameters:**

* `NoteId` – ID of the note
* `Path` – Output file path
* `Format` – (Optional) Export format (`zip`, `html`, `md`)

```powershell
Export-TriliumNote -NoteId 'abcdef' -Path 'C:\Backups\note.zip'
Export-TriliumNote -NoteId 'abcdef' -Path 'C:\Backups\note.md' -Format md
```

---

### 📥 Import-TriliumNoteZip

Imports a `.zip` archive as a note under a specified parent note.

**Parameters:**

* `NoteId` – ID of the parent note
* `Path` – Path to the `.zip` file

```powershell
Import-TriliumNoteZip -NoteId 'parentNoteId' -Path 'C:\note.zip'
```

---

### 🕰 New-TriliumNoteRevision

Creates a new revision for a note.

**Parameters:**

* `NoteId` – ID of the note
* `Content` – New content for the revision

```powershell
New-TriliumNoteRevision -NoteId 'abcdef' -Content 'Revision text'
```

---

### 🪄 Copy-TriliumNote

Clones (branches) a note under a new parent.

**Parameters:**

* `NoteId` – ID of the note to clone
* `ParentNoteId` – ID of the new parent note

```powershell
Copy-TriliumNote -NoteId 'abcdef' -ParentNoteId 'root'
```

---

### 🌳 Get-TriliumRootNote

Retrieves details for the root note.

```powershell
Get-TriliumRootNote
```

---

### 💾 New-TriliumBackup

Triggers a backup of the Trilium instance.

```powershell
New-TriliumBackup
```

---

### 🏷 Get-TriliumAttribute

Views attributes for a note.

**Parameters:**

* `NoteId` – ID of the note

```powershell
Get-TriliumAttribute -NoteId 'abcdef'
```

---

### 🗑 Remove-TriliumAttribute

Deletes an attribute from a note.

**Parameters:**

* `NoteId` – ID of the note
* `Name` – Name of the attribute

```powershell
Remove-TriliumAttribute -NoteId 'abcdef' -Name 'myAttribute'
```

---

### 🌿 Get-TriliumBranch

Gets metadata for a note branch.

**Parameters:**

* `NoteId` – ID of the note

```powershell
Get-TriliumBranch -NoteId 'abcdef'
```

---

### 🗑 Remove-TriliumBranch

Removes a branch from a note.

**Parameters:**

* `NoteId` – ID of the note
* `BranchId` – ID of the branch

```powershell
Remove-TriliumBranch -NoteId 'abcdef' -BranchId 'branch123'
```

---

### 🔢 Update-TriliumNoteOrder

Changes the order of child notes under a parent.

**Parameters:**

* `ParentNoteId` – ID of the parent note
* `ChildNoteIds` – Array of child note IDs in desired order

```powershell
Update-TriliumNoteOrder -ParentNoteId 'root' -ChildNoteIds @('id1','id2','id3')
```

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