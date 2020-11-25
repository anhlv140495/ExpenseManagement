//
//  CategoryData.swift
//  VayMuonP4New
//
//  Created by LE VIET ANH on 10/23/20.
//  Copyright © 2020 Sơn Bùi. All rights reserved.
//

import Foundation

enum CategoryType {
    case expense
    case income

    var direction: Int {
        switch self {
        case .expense:
            return -1
        case .income:
            return +1
        }
    }
}

struct CategoryData {
    let title: String
    let identifier: String
    let icon: String
    let type: CategoryType
    let colorIndex : Int64
    let iconIndex : Int64
}

extension CategoryData {

    static var list: [CategoryData] {
        return CategoryData.expenseList + CategoryData.incomeList
    }

    static let expenseList: [CategoryData] = [
        CategoryData(
            title: "Ăn uống",
            identifier: "cat_expense_foods",
            icon: "fa-utensils",
            
            type: .expense,
            colorIndex : 0,
            iconIndex : -1
        ),
        CategoryData(
            title: "Chi tiêu tạp hoá",
            identifier: "cat_expense_groceries",
            icon: "fa-shopping-cart",
            type: .expense,
            colorIndex : 0,
            iconIndex : -1
        ),
        
        CategoryData(
            title: "Di chuyển",
            identifier: "cat_expense_transport",
            icon: "fa-subway",
            type: .expense,
            colorIndex : 0,
            iconIndex : -1
        ),
        CategoryData(
            title: "Giải trí",
            identifier: "cat_expense_entertainment",
            icon: "fa-smile-beam",
            type: .expense,
            colorIndex : 0,
            iconIndex : -1
        ),
        CategoryData(
            title: "Chăm sóc cá nhân",
            identifier: "cat_expense_care",
            icon: "fa-heartbeat",
            type: .expense,
            colorIndex : 0,
            iconIndex : -1
        ),
        CategoryData(
            title: "Hoá đơn",
            identifier: "cat_expense_bills",
            icon: "fa-file-invoice",
            type: .expense,
            colorIndex : 0,
            iconIndex : -1
        ),
        CategoryData(
            title: "Mua sắm",
            identifier: "cat_expense_shopping",
            icon: "fa-shopping-bag",
            type: .expense,
            colorIndex : 0,
            iconIndex : -1
        ),
        CategoryData(
            title: "Chỗ ở",
            identifier: "cat_expense_accommodation",
            icon: "fa-building",
            type: .expense,
            colorIndex : 0,
            iconIndex : -1
        ),
        CategoryData(
            title: "Chi phí nhà ở",
            identifier: "cat_expense_housing",
            icon: "fa-paint-roller",
            type: .expense,
            colorIndex : 0,
            iconIndex : -1
        ),
        CategoryData(
            title: "Ngày lễ, du lịch",
            identifier: "cat_expense_holidays",
            icon: "fa-umbrella-beach",
            type: .expense,
            colorIndex : 0,
            iconIndex : -1
        ),
        CategoryData(
            title: "Cho vay",
            identifier: "cat_expense_lending",
            icon: "fa-hand-holding-usd",
            type: .expense,
            colorIndex : 0,
            iconIndex : -1
        )
    ]

    static let incomeList: [CategoryData] = [
        CategoryData(
            title: "Lương",
            identifier: "cat_income_salary",
            icon: "fa-suitcase",
            type: .income,
            colorIndex : 1,
            iconIndex : -1
        ),
        
        CategoryData(
            title: "Quà tặng",
            identifier: "cat_income_gifts",
            icon: "fa-gift",
            type: .income,
            colorIndex : 1,
            iconIndex : -1
        ),
        CategoryData(
            title: "Bán hàng",
            identifier: "cat_income_sales",
            icon: "fa-chart-bar",
            type: .income,
            colorIndex : 1,
            iconIndex : -1
        ),
        CategoryData(
            title: "Lãi",
            identifier: "cat_income_interests",
            icon: "fa-coins",
            type: .income,
            colorIndex : 1,
            iconIndex : -1
        ),
        CategoryData(
            title: "Gỉam giá",
            identifier: "cat_income_copuns",
            icon: "fa-money-bill-wave",
            type: .income,
            colorIndex : 1,
            iconIndex : -1
        ),
        
        CategoryData(
            title: "Đầu tư",
            identifier: "cat_income_investments",
            icon: "fa-piggy-bank",
            type: .income,
            colorIndex : 1,
            iconIndex : -1
        ),
        CategoryData(
            title: "Hoàn trả nợ",
            identifier: "cat_income_refunding",
            icon: "fa-undo-alt",
            type: .income,
            colorIndex : 1,
            iconIndex : -1
        )
    ]
}

