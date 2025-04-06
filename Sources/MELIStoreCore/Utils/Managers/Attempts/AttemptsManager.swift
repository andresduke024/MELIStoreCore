//
//  AttemptsManager.swift
//  MELIStoreProducts
//
//  Created by Andres Duque on 5/04/25.
//

actor AttemptsManager: AttemptsManagerProtocol {
    private var attempts: Int = 0
    
    func execute<T: Sendable>(
        maxAttempts: Int,
        _ block: @Sendable @escaping () async throws -> T,
    ) async rethrows -> T {
        do {
            let result = try await block()
            
            attempts = 0
            return result
        } catch {
            guard attempts < maxAttempts else { throw error }
            
            attempts += 1
            return try await execute(maxAttempts: maxAttempts, block)
        }
    }
}
