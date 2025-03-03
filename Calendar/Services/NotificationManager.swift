import UIKit
import UserNotifications

protocol NotificationManagerProtocol {
    func addNotification(name: String, start: Date, end: Date, sound: String)
}

final class NotificationManager: NotificationManagerProtocol {
    
    func addNotification(name: String, start: Date, end: Date, sound: String) {
        let notificationCenter = UNUserNotificationCenter.current()
        notificationCenter.getNotificationSettings { settings in
            switch settings.authorizationStatus {
            case .authorized: self.dispatchNotification(name: name, start: start, end: end, sound: sound)
            case .denied: return
            case .notDetermined:
                notificationCenter.requestAuthorization(options: [.alert, .sound]) { didAllow, error in
                    if didAllow {
                        self.dispatchNotification(name: name, start: start, end: end, sound: sound)
                    }
                }
            default: return
            }
        }
   }
                                                          
    private func dispatchNotification(name: String, start: Date, end: Date, sound: String) {
        let identifier = "Test"
        let title = "SigmaLendar"
        let notificationCenter = UNUserNotificationCenter.current()
        let content = UNMutableNotificationContent()
        content.title = title
        content.body = name
        content.sound = sound == "default" ? .default : .defaultCritical
        content.launchImageName = "AppIcon"
        
        var dateComponents = DateComponents(calendar: Calendar.current, timeZone: TimeZone.current)
        dateComponents.hour = Calendar.current.component(.hour, from: start)
        dateComponents.minute = Calendar.current.component(.minute, from: start)
        
        let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: false)
        let request = UNNotificationRequest (identifier: identifier, content: content, trigger: trigger)
        notificationCenter.removePendingNotificationRequests(withIdentifiers: [identifier])
        notificationCenter.add(request)
    }
}
