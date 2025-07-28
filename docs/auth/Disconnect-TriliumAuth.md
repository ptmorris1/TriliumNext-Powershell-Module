---
document type: cmdlet
external help file: Trilium-Help.xml
HelpUri: 'https://ptmorris1.github.io/TriliumNext-Powershell-Module/auth/Disconnect-TriliumAuth.html'
Locale: en-US
Module Name: Trilium
ms.date: 07/19/2025
PlatyPS schema version: 2024-05-01
title: Disconnect-TriliumAuth
---
# Disconnect-TriliumAuth

## Synopsis

Removes authentication for TriliumNext and clears stored credentials.

## Syntax

```
Disconnect-TriliumAuth [-SkipCertCheck] [<CommonParameters>]
```

## Aliases

This cmdlet has the following aliases:
- *(none specified)*

## Description

This function removes authentication for TriliumNext by clearing the global credential variable `Global:TriliumCreds`.
If you authenticated using a password, it will also log you out of Trilium via the API.
If you authenticated using an ETAPI token, it will only remove the global variable (no logout API call is made).

## Examples

### Example 1

```
Disconnect-TriliumAuth
```

Logs out (if using password authentication) and clears credentials.

## Parameters

### -SkipCertCheck

If specified, SSL certificate errors will be ignored (useful for self-signed certificates). Optional.

- **Required?**: false
- **Position?**: Named
- **Default value**: false
- **Accept pipeline input?**: false
- **Accept wildcard characters?**: false

Type: `System.Management.Automation.SwitchParameter`
DefaultValue: `False`
SupportsWildcards: `false`
Aliases: `[]`

### CommonParameters

This cmdlet supports the common parameters: `-Debug`, `-ErrorAction`, `-ErrorVariable`,
`-InformationAction`, `-InformationVariable`, `-OutBuffer`, `-OutVariable`, `-PipelineVariable`,
`-ProgressAction`, `-Verbose`, `-WarningAction`, and `-WarningVariable`. For more information, see
[about_CommonParameters](https://go.microsoft.com/fwlink/?LinkID=113216).

## Inputs

None. You cannot pipe objects to Disconnect-TriliumAuth.

## Outputs

None. This function performs logout and/or clears credentials.

## Notes

- Use this function to clear your credentials from the session, especially if you switch users or finish automation tasks.
- If you authenticated with a password, this will log you out of Trilium.
- If you used an ETAPI token, it only clears the session variable.
- Use `-SkipCertCheck` for self-signed or untrusted SSL certificates.
- **Author**: P. Morris
- **Module**: TriliumNext-Powershell-Module

## Related Links

- [Docs](https://ptmorris1.github.io/TriliumNext-Powershell-Module/auth/Disconnect-TriliumAuth.html)
