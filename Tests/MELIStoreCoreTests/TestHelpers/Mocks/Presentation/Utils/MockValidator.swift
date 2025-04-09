//
//  MockValidator.swift
//  MELIStoreCore
//
//  Created by Andres Duque on 9/04/25.
//

@testable import MELIStoreCore

struct MockValidator: ValidatorProtocol {
    let result: Result<Int, Error>

    func validate(_ content: String) throws {
        switch result {
        case .success: return
        case .failure(let error): throw error
        }
    }
}
