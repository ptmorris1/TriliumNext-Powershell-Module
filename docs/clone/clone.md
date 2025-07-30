---
#title: Calendar
hide:
  - navigation
---

# 🔗 Clone Functions

The Clone functions in the TriliumNext PowerShell Module provide comprehensive management capabilities for Trilium note branches and cloning operations. These functions allow you to create, retrieve, update, and remove note clones (branches) within your Trilium knowledge base.

!!! warning "Authentication Required"
    All functions in this section require authentication using `Connect-TriliumAuth` before use.

## Overview

In Trilium, a clone (also called a branch) is a reference to a note that can appear in multiple locations within the note tree hierarchy. This powerful feature allows you to organize your notes in multiple ways without duplicating content.

!!! info "What are Clones?"
    Clones are references to the same note that can exist in multiple locations in your note tree. When you edit a cloned note, the changes appear in all locations where the clone exists.

## Available Functions

The clone module includes the following functions:

| Function | Description |
|----------|-------------|
| [`Copy-TriliumNote`](Copy-TriliumNote.md) | Creates a clone (branch) of a Trilium note in another note |
| [`Get-TriliumBranch`](Get-TriliumBranch.md) | Gets details of a specific Trilium branch |
| [`Remove-TriliumBranch`](Remove-TriliumBranch.md) | Removes a specific Trilium branch |
| [`Set-TriliumBranch`](Set-TriliumBranch.md) | Updates a branch's prefix or note position |

## Common Use Cases

### Creating Note Clones
Use `Copy-TriliumNote` to create references to existing notes in different parts of your note tree:

```powershell
Copy-TriliumNote -NoteID "abc123" -parentNoteID "def456"
```

### Managing Branch Properties
Use `Set-TriliumBranch` to update branch-specific properties like prefixes and positions:

```powershell
Set-TriliumBranch -BranchId "branch123" -Prefix "Important" -NotePosition 1
```

### Retrieving Branch Information
Use `Get-TriliumBranch` to inspect branch details and relationships:

```powershell
Get-TriliumBranch -BranchID "branch123"
```

### Cleaning Up Branches
Use `Remove-TriliumBranch` to remove unwanted clone references:

```powershell
Remove-TriliumBranch -BranchID "branch123"
```

## Key Concepts

### Branch ID vs Note ID
- **Note ID**: Identifies the actual note content
- **Branch ID**: Identifies a specific instance/location of that note in the tree

### Prefixes
Branches can have prefixes that appear before the note title in the tree view, useful for:
- Numbering or ordering notes
- Adding visual indicators
- Categorizing content

### Note Position
Controls the order of child notes under a parent, allowing you to organize the display sequence.

## Best Practices

1. **Plan Your Structure**: Consider your note organization before creating multiple clones
2. **Use Meaningful Prefixes**: Add prefixes that help identify the context or purpose
3. **Manage Positions**: Use note positions to maintain logical ordering
4. **Clean Up Unused Branches**: Remove branches that are no longer needed to keep your tree organized
