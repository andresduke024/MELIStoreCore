//
//  AttemptsManagerProtocol.swift
//  MELIStoreProducts
//
//  Created by Andres Duque on 5/04/25.
//

public protocol AttemptsManagerProtocol: Sendable {
    func execute<T: Sendable>(
        maxAttempts: Int,
        _ block: @Sendable @escaping () async throws -> T
    ) async rethrows -> T
}
