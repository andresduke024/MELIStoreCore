//
//  QueryParamsModelProtocol.swift
//  MELIStoreCore
//
//  Created by Andres Duque on 5/04/25.
//

/// `QueryParamsModelProtocol` define un contrato para modelos que deben representar
/// sus datos como un diccionario de parámetros de consulta (`query parameters`)
/// que pueden ser enviados en una URL, por ejemplo en peticiones HTTP GET.
///
/// Esta abstracción permite estandarizar la forma en que los modelos definen
/// y transforman su contenido en parámetros de red.
public protocol QueryParamsModelProtocol {
    
    /// Transforma el modelo actual en un diccionario de parámetros
    /// de consulta (`query parameters`) para ser usado en peticiones.
    ///
    /// - Returns: Un diccionario con claves tipo `String` y valores `Sendable`.
    func transform() -> [String: Sendable]
}
