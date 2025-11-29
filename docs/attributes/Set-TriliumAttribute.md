---
title: Set-TriliumAttribute
description: Updates an existing Trilium attribute (label or relation)
document_type: cmdlet
external_help_file: Trilium-Help.xml
help_uri: https://github.com/ptmorris1/TriliumNext-Powershell-Module
locale: en-US
module_name: Trilium
date: 2025-10-12
platyps_schema_version: 2024-05-01
---

# Set-TriliumAttribute

## SYNOPSIS

Updates an existing Trilium attribute (label or relation).

## SYNTAX

### __AllParameterSets

```powershell
Set-TriliumAttribute [-AttributeId] <string> [[-Value] <string>] [[-Position] <int>] [<CommonParameters>]
```

## ALIASES

None

## DESCRIPTION

Updates an existing attribute in Trilium Notes by patching the attribute identified by the attributeId.
For labels, only value and position can be updated.
For relations, only position can be updated.
If you want to modify other properties, you need to delete the old attribute and create a new one.

## EXAMPLES

### EXAMPLE 1

```powershell
Set-TriliumAttribute -AttributeId "evnnmvHTCgIn" -Value "new value"
```

Updates the value of a label attribute with ID evnnmvHTCgIn.

### EXAMPLE 2

```powershell
Set-TriliumAttribute -AttributeId "evnnmvHTCgIn" -Position 5
```

Updates the position of an attribute (works for both labels and relations).

### EXAMPLE 3

```powershell
Set-TriliumAttribute -AttributeId "evnnmvHTCgIn" -Value "updated" -Position 3
```

Updates both the value and position of a label attribute.

## PARAMETERS

### -AttributeId

The ID of the attribute to update.

```yaml
Type: String
Parameter Sets: __AllParameterSets
Aliases: 

Required: True
Position: 0
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Value

(Optional) The new value for the attribute. Only applicable for labels.

```yaml
Type: String
Parameter Sets: __AllParameterSets
Aliases: 

Required: False
Position: 1
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Position

(Optional) The new position of the attribute in the note's attribute list.

```yaml
Type: Int32
Parameter Sets: __AllParameterSets
Aliases: 

Required: False
Position: 2
Default value: 0
Accept pipeline input: False
Accept wildcard characters: False
```

### CommonParameters

This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

### None

You cannot pipe objects to Set-TriliumAttribute.

## OUTPUTS

### PSCustomObject

Returns the updated attribute object.

## NOTES

- Requires authentication via Connect-TriliumAuth.
- For labels: only value and position can be updated.
- For relations: only position can be updated.
- At least one property (Value or Position) must be specified.
- To modify other properties, delete the old attribute and create a new one.
- Author: P. Morris
- Module: TriliumNext-Powershell-Module

## RELATED LINKS

[https://github.com/ptmorris1/TriliumNext-Powershell-Module](https://github.com/ptmorris1/TriliumNext-Powershell-Module)

[New-TriliumAttribute](New-TriliumAttribute.md)

[Get-TriliumAttribute](Get-TriliumAttribute.md)

[Remove-TriliumAttribute](Remove-TriliumAttribute.md)