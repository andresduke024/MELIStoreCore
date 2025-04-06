//
//  ModuleProtocol.swift
//  MELIStore
//
//  Created by Andres Duque on 5/04/25.
//

public protocol ModuleProtocol: Sendable {
    var dependenciesContainer: DependenciesContainer { get }
}
