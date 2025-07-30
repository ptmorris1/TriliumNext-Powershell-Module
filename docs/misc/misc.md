# Miscellaneous Functions

This section contains various utility and administrative functions for the TriliumNext PowerShell Module that don't fit into the main categories but provide essential functionality for managing your Trilium instance.

!!! warning "Authentication Required"
    All functions require authentication using `Connect-TriliumAuth` before use.

## Overview

The miscellaneous functions provide capabilities for:

- **Backup Management**: Create and manage backups of your Trilium data
- **System Information**: Retrieve root note details and system information
- **Note Organization**: Update note ordering and structure
- **Administrative Tasks**: Various utility functions for Trilium management



## Available Functions

| Function | Description |
|----------|-------------|
| `Get-TriliumRootNote` | Retrieves the root note details from your Trilium instance |
| `New-TriliumBackup` | Creates a new backup for your Trilium instance |
| `Update-TriliumNoteOrder` | Updates the order of notes under a specific parent note |

## Getting Started

Before using any of these functions, ensure you have:

1. **Established a connection** to your Trilium instance using `Connect-TriliumAuth`
2. **Proper permissions** for the operations you want to perform
3. **Valid certificates** or use the `-SkipCertCheck` parameter for self-signed certificates

!!! tip "Best Practices"
    - Regular backups are recommended before making structural changes
    - Test operations with `-WhatIf` parameter when available
    - Keep your authentication token secure and refresh as needed
