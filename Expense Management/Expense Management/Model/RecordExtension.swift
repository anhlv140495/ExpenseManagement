//
//  RecordExtension.swift
//  VayMuonP4New
//
//  Created by LE VIET ANH on 10/26/20.
//  Copyright © 2020 Sơn Bùi. All rights reserved.
//

import Foundation
enum DirectionType {
    case cost
    case income
}

extension Records {
    var directionType: DirectionType {
        if self.direction == -1 {
            return .cost
        } else {
            return .income
        }
    }
}

extension Sequence where Element: Records {

    func sum() -> RecordRepresentation {
        let costs = self.sumAmount(type: .cost)
        let incomes = self.sumAmount(type: .income)

        let total = incomes - costs

        return RecordRepresentation(
            type: .total,
            value: total,
            recordType: .all
        )
    }

    func sumAmount(type: DirectionType) -> Double {
        return self.filter({ $0.directionType == type })
        .map({ record in record.amount})
        .reduce(0, +)
    }
}
