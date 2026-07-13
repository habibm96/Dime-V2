//
//  ToolbarButton.swift
//  Stash
//
//  Modified by Habib Allawati, 2026.
//

import SwiftUI

struct ToolbarButton: View {
    var systemName: String
    var onTapGesture: (() -> Void)?

    var body: some View {
        Button {
            if onTapGesture != nil {
                onTapGesture?()
            }
        } label: {
            Image(systemName: systemName)
                .font(.system(.callout, design: .rounded).weight(.semibold))
                .dynamicTypeSize(...DynamicTypeSize.xxxLarge)
                .foregroundColor(Color.SubtitleText)
                .offset(y: 0.8)
                .frame(width: 33, height: 33)
                .background {
                    Circle()
                        .fill(Color.SecondaryBackground)
                }
                .contentShape(Circle())
        }
        .buttonStyle(.plain)
    }
}
