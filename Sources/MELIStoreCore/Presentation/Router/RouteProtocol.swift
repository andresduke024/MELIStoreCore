//
//  RouteProtocol.swift
//  MELIStoreCore
//
//  Created by Andres Duque on 7/04/25.
//

/// Protocolo base para definir rutas de navegación en el módulo.
///
/// `RouteProtocol` permite que cualquier enumeración o tipo conforme
/// pueda ser utilizado como una ruta identificable y única dentro
/// de un `NavigationStack`.
///
/// Conformar a este protocolo implica adoptar `Hashable`, ya que SwiftUI
/// necesita que los destinos en `navigationDestination(for:destination:)`
/// puedan ser comparados y diferenciados en la pila de navegación.
///
/// ## Uso típico:
/// Se recomienda usar una enumeración para representar las rutas disponibles:
///
/// ```swift
/// enum AppRoutes: RouteProtocol {
///     case detallesProducto(id: String)
///     case perfilUsuario
/// }
/// ```
///
/// Estas rutas luego pueden usarse en componentes como `NavigationModule`
/// para controlar la navegación de forma centralizada y segura.
///
/// - Important: Cada tipo que conforme a `RouteProtocol` debe ser único
///   y representativo de una vista destino concreta.
public protocol RouteProtocol: Hashable {}
