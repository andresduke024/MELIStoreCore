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
        requiresAuthentication: Bool,
        body: RequestModelProtocol?,
        requestErrorMapper: ((RequestError) -> Error)?
    ) async throws -> T where T: Decodable & Sendable {
        return try await request(
            endpoint: endpoint,
            method: .post,
            encoding: JSONEncoding.default,
            requiresAuthentication: requiresAuthentication,
            body: body,
            requestErrorMapper: requestErrorMapper
        )
    }

    func get<T>(
        endpoint: any EndpointProtocol,
        requiresAuthentication: Bool,
        queryParams: QueryParamsModelProtocol?,
        requestErrorMapper: ((RequestError) -> Error)?
    ) async throws -> T where T: Decodable & Sendable {
        return try await request(
            endpoint: endpoint,
            method: .get,
            encoding: URLEncoding.queryString,
            requiresAuthentication: requiresAuthentication,
            queryParams: queryParams,
            requestErrorMapper: requestErrorMapper
        )
    }
    
    private func request<T: Decodable & Sendable>(
        endpoint: EndpointProtocol,
        method: HTTPMethod,
        encoding: any ParameterEncoding,
        requiresAuthentication: Bool,
        body: RequestModelProtocol? = nil,
        queryParams: QueryParamsModelProtocol? = nil,
        requestErrorMapper: ((RequestError) -> Error)?
    ) async throws -> T {
        do {
            return try await performRequest(
                service: environmentValues.get(.baseURL) + "\(endpoint.api)/\(endpoint.path)",
                method: method,
                queryParameters: queryParams?.transform(),
                encoding: encoding,
                headers: createHeaders(requiresAuthentication: requiresAuthentication)
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
    
    private func createHeaders(
        requiresAuthentication: Bool
    ) -> [HTTPHeader] {
        var headers: [HTTPHeader] = []
        
        if !requiresAuthentication { return headers }
        
        let token: String = environmentValues.get(.accessToken)
        
        let authorization = HTTPHeader(
            name: "Authorization",
            value: "Bearer \(token)"
        )
        
        headers.append(authorization)
        
        return headers
    }
}
