//
//  NotificationView.swift
//  WeProspect
//
//  Created by Taylor on 2025-02-20.
//

import SwiftUI
import UserNotifications

struct NotificationView: View {
    var body: some View {
        VStack {
            Spacer()

            Button("Request Permission") {
                UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .badge, .sound]) { success, error in
                    if success {
                        print("All set!")
                    } else if let error {
                        print(error.localizedDescription)
                    } else {
                        print("Unknown error when requesting notification permission.")
                    }
                }
            }

            Spacer()

            Button("Schedule Notification") {
                // content - what to be shown
                let content = UNMutableNotificationContent()
                content.title = "Feed the cat"
                content.subtitle = "It looks hungry."
                content.sound = UNNotificationSound.default

                // trigger - when to send notification to user
                // show this notification five seconds from now
                let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 5, repeats: false)

                // request - create a notification request to identify the notification
                // choose a random identifier
                let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)

                // schedule - add the notification request to the schedule
                // add our notification request
                UNUserNotificationCenter.current().add(request)
            }

            Spacer()
        }
    }
}

#Preview {
    NotificationView()
}
