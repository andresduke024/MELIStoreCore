//
//  EnvironmentValuesProtocol.swift
//  MELIStore
//
//  Created by Andres Duque on 5/04/25.
//

/// Protocolo que define una interfaz para acceder a valores del entorno,
/// generalmente configurados en el archivo `Info.plist` de la aplicación.
///
/// Este protocolo abstrae la lectura de valores a partir de claves específicas,
/// permitiendo desacoplar la lógica de lectura del origen de datos (como un `.plist`),
/// y facilitando su implementación o reemplazo, por ejemplo, en tests o diferentes entornos.
///
/// ### Ejemplo de implementación:
/// Ver `EnvironmentValuesReader`.
public protocol EnvironmentValuesProtocol: Sendable {
    
    /// Obtiene un valor del entorno según una clave específica.
   ///
   /// - Parameter key: La clave del valor que se desea obtener, definida como un caso de `EnvironmentValueType`.
   /// - Returns: El valor del entorno casteado al tipo `T`.
   /// - Throws: La implementación puede lanzar errores o fallar si la clave no existe o el tipo no es el esperado.
    func get<T>(_ key: EnvironmentValueType) -> T
}
