//
//  RequestError.swift
//  MELIStore
//
//  Created by Andres Duque on 5/04/25.
//

/// `RequestError` representa los distintos tipos de errores que pueden ocurrir
/// durante una petición HTTP en la capa de red del sistema.
///
/// Este enum facilita el manejo de errores de forma tipada y clara, incluyendo
/// errores comunes como URL inválida, códigos de estado específicos, errores
/// de autenticación y recursos no encontrados.
///
/// También incluye una función estática para mapear automáticamente códigos
/// de estado HTTP (`statusCode`) a errores del dominio.
public enum RequestError: Error, Sendable {
    
    /// La URL proporcionada es inválida.
    case invalidURL
    
    /// Error genérico que encapsula un código de estado HTTP.
    case statusCode(Int)
    
    /// Error 401 - No autorizado.
    case unauthorized
    
    /// Error 404 - Recurso no encontrado.
    case notFound
    
    /// Error genérico sin código de estado definido.
    case fail
    
    /// Construye un `RequestError` a partir de un código de estado HTTP.
    ///
    /// - Parameter statusCode: Código de estado de la respuesta HTTP.
    /// - Returns: Un valor del enum `RequestError` que representa el error correspondiente.
    static func build(from statusCode: Int?) -> RequestError {
        guard let statusCode else {
            return .fail
        }
        
        switch statusCode {
        case 401: return .unauthorized
        case 404: return .notFound
        default: return .statusCode(statusCode)
        }
    }
}
