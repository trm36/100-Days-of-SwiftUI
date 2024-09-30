//
//  ColorPicker.swift
//  WeHabit
//
//  Created by Taylor on 2024-09-30.
//

import SwiftUI

struct ColorPicker: View {
    @Binding var selectedColor: Habit.HabitColor?

    var body: some View {
        let dimension = 40.0
        let columns = [
            GridItem(.adaptive(minimum: dimension)),
        ]

        LazyVGrid(columns: columns) {
            ForEach(Habit.HabitColor.allCases) { habitColor in
                ZStack {
                    Circle()
                        .foregroundStyle(habitColor.color)
                        .frame(width: dimension, height: dimension)

                    if selectedColor == habitColor {
                        Image(systemName: "checkmark")
                            .bold()
                            .foregroundStyle(.white)
                    }
                }
                .accessibilityLabel("Select Color")
                .onTapGesture {
                    selectedColor = habitColor
                }
            }
        }
        .accessibilityValue("Selected  " + String(describing: selectedColor?.displayString))
    }
}

#Preview {
    ColorPicker(selectedColor: .constant(.red))
}
