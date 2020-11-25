//
//  NSLocaleExtension.swift
//  VayMuonP4New
//
//  Created by LE VIET ANH on 10/26/20.
//  Copyright © 2020 Sơn Bùi. All rights reserved.
//

import Foundation
extension NSLocale {
    static var defaultCurrency: String {
        return UserDefaults.standard.string(forKey: UserDefaults.currencySymbolKey) ?? ""
    }

    static func setupDefaultCurrency(symbol: String) {
        UserDefaults.standard.set(symbol, forKey: UserDefaults.currencySymbolKey)
    }
}


extension UserDefaults {
    static let currencySymbolKey = "currencySymbol"
    static let snapshotKey = "FASTLANE_SNAPSHOT"
}
