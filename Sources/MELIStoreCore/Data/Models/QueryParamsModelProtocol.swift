//
//  QueryParamsModelProtocol.swift
//  MELIStoreCore
//
//  Created by Andres Duque on 5/04/25.
//

public protocol QueryParamsModelProtocol {
    func transform() -> [String: Sendable]
}
