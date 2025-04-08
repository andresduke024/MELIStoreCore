//
//  RequestError.swift
//  MELIStore
//
//  Created by Andres Duque on 5/04/25.
//

public enum RequestError: Error, Sendable {
    case invalidURL
    case statusCode(Int)
    case unauthorized
    case notFound
    case fail
    
    static func build(from statusCode: Int?) -> RequestError {
        guard let statusCode else {
            return .fail
        }
        
        switch statusCode {
        case 401: return .unauthorized
        case 404: return .notFound
        default: return .statusCode(statusCode)
        }
    }
}
