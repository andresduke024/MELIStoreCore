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
        body: RequestModelProtocol?
    ) async throws -> T where T: Decodable & Sendable {
        return try await request(
            endpoint: endpoint,
            method: .post,
            encoding: JSONEncoding.default,
            requiresAuthentication: requiresAuthentication,
            body: body
        )
    }

    func get<T>(
        endpoint: any EndpointProtocol,
        requiresAuthentication: Bool,
        queryParams: QueryParamsModelProtocol?
    ) async throws -> T where T: Decodable & Sendable {
        return try await request(
            endpoint: endpoint,
            method: .get,
            encoding: URLEncoding.queryString,
            requiresAuthentication: requiresAuthentication,
            queryParams: queryParams
        )
    }
    
    private func request<T: Decodable & Sendable>(
        endpoint: EndpointProtocol,
        method: HTTPMethod,
        encoding: any ParameterEncoding,
        requiresAuthentication: Bool,
        body: RequestModelProtocol? = nil,
        queryParams: QueryParamsModelProtocol? = nil
    ) async throws -> T {
        let service = environmentValues.get(.baseURL) + "\(endpoint.api)/\(endpoint.path)"
        
        let token: String = environmentValues.get(.accessToken)
        
        let headers: [HTTPHeader] = [
            HTTPHeader(
                name: "Authorization",
                value: "Bearer \(token)"
            ),
        ]
        
        return try await withCheckedThrowingContinuation { continuation in
            AF.request(
                service,
                method: method,
                parameters: queryParams?.transform(),
                encoding: encoding,
                headers: HTTPHeaders(headers)
            ).responseDecodable(of: T.self) { response in
                switch response.result {
                case let .success(data):
                    continuation.resume(returning: data)

                case let .failure(error):
                    continuation.resume(throwing: error)
                }
            }
        }
    }
}
