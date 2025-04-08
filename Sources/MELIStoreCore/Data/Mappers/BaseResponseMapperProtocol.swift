//
//  BaseResponseMapperProtocol.swift
//  MELIStoreCore
//
//  Created by Andres Duque on 5/04/25.
//

public protocol BaseResponseMapperProtocol: Sendable {
    associatedtype InputModel
    associatedtype OutputEntity
    
    func mapResponse(_ input: InputModel) throws -> OutputEntity
    
    func mapOptionalList<Input, Output>(
        _ list: [Input]?,
        _ transform: (Input) throws -> Output?
    ) rethrows -> [Output]
}


public extension BaseResponseMapperProtocol {
    func mapOptionalList<Input, Output>(
        _ list: [Input]?,
        _ transform: (Input) throws -> Output?
    ) rethrows -> [Output] {
        let result = try list?.compactMap(transform)
        
        return result ?? []
    }
}
