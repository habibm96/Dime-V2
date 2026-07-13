//
//  InsightsSummaryBlock.swift
//  dime
//
//  Created by Rafael Soh on 19/11/23.
//  Modified by Habib Allawati, 2026.
//

import Foundation
import SwiftUI

struct InsightsSummaryBlockView: View {
    let income: Bool
    let amountString: String
    let showOverlay: Bool
    var action: () -> Void

    var color: Color {
        return income ? Color.IncomeGreen : Color.AlertRed
    }

    var body: some View {
        HStack(spacing: 9) {
            Image(systemName: income ? "arrow.up.right" : "arrow.down.right")
                .font(.system(size: 14, weight: .bold))
                .foregroundColor(.white)
                .frame(width: 28, height: 28)
                .background(color, in: RoundedRectangle(cornerRadius: 8, style: .continuous))

            VStack(alignment: .leading, spacing: 0) {
                Text(income ? "Income" : "Expenses")
                    .font(.system(.caption, design: .rounded).weight(.semibold))
                    .lineLimit(1)
                    .foregroundColor(Color.SubtitleText)

                Text(amountString)
                    .font(.system(.title3, design: .rounded).weight(.semibold))
                    .foregroundColor(Color.PrimaryText)
                    .lineLimit(1)
                    .minimumScaleFactor(0.8)
            }

            Spacer(minLength: 0)
        }
        .padding(.horizontal, 10)
        .padding(.vertical, 9)
        .frame(maxWidth: .infinity, alignment: .leading)
        .contentShape(Rectangle())
        .onTapGesture {
            self.action()
        }
        // Colour lives in the stroke and icon only — the box itself stays
        // uncoloured so the header reads cleaner.
        .overlay {
            RoundedRectangle(cornerRadius: 12, style: .continuous)
                .stroke(color.opacity(showOverlay ? 1 : 0.4), lineWidth: showOverlay ? 2 : 1.4)
        }
    }
}
