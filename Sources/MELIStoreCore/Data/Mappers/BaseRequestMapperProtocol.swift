//
//  BaseRequestMapperProtocol.swift
//  MELIStoreCore
//
//  Created by Andres Duque on 5/04/25.
//

public protocol BaseRequestMapperProtocol: Sendable {
    associatedtype InputEntity
    associatedtype OutputModel
    
    func mapRequest(_ input: InputEntity) throws -> OutputModel
}
