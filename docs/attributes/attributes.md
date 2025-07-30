---
title: Trilium Attributes
description: Overview of PowerShell functions for managing Trilium note attributes
hide:
  - navigation
---

# Trilium Attributes

## Overview

Attributes in Trilium are key-value pairs that can be attached to notes to provide additional metadata, categorization, and functionality. The TriliumNext PowerShell Module provides a comprehensive set of functions to manage these attributes programmatically.

!!! warning "Authentication Required"
    All attribute functions require authentication to your Trilium instance using `Connect-TriliumAuth` before use.

## What are Trilium Attributes?

Trilium supports two types of attributes:

- **Labels**: Simple key-value pairs that store metadata about notes
- **Relations**: Links between notes that establish relationships

!!! info "Attribute Types"
    - **Labels** are used for categorization, tagging, and storing simple metadata
    - **Relations** create connections between notes, enabling complex note hierarchies and cross-references

## Available Functions

The module provides the following functions for attribute management:

### Core Functions

| Function | Description |
|----------|-------------|
| [`Get-TriliumAttribute`](Get-TriliumAttribute.md) | Retrieves details of a specific Trilium attribute |
| [`New-TriliumAttribute`](New-TriliumAttribute.md) | Creates or updates a Trilium attribute (label or relation) for a note |
| [`Remove-TriliumAttribute`](Remove-TriliumAttribute.md) | Removes a specific Trilium attribute |

## Common Use Cases

### Creating Labels

```powershell
# Add a simple label
New-TriliumAttribute -NoteID "abc123" -Name "status" -Value "published"

# Add an inheritable label
New-TriliumAttribute -NoteID "abc123" -Name "theme" -Value "dark" -IsInheritable
```

### Creating Relations

```powershell
# Create a relation between notes
New-TriliumAttribute -NoteID "abc123" -Name "relatedTo" -Value "def456" -Type "relation"
```

### Managing Attributes

```powershell
# Get attribute details
Get-TriliumAttribute -AttributeID "attr123"

# Remove an attribute
Remove-TriliumAttribute -AttributeID "attr123"
```

## Best Practices

!!! tip "Attribute Naming"
    - Use descriptive, consistent names for your attributes
    - Consider using a naming convention (e.g., `category:subcategory`)
    - Avoid spaces in attribute names when possible

!!! warning "Inheritable Attributes"
    Use the `-IsInheritable` flag carefully as these attributes will be passed down to child notes

