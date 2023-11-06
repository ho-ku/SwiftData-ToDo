//
//  NotesListViewModelTests.swift
//  ToDo-SwiftDataTests
//
//  Created by Денис Андриевский on 06.11.2023.
//

import XCTest
@testable import ToDo_SwiftData

final class NotesListViewModelTests: XCTestCase {
    
    func testDelete() {
        // GIVEN
        let note = Note(title: "Hello")
        let repository = NotesRepositoryMock()
        repository.add(note)
        let sut = makeSUT(repository: repository, notificationUnit: NotificationUnitMock(notificationAuthStatus: .allowed, expectedAuthStatus: .allowed))
        // WHEN
        sut.delete(note)
        // THEN
        XCTAssertEqual(repository.incompletedNotesCount, .zero)
    }
    
    func testRequestNotificationAccess() async {
        // GIVEN
        let notificationUnit = NotificationUnitMock(notificationAuthStatus: .notAllowed, expectedAuthStatus: .allowed)
        let sut = makeSUT(repository: NotesRepositoryMock(), notificationUnit: notificationUnit)
        // WHEN
        await sut.requestNotificationAccess()
        // THEN
        XCTAssertEqual(notificationUnit.notificationAuthStatus, .allowed)
    }
    
    func testScheduleNotificationWithNonEmptyNotes() async {
        // GIVEN
        let note = Note(title: "Hello")
        let repository = NotesRepositoryMock()
        repository.add(note)
        let notificationUnit = NotificationUnitMock(notificationAuthStatus: .allowed, expectedAuthStatus: .allowed)
        let sut = makeSUT(repository: repository, notificationUnit: notificationUnit)
        // WHEN
        await sut.sendNotificationIfNeeded()
        // THEN
        XCTAssertTrue(notificationUnit.isNotificationScheduled)
    }
    
    func testScheduleNotificationWithEmptyNotes() async {
        // GIVEN
        let repository = NotesRepositoryMock()
        let notificationUnit = NotificationUnitMock(notificationAuthStatus: .allowed, expectedAuthStatus: .allowed)
        let sut = makeSUT(repository: repository, notificationUnit: notificationUnit)
        // WHEN
        await sut.sendNotificationIfNeeded()
        // THEN
        XCTAssertFalse(notificationUnit.isNotificationScheduled)
    }

    // MARK: - Private Helpers
    
    private func makeSUT(repository: AnyNotesRepository, notificationUnit: AnyNotificationUnit) -> NotesListViewModel {
        .init(notesRepository: repository, notificationUnit: notificationUnit)
    }

}

// MARK: - Mocks

private extension NotesListViewModelTests {
    final class NotificationUnitMock: AnyNotificationUnit {
        var notificationAuthStatus: NotificationAuthStatus
        var expectedAuthStatus: NotificationAuthStatus
        var isNotificationScheduled: Bool = false
        
        init(notificationAuthStatus: NotificationAuthStatus, expectedAuthStatus: NotificationAuthStatus) {
            self.notificationAuthStatus = notificationAuthStatus
            self.expectedAuthStatus = expectedAuthStatus
        }
        
        func requestAuthorization() async throws {
            notificationAuthStatus = expectedAuthStatus
        }
        
        func schedule(_ notification: NotesNotification, with interval: Interval) async throws {
            isNotificationScheduled = true
        }
    }
}
