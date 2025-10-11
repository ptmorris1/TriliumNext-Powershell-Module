---
document type: cmdlet
external help file: Trilium-Help.xml
HelpUri: https://github.com/ptmorris1/TriliumNext-Powershell-Module
Locale: en-US
Module Name: Trilium
ms.date: 10/11/2025
PlatyPS schema version: 2024-05-01
title: Set-TriliumAttachment
---

# Set-TriliumAttachment

## SYNOPSIS

Updates an existing attachment in Trilium Notes.

## SYNTAX

### __AllParameterSets

```
Set-TriliumAttachment [-AttachmentId] <string> [[-Role] <string>] [[-Mime] <string>] [[-Title] <string>]
 [[-Position] <int>] [<CommonParameters>]
```

## ALIASES

None

## DESCRIPTION

Updates an existing attachment in Trilium Notes by patching the attachment identified by the attachmentId.
Only role, mime, title, and position properties can be updated.
This function does not modify the attachment's content or file data.

## EXAMPLES

### EXAMPLE 1

```powershell
Set-TriliumAttachment -AttachmentId "evnnmvHTCgIn" -Title "Updated Title"
```

Updates the title of the attachment with ID evnnmvHTCgIn.

### EXAMPLE 2

```powershell
Set-TriliumAttachment -AttachmentId "evnnmvHTCgIn" -Role "image" -Mime "image/png" -Position 1
```

Updates multiple properties of the attachment.

## PARAMETERS

### -AttachmentId

The ID of the attachment to update.

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

### -Role

(Optional) The role of the attachment (e.g., image, file).

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

### -Mime

(Optional) The MIME type of the attachment.

```yaml
Type: String
Parameter Sets: __AllParameterSets
Aliases: 

Required: False
Position: 2
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Title

(Optional) The title of the attachment.

```yaml
Type: String
Parameter Sets: __AllParameterSets
Aliases: 

Required: False
Position: 3
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Position

(Optional) The position of the attachment in the note's attachment list.

```yaml
Type: Int32
Parameter Sets: __AllParameterSets
Aliases: 

Required: False
Position: 4
Default value: 0
Accept pipeline input: False
Accept wildcard characters: False
```

### CommonParameters

This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

### None

You cannot pipe objects to Set-TriliumAttachment.

## OUTPUTS

### PSCustomObject

Returns the updated attachment object.

## NOTES

- Requires authentication via Connect-TriliumAuth.
- Only role, mime, title, and position properties can be updated.
- At least one property must be specified to update.
- Author: P. Morris
- Module: TriliumNext-Powershell-Module

## RELATED LINKS

[https://github.com/ptmorris1/TriliumNext-Powershell-Module](https://github.com/ptmorris1/TriliumNext-Powershell-Module)

[New-TriliumAttachment](New-TriliumAttachment.md)

[Get-TriliumAttachment](Get-TriliumAttachment.md)

[Remove-TriliumAttachment](Remove-TriliumAttachment.md)