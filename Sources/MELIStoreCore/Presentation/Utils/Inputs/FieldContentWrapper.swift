//
//  FieldContentWrapper.swift
//  MELIStoreCore
//
//  Created by Andres Duque on 9/04/25.
//

import Foundation

public struct FieldContentWrapper {
    public var content: String
    public var error: String?
    public var isFirstValidationDone: Bool = false
    
    private let validators: [ValidatorProtocol]
    
    public var hasError: Bool { error != nil }
    
    private init(
        initial content: String,
        validators: [ValidatorProtocol] = []
    ) {
        self.content = content
        self.error = nil
        self.validators = validators
    }
    
    @MainActor
    @discardableResult
    
    mutating public func validate(
        always: Bool = true
    ) -> Bool {
        if !always && !isFirstValidationDone {
            return !hasError
        }
        
        executeValidators()
        isFirstValidationDone = true
        
        return !hasError
    }
    
    @MainActor
    mutating private func executeValidators() {
        do {
            for item in validators {
                try item.validate(content)
            }
            
            self.error = nil
        } catch let validationError as ValidationError {
            self.error = validationError.message
        } catch let validationError {
            self.error = validationError.localizedDescription
        }
    }
}

public extension FieldContentWrapper {
    static func build(
        initialValue: String = "",
        rules validators: [ValidatorProtocol] = []
    ) -> FieldContentWrapper {
        return FieldContentWrapper(
            initial: initialValue,
            validators: validators
        )
    }
}
