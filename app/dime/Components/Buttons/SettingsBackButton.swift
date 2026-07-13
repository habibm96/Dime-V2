//
//  SettingsBackButton.swift
//  dime
//
//  Created by Rafael Soh on 5/11/23.
//  Modified by Habib Allawati, 2026.
//

import Foundation
import SwiftUI

struct SettingsBackButton: View {
  var body: some View {
    Image(systemName: "chevron.left")
      .font(.system(.subheadline, design: .rounded).weight(.semibold))
      .foregroundColor(Color.SubtitleText)
      .padding(8)
      .background(Color.SecondaryBackground, in: Circle())
  }
}
