//
//  BaseRepositoryProtocol.swift
//  MELIStoreCore
//
//  Created by Andres Duque on 5/04/25.
//

/// `BaseRepositoryProtocol` define un contrato genérico para la ejecución de una
/// fuente de datos (data source), aplicando un mapper para transformar entidades
/// y manejar las llamadas asíncronas a un servicio o repositorio remoto.
///
/// Esta abstracción permite desacoplar la lógica de transformación entre entidades
/// de dominio, modelos de red (request/response), y el resultado final que se devuelve.
///
/// El protocolo se basa en un `BaseMapperProtocol` que transforma las entidades en
/// ambos sentidos (de entidad a request y de response a entidad final).
///
/// ### Tipo de uso:
/// Este protocolo es ideal para encapsular lógica reutilizable en repositorios
/// que deben llamar a servicios o fuentes de datos remotas con conversión de modelos.
///
/// ### Requisitos del Mapper:
/// - `InputEntity`: Modelo de entrada (normalmente del dominio).
/// - `OutputModel`: Modelo de request (red o externo).
/// - `InputModel`: Modelo de response (de la red).
/// - `OutputEntity`: Modelo de salida (normalmente del dominio).

public protocol BaseRepositoryProtocol {
    
    /// Ejecuta una fuente de datos aplicando un mapper
    /// para transformar la entidad de entrada en un request, y luego
    /// el response en una entidad de salida.
    ///
    /// - Parameters:
    ///   - mapper: Instancia de un `BaseMapperProtocol` que define las transformaciones necesarias.
    ///   - data: Entidad de entrada que será mapeada al request.
    ///   - call: Función asíncrona que ejecuta la operación (por ejemplo, una llamada HTTP).
    ///
    /// - Returns: La entidad de salida mapeada a partir del response.
    /// - Throws: Propaga errores de mapeo o de la llamada `call`.
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

/// Implementación por defecto de `executeDataSource`, que realiza el flujo completo:
/// 1. Mapea la entidad de entrada al modelo de request.
/// 2. Ejecuta la llamada usando ese request.
/// 3. Mapea la respuesta al modelo de salida.
///
/// Este comportamiento puede ser sobrescrito si es necesario.
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
