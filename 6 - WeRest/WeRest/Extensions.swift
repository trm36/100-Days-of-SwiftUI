//
//  Extensions.swift
//  WeRest
//
//  Created by Taylor on 7/28/24.
//

import Foundation

extension Date {
    /// Returns 8AM today.
    ///
    /// If there is an issue with the date components, this function will return Date.now
    static var eightAM: Date {
        let today = Date.now
        var components = DateComponents()
        components.hour = 8
        components.minute = 0
        return Calendar.current.date(from: components) ?? today
    }
}
