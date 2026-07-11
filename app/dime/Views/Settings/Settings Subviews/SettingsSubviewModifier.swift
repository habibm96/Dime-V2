//
//  SettingsSubviewModifier.swift
//  dime
//
//  Created by Rafael Soh on 5/11/23.
//

import Foundation
import SwiftUI

struct SettingsSubviewModifier: ViewModifier {
    func body(content: Content) -> some View {
        if #available(iOS 16.0, *) {
            content
                .navigationBarBackButtonHidden(true)
                .toolbar(.hidden, for: .navigationBar)
                .padding(20)
                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
                .background(Color.PrimaryBackground)
                .dynamicTypeSize(...DynamicTypeSize.xxxLarge)
        } else {
            content
                .navigationBarBackButtonHidden(true)
                .navigationBarTitle("")
                .navigationBarHidden(true)
                .padding(20)
                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
                .background(Color.PrimaryBackground)
                .dynamicTypeSize(...DynamicTypeSize.xxxLarge)
        }
    }
}
