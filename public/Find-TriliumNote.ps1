function Find-TriliumNote {
    <#
    .SYNOPSIS
    Searches for TriliumNext notes by title, label, or other criteria.

    .DESCRIPTION
    Searches for notes in TriliumNext using a search term and optional filters such as label, ancestor note, fast search, archived notes, debug mode, result limit, and sort order. Requires authentication via Connect-TriliumAuth.

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

    .PARAMETER OrderBy
    The field to order the search results by.

        Required?                    true
        Position?                    7
        Default value                None
        Accept pipeline input?       false
        Accept wildcard characters?  false

    .PARAMETER SkipCertCheck
    Option to skip certificate check.

        Required?                    false
        Position?                    Named
        Default value                None
        Accept pipeline input?       false
        Accept wildcard characters?  false

    .EXAMPLE
    Find-TriliumNote -Search "meeting notes"
    Searches for notes with the term "meeting notes".

    .EXAMPLE
    Find-TriliumNote -Search "project" -Label "work" -FastSearch -IncludeArchivedNotes
    Searches for notes with the term "project" and label "work", using fast search and including archived notes.

    .EXAMPLE
    Find-TriliumNote -Search "api" -Limit 5 -OrderBy dateCreated
    Searches for notes with the term "api", limits results to 5, and orders by creation date.

    .NOTES
    Requires authentication via Connect-TriliumAuth.

    .LINK
    https://github.com/ptmorris1/TriliumNext-Powershell-Module
    #>
    [CmdletBinding(SupportsShouldProcess = $true)]
    param(
        # Search term
        [Parameter(Mandatory = $true, ParameterSetName = 'default')]
        [Parameter(Mandatory = $true, ParameterSetName = 'Limit')]
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
        [Parameter(Mandatory = $true, ParameterSetName = 'Limit')]
        [ValidateNotNullOrEmpty()]
        [Int64]$Limit,
        [Parameter(Mandatory = $true, ParameterSetName = 'Limit')]
        [ValidateSet('title', 'publicationDate', 'isProtected', 'isArchived', 'dateCreated', 'dateModified', 'utcDateCreated', 'utcDateModified', 'parentCount', 'childrenCount', 'attributeCount', 'labelCount', 'ownedLabelCount', 'relationCount', 'ownedRelationCount', 'relationCountIncludingLinks', 'ownedRelationCountIncludingLinks', 'targetRelationCount', 'targetRelationCountIncludingLinks', 'contentSize', 'contentAndAttachmentsSize', 'contentAndAttachmentsAndRevisionsSize', 'revisionCount')]
        [string]$OrderBy,
        [switch]$SkipCertCheck
    )

    process {
        try {
            if ($SkipCertCheck -eq $true) {
                $PSDefaultParameterValues = @{'Invoke-RestMethod:SkipCertificateCheck' = $true }
            }
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

            if ($PSCmdlet.ShouldProcess($uri, 'Searching')) {
                # Make request to find notes
                Invoke-RestMethod -Uri $uri -Headers $TriliumHeaders -SkipHeaderValidation
            }
        } catch {
            $_.Exception.Response
        }
    }

    begin {
        if (!$global:TriliumCreds) { Write-Error -Message 'Need to run: Connect-TriliumAuth'; exit }
    }

    end {
        return
    }
}