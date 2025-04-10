//
//  HeadersBuilder.swift
//  MELIStoreCore
//
//  Created by Andres Duque on 8/04/25.
//

import SwiftDependencyInjector

/// `HeadersBuilder` es una utilidad para construir encabezados HTTP (headers)
/// de forma progresiva y funcional, permitiendo agregar claves como autorización
/// o personalizadas sin mutar el estado original.
///
/// Utiliza inyección de dependencias para acceder a valores de entorno como tokens
/// de autenticación y facilita la creación de encabezados de red en peticiones HTTP.
///
/// ### Ejemplo de uso:
/// ```swift
/// let headers = HeadersBuilder()
///     .addAuthorization()
///     .add(key: "Custom-Header", value: "value")
///     .build()
/// ```
///
/// Esta estructura es inmutable: cada método de modificación devuelve una nueva
/// instancia con el cambio aplicado.
///
/// - Nota: Requiere que `EnvironmentValuesProtocol` esté registrado en el contenedor
/// de dependencias para funcionar correctamente.
public struct HeadersBuilder {

    /// Inyección del lector de valores de entorno desde el contenedor de dependencias.
    @Inject
    private var environmentValues: EnvironmentValuesProtocol
    
    /// Encabezados actuales acumulados.
    private let headers: [String: String]
    
    /// Inicializador privado que permite construir una nueva instancia a partir de encabezados personalizados.
    /// - Parameter headers: Diccionario con los encabezados actuales.
    private init(headers: [String: String]) {
        self.headers = headers
    }
    
    /// Inicializador público por defecto. Crea una instancia vacía sin encabezados.
    public init() {
        self.headers = [:]
    }
    
    /// Devuelve el diccionario final de encabezados HTTP.
    /// - Returns: Un `Dictionary<String, String>` con todos los headers acumulados.
    public func build() -> [String: String] {
        return headers
    }
    
    /// Agrega el encabezado de autorización usando el token del entorno.
    /// - Returns: Una nueva instancia de `HeadersBuilder` con el header `"Authorization"` agregado.
    public func addAuthorization() -> HeadersBuilder {
        let token: String = environmentValues.get(.accessToken)
                
        return add(
            key: "Authorization", 
            value: "Bearer \(token)"
        )
    }
    
    /// Agrega un nuevo encabezado al diccionario.
   /// - Parameters:
   ///   - key: Clave del encabezado (por ejemplo `"Content-Type"`).
   ///   - value: Valor del encabezado (por ejemplo `"application/json"`).
   /// - Returns: Una nueva instancia de `HeadersBuilder` con el header agregado.
    public func add(
        key: String,
        value: String
    ) -> HeadersBuilder {
        var newHeaders = headers
        newHeaders[key] = value
        
        return HeadersBuilder(
            headers: newHeaders
        )
    }
}
