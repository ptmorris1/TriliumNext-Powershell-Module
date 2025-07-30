---
document type: cmdlet
external help file: Trilium-Help.xml
HelpUri: ''
Locale: en-US
Module Name: Trilium
ms.date: 07/19/2025
PlatyPS schema version: 2024-05-01
title: Set-TriliumBranch
---

# Set-TriliumBranch

## SYNOPSIS

Patch (update) a TriliumNext branch's prefix or note position by branchId.

## SYNTAX

### __AllParameterSets

```
Set-TriliumBranch [-BranchId] <string> [[-Prefix] <string>] [[-NotePosition] <int>]
 [<CommonParameters>]
```

## DESCRIPTION

This function updates a TriliumNext branch's prefix and/or notePosition using the PATCH /branches/{branchId} endpoint.
Only prefix and notePosition can be updated.
If you want to update other properties, you need to delete the old branch and create a new one.

## EXAMPLES

### EXAMPLE 1

```powershell
Set-TriliumBranch -BranchId "abc123" -Prefix "A" -NotePosition 2
```

## PARAMETERS

### -BranchId

The ID of the branch to update.

```yaml
Type: System.String
DefaultValue: ''
SupportsWildcards: false
Aliases: []
ParameterSets:
- Name: (All)
  Position: 0
  IsRequired: true
  ValueFromPipeline: false
  ValueFromPipelineByPropertyName: false
  ValueFromRemainingArguments: false
DontShow: false
AcceptedValues: []
HelpMessage: ''
```

### -NotePosition

The new note position to set for the branch.

```yaml
Type: System.Int32
DefaultValue: 0
SupportsWildcards: false
Aliases: []
ParameterSets:
- Name: (All)
  Position: 2
  IsRequired: false
  ValueFromPipeline: false
  ValueFromPipelineByPropertyName: false
  ValueFromRemainingArguments: false
DontShow: false
AcceptedValues: []
HelpMessage: ''
```

### -Prefix

The new prefix to set for the branch.

```yaml
Type: System.String
DefaultValue: ''
SupportsWildcards: false
Aliases: []
ParameterSets:
- Name: (All)
  Position: 1
  IsRequired: false
  ValueFromPipeline: false
  ValueFromPipelineByPropertyName: false
  ValueFromRemainingArguments: false
DontShow: false
AcceptedValues: []
HelpMessage: ''
```

### CommonParameters

This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable,
-InformationAction, -InformationVariable, -OutBuffer, -OutVariable, -PipelineVariable,
-ProgressAction, -Verbose, -WarningAction, and -WarningVariable. For more information, see
[about_CommonParameters](https://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

None

## OUTPUTS

System.Object

## NOTES

This function requires that the authentication has been set using Connect-TriliumAuth.


## RELATED LINKS

[TriliumNext PowerShell Module](https://github.com/ptmorris1/TriliumNext-Powershell-Module)

