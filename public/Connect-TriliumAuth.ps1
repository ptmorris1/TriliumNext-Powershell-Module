function Connect-TriliumAuth {
    <#
    .SYNOPSIS
    Authenticates to a TriliumNext instance for API calls.

    .DESCRIPTION
    Configures authentication for TriliumNext using either a password (via PSCredential) or an ETAPI token. Optionally allows skipping SSL certificate checks. Stores credentials globally for use by other module functions.

    .PARAMETER BaseUrl
    The base URL for the TriliumNext instance. Should include protocol and port if needed.
    Example: https://trilium.myDomain.net
    Example: https://1.2.3.4:443

    .PARAMETER Password
    A PSCredential object containing your Trilium password. Used for standard login authentication.

    .PARAMETER EtapiToken
    A PSCredential object containing your ETAPI token as the password. Used for token-based authentication.

    .PARAMETER SkipCertCheck
    If specified, SSL certificate errors will be ignored (useful for self-signed certs).

    .EXAMPLE
    Connect-TriliumAuth -BaseUrl "https://trilium.myDomain.net" -Password (Get-Credential -UserName 'admin')
    Prompts for password and authenticates using standard login.

    .EXAMPLE
    Connect-TriliumAuth -BaseUrl "https://trilium.myDomain.net" -EtapiToken (Get-Credential -UserName 'admin')
    Authenticates using an ETAPI token.

    .NOTES
    - The function stores credentials in $Global:TriliumCreds for use by other module functions.
    - Ensure the BaseUrl is correct and accessible.
    - Use -SkipCertCheck for self-signed or untrusted SSL certificates.

    .LINK
    https://github.com/ptmorris1/TriliumNext-Powershell-Module
    #>
    [CmdletBinding(DefaultParameterSetName = 'Token')]
    param(
        # Base URL for Trilium instance
        [Parameter(Mandatory = $True, ParameterSetName = 'Password', Position = 0)]
        [Parameter(Mandatory = $True, ParameterSetName = 'Token', Position = 0)]
        [ValidateNotNullOrEmpty()]
        [string]$baseURL,

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
            # Ensure baseURL doesn't have a trailing slash
            if ($baseURL.EndsWith('/')) {
                $baseURL = $baseURL.TrimEnd('/')
            }
            $baseURL = $baseURL + '/etapi'

            if ($PSCmdlet.ParameterSetName -eq 'Password') {
                $headersLogin = @{ }
                $headersLogin.Add('Accept', 'application/json')
                $headersLogin.Add('Content-Type', 'application/json')
                $pass = $Password.GetNetworkCredential().Password
                $body = @{'password' = $Pass } | ConvertTo-Json
                $login = Invoke-RestMethod -Uri "$baseURL/auth/login" -Method Post -Headers $headersLogin -Body $body
                $Global:TriliumCreds = @{ }
                $Global:TriliumCreds.Add('Authorization', "$($login.authToken)")
                $Global:TriliumCreds.Add('URL', "$baseURL")
                $Global:TriliumCreds.Add('Token', 'pass')
            } if ($PSCmdlet.ParameterSetName -eq 'Token') {
                $Global:TriliumCreds = @{ }
                $Token = $EtapiToken.GetNetworkCredential().Password
                $Global:TriliumCreds.Add('Authorization', "Bearer $Token")
                $Global:TriliumCreds.Add('URL', "$baseURL")
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