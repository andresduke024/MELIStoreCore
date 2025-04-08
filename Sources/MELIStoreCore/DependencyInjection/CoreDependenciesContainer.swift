//
//  CoreDependenciesContainer.swift
//  MELIStore
//
//  Created by Andres Duque on 5/04/25.
//

import Foundation
import SwiftDependencyInjector

struct CoreDependenciesContainer: DependenciesContainer {
    public func registerDependencies() {
        // Environment
        
        Injector.global.register(EnvironmentValuesProtocol.self) { EnvironmentValuesReader() }
        
        // Utils
        Injector.global.register(AttemptsManagerProtocol.self) { AttemptsManager() }
        
        // Data
        Injector.global.register(URLSession.self) { URLSession.shared }
        
        Injector.global.register(HTTPManagerProtocol.self) { HTTPManager() }
    }
}
