//
//  HabitDetail.swift
//  WeHabit
//
//  Created by Taylor on 2024-09-29.
//

import SwiftUI

struct HabitDetail: View {
    @State var habit: Habit

    var body: some View {
        List {
            VStack {
                Image(systemName: habit.category.iconName)
                    .resizable()
                    .scaledToFit()
                    .foregroundStyle(.white)
                    .frame(width: 150, height: 150.0)
                    .padding(30.0)
                    .background {
                        Circle()
                            .foregroundStyle(habit.color.color)
                    }

                Text(habit.name)
                    .bold()
                    .font(.largeTitle)
            }
            .frame(maxWidth: .infinity)

            Section {
                if habit.logs.count == 0 {
                    Text("NO LOGS")
                } else {
                    ForEach(habit.logs) { log in
                        Text(log.date.formatted(date: .long, time: .complete))
                    }
                }
            }

        }
        .toolbar {
            ToolbarItem(placement: .bottomBar) {
                Button("Log") {
                    habit.log()
                }
            }
        }
    }
}

#Preview {
    NavigationStack {
        HabitDetail(habit: Habit.testHabits.first!)
    }

}
