//
//  ExpenseItemList.swift
//  WeExpense
//
//  Created by Taylor on 2024-09-08.
//

import SwiftUI

struct ExpenseItemList: View {

    @State private var expenses = Expenses()
    @State private var showingAddExpense = false

    var body: some View {
        NavigationStack {
            List {
                ForEach(expenses.items) { expense in
                    ExpenseItemCell(expenseItem: expense)
                }
                .onDelete(perform: expenses.deleteExpenseItem)
            }
            .navigationTitle("Expenses")
            .toolbar {
                Button("Add Expense", systemImage: "plus") {
                    showingAddExpense = true
                }
            }
            .sheet(isPresented: $showingAddExpense) {
                AddExpenseView(expenses: expenses)
            }
        }
    }
}

#Preview {
    ExpenseItemList()
}
