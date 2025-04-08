//
//  ModuleProtocol.swift
//  MELIStore
//
//  Created by Andres Duque on 5/04/25.
//

import SwiftUI

public protocol ModuleProtocol: BasicModuleProtocol {
    
    associatedtype EntryPoint: View
    
    @MainActor
    var entryPoint: EntryPoint { get }
}
