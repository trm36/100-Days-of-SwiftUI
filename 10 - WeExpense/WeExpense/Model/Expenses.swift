//
//  Expenses.swift
//  WeExpense
//
//  Created by Taylor on 2024-09-08.
//

import Foundation

@Observable class Expenses {
    private let kExpenseItems: String = "expenseItems"

    private(set) var items: [ExpenseItem] = [] {
        didSet {
            guard let encodedData = try? JSONEncoder().encode(items) else { return }
            UserDefaults.standard.set(encodedData, forKey: kExpenseItems)
        }
    }


    init() {
        guard let savedData = UserDefaults.standard.data(forKey: kExpenseItems),
              let decodedItems = try? JSONDecoder().decode([ExpenseItem].self, from: savedData) else {
            items = []
            return
        }
        
        items = decodedItems
    }

    func addExpenseItem(_ expenseItem: ExpenseItem) {
        items.append(expenseItem)
    }

    func deleteExpenseItem(at offsets: IndexSet) {
        items.remove(atOffsets: offsets)
    }
}
