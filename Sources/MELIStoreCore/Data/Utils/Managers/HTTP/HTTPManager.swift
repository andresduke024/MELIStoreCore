//
//  HTTPManager.swift
//  MELIStore
//
//  Created by Andres Duque on 5/04/25.
//

import Foundation
import Alamofire
import SwiftDependencyInjector

/// `HTTPManager` es la implementación por defecto del protocolo `HTTPManagerProtocol`.
/// Se encarga de realizar llamadas HTTP de tipo `GET` y `POST`, utilizando Alamofire
/// como motor de red.
///
/// Incorpora lógica para construir headers dinámicamente, codificar el cuerpo o
/// parámetros de la solicitud, y mapear errores en función del código de estado.
///
/// ### Métodos principales:
/// - `post(...)`: Realiza una solicitud HTTP POST.
/// - `get(...)`: Realiza una solicitud HTTP GET.
struct HTTPManager: HTTPManagerProtocol {
    
    @Inject
    private var environmentValues: EnvironmentValuesProtocol
        
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
    func post<T>(
        endpoint: any EndpointProtocol,
        extraHeaders: ((HeadersBuilder) async -> HeadersBuilder)?,
        requiresAuthentication: Bool,
        body: RequestModelProtocol?,
        requestErrorMapper: ((RequestError) -> Error)?
    ) async throws -> T where T: Decodable & Sendable {
        return try await request(
            endpoint: endpoint,
            method: .post,
            encoding: JSONEncoding.default,
            extraHeaders: extraHeaders,
            requiresAuthentication: requiresAuthentication,
            body: body,
            requestErrorMapper: requestErrorMapper
        )
    }

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
    func get<T>(
        endpoint: any EndpointProtocol,
        extraHeaders: ((HeadersBuilder) async -> HeadersBuilder)?,
        requiresAuthentication: Bool,
        queryParams: QueryParamsModelProtocol?,
        requestErrorMapper: ((RequestError) -> Error)?
    ) async throws -> T where T: Decodable & Sendable {
        return try await request(
            endpoint: endpoint,
            method: .get,
            encoding: URLEncoding.queryString,
            extraHeaders: extraHeaders,
            requiresAuthentication: requiresAuthentication,
            queryParams: queryParams,
            requestErrorMapper: requestErrorMapper
        )
    }
    
    /// Lógica central de solicitud HTTP reutilizable entre `GET` y `POST`.
    private func request<T: Decodable & Sendable>(
        endpoint: EndpointProtocol,
        method: HTTPMethod,
        encoding: any ParameterEncoding,
        extraHeaders: ((HeadersBuilder) async -> HeadersBuilder)?,
        requiresAuthentication: Bool,
        body: RequestModelProtocol? = nil,
        queryParams: QueryParamsModelProtocol? = nil,
        requestErrorMapper: ((RequestError) -> Error)?
    ) async throws -> T {
        do {
            let headers = await createHeaders(
                requiresAuthentication: requiresAuthentication,
                extraHeaders: extraHeaders
            )
            
            let service = createServiceURL(endpoint)
            
            return try await performRequest(
                service: service,
                method: method,
                queryParameters: queryParams?.transform(),
                encoding: encoding,
                headers: headers
            )
        } catch let error as RequestError {
            guard let requestErrorMapper else { throw error }
            
            throw requestErrorMapper(error)
        } catch {
            throw error
        }
    }
    
    /// Ejecuta la solicitud real usando Alamofire y maneja la respuesta.
    private func performRequest<T: Decodable & Sendable>(
        service: String,
        method: HTTPMethod,
        queryParameters: [String: Sendable]?,
        encoding: any ParameterEncoding,
        headers: [HTTPHeader]
    ) async throws -> T {
        return try await withCheckedThrowingContinuation { continuation in
            AF.request(
                service,
                method: method,
                parameters: queryParameters,
                encoding: encoding,
                headers: HTTPHeaders(headers)
            )
            .validate()
            .responseDecodable(of: T.self) { response in
                switch response.result {
                case let .success(data):
                    continuation.resume(returning: data)

                case let .failure(error):
                    guard let statusCode = error.responseCode else {
                        continuation.resume(throwing: error)
                        return
                    }
                    
                    let newError = RequestError.build(from: statusCode)
                    continuation.resume(throwing: newError)
                }
            }
        }
    }
    
    /// Construye la URL completa del servicio usando el endpoint y los valores del entorno.
    private func createServiceURL(_ endpoint: EndpointProtocol) -> String {
        let url = environmentValues.get(.baseURL)
            + "\(endpoint.api)\(CoreConstants.pathSeparator)\(endpoint.path)"
        
        return url.replacingOccurrences(of: "//", with: CoreConstants.pathSeparator)
    }
    
    /// Genera un array de `HTTPHeader` listos para ser usados en una solicitud.
    private func createHeaders(
        requiresAuthentication: Bool,
        extraHeaders: ((HeadersBuilder) async -> HeadersBuilder)?
    ) async -> [HTTPHeader] {
        let builder = await createHeadersBuilder(
            requiresAuthentication: requiresAuthentication,
            extraHeaders: extraHeaders
        )
        
        let headers = builder.build().map {
            HTTPHeader(name: $0.key, value: $0.value)
        }
        
        return headers
    }
    
    /// Construye un `HeadersBuilder`, permitiendo inyectar headers custom y auth.
    private func createHeadersBuilder(
        requiresAuthentication: Bool,
        extraHeaders: ((HeadersBuilder) async -> HeadersBuilder)?
    ) async -> HeadersBuilder {
        var builder = HeadersBuilder()
        
        if let extraHeaders {
            builder = await extraHeaders(builder)
        }
        
        if !requiresAuthentication { return builder }
        
        return builder.addAuthorization()
    }
}
