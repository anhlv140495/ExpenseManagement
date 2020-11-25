//
//  EMMonth.swift
//  VayMuonP4New
//
//  Created by LE VIET ANH on 10/23/20.
//  Copyright © 2020 Sơn Bùi. All rights reserved.
//

import Foundation
import Foundation

struct EMMonth {
    let year: Int
    let shortYear: Int
    let month: Int
    let title: String
    let shortTitle: String
    let currentYear: Bool

    var titleWithYear: String {
        return "\(title) \(year)"
    }

    var shortTitleWithYear: String {
        return "\(shortTitle) \(shortYear)"
    }

    var titleWithCurrentYear: String {
        return currentYear ? title : titleWithYear
    }

    var shortTitleWithCurrentYear: String {
        return currentYear ? shortTitle : shortTitleWithYear
    }
}
