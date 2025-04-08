//
//  BaseRepositoryProtocol.swift
//  MELIStoreCore
//
//  Created by Andres Duque on 5/04/25.
//

public protocol BaseRepositoryProtocol {
    func executeDataSource<
        Mapper: BaseMapperProtocol,
        InputEntity,
        Request,
        Response,
        OutputEntity
    >(
        mapper: Mapper,
        data: InputEntity,
        call: @Sendable @escaping (Request) async throws -> Response
    ) async throws -> OutputEntity
    where
        Mapper.InputEntity == InputEntity,
        Mapper.OutputModel == Request,
        Mapper.InputModel == Response,
        Mapper.OutputEntity == OutputEntity
}

public extension BaseRepositoryProtocol {
    func executeDataSource<
        Mapper: BaseMapperProtocol,
        InputEntity,
        Request,
        Response,
        OutputEntity
    >(
        mapper: Mapper,
        data: InputEntity,
        call: @Sendable @escaping (Request) async throws -> Response
    ) async throws -> OutputEntity
    where
        Mapper.InputEntity == InputEntity,
        Mapper.OutputModel == Request,
        Mapper.InputModel == Response,
        Mapper.OutputEntity == OutputEntity
    {
        let request = try mapper.mapRequest(data)

        let response = try await call(request)

        return try mapper.mapResponse(response)
    }
}
