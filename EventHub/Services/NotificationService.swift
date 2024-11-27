//
//  NotificationService.swift
//  EventHub
//
//  Created by Мария Нестерова on 26.11.2024.
//

import UserNotifications

final class NotificationManager {
    static let shared = NotificationManager()
    
    private init() {}
    
    func requestAuthorization(completion: @escaping (Bool) -> Void) {
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .badge, .sound]) { granted, error in
            if let error = error {
                print("Authorization request error: \(error.localizedDescription)")
            }
            print("Разрешение на уведомление предоставлено: \(granted)")
            completion(granted)
        }
    }
    
    func enableNotifications() {
        let content = UNMutableNotificationContent()
        content.title = "Test Notification"
        content.body = "This is a test notification."
        
        /// Тестовое уведомление
        var dateComponents = DateComponents()
        dateComponents.second = 10
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 10, repeats: false)
        
        let uuidString = UUID().uuidString
        let request = UNNotificationRequest(identifier: uuidString, content: content, trigger: trigger)
        
        let notificationCenter = UNUserNotificationCenter.current()
        notificationCenter.removeAllPendingNotificationRequests()
        notificationCenter.add(request) { error in
            if let error = error {
                print("Error adding notification: \(error.localizedDescription)")
            } else {
                print("Уведомление запланировано с идентификатором: \(uuidString)")
            }
        }
    }
    
    func disableNotifications() {
        print("Отключение уведомлений...")
        UNUserNotificationCenter.current().removeAllPendingNotificationRequests()
    }
}
