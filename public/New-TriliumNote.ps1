function New-TriliumNote {
    <#
    .SYNOPSIS
    Creates a new Trilium note.

    .DESCRIPTION
    Creates a new Trilium note under the specified parent note ID (defaults to 'root') with the provided content. You must provide content for the note. Optionally, you can specify a title and note type. If -NoteType is not specified, the note will default to type 'text' and mime 'text/html'.

    .PARAMETER ParentNoteId
    The parent note ID to create the new note under. If not specified, the note will be created under the root note. Default is 'root'.

        Required?                    false
        Position?                    0
        Default value                'root'
        Accept pipeline input?       false
        Accept wildcard characters?  false

    .PARAMETER Title
    The title of the new note. Optional. If not specified, the note will be created without a title.

        Required?                    false
        Position?                    1
        Default value                None
        Accept pipeline input?       false
        Accept wildcard characters?  false

    .PARAMETER Content
    The content of the new note. This parameter is required. The note will not be created without content.

        Required?                    true
        Position?                    2
        Default value                None
        Accept pipeline input?       false
        Accept wildcard characters?  false

    .PARAMETER NoteType
    The type of the new note. Optional. Must be one of:
        text, book, canvas, mermaid, geoMap, mindMap, relationMap, renderNote, webview,
        PlainText, CSS, html, http, JSbackend, JSfrontend, json, markdown, powershell, python, ruby, shellBash, sql, sqliteTrilium, xml, yaml
    If not specified, defaults to 'text' with mime 'text/html'.

        Required?                    false
        Position?                    Named
        Default value                None
        Accept pipeline input?       false
        Accept wildcard characters?  false

    .PARAMETER SkipCertCheck
    Option to skip certificate check. Optional. Use this if you are connecting to a Trilium server with a self-signed certificate.

        Required?                    false
        Position?                    Named
        Default value                None
        Accept pipeline input?       false
        Accept wildcard characters?  false

    .PARAMETER Markdown
    Option to convert markdown content to HTML. Optional. Use this if you want to convert the content from markdown to HTML before creating the note. Only applicable if -NoteType is 'text'. If -Markdown is specified, -NoteType must be 'text'.

        Required?                    false
        Position?                    Named
        Default value                None
        Accept pipeline input?       false
        Accept wildcard characters?  false

    .PARAMETER NoMath
    Option to disable math extension for markdown content. Optional. By default, math extension is enabled for inline and block LaTeX math rendering. Only applicable if -Markdown and -NoteType is 'text'.

        Required?                    false
        Position?                    Named
        Default value                None
        Accept pipeline input?       false
        Accept wildcard characters?  false

    .EXAMPLE
    New-TriliumNote -Content "This is a new note."
    Creates a new note under the root with the specified content and default type 'text' and mime 'text/html'.

    .EXAMPLE
    New-TriliumNote -Title "My Note" -Content "This is a new note." -NoteType markdown
    Creates a new note under the root with the specified title, content, and type 'code' with mime 'text/x-markdown'.

    .EXAMPLE
    New-TriliumNote -ParentNoteId "abcdef123456" -Title "Child Note" -Content "Child note content."
    Creates a new note under the specified parent note with the given title and content, using default type 'text' and mime 'text/html'.

    .EXAMPLE
    New-TriliumNote -Content "Geo data" -NoteType geoMap
    Creates a new note under the root with the specified content and type 'geoMap' with mime 'application/json'.

    .NOTES
    This function requires that authentication has been set using Connect-TriliumAuth.
    The -Content parameter is always required. All other parameters are optional.
    If -NoteType is not specified, the note will be created as a standard text note (type 'text', mime 'text/html').
    If -ParentNoteId is not specified, the note will be created under the root note.
    If -Title is not specified, the note will be created without a title.

    .LINK
    https://github.com/ptmorris1/TriliumNext-Powershell-Module
    #>
    [CmdletBinding(SupportsShouldProcess = $true)]
    param (
        # Parent note ID to create the new note under
        [Parameter()]
        [string]$ParentNoteId = 'root',

        # Title of the new note
        [Parameter()]
        [string]$Title,

        # Content of the new note
        [Parameter(Mandatory = $true)]
        [string]$Content,
        
        # Optional note type
        [Parameter()]
        [ValidateSet('file','text','book','canvas','mermaid','geoMap','mindMap','relationMap','renderNote','webview',
            'PlainText','CSS','html','http','JSbackend','JSfrontend','json','markdown','powershell','python','ruby','shellBash','sql','sqliteTrilium','xml','yaml')]
        [string]$NoteType,
        [Parameter()]
        [switch]$SkipCertCheck,
        [Parameter()]
        [switch]$Markdown,
        [Parameter()]
        [switch]$NoMath
    )
    begin {
        if (!$global:TriliumCreds) { Write-Error -Message 'Need to run: Connect-TriliumAuth'; exit }
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
            if (-not $NoMath) {
                # Enable the math extension (inline and block LaTeX)
                [Markdig.MarkdownExtensions]::UseMathematics($builder) | Out-Null
            }
            $pipeline = $builder.Build()
            $Content = [Markdig.Markdown]::ToHtml($Content, $pipeline)
            if (-not $NoMath) {
                $Content = $Content.Replace('<span class="math"','<span class="math-tex"')
                $Content = $Content.Replace('<div class="math"','<span class="math-tex"')
            }
            # Patch code block classes to MIME-style if needed
            # ~50 common languages and their MIME-style class equivalents
            $LanguageToMimeMap = @{
                "powershell"   = "application-x-powershell"
                "bash"         = "application-x-sh"
                "shell"        = "application-x-sh"
                "zsh"          = "application-x-zsh"
                "sh"           = "application-x-sh"
                "python"       = "text-x-python"
                "javascript"   = "application-x-javascript"
                "typescript"   = "application-x-typescript"
                "java"         = "text-x-java-source"
                "csharp"       = "text-x-csharp"
                "cs"           = "text-x-csharp"
                "cpp"          = "text-x-c++src"
                "c"            = "text-x-csrc"
                "go"           = "text-x-go"
                "rust"         = "text-x-rustsrc"
                "ruby"         = "application-x-ruby"
                "perl"         = "application-x-perl"
                "php"          = "application-x-php"
                "html"         = "text-html"
                "xml"          = "application-xml"
                "json"         = "application-json"
                "yaml"         = "application-x-yaml"
                "toml"         = "application-toml"
                "markdown"     = "text-x-markdown"
                "sql"          = "application-sql"
                "dockerfile"   = "text-x-dockerfile"
                "makefile"     = "text-x-makefile"
                "ini"          = "text-x-ini"
                "config"       = "text-x-config"
                "kotlin"       = "text-x-kotlin"
                "swift"        = "application-x-swift"
                "r"            = "text-x-r"
                "scala"        = "text-x-scala"
                "groovy"       = "application-x-groovy"
                "vbnet"        = "text-x-vbnet"
                "dart"         = "application-x-dart"
                "haskell"      = "text-x-haskell"
                "elixir"       = "application-x-elixir"
                "clojure"      = "application-x-clojure"
                "lua"          = "text-x-lua"
                "matlab"       = "application-x-matlab"
                "fortran"      = "text-x-fortran"
                "assembly"     = "text-x-asm"
                "asm"          = "text-x-asm"
                "latex"        = "application-x-latex"
                "plaintext"    = "text-plain"
                "text"         = "text-plain"
            }
            # Replace all class="language-xxx" with correct MIME-style
            $Content = $Content -replace 'class="language-([a-z0-9+\-]+)"', {
                param($match)
                $lang = $matches[1]
                if ($LanguageToMimeMap.ContainsKey($lang)) {
                    $mime = $LanguageToMimeMap[$lang]
                } else {
                    if ($lang -match '^(html|xml|json|markdown|sql|text|plaintext)$') {
                        $mime = "text-$lang"
                    } elseif ($lang -match '^(c|cpp|csharp|java|go|sh|bash|powershell)$') {
                        $mime = "text-x-$lang"
                    } else {
                        $mime = "application-x-$lang"
                    }
                }
                'class="language-' + $mime + '"'
            }
        }
    }
    process {
        try {
            if ($SkipCertCheck -eq $true) {
                $PSDefaultParameterValues = @{'Invoke-RestMethod:SkipCertificateCheck' = $true }
            }
            $TriliumHeaders = @{}
            $TriliumHeaders.Add('Authorization', "$($TriliumCreds.Authorization)")
            $uri = "$($TriliumCreds.URL)/create-note"
            $mimeMap = @(
                [PSCustomObject]@{ Note = 'PlainText'; Type = 'code'; Mime = 'text/plain' }
                [PSCustomObject]@{ Note = 'CSS'; Type = 'code'; Mime = 'text/css' }
                [PSCustomObject]@{ Note = 'html'; Type = 'code'; Mime = 'text/html' }
                [PSCustomObject]@{ Note = 'http'; Type = 'code'; Mime = 'message/http' }
                [PSCustomObject]@{ Note = 'JSbackend'; Type = 'code'; Mime = 'application/javascript;env=backend' }
                [PSCustomObject]@{ Note = 'JSfrontend'; Type = 'code'; Mime = 'application/javascript;env=frontend' }
                [PSCustomObject]@{ Note = 'json'; Type = 'code'; Mime = 'application/json' }
                [PSCustomObject]@{ Note = 'markdown'; Type = 'code'; Mime = 'text/x-markdown' }
                [PSCustomObject]@{ Note = 'powershell'; Type = 'code'; Mime = 'application/x-powershell' }
                [PSCustomObject]@{ Note = 'python'; Type = 'code'; Mime = 'text/x-python' }
                [PSCustomObject]@{ Note = 'ruby'; Type = 'code'; Mime = 'text/x-ruby' }
                [PSCustomObject]@{ Note = 'shellBash'; Type = 'code'; Mime = 'text/x-sh' }
                [PSCustomObject]@{ Note = 'sql'; Type = 'code'; Mime = 'text/x-sql' }
                [PSCustomObject]@{ Note = 'sqliteTrilium'; Type = 'code'; Mime = 'text/x-sqlite;schema=trilium' }
                [PSCustomObject]@{ Note = 'xml'; Type = 'code'; Mime = 'text/xml' }
                [PSCustomObject]@{ Note = 'yaml'; Type = 'code'; Mime = 'text/x-yaml' }
                [PSCustomObject]@{ Note = 'text'; Type = 'text'; Mime = 'text/html' }
                [PSCustomObject]@{ Note = 'book'; Type = 'book'; Mime = $null }
                [PSCustomObject]@{ Note = 'canvas'; Type = 'canvas'; Mime = 'application/json' }
                [PSCustomObject]@{ Note = 'mermaid'; Type = 'mermaid'; Mime = 'text/mermaid' }
                [PSCustomObject]@{ Note = 'geoMap'; Type = 'geoMap'; Mime = 'application/json' }
                [PSCustomObject]@{ Note = 'mindMap'; Type = 'mindMap'; Mime = 'application/json' }
                [PSCustomObject]@{ Note = 'relationMap'; Type = 'relationMap'; Mime = 'application/json' }
                [PSCustomObject]@{ Note = 'renderNote'; Type = 'renderNote'; Mime = $null }
                [PSCustomObject]@{ Note = 'webview'; Type = 'webview'; Mime = $null }
            )
            $body = @{
                parentNoteId = $ParentNoteId
            }
            if ($Title) { $body.title = $Title }
            if ($Content) { $body.content = $Content }
            if ($NoteType) {
                $mimeObj = $mimeMap | Where-Object { $_.Note -eq $NoteType }
                if ($mimeObj) {
                    $body.type = $mimeObj.Type
                    if ($null -ne $mimeObj.Mime) {
                        $body.mime = $mimeObj.Mime
                    }
                } else {
                    $body.type = $NoteType
                }
            } elseif (-not $body.ContainsKey('type')) {
                $body.type = 'text'
                $body.mime = 'text/html'
            }
            $body = $body | ConvertTo-Json
            if ($PSCmdlet.ShouldProcess($uri, 'Create new note')) {
                Invoke-RestMethod -Uri $uri -Headers $TriliumHeaders -SkipHeaderValidation -ContentType 'application/json' -Body $body -Method Post
            }
        } catch {
            $_.Exception.Response
        }
    }
    end {
        return
    }
}