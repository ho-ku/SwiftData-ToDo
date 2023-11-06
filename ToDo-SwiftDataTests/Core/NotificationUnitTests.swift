//
//  NotificationUnitTests.swift
//  ToDo-SwiftDataTests
//
//  Created by Денис Андриевский on 06.11.2023.
//

import XCTest
@testable import ToDo_SwiftData

final class NotificationUnitTests: XCTestCase {
    
    // MARK: - Properties
    
    private var savedValue: String?
    
    // MARK: - Lifecycle
    
    override func setUp() {
        super.setUp()
        
        let defaults = UserDefaults.standard
        savedValue = defaults.value(forKey: "notificationStatus") as? String
        defaults.removeObject(forKey: "notificationStatus")
    }
    
    override func tearDown() {
        super.tearDown()
        
        let defaults = UserDefaults.standard
        defaults.set(savedValue, forKey: "notificationStatus")
    }
    
    // MARK: - Tests
    
    func testRequestAuthorizationAllowed() {
        let sut = makeSUT(userNotificationCenter: NotificationCenterMock(shouldAuthorize: true))
        XCTAssertEqual(sut.notificationAuthStatus, .notAllowed)
        
        let expectation = expectation(description: "Should change auth status")
        Task {
            do {
                try await sut.requestAuthorization()
                expectation.fulfill()
            } catch {
                XCTFail()
            }
        }
        
        wait(for: [expectation], timeout: 1.0)
        XCTAssertEqual(sut.notificationAuthStatus, .allowed)
    }
    
    func testRequestAuthorizationRestricted() {
        let sut = makeSUT(userNotificationCenter: NotificationCenterMock(shouldAuthorize: false))
        XCTAssertEqual(sut.notificationAuthStatus, .notAllowed)
        
        let expectation = expectation(description: "Should change auth status")
        Task {
            do {
                try await sut.requestAuthorization()
                expectation.fulfill()
            } catch {
                XCTFail()
            }
        }
        
        wait(for: [expectation], timeout: 1.0)
        XCTAssertEqual(sut.notificationAuthStatus, .restricted)
    }
    
    func testScheduleNotification() {
        let notificationCenter = NotificationCenterMock(shouldAuthorize: true)
        let sut = makeSUT(userNotificationCenter: notificationCenter)
        let expectation = expectation(description: "Should change auth status")
        
        Task {
            do {
                let notification = NotesNotification(
                    id: "Sample",
                    title: "Sample",
                    description: "Sample")
                try await sut.schedule(notification, with: .test)
                expectation.fulfill()
            } catch {
                XCTFail()
            }
        }
        
        wait(for: [expectation], timeout: 1.0)
        
        /// Request was created
        XCTAssertEqual(notificationCenter.requestsCount, 1)
    }
    
    func testIntervalDailyValue() {
        let secondsInMinute = 60.0
        let minutesInHour = 60.0
        
        XCTAssertEqual(Interval.eightHour.interval, secondsInMinute * minutesInHour * 8)
    }
    
    func testNotificationStatusInit() {
        let valuePairs: [(String?, NotificationAuthStatus)] = [
            ("notAllowed", .notAllowed),
            ("restricted", .restricted),
            ("allowed", .allowed),
            ("", .notAllowed),
            (nil, .notAllowed)
        ]
        
        valuePairs.forEach {
            XCTAssertEqual(NotificationAuthStatus(from: $0.0), $0.1)
        }
    }

    // MARK: - Helpers
    
    private func makeSUT(userNotificationCenter: NotesNotificationCenter) -> NotificationUnit {
        NotificationUnit(userNotificationCenter: userNotificationCenter)
    }

}

// MARK: - Mocks

private extension NotificationUnitTests {
    final class NotificationCenterMock: NotesNotificationCenter {
        
        private let shouldAuthorize: Bool
        var requestsCount = 0
        
        init(shouldAuthorize: Bool) {
            self.shouldAuthorize = shouldAuthorize
        }
        
        func requestAuthorization(options: UNAuthorizationOptions) async throws -> Bool {
            shouldAuthorize
        }
        
        func add(_ request: UNNotificationRequest) async throws {
            requestsCount += 1
        }
    }

}
