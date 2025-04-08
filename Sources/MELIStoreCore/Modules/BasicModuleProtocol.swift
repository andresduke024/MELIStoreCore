//
//  BasicModuleProtocol.swift
//  MELIStoreCore
//
//  Created by Andres Duque on 8/04/25.
//

public protocol BasicModuleProtocol: Sendable {
    var dependenciesContainer: DependenciesContainer { get }
}
