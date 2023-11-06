//
//  NotificationUnit.swift
//  ToDo-SwiftData
//
//  Created by Денис Андриевский on 06.11.2023.
//

import Foundation
import UserNotifications

/// Notification interval
public enum Interval {
    
    /// 8 hours
    case eightHour
    
    /// Interval for testing purposes - 10 seconds
    case test
    
    public var interval: Double {
        switch self {
        case .eightHour:
            return 8*60*60
        case .test:
            return 10
        }
    }
}

/// User notification authorization status
/// Contains three values:
/// `allowed` when user allowed notifications
/// `notAllowed` when user is not yet allowed notificaions
/// `restricted` when user restricted notifications
public enum NotificationAuthStatus: String {
    case allowed
    case notAllowed
    case restricted
    
    public init(from value: String?) {
        guard let value = value else {
            self = .notAllowed
            return
        }
        self = .init(rawValue: value) ?? .notAllowed
    }
}

/// User notification service
public protocol AnyNotificationUnit {
    
    /// User notification authorization status
    var notificationAuthStatus: NotificationAuthStatus { get set }
    
    /// Request user notification authorization
    func requestAuthorization() async throws
    
    /// Schedule notification
    func schedule(_ notification: NotesNotification, with interval: Interval) async throws
}

public final class NotificationUnit: AnyNotificationUnit {
    
    // MARK: - Properties
    
    public var notificationAuthStatus: NotificationAuthStatus {
        get { .init(from: UserDefaults.standard.object(forKey: "notificationStatus") as? String) }
        set { UserDefaults.standard.setValue(newValue.rawValue, forKey: "notificationStatus") }
    }
    
    private let userNotificationCenter: NotesNotificationCenter
    
    // MARK: - Init
    
    public init(userNotificationCenter: NotesNotificationCenter) {
        self.userNotificationCenter = userNotificationCenter
    }
    
    
    // MARK: - Methods
    
    public func requestAuthorization() async throws {
        let authOptions = UNAuthorizationOptions.init(arrayLiteral: .alert, .badge, .sound)
        notificationAuthStatus = try await userNotificationCenter.requestAuthorization(options: authOptions) ? .allowed : .restricted
    }
    
    public func schedule(_ notification: NotesNotification, with interval: Interval) async throws {
        let notificationContent = UNMutableNotificationContent()
        notificationContent.title = notification.title
        notificationContent.body = notification.description
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: interval.interval,
                                                        repeats: false)
        let request = UNNotificationRequest(identifier: notification.id,
                                            content: notificationContent,
                                            trigger: trigger)
        
        try await userNotificationCenter.add(request)
    }
}
