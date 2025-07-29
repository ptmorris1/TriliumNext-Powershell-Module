# 🔐 Authentication

!!! note
    Before using any cmdlets in this module, you must authenticate with [`Connect-TriliumAuth`](Connect-TriliumAuth.md).

---

## 🔑 Connect-TriliumAuth

Authenticate to your TriliumNext instance for API access. Two mutually exclusive authentication methods are supported:

- **Password-based**: Use the `-Password` parameter with a PSCredential object containing your Trilium password.
- **ETAPI token-based**: Use the `-EtapiToken` parameter with a PSCredential object containing your ETAPI token as the password.

!!! important
    Provide either `-Password` or `-EtapiToken`, not both. Optionally, use `-SkipCertCheck` to ignore SSL certificate errors (for self-signed certs).

### Parameters

| Parameter        | Type         | Required | Description                                                        |
|------------------|--------------|----------|--------------------------------------------------------------------|
| `-BaseUrl`       | String       | Yes      | Base URL for your TriliumNext instance. E.g., `https://trilium.myDomain.net` |
| `-Password`      | PSCredential | No*      | Credential for password-based authentication.                      |
| `-EtapiToken`    | PSCredential | No*      | Credential for ETAPI token authentication (token as password).     |
| `-SkipCertCheck` | Switch       | No       | Ignore SSL certificate errors (for self-signed certs).             |

\* One of `-Password` or `-EtapiToken` is required, but not both.

!!! tip
    The username in `Get-Credential` is not used by Trilium; you can enter any value.

!!! warning
    Credentials are stored in `$Global:TriliumCreds` for use by other module functions. The function also calls `Get-TriliumInfo` after authentication to verify the connection.

---

### Examples

#### Authenticate with Password

```powershell
$creds = Get-Credential -UserName 'admin'
Connect-TriliumAuth -BaseUrl "https://trilium.myDomain.net" -Password $creds
```

Sample output:
```powershell
appVersion             : 0.96.0
dbVersion              : 232
nodeVersion            : v22.17.0
syncVersion            : 36
buildDate              : 6/7/2025 9:45:40 AM
buildRevision          : 7cbff47078012e32279c110c49b904bd24dcecb3
dataDirectory          : /home/node/trilium-data
clipperProtocolVersion : 1.0
utcDateTime            : 7/4/2025 4:07:48 AM
```

!!! tip
    This output confirms a successful connection and shows server environment details.

#### Authenticate with ETAPI Token

```powershell
$token = Get-Credential -UserName 'admin' # Enter your ETAPI token as the password
Connect-TriliumAuth -BaseUrl "https://trilium.myDomain.net" -EtapiToken $token
```

#### Skip Certificate Check (Self-Signed Certs)

```powershell
Connect-TriliumAuth -BaseUrl "https://trilium.myDomain.net" -Password $creds -SkipCertCheck
```

!!! tip
    All Trilium module cmdlets support the `-SkipCertCheck` parameter for self-signed certificates.

!!! warning
    Ensure your BaseUrl is correct and accessible. Use `-SkipCertCheck` only if you trust the server.

---

## 🔌 Disconnect-TriliumAuth

Removes your session from Trilium and clears the global credential variable.

- If you authenticated with a password, it logs you out of Trilium via the API.
- If you used an ETAPI token, it only clears the session variable (no logout API call is made).

See: [`Disconnect-TriliumAuth`](Disconnect-TriliumAuth.md)

### Parameters

| Parameter        | Type   | Required | Description                                        |
|------------------|--------|----------|----------------------------------------------------|
| `-SkipCertCheck` | Switch | No       | Ignore SSL certificate errors (for self-signed certs). |

### Output
None. This cmdlet performs a logout operation (if using password authentication) and/or clears credentials.

### Example

```powershell
Disconnect-TriliumAuth
```

!!! tip
    Use [`Disconnect-TriliumAuth`](Disconnect-TriliumAuth.md) to ensure your credentials are cleared from your session, especially if you switch users or finish your automation tasks.

---

