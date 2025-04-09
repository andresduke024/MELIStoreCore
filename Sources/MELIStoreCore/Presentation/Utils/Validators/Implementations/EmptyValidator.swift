//
//  EmptyValidator.swift
//  MELIStoreCore
//
//  Created by Andres Duque on 9/04/25.
//

public struct EmptyValidator: ValidatorProtocol {
    
    private let message: String
    
    public init(message: String) {
        self.message = message
    }
    
    public func validate(_ text: String) throws {
        guard text.isEmpty else { return }
        
        throw ValidationError(
            message: message
        )
    }
}
