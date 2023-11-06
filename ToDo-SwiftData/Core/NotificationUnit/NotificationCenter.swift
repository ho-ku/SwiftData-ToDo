import UIKit

/// Notification center
public protocol NotesNotificationCenter {
    
    /// Request authorization
    /// Returns bool value that stands for allownce to send notifications
    func requestAuthorization(options: UNAuthorizationOptions) async throws -> Bool
    
    /// Add user notifications request
    func add(_ request: UNNotificationRequest) async throws
}

extension UNUserNotificationCenter: NotesNotificationCenter { }
