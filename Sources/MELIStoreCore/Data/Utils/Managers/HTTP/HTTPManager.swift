//
//  HTTPManager.swift
//  MELIStore
//
//  Created by Andres Duque on 5/04/25.
//

import Foundation
import Alamofire
import SwiftDependencyInjector

struct HTTPManager: HTTPManagerProtocol {
    
    @Inject
    private var environmentValues: EnvironmentValuesProtocol
    
    @Inject
    private var urlSession: URLSession
    
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
    
    private func createServiceURL(_ endpoint: EndpointProtocol) -> String {
        let url = environmentValues.get(.baseURL)
            + "\(endpoint.api)\(CoreConstants.pathSeparator)\(endpoint.path)"
        
        return url.replacingOccurrences(of: "//", with: CoreConstants.pathSeparator)
    }
    
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
