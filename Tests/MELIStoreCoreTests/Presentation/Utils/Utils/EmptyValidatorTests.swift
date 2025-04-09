//
//  EmptyValidatorTests.swift
//  MELIStoreCore
//
//  Created by Andres Duque on 9/04/25.
//

import XCTest

@testable import MELIStoreCore

final class EmptyValidatorTests: XCTest {
    
    func testSuccess() throws {
        // Arrange
        let sut = EmptyValidator(message: "")

        // Act / Assert
        XCTAssertNoThrow(try sut.validate("Non empty"))
    }
    
    func testFailure() throws {
        // Arrange
        let sut = EmptyValidator(message: "")

        // Act / Assert
        XCTAssertThrowsError(try sut.validate(""))
    }
}
