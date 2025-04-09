//
//  BasicModuleProtocol.swift
//  MELIStoreCore
//
//  Created by Andres Duque on 8/04/25.
//

/// Protocolo base para todos los módulos dentro de la arquitectura de la aplicación.
///
/// Este protocolo define la estructura mínima que debe tener cualquier módulo,
/// especificando un contenedor de dependencias (`dependenciesContainer`) que
/// se usará para registrar e inyectar las dependencias necesarias.
///
/// Este protocolo es útil para estandarizar la forma en la que los módulos declaran
/// y exponen sus dependencias, permitiendo que puedan ser fácilmente integrados en
/// el entorno de la aplicación usando inyección de dependencias.
///
/// ### Ejemplo de implementación:
/// ```swift
/// struct AuthModule: BasicModuleProtocol {
///     var dependenciesContainer: DependenciesContainer {
///         AuthDependenciesContainer()
///     }
/// }
/// ```
public protocol BasicModuleProtocol: Sendable {
    
    /// Contenedor de dependencias del módulo.
    ///
    /// Este contenedor debe registrar todos los servicios, repositorios y componentes
    /// necesarios para el funcionamiento del módulo, permitiendo su inyección
    /// automática donde se necesite.
    var dependenciesContainer: DependenciesContainer { get }
}
