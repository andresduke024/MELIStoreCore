//
//  NavigationModule.swift
//  MELIStoreCore
//
//  Created by Andres Duque on 7/04/25.
//

import SwiftUI

public struct NavigationModule<Content: View, Route: RouteProtocol, Destination: View>: View {
    
    @EnvironmentObject
    private var router: Router
    
    private let content: () -> Content
    
    private let onNavigateTo: (Route) -> Destination
    
    public init(
        @ViewBuilder onNavigateTo: @escaping (Route) -> Destination,
        content: @escaping () -> Content,
    ) {
        self.content = content
        self.onNavigateTo = onNavigateTo
    }
    
    public var body: some View {
        NavigationStack(path: $router.navPath) {
            content()
                .navigationDestination(for: Route.self, destination: onNavigateTo)
                .navigationBarBackButtonHidden()
        }
    }
}
