# 📅 Changelog

All notable changes to the **Trilium** PowerShell module will be documented in this file.

---

## [0.5.0]
- Fixed Export-TriliumNote
- Added Markdown option to Export-TriliumNote. Default is HTML
- Updated and improved some documentation
- Split out functions into their own .ps1 file

---

## [0.4.0]
- Improved Connect-TriliumAuth to use PSCredential object.
  - See documentation for new usage.

---

## [0.3.0]
- Added check for / at the end of base URL.
- Updated Connect-TriliumAuth to use -SkipCertCheck switch.
- Added -SkipCertCheck switch to ALL functions.

---

## [0.2.0]
- Fixed parameter sets in Find-TriliumNote
  - orderBy and Limit must be used together.
- Updated/added some documentation.

---

## [0.1.0]
- Initial Release of Trilium, including:
  - A command for almost every documented TriliumNext API.

---

> 📌 This changelog follows [Keep a Changelog](https://keepachangelog.com/en/1.0.0/) principles.
