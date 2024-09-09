//
//  ExpenseItem.swift
//  WeExpense
//
//  Created by Taylor on 2024-09-08.
//

import Foundation

struct ExpenseItem: Codable, Identifiable {
    let id: UUID
    let name: String
    let type: ExpenseType
    let amount: Decimal
    let currency: Locale.Currency

    var amountFormatted: String {
        return amount.formatted(.currency(code: currency.identifier))
    }

    init(id: UUID = UUID(), name: String, type: ExpenseType, amount: Decimal, currency: Locale.Currency = Locale.Currency.currentOrDefault) {
        self.id = id
        self.name = name
        self.type = type
        self.amount = amount
        self.currency = currency
    }

    static var testExpenseItem: ExpenseItem = ExpenseItem(name: "Test Expense", type: .personal, amount: 5)
}

enum ExpenseType: String, Codable, CaseIterable {
    case personal
    case business
}
