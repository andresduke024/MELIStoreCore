//
//  EnvironmentValuesProtocol.swift
//  MELIStore
//
//  Created by Andres Duque on 5/04/25.
//

public protocol EnvironmentValuesProtocol: Sendable {
    func get<T>(_ key: EnvironmentValueType) -> T
}
