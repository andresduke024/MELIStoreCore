//
//  ModuleProtocol.swift
//  MELIStore
//
//  Created by Andres Duque on 5/04/25.
//

import SwiftUI

/// Protocolo base para definir un módulo funcional dentro de la arquitectura de la aplicación.
///
/// `ModuleProtocol` extiende `BasicModuleProtocol` y define un punto de entrada visual (`entryPoint`)
/// que representa la vista inicial del módulo. Esta vista se usará para renderizar el contenido
/// del módulo en la aplicación.
///
/// Este protocolo es útil cuando se implementan módulos desacoplados y reutilizables en una arquitectura
/// basada en dependencias inyectables y navegación modular.
///
/// ### Requisitos:
/// - Conformar a `BasicModuleProtocol` (debe proveer un contenedor de dependencias).
/// - Definir una propiedad `entryPoint` que representa la vista raíz del módulo.
///
/// ### Ejemplo de implementación:
/// ```swift
/// struct MyModule: ModuleProtocol {
///     var dependenciesContainer: any DependenciesContainer {
///         MyDependenciesContainer()
///     }
///
///     var entryPoint: some View {
///         MyStartPage()
///     }
/// }
/// ```
public protocol ModuleProtocol: BasicModuleProtocol {
    
    /// Tipo de la vista que será el punto de entrada del módulo.
    associatedtype EntryPoint: View
    
    /// Vista raíz del módulo, que será presentada al navegar hacia este módulo.
    ///
    /// Este punto de entrada se debe construir utilizando cualquier vista de SwiftUI
    /// que represente la pantalla inicial del módulo.
    @MainActor
    var entryPoint: EntryPoint { get }
}
