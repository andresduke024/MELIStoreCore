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
            
            restore()
            return result
        } catch {
            increment()
            
            guard attempts < maxAttempts else {
                restore()
                throw error
            }
            
            return try await execute(
                maxAttempts: maxAttempts,
                block
            )
        }
    }
    
    private func increment() { attempts += 1 }
    
    private func restore() { attempts = 0 }
}
