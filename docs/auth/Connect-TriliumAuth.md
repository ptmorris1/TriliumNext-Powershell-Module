---
document type: cmdlet
external help file: Trilium-Help.xml
HelpUri: 'https://ptmorris1.github.io/TriliumNext-Powershell-Module/auth/Connect-TriliumAuth.html'
Locale: en-US
Module Name: Trilium
ms.date: 07/19/2025
PlatyPS schema version: 2024-05-01
title: Connect-TriliumAuth
---

# Connect-TriliumAuth

## DESCRIPTION

Configures authentication for TriliumNext using either a password (via PSCredential) or an ETAPI token (via PSCredential, with the token as the password). Optionally allows skipping SSL certificate checks. Credentials are stored globally for use by other module functions. After authentication, Get-TriliumInfo is called to verify the connection. Only one authentication method can be used per invocation.

## SYNOPSIS

Authenticates to a TriliumNext instance for API calls.

## SYNTAX

### Token (Default)

```
Connect-TriliumAuth [-baseURL] <string> [-EtapiToken] <pscredential> [-SkipCertCheck]
 [<CommonParameters>]
```

### Password

```
Connect-TriliumAuth [-baseURL] <string> [-Password] <pscredential> [-SkipCertCheck]
 [<CommonParameters>]
```

## ALIASES

This cmdlet has the following aliases:
- None

## EXAMPLES

### EXAMPLE 1

```powershell
Connect-TriliumAuth -BaseUrl "https://trilium.myDomain.net" -Password (Get-Credential -UserName 'admin')
```
Prompts for password and authenticates using standard login.

### EXAMPLE 2

```powershell
Connect-TriliumAuth -BaseUrl "https://trilium.myDomain.net" -EtapiToken (Get-Credential -UserName 'admin')
```
Authenticates using an ETAPI token (token is entered as the password).

### EXAMPLE 3

```powershell
Connect-TriliumAuth -BaseUrl "https://trilium.myDomain.net" -Password (Get-Credential -UserName 'admin') -SkipCertCheck
```
Authenticates using password and skips SSL certificate validation (for self-signed certs).

## PARAMETERS

### -baseURL

The base URL for your TriliumNext instance.
Should include protocol and port if needed.
Example: https://trilium.myDomain.net
Example: https://1.2.3.4:443

Required?                    true
Position?                    0
Accept pipeline input?       false
Accept wildcard characters?  false

```yaml
Type: System.String
DefaultValue: ''
SupportsWildcards: false
Aliases: []
ParameterSets:
- Name: Token
  Position: 0
  IsRequired: true
  ValueFromPipeline: false
  ValueFromPipelineByPropertyName: false
  ValueFromRemainingArguments: false
- Name: Password
  Position: 0
  IsRequired: true
  ValueFromPipeline: false
  ValueFromPipelineByPropertyName: false
  ValueFromRemainingArguments: false
DontShow: false
AcceptedValues: []
HelpMessage: ''
```

### -EtapiToken

A PSCredential object containing your ETAPI token as the password.
Used for token-based authentication.

Required?                    true (if using Token authentication)
Position?                    1
Accept pipeline input?       false
Accept wildcard characters?  false
Parameter set                Token

```yaml
Type: System.Management.Automation.PSCredential
DefaultValue: ''
SupportsWildcards: false
Aliases: []
ParameterSets:
- Name: Token
  Position: 1
  IsRequired: true
  ValueFromPipeline: false
  ValueFromPipelineByPropertyName: false
  ValueFromRemainingArguments: false
DontShow: false
AcceptedValues: []
HelpMessage: ''
```

### -Password

A PSCredential object containing your Trilium password.
Used for standard login authentication.

Required?                    true (if using Password authentication)
Position?                    1
Accept pipeline input?       false
Accept wildcard characters?  false
Parameter set                Password

```yaml
Type: System.Management.Automation.PSCredential
DefaultValue: ''
SupportsWildcards: false
Aliases: []
ParameterSets:
- Name: Password
  Position: 1
  IsRequired: true
  ValueFromPipeline: false
  ValueFromPipelineByPropertyName: false
  ValueFromRemainingArguments: false
DontShow: false
AcceptedValues: []
HelpMessage: ''
```

### -SkipCertCheck

If specified, SSL certificate errors will be ignored (useful for self-signed certs).

Required?                    false
Position?                    named
Default value                false
Accept pipeline input?       false
Accept wildcard characters?  false

```yaml
Type: System.Management.Automation.SwitchParameter
DefaultValue: False
SupportsWildcards: false
Aliases: []
ParameterSets:
- Name: Token
  Position: 2
  IsRequired: false
  ValueFromPipeline: false
  ValueFromPipelineByPropertyName: false
  ValueFromRemainingArguments: false
- Name: Password
  Position: 2
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

None. You cannot pipe objects to Connect-TriliumAuth.

## OUTPUTS

None. Sets $Global:TriliumCreds (a hashtable with authentication info) for use by other module functions.

## NOTES

- The function stores credentials in $Global:TriliumCreds (hashtable) for use by other module functions.
- Only one of -Password or -EtapiToken can be used per call.
- Ensure the BaseUrl is correct and accessible.
- Use -SkipCertCheck for self-signed or untrusted SSL certificates.
- Calls Get-TriliumInfo after authentication to verify connection.
- Author: P.
Morris
- Module: TriliumNext-Powershell-Module


## RELATED LINKS

- [Docs](https://ptmorris1.github.io/TriliumNext-Powershell-Module/auth/Connect-TriliumAuth.html)
