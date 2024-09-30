//
//  Habit.swift
//  WeHabit
//
//  Created by Taylor on 2024-09-29.
//

import SwiftUI


// MARK: - HABIT
struct Habit: Identifiable, Codable, Hashable, Equatable {
    static func == (lhs: Habit, rhs: Habit) -> Bool {
        return lhs.id == rhs.id
    }
    
    var id: UUID = UUID()
    var name: String
    var category: Habit.Category
    var color: Habit.HabitColor
    private(set) var logs: [Habit.Log] = []
    private(set) var lastLogged: Date? = nil

    mutating func log() {
        let log = Log(count: 1.0, date: .now, dateLogged: .now)
        addLog(log)
    }

    private mutating func addLog(_ log: Habit.Log) {
        logs.append(log)
        lastLogged = log.date
    }
}


// MARK: - LOG
extension Habit {
    struct Log: Identifiable, Codable, Hashable {
        var id: UUID = UUID()
        var count: Decimal
        var date: Date
        var dateLogged: Date
    }
}


// MARK: - ENUMS
extension Habit {
    enum HabitColor: String, Codable, CaseIterable, Identifiable {
        case pink
        case red
        case orange
        case yellow
        case green
        case blue
        case purple
        case black

        var id: String {
            return rawValue
        }

        var color: Color {
            switch self {
            case .pink:
                return .init(hue: 305.0 / 365.0 , saturation: 0.52, brightness: 0.92)
            case .red:
                return .red
            case .orange:
                return .orange
            case .yellow:
                return .yellow
            case .green:
                return .green
            case .blue:
                return .blue
            case .purple:
                return .purple
            case .black:
                return .black
            }
        }

        var displayString: String {
            switch self {
            case .black:
                return "Black"
            case .blue:
                return "Blue"
            case .green:
                return "Green"
            case .orange:
                return "Orange"
            case .pink:
                return "Pink"
            case .purple:
                return "Purple"
            case .red:
                return "Red"
            case .yellow:
                return "Yellow"
            }
        }
    }

    enum Category: String, Codable, CaseIterable, Identifiable {
        case fitness
        case books
        case social
        case games
        case home
        case family
        case sleep
        case photography
        case medical
        case school
        case pet
        case work
        case nature
        case money
        case food

        var id: String {
            return rawValue
        }

        var iconName: String {
            switch self {
            case .fitness:
                return "figure.run"
            case .books:
                return "text.book.closed"
            case .social:
                return "star.bubble.fill"
            case .games:
                return "gamecontroller.fill"
            case .home:
                return "house.fill"
            case .family:
                return "figure.and.child.holdinghands"
            case .sleep:
                return "zzz"
            case .photography:
                return "camera.fill"
            case .medical:
                return "stethoscope"
            case .school:
                return "house.and.flag.fill"
            case .pet:
                return "pawprint.fill"
            case .work:
                return "building.2.fill"
            case .nature:
                return "tree.fill"
            case .money:
                return "banknote.fill"
            case .food:
                return "carrot.fill"
            }
        }

        var displayString: String {
            switch self {
            case .books: 
                return "Books"
            case .family:
                return "Family"
            case .fitness:
                return "Fitness"
            case .food:
                return "Food"
            case .games:
                return "Games"
            case .home:
                return "Home"
            case .medical:
                return "Medical"
            case .money:
                return "Money"
            case .nature:
                return "Nature"
            case .pet:
                return "Pet"
            case .photography:
                return "Photography"
            case .school:
                return "School"
            case .sleep:
                return "Rest"
            case .social:
                return "Social"
            case .work:
                return "Work"
            }
        }
    }
}


// MARK: - TEST DATA
extension Habit {
    static var testHabits: [Habit] {
        return [
            Habit(name: "Feed dog", category: .pet, color: .blue),
            Habit(name: "Workout", category: .fitness, color: .orange),
            Habit(name: "Go for a walk", category: .nature, color: .green),
        ]
    }
}
