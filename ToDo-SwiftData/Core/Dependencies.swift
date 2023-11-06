//
//  Dependencies.swift
//  ToDo-SwiftData
//
//  Created by Денис Андриевский on 30.10.2023.
//

import Foundation
import SwiftData
import UserNotifications

public final class ServiceLocator {
    private static var services: [Any] = []
    public init() { }
    
    public static func register<T>(_ service: T) {
        services.append(service)
    }
    
    public static func resolve<T>() -> T {
        guard let service = services.first(where: { $0 is T }) as? T else {
            fatalError("Unable to resolve service with type \(String(describing: T.self))")
        }
        return service
    }
}

final class Dependencies {
    static func registerAll(modelContext: ModelContext) {
        ServiceLocator.register(modelContext)
        
        let repository: AnyNotesRepository = NotesRepository(modelContext: modelContext)
        ServiceLocator.register(repository)
        
        let notificationCenter = UNUserNotificationCenter.current()
        ServiceLocator.register(notificationCenter as NotesNotificationCenter)
        let notificationUnit = NotificationUnit(userNotificationCenter: notificationCenter) as INotificationUnit
        ServiceLocator.register(notificationUnit)
        
        ServiceLocator.register(NotesListViewModel(notesRepository: repository, notificationUnit: notificationUnit))
        ServiceLocator.register(AddNoteViewModel(notesRepository: repository))
    }
}
