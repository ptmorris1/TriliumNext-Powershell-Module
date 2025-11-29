function Connect-TriliumAuth {
    <#
    .SYNOPSIS
        Authenticates to a TriliumNext instance for API calls.

    .DESCRIPTION
        Configures authentication for TriliumNext using either a password (via PSCredential) or an ETAPI token (also via PSCredential, with the token as the password). Optionally allows skipping SSL certificate checks. Stores credentials globally for use by other module functions. Calls Get-TriliumInfo after authentication to verify connection.
        
        Supports both password-based and ETAPI token authentication. Only one authentication method can be used per invocation. Optionally skips SSL certificate checks for self-signed certificates.

    .PARAMETER BaseUrl
        The base URL for your TriliumNext instance. Should include protocol and port if needed.
        Example: https://trilium.myDomain.net
        Example: https://1.2.3.4:443

        Required?                    true
        Position?                    0
        Accept pipeline input?       false
        Accept wildcard characters?  false

    .PARAMETER Password
        A PSCredential object containing your Trilium password. Used for standard login authentication.
        
        Required?                    true (if using Password authentication)
        Position?                    1
        Accept pipeline input?       false
        Accept wildcard characters?  false
        Parameter set                Password

    .PARAMETER EtapiToken
        A PSCredential object containing your ETAPI token as the password. Used for token-based authentication.

        Required?                    true (if using Token authentication)
        Position?                    1
        Accept pipeline input?       false
        Accept wildcard characters?  false
        Parameter set                Token

    .PARAMETER SkipCertCheck
        If specified, SSL certificate errors will be ignored (useful for self-signed certs).

        Required?                    false
        Position?                    named
        Default value                false
        Accept pipeline input?       false
        Accept wildcard characters?  false

    .INPUTS
        None. You cannot pipe objects to Connect-TriliumAuth.

    .OUTPUTS
        None. Sets $Global:TriliumCreds (a hashtable with authentication info) for use by other module functions.

    .EXAMPLE
        Connect-TriliumAuth -BaseUrl "https://trilium.myDomain.net" -Password (Get-Credential -UserName 'admin')

        Prompts for password and authenticates using standard login.

    .EXAMPLE
        Connect-TriliumAuth -BaseUrl "https://trilium.myDomain.net" -EtapiToken (Get-Credential -UserName 'admin')

        Authenticates using an ETAPI token (token is entered as the password).

    .EXAMPLE
        Connect-TriliumAuth -BaseUrl "https://trilium.myDomain.net" -Password (Get-Credential -UserName 'admin') -SkipCertCheck

        Authenticates using password and skips SSL certificate validation (for self-signed certs).

    .NOTES
        - The function stores credentials in $Global:TriliumCreds (hashtable) for use by other module functions.
        - Only one of -Password or -EtapiToken can be used per call.
        - Ensure the BaseUrl is correct and accessible.
        - Use -SkipCertCheck for self-signed or untrusted SSL certificates.
        - Calls Get-TriliumInfo after authentication to verify connection.
        - Author: P. Morris
        - Module: TriliumNext-Powershell-Module

    .LINK
        https://ptmorris1.github.io/TriliumNext-Powershell-Module
    #>
    [CmdletBinding(DefaultParameterSetName = 'Token')]
    param(
        # Base URL for Trilium instance
        [Parameter(Mandatory = $True, ParameterSetName = 'Password', Position = 0)]
        [Parameter(Mandatory = $True, ParameterSetName = 'Token', Position = 0)]
        [ValidateNotNullOrEmpty()]
        [string]$BaseUrl,

        [Parameter(Mandatory = $True, ParameterSetName = 'Password', Position = 1)]
        [PSCredential]$Password,

        [Parameter(Mandatory = $True, ParameterSetName = 'Token', Position = 1)]
        [PSCredential]$EtapiToken,

        # Option to skip certificate check
        [Parameter(Mandatory = $false, ParameterSetName = 'Password', Position = 2)]
        [Parameter(Mandatory = $false, ParameterSetName = 'Token', Position = 2)]
        [switch]$SkipCertCheck
    )

    begin {

    }

    process {
        try {
            if ($SkipCertCheck -eq $true) {
                $PSDefaultParameterValues = @{'Invoke-RestMethod:SkipCertificateCheck' = $true
                }
            }
            # Ensure BaseUrl doesn't have a trailing slash
            if ($BaseUrl.EndsWith('/')) {
                $BaseUrl = $BaseUrl.TrimEnd('/')
            }
            $BaseUrl = $BaseUrl + '/etapi'

            if ($PSCmdlet.ParameterSetName -eq 'Password') {
                $headersLogin = @{ }
                $headersLogin.Add('Accept', 'application/json')
                $headersLogin.Add('Content-Type', 'application/json')
                $pass = $Password.GetNetworkCredential().Password
                $body = @{'password' = $Pass } | ConvertTo-Json
                $login = Invoke-RestMethod -Uri "$BaseUrl/auth/login" -Method Post -Headers $headersLogin -Body $body
                $Global:TriliumCreds = @{ }
                $Global:TriliumCreds.Add('Authorization', "$($login.authToken)")
                $Global:TriliumCreds.Add('URL', "$BaseUrl")
                $Global:TriliumCreds.Add('Token', 'pass')
            } if ($PSCmdlet.ParameterSetName -eq 'Token') {
                $Global:TriliumCreds = @{ }
                $Token = $EtapiToken.GetNetworkCredential().Password
                $Global:TriliumCreds.Add('Authorization', "Bearer $Token")
                $Global:TriliumCreds.Add('URL', "$BaseUrl")
                $Global:TriliumCreds.Add('Token', 'etapi')
            }
            Get-TriliumInfo
        } catch {
            $_.Exception.Response
        }
    }

    end {
        return
    }
}