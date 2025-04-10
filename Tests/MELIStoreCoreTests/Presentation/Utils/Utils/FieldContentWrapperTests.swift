//
//  FieldContentWrapperTests.swift
//  MELIStoreCore
//
//  Created by Andres Duque on 9/04/25.
//

import XCTest

@testable import MELIStoreCore

final class FieldContentWrapperTests: XCTestCase {

    private func buildSUT(
        initialValue: String,
        result: Result<Int, Error>
    ) -> FieldContentWrapper {
        FieldContentWrapper.build(
           initialValue: initialValue,
           rules: [
               MockValidator(result: result)
           ]
       )
    }
    
    @MainActor
    func testValidateSuccessShouldClearError() async {
        // Arrange
        var sut = buildSUT(
            initialValue: "Non-empty",
            result: .success(0)
        )
        
        // Act
        let result = sut.validate()

        // Assert
        XCTAssertTrue(result)
        XCTAssertNil(sut.error)
        XCTAssertTrue(sut.isFirstValidationDone)
    }

    @MainActor
    func testValidateFailureShouldSetValidationErrorMessage() async {
        // Arrange
        var sut = buildSUT(
            initialValue: "",
            result: .failure(ValidationError(message: "Campo inválido"))
        )

        // Act
        let result = sut.validate()

        // Assert
        XCTAssertFalse(result)
        XCTAssertEqual(sut.error, "Campo inválido")
        XCTAssertTrue(sut.hasError)
    }
}
