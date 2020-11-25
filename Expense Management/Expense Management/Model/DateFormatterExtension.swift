//
//  DateFormatterExtension.swift
//  VayMuonP4New
//
//  Created by LE VIET ANH on 10/23/20.
//  Copyright © 2020 Sơn Bùi. All rights reserved.
//

import Foundation
extension DateFormatter {
    static let monthFormatter: DateFormatter = {
        let dateFormtter = DateFormatter()
        dateFormtter.locale = NSLocale(localeIdentifier: "vi_VN") as Locale
        dateFormtter.dateFormat = "MM"

        return dateFormtter
    }()

    static let shortMonthFormatter: DateFormatter = {
        let dateFormtter = DateFormatter()
        dateFormtter.dateFormat = "MMM"
        dateFormtter.locale = NSLocale(localeIdentifier: "vi_VN") as Locale

        return dateFormtter
    }()

    static let shortYearFormatter: DateFormatter = {
        let dateFormtter = DateFormatter()
        dateFormtter.dateFormat = "yy"

        return dateFormtter
    }()

    static let fullDateFormatter: DateFormatter = {
        var formatter = DateFormatter()
        
        formatter.dateFormat = "y-MM-dd"
        formatter.locale = NSLocale(localeIdentifier: "vi_VN") as Locale

        return formatter
    }()
}
