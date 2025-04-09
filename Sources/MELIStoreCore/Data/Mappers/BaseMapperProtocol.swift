//
//  BaseMapperProtocol.swift
//  MELIStore
//
//  Created by Andres Duque on 5/04/25.
//

/// Protocolo compuesto que combina la funcionalidad
/// de `BaseRequestMapperProtocol` y `BaseResponseMapperProtocol`.
///
/// Este protocolo permite definir un único mapper capaz de transformar:
/// - Una entidad del dominio en un modelo de red para una petición (`mapRequest`)
/// - Una respuesta de red en una entidad del dominio (`mapResponse`)
///
/// Al adoptar este protocolo, puedes centralizar la lógica de mapeo
/// bidireccional entre los modelos de red y las entidades del dominio,
/// promoviendo un código más limpio, reutilizable y fácil de testear.
///
/// ### Conforma:
/// - `BaseRequestMapperProtocol`
/// - `BaseResponseMapperProtocol`
public protocol BaseMapperProtocol: BaseRequestMapperProtocol, BaseResponseMapperProtocol {}
