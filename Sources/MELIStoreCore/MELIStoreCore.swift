//
//  CoreModule.swift
//  MELIStoreCore
//
//  Created by Andres Duque on 8/04/25.
//

public struct CoreModule: BasicModuleProtocol {
    
    public static let shared = CoreModule()
    
    private init() {}
    
    public var dependenciesContainer: any DependenciesContainer {
        CoreDependenciesContainer()
    }
}
