import UIKit
import UserNotifications

protocol NotificationManagerProtocol {
    func addNotification(event: EventSettings.Event)
}

final class NotificationManager: NotificationManagerProtocol {
    
    public func addNotification(event: EventSettings.Event) {
        let notificationCenter = UNUserNotificationCenter.current()
        notificationCenter.getNotificationSettings { settings in
            switch settings.authorizationStatus {
            case .authorized: self.dispatchNotification(event: event)
            case .denied: return
            case .notDetermined:
                notificationCenter.requestAuthorization(options: [.alert, .sound]) { didAllow, error in
                    if didAllow {
                        self.dispatchNotification(event: event)
                    }
                }
            default: return
            }
        }
   }
                                                          
    private func dispatchNotification(event: EventSettings.Event) {
        let identifier = "Test"
        let title = "SigmaLendar"
        let notificationCenter = UNUserNotificationCenter.current()
        let content = UNMutableNotificationContent()
        content.title = title
        content.body = event.name
        content.sound = .default
        content.launchImageName = "AppIcon"
        
        var dateComponents = DateComponents(calendar: Calendar.current, timeZone: TimeZone.current)
        dateComponents.hour = Calendar.current.component(.hour, from: event.start)
        dateComponents.minute = Calendar.current.component(.minute, from: event.start)
        
        let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: false)
        let request = UNNotificationRequest (identifier: identifier, content: content, trigger: trigger)
        notificationCenter.removePendingNotificationRequests(withIdentifiers: [identifier])
        notificationCenter.add(request)
    }
}
