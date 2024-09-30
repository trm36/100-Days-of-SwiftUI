//
//  HabitController.swift
//  WeHabit
//
//  Created by Taylor on 2024-09-29.
//

import Foundation

@Observable
class HabitController {
    private let kHabits: String = "habits"

    static let shared: HabitController = HabitController()

    private(set) var habits: [Habit] {
        didSet {
            guard let encodedData = try? JSONEncoder().encode(habits) else { return }
            UserDefaults.standard.set(encodedData, forKey: kHabits)
        }
    }

    init(testing: Bool = false) {
        guard !testing else { habits = Habit.testHabits; return }

        guard let savedData = UserDefaults.standard.data(forKey: kHabits),
              let decodedItems = try? JSONDecoder().decode([Habit].self, from: savedData) else {
            habits = []
            return
        }

        habits = decodedItems
    }

    func addHabit(_ habit: Habit) {
        habits.append(habit)
    }

    func deleteHabit(at offsets: IndexSet) {
        habits.remove(atOffsets: offsets)
    }
}
