//
//  Router.swift
//  MELIStoreCore
//
//  Created by Andres Duque on 7/04/25.
//

import SwiftUI

/// Clase responsable de gestionar la navegación dentro de la aplicación.
///
/// `Router` es un objeto observable que actúa como centro de control
/// para la navegación utilizando `NavigationStack`. Expone un `@Published`
/// `navPath`, que representa la pila de navegación actual.
///
/// Este enrutador puede utilizarse como `EnvironmentObject` para compartir
/// la lógica de navegación entre diferentes vistas del módulo.
///
/// ## Funcionalidades principales:
/// - Añadir nuevas rutas (`push`)
/// - Quitar la ruta actual (`pop`)
/// - Volver al inicio de la pila (`popToRoot`)
/// - Reemplazar la ruta actual completamente (`replace`)
///
/// ## Uso típico:
/// ```swift
/// @EnvironmentObject var router: Router
///
/// Button("Ver detalles") {
///     router.push(DetailsRoute(id: "123"))
/// }
/// ```
///
/// - Note: Este enrutador debe inyectarse como `environmentObject`
///   en la raíz del módulo para funcionar correctamente.
public final class Router: ObservableObject {
    
    /// Pila de navegación utilizada por `NavigationStack`.
    @Published
    public var navPath: NavigationPath
        
    /// Inicializa una nueva instancia del enrutador.
    public init() {
        self.navPath = NavigationPath()
    }
    
    /// Agrega una nueva ruta a la pila de navegación.
    /// - Parameter destination: Ruta conforme a `RouteProtocol`.
    public func push(_ destination: any RouteProtocol) {
        navPath.append(destination)
    }
    
    /// Alias del método `push`.
    /// - Parameter destination: Ruta conforme a `RouteProtocol`.
    public func push(destination: any RouteProtocol) {
        push(destination)
    }
    
    /// Elimina la última ruta de la pila de navegación.
    public func pop() {
        navPath.removeLast()
    }
    
    /// Elimina todas las rutas, regresando a la raíz.
    public func popToRoot() {
        navPath.removeLast(navPath.count)
    }
    
    /// Reemplaza la pila actual con una nueva ruta.
    /// - Parameter newDestination: Nueva ruta conforme a `RouteProtocol`.
    public func replace(newDestination: any RouteProtocol) {
        popToRoot()
        push(newDestination)
    }
}
