//
//  ExpenseItemCell.swift
//  WeExpense
//
//  Created by Taylor on 2024-09-08.
//

import SwiftUI

struct ExpenseItemCell: View {
    let expenseItem: ExpenseItem

    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                Text(expenseItem.name)
                    .font(.headline)
                Text(expenseItem.type.rawValue.uppercased())
                    .font(.caption)
                    .foregroundStyle(.secondary)
            }
            Spacer()
            Text(expenseItem.amountFormatted)
        }

        // OPTION B

//        VStack(alignment: .leading) {
//            HStack {
//                Text(expenseItem.name)
//                Spacer()
//                Text(expenseItem.amount.amountFormatted)
//            }
//            Text(expenseItem.type.rawValue.uppercased())
//                .font(.caption)
//                .foregroundStyle(.secondary)
//        }
    }
}

#Preview {
    ExpenseItemCell(expenseItem: ExpenseItem.testExpenseItem)
        .padding()
}
