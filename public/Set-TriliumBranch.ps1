function Set-TriliumBranch {
    <#
    .SYNOPSIS
    Patch (update) a TriliumNext branch's prefix or note position by branchId.

    .DESCRIPTION
    This function updates a TriliumNext branch's prefix and/or notePosition using the PATCH /branches/{branchId} endpoint. Only prefix and notePosition can be updated. If you want to update other properties, you need to delete the old branch and create a new one.

    .PARAMETER BranchId
    The ID of the branch to update.

        Required?                    true
        Position?                    0
        Accept pipeline input?       false
        Accept wildcard characters?  false

    .PARAMETER Prefix
    The new prefix to set for the branch.

        Required?                    false
        Position?                    1
        Accept pipeline input?       false
        Accept wildcard characters?  false

    .PARAMETER NotePosition
    The new note position to set for the branch.

        Required?                    false
        Position?                    2
        Accept pipeline input?       false
        Accept wildcard characters?  false

    .EXAMPLE
    Set-TriliumBranch -BranchId "abc123" -Prefix "A" -NotePosition 2

    .NOTES
    This function requires that the authentication has been set using Connect-TriliumAuth.
    #>
    [CmdletBinding()]
    param (
        [Parameter(Mandatory = $true)][ValidateNotNullOrEmpty()][string]$BranchId,
        [Parameter(Mandatory = $false)][string]$Prefix,
        [Parameter(Mandatory = $false)][int]$NotePosition
    )
    begin {
        if (!$global:TriliumCreds) { Write-Error -Message 'Need to run: Connect-TriliumAuth'; exit }
        if (-not $Prefix -and -not $NotePosition) {
            throw 'You must specify at least one of -Prefix or -NotePosition.'
        }
    }
    process {
        try {
            $TriliumHeaders = @{}
            $TriliumHeaders.Add('Authorization', "$($TriliumCreds.Authorization)")
            $uri = "$($TriliumCreds.URL)/branches/$BranchId"
            $jsonBody = @{}
            if ($PSBoundParameters.ContainsKey('Prefix')) { $jsonBody.prefix = [string]$Prefix }
            if ($PSBoundParameters.ContainsKey('NotePosition')) { $jsonBody.notePosition = [int]$NotePosition }
            $jsonBody = $jsonBody | ConvertTo-Json
            Invoke-RestMethod -Uri $uri -Headers $TriliumHeaders -Method Patch -Body $jsonBody -ContentType 'application/json' -SkipHeaderValidation
        } catch {
            $_.Exception.Response
        }
    }
    end {
        return
    }
}