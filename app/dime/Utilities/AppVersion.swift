//
//  AppVersion.swift
//  dime
//
//  Created by Rafael Soh on 25/8/22.
//  Modified by Habib Allawati, 2026.
//

import Foundation
import UIKit

extension UIApplication {
    static var appVersion: String? {
        return Bundle.main.object(forInfoDictionaryKey: "CFBundleShortVersionString") as? String
    }

    static var buildNumber: String? {
        return Bundle.main.object(forInfoDictionaryKey: "CFBundleVersion") as? String
    }
}
