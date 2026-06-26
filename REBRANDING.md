# Rebranding: Dime → Stash

This tracks the rebrand from the upstream "Dime" app to **Stash** under the
`com.habibm96.stash` namespace.

## Done (in the code, by Claude)

- [x] App display name set to **Stash** (`INFOPLIST_KEY_CFBundleDisplayName`,
      main app target, Debug + Release).
- [x] Bundle identifiers re-namespaced `com.rafaelsoh.dime` → `com.habibm96.stash`
      across all targets (app, ExpenditureWidget, BudgetIntent, BudgetIntentUI).
- [x] App Group string updated everywhere: `group.com.rafaelsoh.dime` →
      `group.com.habibm96.stash` (used by ~39 `@AppStorage` sites + entitlements).
- [x] iCloud container updated: `iCloud.com.rafaelsoh.dime` →
      `iCloud.com.habibm96.stash` (DataController + entitlements).
- [x] `dime_name` localized string and neutral in-app brand mentions → "Stash".
- [x] README rewritten for Stash.

## You need to do (in Xcode / Apple Developer account — Mac only)

- [ ] **Signing.** Open `app/dime.xcodeproj` → select each target → Signing &
      Capabilities → set your **Team**. Let Xcode register the new bundle IDs.
- [ ] **App Group capability.** Register `group.com.habibm96.stash` for the app
      and the widget/intents targets (must match for shared storage to work).
- [ ] **iCloud / CloudKit capability.** Register the
      `iCloud.com.habibm96.stash` container, or remove the iCloud capability +
      comment out `cloudKitContainerOptions` in
      `app/dime/Data/DataController.swift` for a local-only build.
- [ ] **App icon.** Replace the Dime icon in
      `app/dime/Assets.xcassets` (and the alternate icons referenced by
      `SettingsAppIconView.swift`) with your own.

## Optional / personal references still pointing at the original author

These are left untouched because they need *your* accounts, not a find-replace.
All in `app/dime/Views/Settings/SettingsView.swift`:

- [ ] "Follow Dime on X" → links to `x.com/budgetwithdime` (original app account).
- [ ] "Follow Rafael on X" → links to `x.com/rarfell` (original author).
- [ ] "Share with Friends" → links to the original App Store listing
      (`id1635280255`).
- [ ] **Tip Jar** (`TipJarAlert`, `showTipJarMenu`) → uses StoreKit in-app
      purchases tied to the original developer's App Store Connect products, and
      a "Thanks a million, Rafael" message. Remove, or wire up your own IAPs.

## Notes

- The internal Xcode **target name** and source folder are still `dime`
  (and `dime.xcodeproj`). This is not user-visible — the home-screen name is
  "Stash". Renaming the target/folder/project is optional and is safest done in
  Xcode (Project navigator → rename), since it rewrites many `project.pbxproj`
  path references.
- `// Created by Rafael Soh` headers are kept as correct GPL authorship
  attribution.
