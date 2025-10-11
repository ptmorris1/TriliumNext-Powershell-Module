function New-TriliumNote {
    <#
    .SYNOPSIS
        Creates a new note in Trilium Notes.

    .DESCRIPTION
        Creates a new note in Trilium Notes with the specified content, title, type, and formatting options. Supports a wide range of note types, including text, markdown, code, and special types like book, canvas, mermaid, and more. When using `-Markdown`, the function converts markdown to HTML before sending to Trilium, with optional MathJax support via `-Math`. HTML content is beautified before sending. Requires authentication via `Connect-TriliumAuth`.

    .PARAMETER ParentNoteId
        The ID of the parent note under which the new note will be created. Defaults to 'root'.
        Use `Get-TriliumNotes` to find IDs of existing notes.

        Required?                    false
        Position?                    0
        Default value                'root'
        Accept pipeline input?       false
        Accept wildcard characters?  false

    .PARAMETER Title
        The title of the new note. Displayed in the Trilium Notes UI.

        Required?                    false
        Position?                    1
        Default value                None
        Accept pipeline input?       false
        Accept wildcard characters?  false

    .PARAMETER Content
        The content of the new note. This is required.
        For code notes, provide the code as plain text. For markdown notes, provide markdown-formatted text.

        Required?                    true
        Position?                    2
        Default value                None
        Accept pipeline input?       false
        Accept wildcard characters?  false

    .PARAMETER NoteType
        The type of note to create. Tab completion is available for common types.
        Supported values:
        image, file, text, book, canvas, mermaid, geoMap, mindMap, relationMap, renderNote, webview, PlainText, CSS, html, http, JSbackend, JSfrontend, json, markdown, powershell, python, ruby, shellBash, sql, sqliteTrilium, xml, yaml
        See Trilium documentation for more details.

        Required?                    false
        Position?                    3
        Default value                None
        Accept pipeline input?       false
        Accept wildcard characters?  false

    .PARAMETER Mime
        The MIME type of the note content. If not specified, it will be determined based on NoteType. Only specify this if you need to override the default MIME type.

        Required?                    false
        Position?                    4
        Default value                None
        Accept pipeline input?       false
        Accept wildcard characters?  false

    .PARAMETER SkipCertCheck
        If specified, certificate validation will be skipped when connecting to Trilium (useful for self-signed certificates).

        Required?                    false
        Position?                    named
        Default value                false
        Accept pipeline input?       false
        Accept wildcard characters?  false

    .PARAMETER Markdown
        If specified, the Content will be treated as markdown and converted to HTML. When this parameter is used, NoteType must be 'text' or not specified. Enables advanced markdown rendering including tables, task lists, and code blocks.

        Required?                    false
        Position?                    named
        Default value                false
        Accept pipeline input?       false
        Accept wildcard characters?  false

    .PARAMETER Math
        If specified, adds support for mathematical expressions in markdown using MathJax. Only used with the -Markdown parameter. Math expressions can be included inline using $expression$ syntax or as blocks with $$ syntax.

        Required?                    false
        Position?                    named
        Default value                false
        Accept pipeline input?       false
        Accept wildcard characters?  false

    .INPUTS
        None. You cannot pipe objects to New-TriliumNote.

    .OUTPUTS
        System.Management.Automation.PSCustomObject
        Returns the API response from Trilium, including information about the created note.

    .EXAMPLE
        PS> New-TriliumNote -Title "My Note" -Content "This is the content of my note"
        Creates a new text note with the specified title and content under the root.

    .EXAMPLE
        New-TriliumNote -Title "Code Sample" -Content "Get-Process" -NoteType "powershell"
        Creates a new PowerShell code note with syntax highlighting.

    .EXAMPLE
        New-TriliumNote -Title "Markdown Note" -Content "# Header`n`nThis is *markdown* content" -Markdown
        Creates a new note by converting the markdown content to HTML.

    .EXAMPLE
        New-TriliumNote -Title "Math Example" -Content "When $a \ne 0$, there are two solutions to $ax^2 + bx + c = 0$" -Markdown -Math
        Creates a note with markdown content that includes mathematical expressions.

    .EXAMPLE
        $parentId = (Get-TriliumNotes -Title "My Folder").noteId
        New-TriliumNote -ParentNoteId $parentId -Title "Nested Note" -Content "This is a nested note"
        Creates a new note inside an existing note folder by specifying its ID.

    .LINK
        Online version: https://github.com/ptmorris1/TriliumNext-Powershell-Module
    .LINK
        Connect-TriliumAuth
    .LINK
        Get-TriliumNotes

    .NOTES
        Requires authentication via Connect-TriliumAuth before use.
        Author: P. Morris
        Module: TriliumNext-Powershell-Module
    #>
    [CmdletBinding(SupportsShouldProcess = $true)]
    param (
        [Parameter()] [string]$ParentNoteId = 'root',
        [Parameter()] [string]$Title,
        [Parameter(Mandatory = $true)] [string]$Content,
        [Parameter()]
        [ArgumentCompleter({
            param($commandName, $parameterName, $wordToComplete, $commandAst, $fakeBoundParameters)
            $noteTypes = @('image','file','text','book','canvas','mermaid','geoMap','mindMap','relationMap','renderNote','webview',
            'PlainText','CSS','html','http','JSbackend','JSfrontend','json','markdown','powershell','python','ruby','shellBash','sql','sqliteTrilium','xml','yaml')
            
            return $noteTypes | Where-Object { $_ -like "$wordToComplete*" }
        })]
        [string]$NoteType,
        [Parameter()] [string]$Mime,
        [Parameter()] [switch]$SkipCertCheck,
        [Parameter()] [switch]$Markdown,
        [Parameter()] [switch]$Math
    )
    
    begin {
        if (!$global:TriliumCreds) { Write-Error -Message 'Need to run: Connect-TriliumAuth'; exit }
        
        # Load the MimeTypeMap JSON directly
        $moduleRoot = $MyInvocation.MyCommand.Module.ModuleBase
        $mimeTypeMapPath = Join-Path -Path $moduleRoot -ChildPath 'data\MimeTypeMap.json'
        
        if (Test-Path -Path $mimeTypeMapPath) {
            $mimeTypeMap = Get-Content -Path $mimeTypeMapPath -Raw | ConvertFrom-Json
        } else {
            Write-Error "MimeTypeMap.json not found at path: $mimeTypeMapPath"
            exit
        }

        if ($Markdown) {
            if ($NoteType -and $NoteType -ne 'text') {
                Write-Error -Message 'If -Markdown is specified, -NoteType must be "text".'
                exit
            }
            $NoteType = 'text'
            $moduleRoot = $MyInvocation.MyCommand.Module.ModuleBase
            $dllPath = Join-Path -Path $moduleRoot -ChildPath 'lib\Markdig.dll'
            if (-not ([AppDomain]::CurrentDomain.GetAssemblies() | Where-Object { $_.Location -eq (Resolve-Path $dllPath) })) {
                Add-Type -Path $dllPath
            }
            
            $builder = [Markdig.MarkdownPipelineBuilder]::new()
            [Markdig.MarkdownExtensions]::UseAdvancedExtensions($builder) | Out-Null
            if ($Math) {
                [Markdig.MarkdownExtensions]::UseMathematics($builder) | Out-Null
            }
            $pipeline = $builder.Build()
            $html = [Markdig.Markdown]::ToHtml($Content, $pipeline)
            if ($Math) {
                $html = $html.Replace('<span class="math"', '<span class="math-tex"')
                $html = $html.Replace('<div class="math"', '<span class="math-tex"')
            }
            
            # Format code blocks with proper mime types using our unified mapping
            $html = [regex]::Replace($html, '(?i)<pre><code class="language-([a-z0-9+\-]+)">', {
                param($match)
                $lang = $match.Groups[1].Value.ToLower()
                $mimeType = ($mimeTypeMap | Where-Object { $_.Note -eq $lang })?.Mime
                if ($mimeType) {
                    # Use the found mime type from our mapping
                    $formattedMime = $mimeType.Replace('/', '-')
                } elseif ($lang -match '^(html|xml|json|markdown|sql|text|plaintext)$') {
                    $formattedMime = "text-$lang"
                } elseif ($lang -match '^(c|cpp|csharp|java|go|sh|bash|powershell)$') {
                    $formattedMime = "text-x-$lang"
                } else {
                    $formattedMime = "application-x-$lang"
                }
                
                "<pre><code class=`"language-$formattedMime`">"
            })
            
            $Content = $html
            # Beautify the HTML content before sending to Trilium
            $Content = Format-TriliumHtml -Content $Content
        }
    }
    process {
        try {
            if ($SkipCertCheck) {
                $PSDefaultParameterValues = @{'Invoke-RestMethod:SkipCertificateCheck' = $true }
            }
            
            $TriliumHeaders = @{ Authorization = "$($TriliumCreds.Authorization)" }
            $uri = "$($TriliumCreds.URL)/create-note"

            $body = @{ parentNoteId = $ParentNoteId }
            if ($Title) { $body.title = $Title }
            if ($Content) { $body.content = $Content }
            if ($Mime) { $body.mime = $Mime }
            
            if ($NoteType) {
                $mimeObj = $mimeTypeMap | Where-Object { $_.Note -eq $NoteType }
                if ($mimeObj) {
                    $body.type = $mimeObj.Type
                    if ($null -ne $mimeObj.Mime -and -not $Mime) {
                        $body.mime = $mimeObj.Mime
                    }
                } else {
                    $body.type = $NoteType
                }
            } elseif (-not $body.ContainsKey('type')) {
                $body.type = 'text'
                if (-not $body.ContainsKey('mime')) { $body.mime = 'text/html' }
            }

            $json = $body | ConvertTo-Json -Depth 5
            if ($PSCmdlet.ShouldProcess($uri, 'Create new note')) {
                Invoke-RestMethod -Uri $uri -Headers $TriliumHeaders -SkipHeaderValidation -ContentType 'application/json' -Body $json -Method Post
            }
        } catch {
            $_.Exception.Response
        }
    }
    end { return }
}