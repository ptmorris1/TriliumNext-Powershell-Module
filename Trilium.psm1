function Connect-TriliumAuth {
    <#
    .SYNOPSIS
    Sets the authentication to a TriliumNext instance for API calls.

    .DESCRIPTION
    This function configures the authentication for TriliumNext using either a password or an ETAPI token. It also allows skipping certificate checks.

    .PARAMETER baseURL
    The base URL for the TriliumNext instance. Should include port or use reverse proxy.
    Example: https://trilium.myDomain.net
    Example: https://1.2.3.4:443

        Required?                    true
        Position?                    0
        ParameterSetName             Auth, PlainText, Token
        Default value                None
        Accept pipeline input?       false
        Accept wildcard characters?  false

    .PARAMETER Auth
    The authentication method to use: 'Password' or 'ETAPITOKEN'.
    ETAPITOKEN is required for desktop installations.
    This method will ask for a password or token that can be input masked.

        Required?                    true
        Position?                    1
        ParameterSetName             Auth
        Default value                None
        Accept pipeline input?       false
        Accept wildcard characters?  false

    .PARAMETER SkipCertCheck
    Option to skip certificate check. Default is 'Yes'.

        Required?                    false
        Position?                    2
        ParameterSetName             Auth, PlainText, Token
        Default value                Yes
        Accept pipeline input?       false
        Accept wildcard characters?  false

    .PARAMETER Password
    The password for authentication. This is if you are ok entering plain text password.

        Required?                    true
        Position?                    1
        ParameterSetName             PlainText
        Default value                None
        Accept pipeline input?       false
        Accept wildcard characters?  false

    .PARAMETER EtapiToken
    The ETAPI token for authentication. This is if you are ok entering a plain text token.

        Required?                    true
        Position?                    1
        ParameterSetName             Token
        Default value                None
        Accept pipeline input?       false
        Accept wildcard characters?  false

    .EXAMPLE
    Connect-TriliumAuth -baseURL "https://trilium.myDomain.net" -Auth "Password"

    After running, you will be prompted for password using masked input.

    .EXAMPLE
    Connect-TriliumAuth -baseURL "https://trilium.myDomain.net" -Auth "ETAPITOKEN" -SkipCertCheck "No"

    .NOTES
    Ensure that the baseURL is correct and accessible. The function will store the credentials globally for use in other functions.
    #>
    [CmdletBinding(DefaultParameterSetName = 'Auth')]
    param(
        # Base URL for Trilium instance
        [Parameter(Mandatory = $True, ParameterSetName = 'Auth', Position = 0)]
        [Parameter(Mandatory = $True, ParameterSetName = 'PlainText', Position = 0)]
        [Parameter(Mandatory = $True, ParameterSetName = 'Token', Position = 0)]
        [ValidateNotNullOrEmpty()]
        [string]$baseURL,
        # Authentication method: Password or ETAPI token
        [Parameter(Mandatory = $True, ParameterSetName = 'Auth', Position = 1)]
        [ValidateSet('Password', 'ETAPITOKEN')]
        [string]$Auth,
        # Option to skip certificate check
        [Parameter(Mandatory = $false, ParameterSetName = 'Auth', Position = 2)]
        [Parameter(Mandatory = $false, ParameterSetName = 'PlainText', Position = 2)]
        [Parameter(Mandatory = $false, ParameterSetName = 'Token', Position = 2)]
        [ValidateSet('Yes', 'No')]
        [string]$SkipCertCheck = 'Yes',
        [Parameter(Mandatory = $True, ParameterSetName = 'PlainText', Position = 1)]
        [string]$Password,
        [Parameter(Mandatory = $True, ParameterSetName = 'Token', Position = 1)]
        [string]$EtapiToken
    )

    begin {

    }

    process {
        try {
            if ($SkipCertCheck -eq 'Yes') {
                    $PSDefaultParameterValues = @{'Invoke-RestMethod:SkipCertificateCheck' = $true
                }
            }
            $baseURL = $baseURL + '/etapi'
            if ($PSCmdlet.ParameterSetName -eq 'Auth' -and $Auth -eq 'password') {
                $AuthKey = Read-Host 'Enter your TriliumNext Password' -AsSecureString
                $UnsecurePassword = ConvertFrom-SecureString -SecureString $authkey -AsPlainText
                $headersLogin = @{ }
                $headersLogin.Add('Accept', 'application/json')
                $headersLogin.Add('Content-Type', 'application/json')
                $body = @{'password' = $UnsecurePassword } | ConvertTo-Json
                $login = Invoke-RestMethod -Uri "$baseURL/auth/login" -Method Post -Headers $headersLogin -Body $body
                $Global:TriliumCreds = @{ }
                $Global:TriliumCreds.Add('Authorization', "$($login.authToken)")
                $Global:TriliumCreds.Add('URL', "$baseURL")
                $Global:TriliumCreds.Add('Token', 'pass')
            } elseif ($PSCmdlet.ParameterSetName -eq 'Auth' -and $Auth -eq 'ETAPITOKEN') {
                $AuthKey = Read-Host 'Enter your TriliumNext ETAPI token key' -AsSecureString
                $UnsecurePassword = ConvertFrom-SecureString -SecureString $authkey -AsPlainText
                $Global:TriliumCreds = @{ }
                $Global:TriliumCreds.Add('Authorization', "$UnsecurePassword")
                $Global:TriliumCreds.Add('URL', "$baseURL")
                $Global:TriliumCreds.Add('Token', 'etapi')
            } elseif ($PSCmdlet.ParameterSetName -eq 'PlainText') {
                $headersLogin = @{ }
                $headersLogin.Add('Accept', 'application/json')
                $headersLogin.Add('Content-Type', 'application/json')
                $body = @{'password' = $Password } | ConvertTo-Json
                $login = Invoke-RestMethod -Uri "$baseURL/auth/login" -Method Post -Headers $headersLogin -Body $body
                $Global:TriliumCreds = @{ }
                $Global:TriliumCreds.Add('Authorization', "$($login.authToken)")
                $Global:TriliumCreds.Add('URL', "$baseURL")
                $Global:TriliumCreds.Add('Token', 'pass')
            } elseif ($PSCmdlet.ParameterSetName -eq 'Token') {
                $Global:TriliumCreds = @{ }
                $Global:TriliumCreds.Add('Authorization', "$EtapiToken")
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

function Disconnect-TriliumAuth {
    <#
    .SYNOPSIS
    Removes the authentication for TriliumNext.

    .DESCRIPTION
    This function removes the authentication for TriliumNext. If using password authentication, it logs out. If using ETAPI token, it displays an error.

    .EXAMPLE
    Disconnect-TriliumAuth

    .NOTES
    This function should be called when you want to clear the stored credentials. It will also log out if password authentication was used.
    #>
    # Check if using password authentication and log out, otherwise display error
    process {
        if ($TriliumCreds.token -eq 'pass') {
            $TriliumHeaders = @{}
            $TriliumHeaders.Add('Authorization', "$($TriliumCreds.Authorization)")
            Invoke-RestMethod -Uri "$($TriliumCreds.URL)/auth/logout" -Headers $TriliumHeaders -SkipHeaderValidation -Method Post
            Remove-Variable TriliumCreds
            Write-Output 'Removed ETAPI tokena and global variable'
        } else {
            Write-Output 'Using ETAPI key, will remove global variable'
            Remove-Variable TriliumCreds
        }
    }

    begin {

    }

    end {
        return
    }
}

function Get-TriliumInfo {
    <#
    .SYNOPSIS
    Gets the application info for TriliumNext.

    .DESCRIPTION
    This function retrieves the application info for TriliumNext.

    .EXAMPLE
    Get-TriliumInfo

    .NOTES
    This function requires that the authentication has been set using Connect-TriliumAuth.
    #>
    # Set headers and make request to get app info
    process {
        try {
            $TriliumHeaders = @{}
            $TriliumHeaders.Add('Authorization', "$($TriliumCreds.Authorization)")
            try {
                Invoke-RestMethod -Uri "$($TriliumCreds.URL)/app-info" -Headers $TriliumHeaders -SkipHeaderValidation
            } catch {
                $_.Exception.Response
            }
        } catch {
            $_.Exception.Response
        }
    }
    begin {
        if (!$global:TriliumCreds) { Write-Error -Message 'Need to run: Connect-TriliumAuth';exit }
    }
    end {
        return
    }
}

function Get-TriliumRootNote {
    <#
    .SYNOPSIS
    Gets the root note details from the TriliumNext instance.

    .DESCRIPTION
    This function retrieves the root note of TriliumNext.

    .EXAMPLE
    Get-TriliumRootNote

    .NOTES
    This function requires that the authentication has been set using Connect-TriliumAuth.
    #>
    # Set headers and make request to get root note
    process{
        try {
            $TriliumHeaders = @{}
            $TriliumHeaders.Add('Authorization', "$($TriliumCreds.Authorization)")
            Invoke-RestMethod -Uri "$($TriliumCreds.URL)/notes/root" -Headers $TriliumHeaders -SkipHeaderValidation
        } catch {
            $_.Exception.Response
        }
    }
    begin {
        if (!$global:TriliumCreds) { Write-Error -Message 'Need to run: Connect-TriliumAuth';exit }
    }
    end {
        return
    }
}

function Find-TriliumNote {
    <#
    .SYNOPSIS
    Finds a TriliumNext note based on the search term and optional filters.

    .DESCRIPTION
    This function searches for a TriliumNext note using the provided search term and optional filters such as label, fast search, include archived notes, debug mode, ancestor note ID, and result limit.

    .PARAMETER Search
    The search term to find the note.

        Required?                    true
        Position?                    0
        Default value                None
        Accept pipeline input?       false
        Accept wildcard characters?  false

    .PARAMETER Label
    An optional label to filter the search results.

        Required?                    false
        Position?                    1
        Default value                None
        Accept pipeline input?       false
        Accept wildcard characters?  false

    .PARAMETER FastSearch
    Option to enable fast search.

        Required?                    false
        Position?                    2
        Default value                None
        Accept pipeline input?       false
        Accept wildcard characters?  false

    .PARAMETER IncludeArchivedNotes
    Option to include archived notes in the search results.

        Required?                    false
        Position?                    3
        Default value                None
        Accept pipeline input?       false
        Accept wildcard characters?  false

    .PARAMETER DebugOn
    Option to enable debug mode.

        Required?                    false
        Position?                    4
        Default value                None
        Accept pipeline input?       false
        Accept wildcard characters?  false

    .PARAMETER AncestorNoteId
    An optional note ID to search within.

        Required?                    false
        Position?                    5
        Default value                None
        Accept pipeline input?       false
        Accept wildcard characters?  false

    .PARAMETER Limit
    Limit the number of search results.

        Required?                    false
        Position?                    6
        Default value                10
        Accept pipeline input?       false
        Accept wildcard characters?  false

    .EXAMPLE
    Find-TriliumNote -Search "meeting notes"

    .EXAMPLE
    Find-TriliumNote -Search "project" -Label "work" -FastSearch -IncludeArchivedNotes

    .NOTES
    This function requires that the authentication has been set using Connect-TriliumAuth.
    #>
    [CmdletBinding(DefaultParameterSetName = 'default',SupportsShouldProcess=$true)]
    param(
        # Search term
        [Parameter(Mandatory = $true, ParameterSetName = 'Limit')]
        [Parameter(Mandatory = $true, ParameterSetName = 'default')]
        [ValidateNotNullOrEmpty()]
        [string]$Search,
        # Optional label to filter search
        [Parameter(Mandatory = $false)]
        [ValidateNotNullOrEmpty()]
        [string]$Label,
        # Option for fast search
        [Parameter(Mandatory = $false)]
        [switch]$FastSearch,
        # Option to include archived notes
        [Parameter(Mandatory = $false)]
        [switch]$IncludeArchivedNotes,
        # Option to enable debug mode
        [Parameter(Mandatory = $false)]
        [switch]$DebugOn,
        # Optional Ancestor note ID to search within
        [Parameter(Mandatory = $false)]
        [ValidateNotNullOrEmpty()]
        [string]$AncestorNoteId,
        # Limit the number of search results
        [Parameter(Mandatory = $false, ParameterSetName = 'Limit')]
        [Parameter(Mandatory = $false, ParameterSetName = 'default')]
        [ValidateNotNullOrEmpty()]
        [Int64]$Limit,
        [Parameter(Mandatory = $true, ParameterSetName = 'Limit')]
        [Parameter(Mandatory = $false, ParameterSetName = 'default')]
        [ValidateSet('title', 'publicationDate', 'isProtected', 'isArchived', 'dateCreated', 'dateModified', 'utcDateCreated', 'utcDateModified', 'parentCount', 'childrenCount', 'attributeCount', 'labelCount', 'ownedLabelCount', 'relationCount', 'ownedRelationCount', 'relationCountIncludingLinks', 'ownedRelationCountIncludingLinks', 'targetRelationCount', 'targetRelationCountIncludingLinks', 'contentSize', 'contentAndAttachmentsSize', 'contentAndAttachmentsAndRevisionsSize', 'revisionCount')]
        [string]$OrderBy
    )

    process {
        # If no limit is specified, default to 10
        if ($null -eq $Limit) { $Limit = 10 }
        # Replace special characters in the search term for HTML encoding
        $Search = $Search -replace ' ', '%20'
        $Search = $Search -replace '"', '%22'
        $Search = $Search -replace '#', '%23'
        $Search = $Search -replace '<', '%3C'
        $Search = $Search -replace '>', '%3E'
        $Search = $Search -replace '&', '%26'
        $Search = $Search -replace '\?', '%3F'
        # If a label is specified, add it to the search term
        if (!([string]::IsNullOrEmpty($Label))) { $search = $search + '%20%23' + $Label }
        # If no note ID is specified, default to 'root'
        if (([string]::IsNullOrEmpty($AncestorNoteId))) { $AncestorNoteId = 'root' }
        # Set headers and construct URI for search request
        $TriliumHeaders = @{}
        $TriliumHeaders.Add('Authorization', "$($TriliumCreds.Authorization)")
        $TriliumHeaders.Add('accept', 'application/json; charset=utf-8')
        $uri = "$($TriliumCreds.URL)/notes?search=$($Search)&fastSearch=$($FastSearch.ToString().ToLower())&includeArchivedNotes=$($IncludeArchivedNotes.ToString().ToLower())&ancestorNoteId=$AncestorNoteId&orderBy=$OrderBy&limit=$($Limit)&debug=$($DebugOn.ToString().ToLower())"

        if ($PSCmdlet.ShouldProcess($uri, "Searching")){
            # Make request to find notes
            Invoke-RestMethod -Uri $uri -Headers $TriliumHeaders -SkipHeaderValidation
        }
    }

    begin {
        if (!$global:TriliumCreds) { Write-Error -Message 'Need to run: Connect-TriliumAuth';exit }
    }

    end {
        return
    }
}

function Get-TriliumNoteDetail {
    <#
    .SYNOPSIS
    Gets details of a specific TriliumNext note.

    .DESCRIPTION
    This function retrieves the details of a specific TriliumNext note based on the provided note ID.

    .PARAMETER NoteID
    The note ID to get details for.

        Required?                    true
        Position?                    0
        Default value                None
        Accept pipeline input?       false
        Accept wildcard characters?  false

    .EXAMPLE
    Get-TriliumNoteDetails -NoteID "12345"

    .NOTES
    This function requires that the authentication has been set using Connect-TriliumAuth.
    #>
    param (
        # Note ID to get details for
        [Parameter(Mandatory = $True)][ValidateNotNullOrEmpty()][string]$NoteID
    )
    process{
        # Set headers and make request to get note details
        $TriliumHeaders = @{}
        $TriliumHeaders.Add('Authorization', "$($TriliumCreds.Authorization)")
        $uri = "$($TriliumCreds.URL)/notes/$NoteID"
        Invoke-RestMethod -Uri $uri -Headers $TriliumHeaders -SkipHeaderValidation
    }
    begin {
        if (!$global:TriliumCreds) { Write-Error -Message 'Need to run: Connect-TriliumAuth';exit }

    }
    end {
        return
    }
}

function Export-TriliumNote {
    <#
    .SYNOPSIS
    Exports a TriliumNext note to a zip file.

    .DESCRIPTION
    This function exports a TriliumNext note to a zip file based on the provided note ID and optional path.

    .PARAMETER NoteID
    The note ID to export.

        Required?                    true
        Position?                    0
        Default value                None
        Accept pipeline input?       false
        Accept wildcard characters?  false

    .PARAMETER Path
    Optional path to save the exported file.

        Required?                    false
        Position?                    1
        Default value                None
        Accept pipeline input?       false
        Accept wildcard characters?  false

    .EXAMPLE
    Export-TriliumNote -NoteID "12345" -Path "C:\temp\export.zip"

    .NOTES
    This function requires that the authentication has been set using Connect-TriliumAuth.
    Ensure that the provided path is valid and writable.
    #>
    param (
        # Note ID to export
        [Parameter(Mandatory = $True)][ValidateNotNullOrEmpty()][string]$NoteID,
        # Optional path to save the exported file
        [Parameter(Mandatory = $false)][ValidateNotNullOrEmpty()][string]$Path
    )
    # Get note details and check if path is specified
    process {
        $details = Get-TriliumNoteDetails -NoteID $NoteID
        if ([string]::IsNullOrEmpty($Path)) {
            $Path = "c:\temp\$($details.title + '_' + $NoteID).zip"
        } elseif ($Path -notmatch '.zip') {
            Write-Error 'Full path needed with filename and .zip extension:  C:\temp\export.zip'
        } else {
            # Set headers and make request to export note
            $TriliumHeaders = @{}
            $TriliumHeaders.Add('Authorization', "$($TriliumCreds.Authorization)")
            $uri = "$($TriliumCreds.URL)/notes/$NoteID/export"
            Invoke-RestMethod -Uri $uri -Headers $TriliumHeaders -SkipHeaderValidation -ContentType 'application/zip' -OutFile $Path
            Write-Output "$($details.title) exported to $Path"
        }
    }
    begin {
        if (!$global:TriliumCreds) { Write-Error -Message 'Need to run: Connect-TriliumAuth';exit }

    }
    end {
        return
    }
}

function New-TriliumNote {
    <#
    .SYNOPSIS
    Creates a new Trilium note.

    .DESCRIPTION
    This function creates a new Trilium note under the specified parent note ID with the provided title and content.

    .PARAMETER ParentNoteId
    The parent note ID to create the new note under.

        Required?                    true
        Position?                    0
        Default value                None
        Accept pipeline input?       false
        Accept wildcard characters?  false

    .PARAMETER Title
    The title of the new note.

        Required?                    true
        Position?                    1
        Default value                None
        Accept pipeline input?       false
        Accept wildcard characters?  false

    .PARAMETER Content
    The content of the new note.

        Required?                    true
        Position?                    2
        Default value                None
        Accept pipeline input?       false
        Accept wildcard characters?  false

    .EXAMPLE
    New-TriliumNote -ParentNoteId "root" -Title "New Note" -Content "This is a new note."

    .NOTES
    This function requires that the authentication has been set using Connect-TriliumAuth.
    #>
    [CmdletBinding(SupportsShouldProcess = $true)]
    param (
        # Parent note ID to create the new note under
        [Parameter(Mandatory = $true)][ValidateNotNullOrEmpty()][string]$ParentNoteId,
        # Title of the new note
        [Parameter(Mandatory = $true)][ValidateNotNullOrEmpty()][string]$Title,
        # Content of the new note
        [Parameter(Mandatory = $true)][ValidateNotNullOrEmpty()][string]$Content
    )
    process {
        # Set headers and make request to create new note
        $TriliumHeaders = @{}
        $TriliumHeaders.Add('Authorization', "$($TriliumCreds.Authorization)")
        $uri = "$($TriliumCreds.URL)/create-note"
        $body = @{
            parentNoteId = $ParentNoteId
            title        = $Title
            content      = $Content
            type         = 'text'
        }
        $body = $body | ConvertTo-Json
        if ($PSCmdlet.ShouldProcess($uri, 'Update note order')) {
            Invoke-RestMethod -Uri $uri -Headers $TriliumHeaders -SkipHeaderValidation -ContentType 'application/json' -Body $body -Method Post
        }
    }
    begin {
        if (!$global:TriliumCreds) { Write-Error -Message 'Need to run: Connect-TriliumAuth';exit }
    }
    end {
        return
    }
}

function Remove-TriliumNote {
    <#
    .SYNOPSIS
    Removes a Trilium note.

    .DESCRIPTION
    This function removes a Trilium note based on the provided note ID.

    .PARAMETER NoteID
    The note ID to remove.

        Required?                    true
        Position?                    0
        Default value                None
        Accept pipeline input?       false
        Accept wildcard characters?  false

    .EXAMPLE
    Remove-TriliumNote -NoteID "12345"

    .NOTES
    This function requires that the authentication has been set using Connect-TriliumAuth.
    #>
    [CmdletBinding(SupportsShouldProcess = $true)]
    param (
        # Note ID to remove
        [Parameter(Mandatory = $true)][ValidateNotNullOrEmpty()][string]$NoteID
    )
    process {
        # Set headers and make request to remove note
        $TriliumHeaders = @{}
        $TriliumHeaders.Add('Authorization', "$($TriliumCreds.Authorization)")
        $uri = "$($TriliumCreds.URL)/notes/$NoteID"
        if ($PSCmdlet.ShouldProcess($uri, 'Removing Note')) {
            Invoke-RestMethod -Uri $uri -Headers $TriliumHeaders -Method Delete -SkipHeaderValidation
        }
    }
    begin {
        if (!$global:TriliumCreds) { Write-Error -Message 'Need to run: Connect-TriliumAuth';exit }
    }
    end {
        return
    }
}

function Get-TriliumNoteContent {
    <#
    .SYNOPSIS
    Gets the content of a specific Trilium note.

    .DESCRIPTION
    This function retrieves the content of a specific Trilium note based on the provided note ID.

    .PARAMETER NoteID
    The note ID to get content for.

        Required?                    true
        Position?                    0
        Default value                None
        Accept pipeline input?       false
        Accept wildcard characters?  false

    .EXAMPLE
    Get-TriliumNoteContent -NoteID "root"

    .NOTES
    This function requires that the authentication has been set using Connect-TriliumAuth.
    #>
    param (
        [Parameter(Mandatory = $true)][ValidateNotNullOrEmpty()][string]$NoteID
    )

    process {
        try {
            $TriliumHeaders = @{ }
            $TriliumHeaders.Add('Authorization', "$($TriliumCreds.Authorization)")
            # API call run
            try {
                $uri = "$($TriliumCreds.URL)/notes/$NoteID/content"
                Invoke-RestMethod -Uri $uri -Headers $TriliumHeaders -Method Get -SkipHeaderValidation
            } catch {
                $_.Exception.Response
            }
        } catch {
            $_.Exception.Response
        }
    }
    begin {
        if (!$global:TriliumCreds) { Write-Error -Message 'Need to run: Connect-TriliumAuth';exit }

    }
    end {
        return
    }
}

function Set-TriliumNoteContent {
    <#
    .SYNOPSIS
    Sets the content of a specific Trilium note.

    .DESCRIPTION
    This function updates the content of a specific Trilium note based on the provided note ID and content.

    .PARAMETER NoteID
    The note ID to set content for.

        Required?                    true
        Position?                    0
        Default value                None
        Accept pipeline input?       false
        Accept wildcard characters?  false

    .PARAMETER NoteContent
    The html content to set for the note.

        Required?                    true
        Position?                    1
        Default value                None
        Accept pipeline input?       false
        Accept wildcard characters?  false

    .EXAMPLE
    Set-TriliumNoteContent -NoteID "root" -NoteContent "Updated content for the root note."

    .NOTES
    This function requires that the authentication has been set using Connect-TriliumAuth.
    #>
    [CmdletBinding(SupportsShouldProcess = $true)]
    param (
        [Parameter(Mandatory = $true)][ValidateNotNullOrEmpty()][string]$NoteID,
        [Parameter(Mandatory = $true)][ValidateNotNullOrEmpty()][string]$NoteContent
    )

    process {
        try {
            $TriliumHeaders = @{ }
            $TriliumHeaders.Add('Authorization', "$($TriliumCreds.Authorization)")
            # API call run
            try {
                $uri = "$($TriliumCreds.URL)/notes/$NoteID/content"
                $body = $NoteContent
                if ($PSCmdlet.ShouldProcess($uri, 'Update note order')) {
                    Invoke-RestMethod -Uri $uri -Headers $TriliumHeaders -Method Put -SkipHeaderValidation -Body $body -ContentType 'text/plain'
                }
            } catch {
                $_.Exception.Response
            }
        } catch {
            $_.Exception.Response
        }
    }
    begin {
        if (!$global:TriliumCreds) { Write-Error -Message 'Need to run: Connect-TriliumAuth';exit }

    }
    end {
        return
    }
}

function Import-TriliumNoteZip {
    <#
    .SYNOPSIS
    Imports a Trilium note zip file to a specific Trilium note.

    .DESCRIPTION
    This function uploads a zip file to a specific Trilium note based on the provided note ID and zip file path.
    The zip file is an export of a note from Trilium.
    You can use Export-TriliumNote to create this zip if needed or the Trilium GUI

    .PARAMETER NoteID
    The note ID to add the zip file to.

        Required?                    true
        Position?                    0
        Default value                None
        Accept pipeline input?       false
        Accept wildcard characters?  false

    .PARAMETER ZipPath
    The path to the zip file to upload.

        Required?                    true
        Position?                    1
        Default value                None
        Accept pipeline input?       false
        Accept wildcard characters?  false

    .EXAMPLE
    Import-TriliumNoteZip -NoteID "root" -ZipPath "C:\temp\import.zip"

    .NOTES
    This function requires that the authentication has been set using Connect-TriliumAuth.
    Ensure that the provided path is valid and points to a zip file.
    #>
    [CmdletBinding(SupportsShouldProcess = $true)]
    param (
        [Parameter(Mandatory = $true)]
        [ValidateNotNullOrEmpty()]
        [string]$NoteID,
        [Parameter(Mandatory = $true)]
        [ValidateNotNullOrEmpty()]
        [string]$ZipPath
    )

    process {
        try {
            $TriliumHeaders = @{ }
            $TriliumHeaders.Add('Authorization', "$($TriliumCreds.Authorization)")
            # Read the zip file content as byte array
            $fileBytes = [System.IO.File]::ReadAllBytes($ZipPath)
            # API call run
            try {
                $uri = "$($TriliumCreds.URL)/notes/$NoteID/import"
                $TriliumHeaders.Add('Content-Transfer-Encoding', 'binary')
                if ($PSCmdlet.ShouldProcess($uri, "Importing")) {
                    Invoke-RestMethod -Uri $uri -Headers $TriliumHeaders -Method Post -SkipHeaderValidation -Body $fileBytes -ContentType 'application/octet-stream'
                }
            } catch {
                $_.Exception.Response
            }
        } catch {
            $_.Exception.Response
        }
    }
    begin {
        if (!$global:TriliumCreds) { Write-Error -Message 'Need to run: Connect-TriliumAuth';exit }
        # Validate that the ZipPath is a correct Windows path with .zip extension
        if ($ZipPath -notmatch '^[a-zA-Z]:\\(?:[^\\\/:*?"<>|\r\n]+\\)*[^\\\/:*?"<>|\r\n]+\.(zip)$') {
            throw 'Invalid path. Please provide a valid Windows path with a .zip extension. `nExample: C:\temp\import.zip'
        }
    }
    end {
        return
    }
}

function New-TriliumNoteRevision {
    <#
    .SYNOPSIS
    Creates a new revision for a specific Trilium note.

    .DESCRIPTION
    This function creates a new revision for a specific Trilium note based on the provided note ID.

    .PARAMETER NoteID
    The note ID to create a new revision for.

        Required?                    true
        Position?                    0
        Default value                None
        Accept pipeline input?       false
        Accept wildcard characters?  false

    .EXAMPLE
    New-TriliumNoteRevision -NoteID "12345"

    .NOTES
    This function requires that the authentication has been set using Connect-TriliumAuth.
    #>
    [CmdletBinding(SupportsShouldProcess = $true)]
    param (
        [Parameter(Mandatory = $true)]
        [ValidateNotNullOrEmpty()]
        [string]$NoteID
    )

    process {
        try {
            $TriliumHeaders = @{ }
            $TriliumHeaders.Add('Authorization', "$($TriliumCreds.Authorization)")
            # API call run
            try {
                $uri = "$($TriliumCreds.URL)/notes/$NoteID/revision"
                if ($PSCmdlet.ShouldProcess($uri, 'Creating revision')) {
                    Invoke-RestMethod -Uri $uri -Headers $TriliumHeaders -Method Post -SkipHeaderValidation
                }
            } catch {
                $_.Exception.Response
            }
        } catch {
            $_.Exception.Response
        }
    }
    begin {
        if (!$global:TriliumCreds) { Write-Error -Message 'Need to run: Connect-TriliumAuth';exit }

    }
    end {
        return
    }
}

function Copy-TriliumNote {
    <#
    .SYNOPSIS
    Creates a clone (branch) of a Trilium note in another note.

    .DESCRIPTION
    This function clones a Trilium note to a new parent note based on the provided note ID and parent note ID.

    .PARAMETER NoteID
    The note ID to clone.

        Required?                    true
        Position?                    0
        Default value                None
        Accept pipeline input?       false
        Accept wildcard characters?  false

    .PARAMETER parentNoteID
    The parent note ID to clone the note to.

        Required?                    true
        Position?                    1
        Default value                None
        Accept pipeline input?       false
        Accept wildcard characters?  false

    .PARAMETER IsExpanded
    Option to expand the copied note.

        Required?                    false
        Position?                    2
        Default value                False
        Accept pipeline input?       false
        Accept wildcard characters?  false

    .PARAMETER Prefix
    Optional prefix for the copied note.

        Required?                    false
        Position?                    3
        Default value                None
        Accept pipeline input?       false
        Accept wildcard characters?  false

    .EXAMPLE
    Copy-TriliumNote -NoteID "sxhoPPMkVIuO" -parentNoteID "A2PGuqZgT03z"

    .NOTES
    This function requires that the authentication has been set using Connect-TriliumAuth.
    #>
    [CmdletBinding(SupportsShouldProcess = $true)]
    param (
        [Parameter(Mandatory = $true)][ValidateNotNullOrEmpty()][string]$NoteID,
        [Parameter(Mandatory = $true)][ValidateNotNullOrEmpty()][string]$parentNoteID,
        [Parameter(Mandatory = $false)][switch]$IsExpanded,
        [Parameter(Mandatory = $false)][ValidateNotNullOrEmpty()][string]$Prefix
    )

    process {
        try {
            $TriliumHeaders = @{ }
            $TriliumHeaders.Add('Authorization', "$($TriliumCreds.Authorization)")
            $TriliumHeaders.Add('accept', 'application/json; charset=utf-8')
            # API call run
            try {
                $uri = "$($TriliumCreds.URL)/branches"
                $body = @{
                    noteId       = $NoteID
                    parentNoteId = $parentNoteID
                    isExpanded   = if ($IsExpanded -match 'false') { $false } else { $true }
                    prefix       = $Prefix
                }
                $body = $body | ConvertTo-Json
                if ($PSCmdlet.ShouldProcess($uri, 'Creating clone\branch')) {
                    Invoke-RestMethod -Uri $uri -Headers $TriliumHeaders -Method Post -SkipHeaderValidation -Body $body -ContentType 'application/json'
                }
            } catch {
                $_.Exception.Response
            }
        } catch {
            $_.Exception.Response
        }
    }
    begin {
        if (!$global:TriliumCreds) { Write-Error -Message 'Need to run: Connect-TriliumAuth';exit }

    }
    end {
        return
    }
}

function Get-TriliumBranch {
    <#
    .SYNOPSIS
    Gets details of a specific Trilium branch.

    .DESCRIPTION
    This function retrieves the details of a specific Trilium branch based on the provided branch ID.

    .PARAMETER BranchID
    The branch ID to get details for.

        Required?                    true
        Position?                    0
        Default value                None
        Accept pipeline input?       false
        Accept wildcard characters?  false

    .EXAMPLE
    Get-TriliumBranch -BranchID "A2PGuqZgT03z_sxhoPPMkVIuO"

    .NOTES
    This function requires that the authentication has been set using Connect-TriliumAuth.
    #>
    param (
        [Parameter(Mandatory = $true)][ValidateNotNullOrEmpty()][string]$BranchID
    )

    process {
        try {
            $TriliumHeaders = @{ }
            $TriliumHeaders.Add('Authorization', "$($TriliumCreds.Authorization)")
            # API call run
            try {
                $uri = "$($TriliumCreds.URL)/branches/$BranchID"
                Invoke-RestMethod -Uri $uri -Headers $TriliumHeaders -SkipHeaderValidation
            } catch {
                $_.Exception.Response
            }
        } catch {
            $_.Exception.Response
        }
    }
    begin {
        if (!$global:TriliumCreds) { Write-Error -Message 'Need to run: Connect-TriliumAuth';exit }

    }
    end {
        return
    }
}

function Remove-TriliumBranch {
    <#
    .SYNOPSIS
    Removes a specific Trilium branch.

    .DESCRIPTION
    This function removes a specific Trilium branch based on the provided branch ID.

    .PARAMETER BranchID
    The branch ID to remove.

        Required?                    true
        Position?                    0
        Default value                None
        Accept pipeline input?       false
        Accept wildcard characters?  false

    .EXAMPLE
    Remove-TriliumBranch -BranchID "A2PGuqZgT03z_sxhoPPMkVIuO"

    .NOTES
    This function requires that the authentication has been set using Connect-TriliumAuth.
    #>
    [CmdletBinding(SupportsShouldProcess = $true)]
    param (
        [Parameter(Mandatory = $true)][ValidateNotNullOrEmpty()][string]$BranchID
    )

    process {
        try {
            $TriliumHeaders = @{ }
            $TriliumHeaders.Add('Authorization', "$($TriliumCreds.Authorization)")
            # API call run
            try {
                $uri = "$($TriliumCreds.URL)/branches/$BranchID"
                if ($PSCmdlet.ShouldProcess($uri, 'Removing branch')) {
                    Invoke-RestMethod -Uri $uri -Headers $TriliumHeaders -SkipHeaderValidation -Method Delete
                }
            } catch {
                $_.Exception.Response
            }
        } catch {
            $_.Exception.Response
        }
    }
    begin {
        if (!$global:TriliumCreds) { Write-Error -Message 'Need to run: Connect-TriliumAuth';exit }

    }
    end {
        return
    }
}

function New-TriliumBackup {
    <#
    .SYNOPSIS
    Creates a new backup for a specific Trilium instance.

    .DESCRIPTION
    This function creates a new backup for a specific Trilium instance based on the provided backup ID.

    .PARAMETER BackupID
    The backup ID to create a new backup for.

        Required?                    true
        Position?                    0
        Default value                None
        Accept pipeline input?       false
        Accept wildcard characters?  false

    .EXAMPLE
    New-TriliumBackup -BackupID "MyBackup"

    .NOTES
    This function requires that the authentication has been set using Connect-TriliumAuth.
    #>
    [CmdletBinding(SupportsShouldProcess = $true)]
    param (
        [Parameter(Mandatory = $true)][ValidateNotNullOrEmpty()][string]$BackupID
    )

    process {
        try {
            $TriliumHeaders = @{ }
            $TriliumHeaders.Add('Authorization', "$($TriliumCreds.Authorization)")
            # API call run
            try {
                $uri = "$($TriliumCreds.URL)/backup/$BackupID"
                if ($PSCmdlet.ShouldProcess($uri, 'Create backup')) {
                    Invoke-RestMethod -Uri $uri -Headers $TriliumHeaders -Method Put -SkipHeaderValidation
                }
            } catch {
                $_.Exception.Response
            }
        } catch {
            $_.Exception.Response
        }
    }
    begin {
        if (!$global:TriliumCreds) { Write-Error -Message 'Need to run: Connect-TriliumAuth';exit }

    }
    end {
        return
    }
}

function Get-TriliumAttribute {
    <#
    .SYNOPSIS
    Gets details of a specific Trilium attribute.

    .DESCRIPTION
    This function retrieves the details of a specific Trilium attribute based on the provided attribute ID.

    .PARAMETER AttributeID
    The attribute ID to get details for.

        Required?                    true
        Position?                    0
        Default value                None
        Accept pipeline input?       false
        Accept wildcard characters?  false

    .EXAMPLE
    Get-TriliumAttribute -AttributeID "12345"

    .NOTES
    This function requires that the authentication has been set using Connect-TriliumAuth.
    #>
    [CmdletBinding(SupportsShouldProcess = $true)]
    param (
        [Parameter(Mandatory = $true)]
        [ValidateNotNullOrEmpty()]
        [string]$AttributeID
    )

    process {
        try {
            $TriliumHeaders = @{ }
            $TriliumHeaders.Add('Authorization', "$($TriliumCreds.Authorization)")
            $uri = "$($TriliumCreds.URL)/attributes/$AttributeID"
            if ($PSCmdlet.ShouldProcess($uri, 'Update note order')) {
                Invoke-RestMethod -Uri $uri -Headers $TriliumHeaders -SkipHeaderValidation
            }
        } catch {
            $_.Exception.Response
        }
    }

    begin {
        if (!$global:TriliumCreds) { Write-Error -Message 'Need to run: Connect-TriliumAuth';exit }
    }

    end {
        return
    }
}

function Remove-TriliumAttribute {
    <#
    .SYNOPSIS
    Removes a specific Trilium attribute.

    .DESCRIPTION
    This function removes a specific Trilium attribute based on the provided attribute ID.

    .PARAMETER AttributeID
    The attribute ID to remove.

        Required?                    true
        Position?                    0
        Default value                None
        Accept pipeline input?       false
        Accept wildcard characters?  false

    .EXAMPLE
    Remove-TriliumAttribute -AttributeID "12345"

    .NOTES
    This function requires that the authentication has been set using Connect-TriliumAuth.
    #>
    [CmdletBinding(SupportsShouldProcess = $true)]
    [Alias('Delete-TriliumAttribute', 'dta', 'rta')]
    param (
        [Parameter(Mandatory = $true)]
        [ValidateNotNullOrEmpty()]
        [string]$AttributeID
    )

    process {
        try {
            $TriliumHeaders = @{ }
            $TriliumHeaders.Add('Authorization', "$($TriliumCreds.Authorization)")
            $uri = "$($TriliumCreds.URL)/attributes/$AttributeID"
            if ($PSCmdlet.ShouldProcess($uri, 'Remove attribute')) {
                Invoke-RestMethod -Uri $uri -Headers $TriliumHeaders -SkipHeaderValidation -Method Delete
            }
        } catch {
            $_.Exception.Response
        }
    }

    begin {
        if (!$global:TriliumCreds) { Write-Error -Message 'Need to run: Connect-TriliumAuth';exit }
    }

    end {
        return
    }
}

function Update-TriliumNoteOrder {
    <#
    .SYNOPSIS
    Updates the order of notes under a specific parent note.

    .DESCRIPTION
    This function updates the order of notes under a specific parent note based on the provided parent note ID.

    .PARAMETER ParentNoteId
    The parent note ID to update the order for.

        Required?                    true
        Position?                    0
        Default value                None
        Accept pipeline input?       false
        Accept wildcard characters?  false

    .EXAMPLE
    Update-TriliumNoteOrder -ParentNoteId "root"

    .NOTES
    This function requires that the authentication has been set using Connect-TriliumAuth.
    #>
    [CmdletBinding(SupportsShouldProcess = $true)]
    [Alias('utno')]
    param (
        [Parameter(Mandatory = $true)]
        [ValidateNotNullOrEmpty()]
        [string]$ParentNoteId
    )

    process {
        try {
            $TriliumHeaders = @{ }
            $TriliumHeaders.Add('Authorization', "$($TriliumCreds.Authorization)")
            $uri = "$($TriliumCreds.URL)/refresh-note-ordering/$ParentNoteId"
            if ($PSCmdlet.ShouldProcess($uri, 'Update note order')) {
                Invoke-RestMethod -Uri $uri -Headers $TriliumHeaders -SkipHeaderValidation -Method Post
            }
        } catch {
            $_.Exception.Response
        }
    }

    begin {
        if (!$global:TriliumCreds) { Write-Error -Message 'Need to run: Connect-TriliumAuth';exit }
    }

    end {
        return
    }
}