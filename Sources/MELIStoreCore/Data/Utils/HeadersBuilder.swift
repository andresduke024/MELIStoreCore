//
//  HeadersBuilder.swift
//  MELIStoreCore
//
//  Created by Andres Duque on 8/04/25.
//

import SwiftDependencyInjector

public struct HeadersBuilder {

    @Inject
    private var environmentValues: EnvironmentValuesProtocol
    
    private let headers: [String: String]
    
    private init(headers: [String: String]) {
        self.headers = headers
    }
    
    public init() {
        self.headers = [:]
    }
    
    public func build() -> [String: String] {
        return headers
    }
    
    public func addAuthorization() -> HeadersBuilder {
        let token: String = environmentValues.get(.accessToken)
                
        return add(
            key: "Authorization", 
            value: "Bearer \(token)"
        )
    }
    
    public func add(
        key: String,
        value: String
    ) -> HeadersBuilder {
        var newHeaders = headers
        newHeaders[key] = value
        
        return HeadersBuilder(
            headers: newHeaders
        )
    }
}
