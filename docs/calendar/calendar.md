---
#title: Calendar
hide:
  - navigation
---

# 📅 Calendar Functions

The TriliumNext PowerShell Module provides a comprehensive set of calendar functions that help you interact with TriliumNext's calendar and journaling features. These functions allow you to retrieve or create time-based notes for various periods.

!!! warning "Authentication Required"
    All functions in this section require authentication using `Connect-TriliumAuth` before use.

## Overview

TriliumNext supports hierarchical calendar notes that can be used for journaling, planning, and organizing time-based content. The calendar functions in this module provide programmatic access to these features.

## Available Functions

### Time-Based Notes

| Function | Description | Time Period |
|----------|-------------|-------------|
| [Get-TriliumDayNote](Get-TriliumDayNote.md) | Gets or creates a day note | Daily |
| [Get-TriliumWeekNote](Get-TriliumWeekNote.md) | Gets or creates a week note | Weekly |
| [Get-TriliumMonthNote](Get-TriliumMonthNote.md) | Gets or creates a month note | Monthly |
| [Get-TriliumYearNote](Get-TriliumYearNote.md) | Gets or creates a year note | Yearly |
| [Get-TriliumInbox](Get-TriliumInbox.md) | Gets or creates an inbox note | Daily/Fixed† |

!!! note "Inbox Behavior"
    † `Get-TriliumInbox` has dual behavior based on the TriliumNext API:
    
    - **Fixed inbox**: If a note with `#inbox` label exists, returns that note regardless of date
    - **Day note mode**: If no `#inbox` label is set, behaves like `Get-TriliumDayNote` for the specified date
    
    This behavior is determined by the TriliumNext `/inbox/{date}` API endpoint.

## Common Features

All calendar functions share these common characteristics:

- **Auto-creation**: If a note doesn't exist for the specified time period, it will be created automatically
- **Authentication required**: All functions require authentication via `Connect-TriliumAuth`
- **Date flexibility**: Accept various date formats and default to current time periods
- **Certificate options**: Support for skipping certificate validation with `-SkipCertCheck`

## Usage Patterns


### Working with Different Time Periods

```powershell
# Get notes for a specific date across all time periods
$date = Get-Date "2022-02-22"
$dayNote = Get-TriliumDayNote -Date $date
$weekNote = Get-TriliumWeekNote -Date $date
$monthNote = Get-TriliumMonthNote -Month $date
$yearNote = Get-TriliumYearNote -Year $date
```

### Inbox Management

```powershell
# Get today's inbox (returns fixed #inbox note if it exists, otherwise creates/gets today's day note)
$inbox = Get-TriliumInbox

# Get inbox for a specific date (only applies if no #inbox label is set)
$inbox = Get-TriliumInbox -Date "2022-02-22"
```

!!! tip "Inbox vs Day Note"
    The key difference between `Get-TriliumInbox` and `Get-TriliumDayNote`:
    
    - **Get-TriliumInbox**: Checks for a fixed `#inbox` labeled note first, falls back to day note behavior if none exists
    - **Get-TriliumDayNote**: Always creates/retrieves day-specific notes in the calendar structure

## Notes Structure

The calendar functions work with TriliumNext's hierarchical note structure:

- **Year notes** serve as top-level containers
- **Month notes** are organized under year notes
- **Week notes** provide weekly organization
- **Day notes** contain daily entries
- **Inbox notes** provide a capture mechanism for quick entries

!!! info "Calendar Root"
    Notes are created under the `#calendarRoot` in your TriliumNext instance. Ensure you have the appropriate calendar structure set up in TriliumNext.