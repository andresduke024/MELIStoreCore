//
//  Router.swift
//  MELIStoreCore
//
//  Created by Andres Duque on 7/04/25.
//

import SwiftUI

public final class Router: ObservableObject {
    
    @Published
    public var navPath: NavigationPath
    
    public init() {
        self.navPath = NavigationPath()
    }
    
    public func push(_ destination: any RouteProtocol) {
        navPath.append(destination)
    }
    
    public func push(destination: any RouteProtocol) {
        push(destination)
    }
    
    public func pop() {
        navPath.removeLast()
    }
    
    public func popToRoot() {
        navPath.removeLast(navPath.count)
    }
    
    public func replace(newDestination: any RouteProtocol) {
        popToRoot()
        push(newDestination)
    }
}
