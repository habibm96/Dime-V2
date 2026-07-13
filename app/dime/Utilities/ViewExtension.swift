//
//  ViewExtension.swift
//  xpenz
//
//  Created by Rafael Soh on 16/5/22.
//  Modified by Habib Allawati, 2026.
//

import Foundation
import SwiftUI

#if canImport(UIKit)
    extension View {
        func hideKeyboard() {
            UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
        }
    }
#endif

extension View {
    @ViewBuilder func scrollEnabled(_ enabled: Bool) -> some View {
        if enabled {
            self
        } else {
            simultaneousGesture(DragGesture(minimumDistance: 0),
                                including: .all)
        }
    }
}

extension HorizontalAlignment {
    struct MoneySubtitle: AlignmentID {
        static func defaultValue(in d: ViewDimensions) -> CGFloat {
            d[.top]
        }
    }

    static let moneySubtitle = HorizontalAlignment(MoneySubtitle.self)
}

extension UINavigationController: @retroactive UIGestureRecognizerDelegate {
    override open func viewDidLoad() {
        super.viewDidLoad()
        interactivePopGestureRecognizer?.delegate = self
    }

    public func gestureRecognizerShouldBegin(_: UIGestureRecognizer) -> Bool {
        return viewControllers.count > 1
    }
}

// MARK: - Liquid Glass card helpers

extension View {
    /// Grouped-settings card: stable filled cards keep dense settings pages readable.
    func settingsCard(cornerRadius: CGFloat = 9) -> some View {
        modifier(SettingsCardBackground(cornerRadius: cornerRadius))
    }

    /// Content card (transaction rows, etc.): Liquid Glass on iOS 26+, SecondaryBackground below.
    func contentCard(cornerRadius: CGFloat = 13) -> some View {
        modifier(ContentCardBackground(cornerRadius: cornerRadius))
    }

    /// Rolls digits smoothly when a displayed number changes (iOS 16+); no-op below.
    @ViewBuilder
    func numericContentTransition() -> some View {
        if #available(iOS 16.0, *) {
            self.contentTransition(.numericText())
        } else {
            self
        }
    }
}

private struct SettingsCardBackground: ViewModifier {
    let cornerRadius: CGFloat
    func body(content: Content) -> some View {
        content.background(
            Color.SettingsBackground,
            in: RoundedRectangle(cornerRadius: cornerRadius, style: .continuous)
        )
    }
}

private struct ContentCardBackground: ViewModifier {
    let cornerRadius: CGFloat
    func body(content: Content) -> some View {
        if #available(iOS 26, *) {
            content.background {
                GlassEffectContainer {
                    RoundedRectangle(cornerRadius: cornerRadius, style: .continuous)
                        .glassEffect()
                }
            }
        } else {
            content.background(
                Color.SecondaryBackground,
                in: RoundedRectangle(cornerRadius: cornerRadius, style: .continuous)
            )
        }
    }
}

struct CompatibleNavigationStack<Content: View>: View {
    private let content: Content

    init(@ViewBuilder content: () -> Content) {
        self.content = content()
    }

    var body: some View {
        if #available(iOS 16.0, *) {
            NavigationStack {
                content
            }
        } else {
            NavigationView {
                content
            }
            .navigationViewStyle(.stack)
        }
    }
}

class Utilities {
    @AppStorage("colourScheme") var selectedAppearance = 0
    var userInterfaceStyle: ColorScheme? = .dark

    func overrideDisplayMode() {
        var userInterfaceStyle: UIUserInterfaceStyle

        if selectedAppearance == 2 {
            userInterfaceStyle = .dark
        } else if selectedAppearance == 1 {
            userInterfaceStyle = .light
        } else {
            userInterfaceStyle = .unspecified
        }

        (UIApplication.shared.connectedScenes.first as?
            UIWindowScene)?.windows.first!.overrideUserInterfaceStyle = userInterfaceStyle
    }
}
