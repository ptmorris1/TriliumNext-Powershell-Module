# 📅 Changelog

All notable changes to the **TriliumNext-Powershell-Module** will be documented in this file.

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
