//
//  RequestError.swift
//  MELIStore
//
//  Created by Andres Duque on 5/04/25.
//

public enum RequestError: Error, Sendable {
    case invalidURL
    case statusCode(Int)
    case fail
}
