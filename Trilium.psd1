@{
    ModuleVersion   = '0.11.0'
    Guid            = '5d0452a3-0c40-4681-b12c-070eccc905dc'
    CompanyName     = 'Patrick Morris '
    Copyright       = '2024-25 Patrick Morris'
    Author          = 'Patrick Morris'
    AliasesToExport = '*'
    RootModule      = 'Trilium.psm1'
    Description     = 'Powershell wrapper for the TriliumNext API'
    FileList             = @('Trilium.psm1', 'Trilium.psd1', 'lib\Markdig.dll', 'lib\Markdig.xml', 'THIRD-PARTY-NOTICES.txt')
    PowerShellVersion    = '7.5'
    CompatiblePSEditions = @('Core')
    RequiredAssemblies   = @('.\lib\Markdig.dll')
    PrivateData     = @{
        PSData = @{
            Tags         = 'Windows', 'TriliumNext', 'PowerShell', 'PSEdition_Core', 'Trilium'
            ProjectURI   = 'https://github.com/ptmorris1/TriliumNext-Powershell-Module'
            LicenseURI   = 'https://github.com/ptmorris1/TriliumNext-Powershell-Module/blob/main/LICENSE'            
            ReleaseNotes = @'
# 📅 Changelog

All notable changes to the **TriliumNext-Powershell-Module** will be documented in this file.

---

## [0.11.0] - 2025-06-13

### Added

* Added function `Get-TriliumNoteAttachment` - Retrieves attachments for a specific note. (Undocumented API)
* Added `New-TriliumNoteFile` - The File note type can be used to attach various external files such as images, videos or PDF documents.

### Changed

* Changed ETAPI authentication header to use 'Bearer' in `Connect-TriliumAuth`.

### Fixed

* Fixed code block rendering when using `-Markdown` with `New-TriliumNote`.

### Removed

* Removed function `Get-TriliumAttachmentID`, replaced with `Get-TriliumNoteAttachment`

---

## [0.10.0] - 2025-06-11

### Added

* Added markdig library (v0.41.2) for Markdown to HTML conversion.
* Added parameter `-Markdown` to `New-TriliumNote` to convert markdown content to HTML for rendering in text notes.
* Added function `Get-TriliumAttachmentID` - Parses all attachment IDs from a note's contents (no direct API equivalent).
* Added parameter `-Math` (used with `-Markdown`) to convert math markdown for rendering.
* Added function `Create-TriliumAttribute`.
* Added type `file` to `New-TriliumNote`  for file type notes.

---

## [0.8.0] - 2025-05-27

### Updated

* Updated `Set-TriliumNoteDetails` to improve `-NoteType` parameter handling and type/mime mapping for special note types.
* Updated `New-TriliumNote` to include `-NoteType` parameter and unified type/mime mapping logic.

---

## [0.7.0] - 2025-05-25

### Added

* Added function `Get-TriliumInbox` - GET /inbox/{date}
* Added function `Get-TriliumDayNote` - GET /calendar/days/{date}
* Added function `Get-TriliumWeekNote` - GET /calendar/weeks/{date} (Note: This appears to be broken due to a bug in TriliumNext)
* Added function `Get-TriliumMonthNote` - GET /calendar/months/{month}
* Added function `Get-TriliumYearNote` - GET /calendar/years/{year}
* Added function `Set-TriliumNoteDetails` - PATCH /notes/{noteId}
* Added function `Set-TriliumBranch` - PATCH /branches/{branchId}

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

