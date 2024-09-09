//
//  AddExpenseView.swift
//  WeExpense
//
//  Created by Taylor on 2024-09-09.
//

import SwiftUI

struct AddExpenseView: View {

    @State private var name: String = ""
    @State private var type: ExpenseType = .personal
    @State private var amount: Decimal = 0
    var expenses: Expenses

    @Environment(\.dismiss) var dismiss

    var body: some View {
        NavigationStack {
            Form {
                TextField("Name", text: $name)
                Picker("Expense Type", selection: $type) {
                    ForEach(ExpenseType.allCases, id: \.self) {
                        Text($0.rawValue.capitalized)
                    }
                }
                .pickerStyle(.segmented)
                TextField("Amount", value: $amount, format: .currency(code: Locale.Currency.currentOrDefault.identifier))
                    .keyboardType(.decimalPad)
            }
            .navigationTitle("Add New Expense")
            .toolbar {
                Button("Save") {
                    let item = ExpenseItem(name: name, type: type, amount: amount)
                    expenses.addExpenseItem(item)
                    dismiss()
                }
            }
        }
    }
}

#Preview {
    AddExpenseView(expenses: Expenses())
}
