@{
    ModuleVersion   = '0.2.0'
    Guid            = '5d0452a3-0c40-4681-b12c-070eccc905dc'
    CompanyName     = 'Patrick Morris '
    Copyright       = '2024 Patrick Morris'
    Author          = 'Patrick Morris'
    AliasesToExport = '*'
    RootModule      = 'Trilium.psm1'
    Description     = 'Powershell wrapper for the TriliumNext API'
    #FormatsToProcess = 'PSSVG.format.ps1xml'
    PrivateData     = @{
        PSData = @{
            Tags         = 'Windows', 'TriliumNext', 'PowerShell', 'PSEdition_Core', 'Trilium'
            ProjectURI   = 'https://github.com/ptmorris1/TriliumNext-Powershell-Module'
            LicenseURI   = 'https://github.com/ptmorris1/TriliumNext-Powershell-Module/blob/main/LICENSE'            
            ReleaseNotes = @'
### Trilium 0.1.0
* Initial Release of Trilium, including:
  * A command for almost every documented TriliumNext API.
---
## Trilium 0.2.0
* Fixed paramter sets in Find-TriliumNote
  * orderBy and Limit must be used together.
* Updated\added some documentation.
---

'@
        }
    }
}
