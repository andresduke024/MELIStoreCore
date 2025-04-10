//
//  NavigationModule.swift
//  MELIStoreCore
//
//  Created by Andres Duque on 7/04/25.
//

import SwiftUI

/// Vista genérica reutilizable que encapsula un `NavigationStack`
/// utilizando rutas definidas por `RouteProtocol`.
///
/// `NavigationModule` permite declarar de forma flexible una navegación basada en rutas tipadas,
/// facilitando el desacoplamiento entre vistas y navegación en arquitecturas modulares.
///
/// ## Parámetros Genéricos:
/// - `Content`: Tipo de vista que representa el contenido principal del módulo.
/// - `Route`: Tipo que conforma `RouteProtocol` y representa las rutas disponibles para navegar.
/// - `Destination`: Tipo de vista destino al que se navegará según la ruta.
///
/// ## Uso:
/// Esta vista se integra con un `Router` como `EnvironmentObject`
/// y usa `NavigationStack` para manejar la pila de navegación.
///
/// ```swift
/// struct AppRoutes: RouteProtocol {
///     case details(id: String)
/// }
///
/// struct DetailsPage: View {
///     let id: String
///     var body: some View { Text("ID: \(id)") }
/// }
///
/// struct AppView: View {
///     var body: some View {
///         NavigationModule(
///             onNavigateTo: { route in
///                 switch route {
///                 case .detalles(let id): DetailsPage(id: id)
///                 }
///             },
///             content: {
///                 HomePage()
///             }
///         )
///     }
/// }
/// ```
///
/// - Note: Se espera que el `Router` sea inyectado como `EnvironmentObject` en el árbol de vistas.
public struct NavigationModule<Content: View, Route: RouteProtocol, Destination: View>: View {
    
    /// Objeto de enrutamiento compartido para controlar la navegación.
    @EnvironmentObject
    private var router: Router
    
    /// Contenido raíz del módulo de navegación.
    private let content: () -> Content
    
    /// Closure que construye la vista de destino a partir de una ruta.
    private let onNavigateTo: (Route) -> Destination
    
    /// Inicializador del módulo de navegación.
    ///
    /// - Parameters:
    ///   - onNavigateTo: Closure que recibe una ruta y retorna la vista de destino correspondiente.
    ///   - content: Closure que retorna la vista principal a mostrar dentro del `NavigationStack`.
    public init(
        @ViewBuilder onNavigateTo: @escaping (Route) -> Destination,
        content: @escaping () -> Content,
    ) {
        self.content = content
        self.onNavigateTo = onNavigateTo
    }
    
    /// Cuerpo de la vista.
    ///
    /// Renderiza un `NavigationStack` que reacciona a los cambios en el `router.navPath`
    /// y permite la navegación utilizando rutas tipadas.
    public var body: some View {
        NavigationStack(path: $router.navPath) {
            content()
                .navigationDestination(for: Route.self, destination: onNavigateTo)
                .navigationBarBackButtonHidden()
        }
    }
}
