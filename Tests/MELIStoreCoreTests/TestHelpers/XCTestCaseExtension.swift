//
//  XCTestCaseExtension.swift
//  MELIStoreCore
//
//  Created by Andres Duque on 9/04/25.
//

import XCTest

extension XCTestCase {
    func XCTAssertThrowsErrorAsync<T>(
        _ expression: @autoclosure @escaping () async throws -> T,
        _ message: @autoclosure () -> String = "",
        file: StaticString = #file,
        line: UInt = #line,
        _ errorHandler: (_ error: Error) -> Void = { _ in }
    ) async {
        do {
            _ = try await expression()
            XCTFail("Expected error but got success", file: (file), line: line)
        } catch {
            errorHandler(error)
        }
    }
}
