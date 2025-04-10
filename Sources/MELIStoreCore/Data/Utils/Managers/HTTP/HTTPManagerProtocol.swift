//
//  HTTPManagerProtocol.swift
//  MELIStore
//
//  Created by Andres Duque on 5/04/25.
//

import Foundation
import SwiftDependencyInjector

/// `HTTPManagerProtocol` define la interfaz que deben implementar
/// los manejadores encargados de realizar llamadas HTTP, incluyendo
/// solicitudes `POST` y `GET`.
///
/// Este protocolo permite abstraer la lógica de red para facilitar pruebas,
/// inyección de dependencias y reutilización de código en la capa de datos.
///
/// ### Métodos Disponibles:
/// - `post`: Ejecuta una solicitud HTTP de tipo POST.
/// - `get`: Ejecuta una solicitud HTTP de tipo GET.
///
/// Cada método admite parámetros opcionales como headers adicionales,
/// autenticación requerida, parámetros de consulta (`queryParams`) o
/// cuerpo (`body`), y un mapeador de errores personalizado.
public protocol HTTPManagerProtocol: Sendable {
    
    /// Ejecuta una solicitud HTTP de tipo POST.
    ///
    /// - Parameters:
    ///   - endpoint: Objeto que representa el endpoint a consumir.
    ///   - extraHeaders: Closure opcional para agregar headers personalizados.
    ///   - requiresAuthentication: Indica si se requiere token de autenticación.
    ///   - body: Modelo que representa el cuerpo del request.
    ///   - requestErrorMapper: Closure opcional para transformar errores HTTP.
    ///
    /// - Returns: Un modelo decodificable del tipo `T`.
    func post<T: Decodable & Sendable>(
        endpoint: EndpointProtocol,
        extraHeaders: ((HeadersBuilder) async -> HeadersBuilder)?,
        requiresAuthentication: Bool,
        body: RequestModelProtocol?,
        requestErrorMapper: ((RequestError) -> Error)?
    ) async throws -> T
    
    /// Ejecuta una solicitud HTTP de tipo GET.
    ///
    /// - Parameters:
    ///   - endpoint: Objeto que representa el endpoint a consumir.
    ///   - extraHeaders: Closure opcional para agregar headers personalizados.
    ///   - requiresAuthentication: Indica si se requiere token de autenticación.
    ///   - queryParams: Parámetros opcionales a incluir en la URL.
    ///   - requestErrorMapper: Closure opcional para transformar errores HTTP.
    ///
    /// - Returns: Un modelo decodificable del tipo `T`.
    func get<T: Decodable & Sendable>(
        endpoint: EndpointProtocol,
        extraHeaders: ((HeadersBuilder) async -> HeadersBuilder)?,
        requiresAuthentication: Bool,
        queryParams: QueryParamsModelProtocol?,
        requestErrorMapper: ((RequestError) -> Error)?
    ) async throws -> T
}
