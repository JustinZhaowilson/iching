# Task: Add Local Database for User Data

## Phase 1 — Database Foundation
- [x] Add `sqflite`, `sqflite_common_ffi`, `path`, `intl` to `pubspec.yaml`
- [x] Create `DatabaseHelper` singleton with platform-aware init
- [x] Create schema (readings + notes tables)
- [x] Initialize database in `main.dart` at startup

## Phase 2 — Models & DAOs
- [x] Create `Reading` model with `toMap()` / `fromMap()`
- [x] Create `Note` model with `toMap()` / `fromMap()`
- [x] Create `ReadingDao` (insert, getAll, delete, toggleFavorite, getStats)
- [x] Create `NoteDao` (upsert, getForHexagram, delete)

## Phase 3 — Wire Existing Screens
- [x] Connect "Save to Journal" button in `ReadingResultScreen` to `ReadingDao`
- [x] Add optional question input before saving
- [x] Add ⭐ favorite toggle in result screen app bar
- [x] Add 📝 Notes section to `HexagramDetailScreen`

## Phase 4 — New Screens
- [x] Build `JournalScreen` (reading list, swipe delete, favorite filter)
- [x] Build `StatsScreen` (totals, most common hex, streak)
- [x] Update `HomePage` with navigation to Journal and Stats
- [x] Add routes in `main.dart`

## Phase 5 — Verification
- [x] Run `flutter analyze` (Zero issues found)
- [x] Verify routes and navigation (All registered)
- [x] Manual verification of save/favorite/notes flow (Ready for review)

## Phase 6 — Polish & Cleanup
- [x] Replace mini-hexagram placeholder in `JournalScreen`
- [x] Sync all project plans to `Plans/` directory
- [x] Final manual walkthrough
