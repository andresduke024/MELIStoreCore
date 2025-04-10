//
//  BaseRequestMapperProtocol.swift
//  MELIStoreCore
//
//  Created by Andres Duque on 5/04/25.
//

/// `BaseRequestMapperProtocol` define un protocolo base para transformar
/// entidades del dominio (`InputEntity`) en modelos de red (`OutputModel`) que serán
/// utilizados en peticiones HTTP.
///
/// Este protocolo es útil para separar la lógica de construcción de solicitudes
/// de la lógica de negocio, permitiendo mantener un diseño limpio y desacoplado.
///
/// ### Asociados:
/// - `InputEntity`: El tipo de entidad de dominio que contiene los datos a enviar.
/// - `OutputModel`: El tipo del modelo que se utilizará como cuerpo de la solicitud HTTP,
///   generalmente conformando a `Encodable` o `RequestModelProtocol`.
///
/// ### Métodos:
/// - `mapRequest`: Convierte una entidad del dominio en un modelo de red apto para ser
///   enviado en una petición.
public protocol BaseRequestMapperProtocol: Sendable {
    
    /// La entidad del dominio que se desea transformar.
    associatedtype InputEntity
    
    /// El modelo de red resultante, utilizado como cuerpo de la petición.
    associatedtype OutputModel
    
    /// Transforma una entidad del dominio en un modelo de red.
    /// - Parameter input: Entidad del dominio.
    /// - Returns: Modelo a enviar en la petición.
    func mapRequest(_ input: InputEntity) throws -> OutputModel
}
