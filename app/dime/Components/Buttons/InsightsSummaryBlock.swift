//
//  InsightsSummaryBlock.swift
//  dime
//
//  Created by Rafael Soh on 19/11/23.
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
        // Subtle colour tint ties each block to its meaning (green income /
        // red expenses) instead of a heavy neutral grey.
        .background(color.opacity(0.1), in: RoundedRectangle(cornerRadius: 12, style: .continuous))
        .overlay {
            RoundedRectangle(cornerRadius: 12, style: .continuous)
                .stroke(color.opacity(showOverlay ? 0.9 : 0.18), lineWidth: showOverlay ? 1.6 : 1)
        }
    }
}
