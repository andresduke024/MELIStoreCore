//
//  EndpointProtocol.swift
//  MELIStore
//
//  Created by Andres Duque on 5/04/25.
//

public protocol EndpointProtocol: Sendable {
    var path: String { get }
    var api: String { get }
}
