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

## 🌐 Connect to Trilium

Use [`Connect-TriliumAuth`](auth/Connect-TriliumAuth.md) to authenticate to your TriliumNext instance. You can connect using either a password or an ETAPI token.

!!! note
    The username provided to `Get-Credential` is not used for authentication. Only the password (or token) is required and used.

### 🔑 Example: Password Authentication

```powershell
Connect-TriliumAuth -BaseUrl "https://trilium.myDomain.net" -Password (Get-Credential -UserName 'admin')
```

### 🪪 Example: Token Authentication

```powershell
Connect-TriliumAuth -BaseUrl "https://trilium.myDomain.net" -EtapiToken (Get-Credential -UserName 'admin')
```

## 🔒 Disconnect from Trilium

Use [`Disconnect-TriliumAuth`](auth/Disconnect-TriliumAuth.md) when you are done. This will remove your authentication token from Trilium (if you logged in with a password) and clear the credential variable from your PowerShell session.

```powershell
Disconnect-TriliumAuth
```

## 🛠️ Start using the other [functions](Trilium.md)