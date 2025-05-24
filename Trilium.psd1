@{
    ModuleVersion   = '0.6.0'
    Guid            = '5d0452a3-0c40-4681-b12c-070eccc905dc'
    CompanyName     = 'Patrick Morris '
    Copyright       = '2024-25 Patrick Morris'
    Author          = 'Patrick Morris'
    AliasesToExport = '*'
    RootModule      = 'Trilium.psm1'
    Description     = 'Powershell wrapper for the TriliumNext API'
    PrivateData     = @{
        PSData = @{
            Tags         = 'Windows', 'TriliumNext', 'PowerShell', 'PSEdition_Core', 'Trilium'
            ProjectURI   = 'https://github.com/ptmorris1/TriliumNext-Powershell-Module'
            LicenseURI   = 'https://github.com/ptmorris1/TriliumNext-Powershell-Module/blob/main/LICENSE'            
            ReleaseNotes = @'
# 📅 Changelog

All notable changes to the **TriliumNext-Powershell-Module** will be documented in this file.

---

## [0.6.0] - 2025-05-24

### Added

* Added function `Get-TriliumAttachment` - GET /attachments/{attachmentId}
* Added function `Get-TriliumAttachmentContent` - GET /attachments/{attachmentId}/content

---

## [0.5.0] - 

### Fixed

* Fixed `Export-TriliumNote`.

### Added

* Added Markdown option to `Export-TriliumNote`. Default is HTML.

### Updated

* Updated and improved some documentation.
* Split out functions into their own .ps1 file.

---

## [0.4.0] - 

### Improved

* Improved `Connect-TriliumAuth` to use PSCredential object.
  * See documentation for new usage.

---

## [0.3.0] - 

### Added

* Added check for `/` at the end of base URL.
* Added `-SkipCertCheck` switch to ALL functions.

### Updated

* Updated `Connect-TriliumAuth` to use `-SkipCertCheck` switch.

---

## [0.2.0] - 

### Fixed

* Fixed parameter sets in `Find-TriliumNote`.
  * `orderBy` and `Limit` must be used together.

### Updated

* Updated/added some documentation.

---

## [0.1.0] - 

### Initial Release

* Initial release of TriliumNext-Powershell-Module.
  * A command for almost every documented TriliumNext API.

---

> 📌 This changelog follows [Keep a Changelog](https://keepachangelog.com/en/1.0.0/) principles.
'@
        }
    }
}
