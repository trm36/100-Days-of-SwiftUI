//
//  HabitList.swift
//  WeHabit
//
//  Created by Taylor on 2024-09-29.
//

import SwiftUI

struct HabitList: View {

    @State var path: NavigationPath = NavigationPath()
    @State var habitController: HabitController = HabitController.shared
    @State private var showingAddHabit = false

    var body: some View {
        NavigationStack(path: $path) {
            List {
                ForEach(habitController.habits) { habit in
                    NavigationLink(value: habit) {
                        HStack {
                            Label {
                                Text(habit.name)
                            } icon: {
                                Image(systemName: habit.category.iconName)
                                    .resizable()
                                    .scaledToFit()
                                    .foregroundStyle(.white)
                                    .frame(width: 20, height: 20.0)
                                    .padding(6.0)
                                    .background {
                                        Circle()
                                            .foregroundStyle(habit.color.color)
                                    }
                            }

                            Spacer()

                            Text("INCOMPLETE")
                                .foregroundStyle(.white)
                                .font(.caption)
                                .padding(.horizontal, 8.0)
                                .padding(.vertical, 2.0)
                                .background {
                                    RoundedRectangle(cornerRadius: 25.0)
                                        .foregroundStyle(.red)

                                }
                        }
                    }
                }
            }
            .navigationTitle("Habits")
            .navigationDestination(for: Habit.self) { selectedHabit in
                HabitDetail(habit: selectedHabit)
            }
            .toolbar {
                Button("Add Habit", systemImage: "plus") {
                    showingAddHabit = true
                }
            }
            .sheet(isPresented: $showingAddHabit) {
                
            }
        }
    }
}

#Preview {
    HabitList(habitController: HabitController(testing: true))
}
