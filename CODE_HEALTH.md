# Code Health Backlog

Static audit of the Stash codebase (no compiler available in the dev
environment, so this is source-level analysis). Items are grouped by whether
they're safe to fix without building vs. need the Xcode build loop on the Mac.

## Fixed

- [x] **Crash: `Locale.current.currencyCode!` force-unwrap (42 sites, 21 files).**
      On devices whose region reports no currency code, `currencyCode` is `nil`
      and the app crashed on launch/use. Replaced with
      `(Locale.current.currencyCode ?? "USD")` everywhere — same value when a
      currency exists, safe USD fallback otherwise. Behavior-preserving.

## Needs the build loop (warnings — still compile; modern API conflicts with iOS 15 target)

These are deprecation **warnings**, not errors. The replacements require a higher
deployment target than the current iOS 15 minimum, so they should be handled
deliberately (likely alongside the iOS 27 design work), not mass-changed blind.

- [ ] **`UIScreen.main` — 37 uses** (deprecated iOS 16). Correct replacement is
      window-scene / `GeometryReader`-based sizing, which is a behavior-changing
      refactor per call site.
- [ ] **`.onChange(of:) { newValue in }` — 82 uses** (single-param form
      deprecated iOS 17). New two-param form needs iOS 17+; old form still
      compiles on the iOS 15 target.
- [ ] **`NavigationView` — 2 uses** (deprecated iOS 16). `NavigationStack`
      needs iOS 16+.

## Review candidates (low-confidence — need context to confirm they're real)

Not changed because they're plausibly guarded by their call site. Verify on the
Mac before touching.

- [ ] `as!` force casts — 2 sites.
- [ ] `sets.first!` — `app/dime/Views/CategoryView.swift:700` (inside a reorder;
      likely only runs on non-empty data).
- [ ] `windows.first!` — `app/dime/Utilities/ViewExtension.swift:67` (idiomatic
      key-window access).
- [ ] `URL(string: "dimeapp://...")!` in widgets — static valid literals, never
      nil. Cosmetic only.

## Hygiene (low priority)

- [ ] ~413 lines of commented-out code across the views. Left in place — without
      a compiler it's risky to judge which blocks are intentional references.
      Clean up incrementally as files are touched.
- [ ] ~28 leftover `print()` debug statements.

## How to drive the rest

Build in Xcode on the Mac, then paste the compiler's warning/error list here.
That turns this backlog from static guesses into a verified, prioritized list.
