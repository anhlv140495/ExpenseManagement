//
//  DateExtension.swift
//  VayMuonP4New
//
//  Created by LE VIET ANH on 10/23/20.
//  Copyright © 2020 Sơn Bùi. All rights reserved.
//

import Foundation
extension Int {
    func format(formatString: String) -> String {
        return String(format: "%\(formatString)d", self)
    }
}

extension Double {
    func format(formatString: String) -> String {
        return String(format: "%\(formatString)f", self)
    }

    var clean: String {
        return self.truncatingRemainder(dividingBy: 1) == 0 ? String(format: "%.0f", self) : String(self)
    }

    func recordPresenter(for type: RecordType, preciseDecimal: Int = 2, formatting: Bool = true) -> String {
        var prefix = ""
        if type == .all {
            if self >= 0 {
                prefix = "+"
            } else {
                prefix = "-"
            }
        } else if type == .income {
            prefix = "+"
        } else {
            prefix = "-"
        }
        let absValue = abs(self)

        let formatter = NumberFormatter()
        formatter.minimumFractionDigits = 0
        formatter.maximumFractionDigits = 2

        if formatting {
            return "\(prefix) \(Utils.convertDoubleNumberToStringFormatNumber(number: absValue)) VNĐ "
        } else {
            return "\(prefix)  \(Utils.convertDoubleNumberToStringFormatNumber(number: absValue)) VNĐ"
        }
    }
}
