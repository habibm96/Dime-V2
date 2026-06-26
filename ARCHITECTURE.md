# Dime-V2 — Architecture Overview

> Fork of [rafsoh/dimeApp](https://github.com/rafsoh/dimeApp), a SwiftUI iOS
> personal-finance tracker (GPL v3). This document maps where everything lives
> so you can navigate and extend the codebase confidently.

## Tech stack at a glance

| Aspect | Detail |
|---|---|
| Language | Swift (100%) |
| UI | SwiftUI (with some UIKit bridging for the tab bar, keyboard, introspection) |
| Persistence | Core Data via `NSPersistentCloudKitContainer` (iCloud sync built in) |
| Settings/state | `@AppStorage` backed by a shared App Group `group.com.rafaelsoh.dime` |
| Extensions | Home-screen widgets (WidgetKit), Siri/Shortcuts (App Intents) |
| Dependencies | Swift Package Manager — Alamofire, ConfettiSwiftUI, SwiftUIIntrospect, etc. |
| Build | macOS + Xcode only. Open `app/dime.xcodeproj`. |
| License | GPL v3 (derivative work must stay GPL v3) |

## Top-level layout

```
app/
├── dime/                     # Main iOS app target (94 Swift files live mostly here)
│   ├── dimeApp.swift         # @main entry point — wires up environment objects
│   ├── ContentView.swift     # Root view: first-launch, migrations, app-lock, theming
│   ├── AppDelegate.swift     # Scene configuration shim
│   ├── SceneDelegate.swift   # Handles quick actions / URL launch
│   ├── Views/                # Screen-level views (see below)
│   ├── Components/            # Reusable pieces: Buttons/, Toolbar/, Transactions/
│   ├── Models/                # Plain Swift enums/structs (not Core Data) — Currency, TimeFrame, etc.
│   ├── Data/                  # DataController.swift (the Core Data brain) + Helper.swift
│   ├── Utilities/            # Extensions & helpers: Color, fonts, auth, sheets, haptics
│   ├── Shortcuts/            # Siri App Intents (in-app)
│   ├── Assets.xcassets       # Images, colors, app icon (~38 MB, most of repo size)
│   └── MainModel.xcdatamodeld # (duplicate model dir also at app/ level)
├── ExpenditureWidget/        # WidgetKit extension target
├── BudgetIntent/ + BudgetIntentUI/  # Siri intent + its custom UI
├── Localizations/            # Localized .strings for multiple languages
├── MainModel.xcdatamodeld    # Core Data model (source of truth for the schema)
└── dime.xcodeproj            # Xcode project & schemes
docs/                         # Screenshots, privacy policy
```

## Data model (Core Data)

The schema is defined in `app/MainModel.xcdatamodeld`. Core entities:

- **Transaction** — a single expense/income. Fields: `amount`, `date`, `day`,
  `month`, `note`, `income` (Bool), recurrence (`recurringType`,
  `recurringCoefficient`, `onceRecurring`). Belongs to a `Category`.
  Note: `day`/`month` are pre-truncated dates used to speed up grouping.
- **Category** — `name`, `emoji`, `colour` (hex string), `income` flag, `order`.
  Has many `transactions`, `templates`, and `budget`.
- **Budget** — a per-category spending limit. `amount`, `type` (timeframe),
  `startDate`, `green` (display flag). Linked to a `Category`.
- **MainBudget** — a single overall (all-categories) budget.
- **TemplateTransaction** — saved/recurring transaction templates for quick entry.

Sync: `DataController.init()` configures the CloudKit container
(`iCloud.com.rafaelsoh.dime`) and an App Group store at `Main.sqlite`, with
history tracking + remote-change notifications enabled.

## Key file: `Data/DataController.swift` (~1,700 lines)

This is the heart of the app — an `ObservableObject` (`DataController.shared`)
injected as an environment object everywhere. It owns the persistent container
and contains most business logic: creating/saving/deleting transactions,
budget calculations, recurring-transaction expansion, CSV import, widget
timeline reloads, and CloudKit handling. When adding data-related features,
start here.

## Navigation & screens

`dimeApp` → `ContentView` → `HomeView`, which hosts a `TabView` driven by a
custom tab bar (`Views/CustomTabBar.swift`). Four tabs (string-tagged):

| Tab | View | What it does |
|---|---|---|
| **Log** | `Views/LogView.swift` (~2,275 ln) | Transaction list/history, search, add/edit entry |
| **Insights** | `Views/InsightsView.swift` (~2,371 ln) | Charts & spending analytics (`LineGraph.swift`) |
| **Budget** | `Views/BudgetView.swift` (~2,381 ln) | Budgets per category + overall; `NewBudgetView` to create |
| **Settings** | `Views/Settings/SettingsView.swift` | Preferences, app lock, currency, import, etc. |

Other notable views: `TransactionView` (add/edit a transaction, ~1,794 ln),
`CategoryView` (manage categories, ~2,016 ln), `TemplateTransactionView`,
`ImportDataView` (CSV import), `WelcomeSheetView` (onboarding),
`UpdateSheet` (what's-new).

## Cross-cutting systems

- **App lock / biometrics** — `Views/UnlockManager.swift` +
  `Utilities/Authentication.swift` (`AppLockViewModel`). Face ID / passcode gate.
- **Theming** — `Utilities/Color.swift` defines the named color palette
  (`Color.PrimaryText`, `Color.PrimaryBackground`, `Color.Outline`, etc.).
  Light/dark/system chosen via the `colourScheme` AppStorage key.
- **Typography** — `Utilities/FontExtension.swift` + `DynamicType.swift`.
  The app heavily uses `.system(size:weight:design: .rounded)`.
- **Settings storage** — almost all preferences are `@AppStorage` keys in the
  `group.com.rafaelsoh.dime` suite, so the app and widgets share them.
- **Tab bar visibility** — `TabBarManager` (env object) hides/shows the bar.
- **Toasts & sheets** — `Utilities/AlertToast.swift`, `BottomSheet.swift`.

## Things to know before building on a Mac

1. **Signing & bundle IDs** — everything is namespaced to `com.rafaelsoh.dime`
   (app group, iCloud container, bundle IDs). To build under your own Apple
   account you must change these in the target settings and `*.entitlements`,
   or disable iCloud/widgets/app-group capabilities.
2. **CloudKit** — the iCloud container identifier is hard-coded in
   `DataController.swift`; point it at your own container or comment it out for
   local-only Core Data.
3. **GPL v3** — any app you ship from this must remain open-source under GPL v3.

## Suggested entry points for common changes

- Add/modify a stored field → edit `MainModel.xcdatamodeld` (add a model
  version for a clean migration) + the logic in `DataController.swift`.
- New chart/insight → `Views/InsightsView.swift` + `Views/LineGraph.swift`.
- Restyle → `Utilities/Color.swift` and `FontExtension.swift` first.
- New tab/screen → add a `.tag(...)` case in `HomeView`'s `TabView` and a
  `TabButton` in `CustomTabBar.swift`.
