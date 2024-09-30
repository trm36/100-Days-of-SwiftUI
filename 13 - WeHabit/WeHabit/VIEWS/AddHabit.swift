//
//  AddHabit.swift
//  WeHabit
//
//  Created by Taylor on 2024-09-30.
//

import SwiftUI

struct AddHabit: View {

    @State private var name: String = ""
    @State private var color: Habit.HabitColor?
    @State private var category: Habit.Category = .fitness
    @State private var showingIncompleteAlert = false

    @Environment(\.dismiss) var dismiss

    var body: some View {
        NavigationStack {
            Form {
                TextField("Name", text: $name)
                
                Picker("Category", selection: $category) {
                    ForEach(Habit.Category.allCases) { category in
                        Label(category.displayString, systemImage: category.iconName)
                    }
                }

                ColorPicker(selectedColor: $color)
            }
            .navigationTitle("Add Habit")
            .toolbar {
                Button("Save") {
                    guard !name.isEmpty, let selectedColor = color else {
                        showingIncompleteAlert = true
                        return
                    }

                    let habit = Habit(name: name, category: category, color: selectedColor)
                    HabitController.shared.addHabit(habit)
                    dismiss()
                }
            }
            .alert("Incomplete Habit", isPresented: $showingIncompleteAlert, actions: {}) {
                Text("Please enter a name, category and color for each habit.")
            }
        }
    }
}

#Preview {
    AddHabit()
}
