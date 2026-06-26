# Stash

Stash is a personal finance tracker for iOS, built with SwiftUI. It is a fork of
[Dime](https://github.com/rafsoh/dimeApp) by Rafael Soh, used as the foundation
for continued development.

## Features

- Beautifully iOS-centric design, with simplicity at its core.
- Insightful expenditure breakdowns over various time periods.
- Create budgets based on expense categories and stick to them.
- Create recurring expenses with custom time frames.
- Sync your expenses, categories and budgets across devices via iCloud.
- Custom reminders to input your expenses.
- Biometric authentication to protect your data.
- Home screen quick actions make capturing new expenses a breeze.
- A night theme for dark mode.
- Home and lock screen widgets.

## Build

Requires **Xcode** on macOS.

1. Clone the repo and open `app/dime.xcodeproj` in Xcode.
2. Let Swift Package Manager resolve dependencies (or run
   `File > Packages > Resolve Package Versions`).
3. Set your own signing **Team** and confirm the bundle identifiers
   (namespaced under `com.habibm96.stash`).
4. Register the **App Group** (`group.com.habibm96.stash`) and **iCloud
   container** (`iCloud.com.habibm96.stash`) capabilities in your Apple Developer
   account, or disable those capabilities for a local-only build.

See [`REBRANDING.md`](REBRANDING.md) for the full first-build checklist and
[`ARCHITECTURE.md`](ARCHITECTURE.md) for a map of the codebase.

## Third-party dependencies

Alamofire, CloudKitSyncMonitor, ConfettiSwiftUI, CrookedText, SwiftUI Introspect,
IsScrolling, Popovers, ScrollViewStyle, STools.

## License

Licensed under the GNU General Public License v3.0 — see [LICENSE](LICENSE).
As a derivative of Dime (GPL v3), Stash remains under GPL v3.
