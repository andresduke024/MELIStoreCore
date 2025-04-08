//
//  HTTPManagerProtocol.swift
//  MELIStore
//
//  Created by Andres Duque on 5/04/25.
//

import Foundation
import SwiftDependencyInjector

public protocol HTTPManagerProtocol: Sendable {    
    func post<T: Decodable & Sendable>(
        endpoint: EndpointProtocol,
        requiresAuthentication: Bool,
        body: RequestModelProtocol?,
        requestErrorMapper: ((RequestError) -> Error)?
    ) async throws -> T
    
    func get<T: Decodable & Sendable>(
        endpoint: EndpointProtocol,
        requiresAuthentication: Bool,
        queryParams: QueryParamsModelProtocol?,
        requestErrorMapper: ((RequestError) -> Error)?
    ) async throws -> T
}
