# 📅 Changelog

All notable changes to the **TriliumNext-Powershell-Module** will be documented in this file.

---

## [1.0.0] - 2025-11-29

### Added

* Added `Set-TriliumAttribute` function to update properties of existing attributes (value for labels, position for both labels and relations).

### Fixed

* Fixed `Export-TriliumNote` now correctly exports to HTML or Markdown format.

---

## [0.14.0] - 2025-10-11

### Added

* Added `Set-TriliumAttachment` function to update properties of existing attachments (role, mime, title, position).

---

## [0.13.1] - 2025-07-31

### Changed

* Improved documentation for `Get-TriliumInbox` to clarify dual behavior: returns fixed #inbox labeled note when available, otherwise creates/retrieves day notes.
* Updated examples in `Get-TriliumInbox` help documentation for better clarity.

### Fixed

* Fixed empty private folder causing error during module loading.

---

## [0.13.0] - 2025-07-04

### Fixed

* Fixed module casing to ensure compatibility with Linux filesystems.

### Changed

* Updating and improving help documentation.

---

## [0.12.0] - 2025-06-15

### Added

* Added `Remove-TriliumAttachment` function to delete attachments by attachmentId, supporting pipeline input.
* Added tab-completion for common label names to `New-TriliumAttribute` when -Type is 'label'.
* Added parameters `-IsExpanded`, `-NotePosition`, and `-Prefix` to `New-TriliumNote` for expanded UI control and note placement.
* Added `image` note type to `New-TriliumNote`.
* Added public function `Format-TriliumHtml` to beautify HTML content with improved header spacing and code block formatting.

### Changed

* Updated comment-based help for `New-TriliumAttribute`.
* Updated `New-TriliumNoteFile` to use `New-TriliumNote` and `New-TriliumAttribute` functions instead of direct API calls.
* Improved `New-TriliumNote` with better HTML formatting and consolidated mime type mapping.
* Added `MimeTypeMap.json` file to module's data directory for centralized MIME type mappings across functions.

### Fixed

* `New-TriliumAttachment` now attaches with working links added to note content.

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

* Removed function `Get-TriliumAttachmentID`, replaced with `Get-TriliumNoteAttachment`.

---

## [0.10.0] - 2025-06-11

### Added

* Added markdig library (v0.41.2) for Markdown to HTML conversion.
* Added parameter `-Markdown` to `New-TriliumNote` to convert markdown content to HTML for rendering in text notes.
* Added function `Get-TriliumAttachmentID` - Parses all attachment IDs from a note's contents (no direct API equivalent).
* Added parameter `-Math` (used with `-Markdown`) to convert math markdown for rendering.
* Added function `Create-TriliumAttribute`.
* Added type `file` to `New-TriliumNote` for file type notes.

---

## [0.8.0] - 2025-05-27

### Changed

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

### Added

* Added Markdown option to `Export-TriliumNote`. Default is HTML.
* Added and improved some documentation.
* Split out functions into their own .ps1 file.

### Changed

* Updated and improved some documentation.

### Fixed

* Fixed `Export-TriliumNote`.

---

## [0.4.0] - 

### Changed

* Improved `Connect-TriliumAuth` to use PSCredential object. See documentation for new usage.

---

## [0.3.0] - 

### Added

* Added check for `/` at the end of base URL.
* Added `-SkipCertCheck` switch to ALL functions.

### Changed

* Updated `Connect-TriliumAuth` to use `-SkipCertCheck` switch.

---

## [0.2.0] - 

### Changed

* Fixed parameter sets in `Find-TriliumNote`. `orderBy` and `Limit` must be used together.
* Updated/added some documentation.

---

## [0.1.0] - 

### Added

* Initial release of TriliumNext-Powershell-Module. A command for almost every documented TriliumNext API.

---

> 📌 This changelog follows [Keep a Changelog](https://keepachangelog.com/en/1.1.0/) principles.
