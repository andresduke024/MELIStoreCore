//
//  FieldValidator.swift
//  MELIStoreCore
//
//  Created by Andres Duque on 9/04/25.
//

public protocol ValidatorProtocol {
    func validate(_ text: String) throws
}
