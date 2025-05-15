# Dot source all public functions
Get-ChildItem -Path "$PSScriptRoot\Public\*.ps1" -Recurse | ForEach-Object {
    . $_.FullName
}

# Dot source all private/internal functions
Get-ChildItem -Path "$PSScriptRoot\Private\*.ps1" -Recurse | ForEach-Object {
    . $_.FullName
    Export-ModuleMember -Function $_.BaseName
}