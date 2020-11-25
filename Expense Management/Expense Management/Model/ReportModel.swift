//
//  ReportModel.swift
//  VayMuonP4New
//
//  Created by LE VIET ANH on 10/26/20.
//  Copyright © 2020 Sơn Bùi. All rights reserved.
//

import Foundation
class ReportModel {

    // swiftlint:disable:next function_body_length
    static func monthlyOveralInfo() -> [SWMonthlyOverall] {
        let model = Facade.share.model

        let (minDate, maxDate) = model.getMinMaxDateInRecords()
        let monthYearList = Date.monthsBetweenDates(
            startDate: minDate,
            endDate: maxDate
        )
        let totalBudget = model.getTotalBudget()

        return monthYearList.compactMap {
            let numDays = Date.getMonthDuration(
                year: $0.year,
                month: $0.month,
                considerCurrent: true
            )
            let numDaysAll = Date.getMonthDuration(
                year: $0.year,
                month: $0.month,
                considerCurrent: false
            )

            let monthlyTotalCost = model.getTotalMonth(
                year: $0.year,
                month: $0.month,
                type: .cost
            )
            let dailyAverageCost = monthlyTotalCost / Double(numDays)

            let monthlyTotalIncome = model.getTotalMonth(
                year: $0.year,
                month: $0.month,
                type: .income
            )
            let dailyAverageIncome = monthlyTotalIncome / Double(numDays)

            let monthlyTotal = monthlyTotalIncome - monthlyTotalCost
            let dailyAverage = dailyAverageIncome - dailyAverageCost

            var items = [RecordRepresentation]()

            items.append(RecordRepresentation(
                type: .totalCost,
                value: monthlyTotalCost,
                recordType: .cost
            ))

            items.append(RecordRepresentation(
                type: .totalIncome,
                value: monthlyTotalIncome,
                recordType: .income
            ))

            items.append(RecordRepresentation(
                type: .total,
                value: monthlyTotal,
                recordType: .all
            ))

            if totalBudget > 0 {
                let monthlyTotalSave = totalBudget - monthlyTotalCost
                items.append(RecordRepresentation(
                    type: .totalSave,
                    value: monthlyTotalSave,
                    recordType: .all
                ))
            }

            items.append(RecordRepresentation(
                type: .dailyAverage,
                value: dailyAverage,
                recordType: .all
            ))

            items.append(RecordRepresentation(
                type: .dailyAverageCost,
                value: dailyAverageCost,
                recordType: .cost
            ))

            items.append(RecordRepresentation(
                type: .dailyAverageIncome,
                value: dailyAverageIncome,
                recordType: .income
            ))

            let monthlyForecast = dailyAverage * Double(numDaysAll)
            items.append(RecordRepresentation(
                type: .forcast,
                value: monthlyForecast,
                recordType: .all
            ))

            let monthlyForecastCost = dailyAverageCost * Double(numDaysAll)
            items.append(RecordRepresentation(
                type: .forcastCost,
                value: monthlyForecastCost,
                recordType: .cost
            ))

            let monthlyForecastIncome = dailyAverageIncome * Double(numDaysAll)
            items.append(RecordRepresentation(
                type: .forcastIncome,
                value: monthlyForecastIncome,
                recordType: .income
            ))

            return SWMonthlyOverall(month: $0, items: items)
        }
    }
}

struct SWMonthlyOverall {
    let month: EMMonth
    var items: [RecordRepresentation]
}

struct RecordRepresentation {
    let type: SWRepresentationType
    let value: Double
    let recordType: RecordType

    var label: String {
        return value.recordPresenter(for: recordType)
    }
}

enum SWRepresentationType: String {
    case totalCost = "Total Cost"
    case totalIncome = "Total Income"
    case total = "Total"
    case totalSave = "Total Save"
    case dailyAverage = "Daily Average"
    case dailyAverageCost = "Daily Average Cost"
    case dailyAverageIncome = "Daily Average Income"
    case forcast = "Monthly Forecast"
    case forcastCost = "Monthly Forecast Cost"
    case forcastIncome = "Monthly Forecast Income"
}
