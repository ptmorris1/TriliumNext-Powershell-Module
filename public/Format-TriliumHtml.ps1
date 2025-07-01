function Format-TriliumHtml {
    <#
    .SYNOPSIS
        Formats and beautifies HTML content for Trilium Notes.

    .DESCRIPTION
        This function formats and beautifies HTML content before sending to Trilium Notes.
        It fixes spacing issues, improves header formatting, and cleans up HTML structure
        to ensure proper display in Trilium Notes.
        
        The function performs several improvements to the HTML:
        - Fixes redundant empty paragraph tags before headings
        - Adds proper spacing between code blocks and headings
        - Ensures consistent new lines before headings
        - Fixes spacing issues with images and code blocks
        - Removes redundant empty lines and excessive whitespace
        - Improves overall HTML structure for better rendering in Trilium

    .PARAMETER Content
        The HTML content to beautify.
        
        Required?                    true
        Position?                    0
        Default value                None
        Accept pipeline input?       false
        Accept wildcard characters?  false

    .INPUTS
        None. You cannot pipe objects to Format-TriliumHtml.

    .OUTPUTS
        System.String. Format-TriliumHtml returns a string with the beautified HTML content.

    .EXAMPLE
        PS> $html = Format-TriliumHtml -Content "<h2>Header</h2><p>Text</p>"
        
        Beautifies the HTML by adding proper spacing and formatting.

    .EXAMPLE
        PS> $markdownHtml = [Markdig.Markdown]::ToHtml($markdown)
        PS> $beautifiedHtml = Format-TriliumHtml -Content $markdownHtml
        
        Processes HTML generated from markdown to ensure proper formatting in Trilium Notes.    .EXAMPLE
        PS> $html = "<pre><code>Get-Process</code></pre><h2>Results</h2>"
        PS> Format-TriliumHtml -Content $html
        
        Adds proper spacing between the code block and the heading.

    .EXAMPLE
        # Example of retrieving note content, beautifying it, and updating the note
        $noteId = "abc123def456"
        $originalContent = Get-TriliumNoteContent -NoteID $noteId
        $beautifiedContent = Format-TriliumHtml -Content $originalContent
        Set-TriliumNoteContent -NoteID $noteId -NoteContent $beautifiedContent
        
        This example shows a complete workflow: retrieving a note's content with Get-TriliumNoteContent,
        beautifying the HTML with Format-TriliumHtml, and then saving the improved content back
        to the note with Set-TriliumNoteContent.

    .NOTES
        Name: Format-TriliumHtml
        Author: Patrick Morris
        Module: Trilium
        This function is used internally by New-TriliumNote to format HTML content.

    .LINK
        Online version: https://github.com/ptmorris1/TriliumNext-Powershell-Module

    .LINK
        New-TriliumNote
    #>
    [CmdletBinding()]
    param (
        [Parameter(Mandatory = $true)]
        [string]$Content
    )
    
    # Unescape HTML entities (similar to Python's html.unescape)
    $Content = [System.Net.WebUtility]::HtmlDecode($Content)
    
    # Fix redundant empty <p> tags
    for ($headingLevel = 2; $headingLevel -le 5; $headingLevel++) {
        # Replace patterns of empty <p> tags before headings
        $Content = $Content.Replace("<p> </p><p></p><h$headingLevel>", "<h$headingLevel>")
        $Content = $Content.Replace("<p> </p><h$headingLevel>", "<h$headingLevel>")
        $Content = $Content.Replace("<p> <h$headingLevel>", "<h$headingLevel>")
    }
    
    # First ensure all headers have proper spacing after code blocks
    $Content = [regex]::Replace($Content, '(<\/pre>)(<h[2-5])', '$1<p></p>$2')
    
    # Add a new line before headings (all variations with ID attribute)
    for ($headingLevel = 2; $headingLevel -le 5; $headingLevel++) {
        # For headers with ID attribute
        $pattern = "<h$headingLevel id="".*?"">"
        $matchResults = [regex]::Matches($Content, $pattern)
        
        # Process matches in reverse to avoid position shifting
        for ($i = $matchResults.Count - 1; $i -ge 0; $i--) {
            $pos = $matchResults[$i].Index
            $key1 = '<p>&nbsp;</p>'
            $backPos1 = $pos - $key1.Length
            $key2 = '<p></p>'
            $backPos2 = $pos - $key2.Length
            
            # If no unnecessary empty <p> tag exists before the heading, insert <p></p>
            if (-not (
                ($backPos1 -ge 0 -and $Content.Substring($backPos1, $key1.Length) -eq $key1) -or
                ($backPos2 -ge 0 -and $Content.Substring($backPos2, $key2.Length) -eq $key2)
            )) {
                $Content = $Content.Substring(0, $pos) + '<p></p>' + $Content.Substring($pos)
            }
        }
        
        # For simple headers without ID
        $pattern = "<h$headingLevel>"
        $matchResults = [regex]::Matches($Content, [regex]::Escape($pattern))
        
        # Process matches in reverse to avoid position shifting
        for ($i = $matchResults.Count - 1; $i -ge 0; $i--) {
            $pos = $matchResults[$i].Index
            $key1 = '<p>&nbsp;</p>'
            $backPos1 = $pos - $key1.Length
            $key2 = '<p></p>'
            $backPos2 = $pos - $key2.Length
            
            # If no unnecessary empty <p> tag exists before the heading, insert <p></p>
            if (-not (
                ($backPos1 -ge 0 -and $Content.Substring($backPos1, $key1.Length) -eq $key1) -or
                ($backPos2 -ge 0 -and $Content.Substring($backPos2, $key2.Length) -eq $key2)
            )) {
                $Content = $Content.Substring(0, $pos) + '<p></p>' + $Content.Substring($pos)
            }
        }
    }
    
    # Remove redundant new line in code block
    $Content = $Content.Replace("`n</code></pre>", "</code></pre>")
    
    # Add new line to image
    $Content = $Content.Replace(" <img", "</p><p><img")
    
    # Remove redundant empty lines
    $Content = $Content.Replace("<p> </p><p>&nbsp;</p>", "<p>&nbsp;</p>")
    $Content = $Content.Replace("<p>&nbsp;</p><p>&nbsp;</p>", "<p>&nbsp;</p>")
    
    # Remove redundant beginning
    $Content = [regex]::Replace($Content, "^<p></p><h2>", "<h2>")
    $Content = [regex]::Replace($Content, "^<div><div><p></p><h2>", "<h2>")
    
    # Fix spacing issues around code blocks
    $Content = [regex]::Replace($Content, '<pre>\s*<code', '<pre><code')
    
    # Ensure proper spacing between code blocks and headers
    $Content = [regex]::Replace($Content, '(</pre>)(<h[2-5])', '$1<p></p>$2')
    
    # Clean up excessive newlines and indentation in generated HTML
    $Content = [regex]::Replace($Content, '>\s+<', '><')
    $Content = [regex]::Replace($Content, '<h([2-5]) id="([^"]+)">\s*([^<]+)\s*</h\1>', '<h$1 id="$2">$3</h$1>')
    $Content = [regex]::Replace($Content, '<h([2-5])>\s*([^<]+)\s*</h\1>', '<h$1>$2</h$1>')
    
    # Fix any remaining spacing issues in headers
    $Content = [regex]::Replace($Content, '<h([2-5]) id="([^"]+)">\n?\s*([^<]+)\n?\s*</h\1>', '<h$1 id="$2">$3</h$1>')
    
    return $Content
}