# Stash — Project Guide for Claude

## What this is
**Stash** is an iOS personal-finance tracker (SwiftUI + Core Data + CloudKit).
It is a fork of [rafsoh/dimeApp](https://github.com/rafsoh/dimeApp) ("Dime"),
licensed under **GPL v3** — any shipped derivative must remain open-source under
GPL v3. See `ARCHITECTURE.md` for the full codebase map.

## Project rules (always follow)

1. **Branch/push: ALWAYS commit and push to `main`.** Do not develop on or push
   to feature branches unless explicitly told otherwise. Commit and push to
   `main` after each meaningful change.
2. **Builds happen on the user's MacBook.** This is an Xcode/iOS project that can
   only be compiled and run on macOS. Claude runs in a Linux cloud environment,
   so Claude writes/edits all the Swift code; the user pulls and
   builds/runs/tests in Xcode. Don't try to compile or launch a simulator here.
3. **Branding/identifiers:**
   - App display name: **Stash**
   - Bundle ID namespace: **`com.habibm96.stash`**
     (app = `com.habibm96.stash`, widget/intents nest under it)
   - App Group: `group.com.habibm96.stash`
   - iCloud container: `iCloud.com.habibm96.stash`

## Key locations
- Main app source: `app/dime/` (internal target/folder still named `dime`)
- Data layer / business logic: `app/dime/Data/DataController.swift`
- Core Data model: `app/MainModel.xcdatamodeld`
- Screens: `app/dime/Views/` (Log, Insights, Budget, Settings tabs)
- Theming: `app/dime/Utilities/Color.swift`, `FontExtension.swift`
- Xcode project: `app/dime.xcodeproj`

## Outstanding rebrand items (require the user's own accounts — not yet done)
See `REBRANDING.md` for the checklist of things only the user can finish in
Xcode / their Apple Developer account (capabilities, app icon, author links,
tip-jar IAPs).
