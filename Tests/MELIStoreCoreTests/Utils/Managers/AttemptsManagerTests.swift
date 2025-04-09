//
//  AttemptsManagerTests.swift
//  MELIStoreCore
//
//  Created by Andres Duque on 9/04/25.
//

import XCTest

@testable import MELIStoreCore

final class AttemptsManagerTests: XCTestCase {
    
    private var sut: AttemptsManager!

    override func setUpWithError() throws {
        sut = AttemptsManager()
    }

    override func tearDownWithError() throws {
        sut = nil
    }
    
    actor AttemptsCounter {
        var value: Int = 0
        
        func increment() {
            value += 1
        }
    }
    
    func testExecuteSucceedsAtFirstAttemp() async throws {
        // Arrange
        let expected = "Success"
        
        // Act
        let result = await sut.execute(maxAttempts: 3) {
            return expected
        }

        // Assert
        XCTAssertEqual(result, expected)
    }

    func testExecuteSucceedsAtSecondAttemp() async throws {
        // Arrange
        let attempt = AttemptsCounter()
        let expected = "expected"
        
        // Act
        let result = try await sut.execute(maxAttempts: 3) {
            await attempt.increment()
            
            if await attempt.value < 2 { throw MockError.general }
            
            return expected
        }

        let finalAttempts = await attempt.value
        
        // Assert
        XCTAssertEqual(result, expected)
        XCTAssertEqual(finalAttempts, 2)
    }

    func testExecuteFails() async {
        // Arrange
        let attempt = AttemptsCounter()
        let maxAttempts = 3
        
        // Act / Assert
        await XCTAssertThrowsErrorAsync(
            try await self.sut.execute(maxAttempts: maxAttempts) {
                await attempt.increment()
                throw MockError.general
            }
        ) { error in
            XCTAssertEqual(error as? MockError, .general)
        }
    }
}
