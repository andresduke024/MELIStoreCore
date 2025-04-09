//
//  FieldValidationError.swift
//  MELIStoreCore
//
//  Created by Andres Duque on 9/04/25.
//

public struct ValidationError: Error {
    public let message: String
    
    public init(message: String) {
        self.message = message
    }
}
