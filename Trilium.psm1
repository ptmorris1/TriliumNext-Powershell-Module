# Dot source all public functions
Get-ChildItem -Path "$PSScriptRoot\public\*.ps1" -Recurse | ForEach-Object {
    . $_.FullName
}

# Dot source all private/internal functions
Get-ChildItem -Path "$PSScriptRoot\private\*.ps1" -Recurse | ForEach-Object {
    . $_.FullName
    Export-ModuleMember -Function $_.BaseName
}