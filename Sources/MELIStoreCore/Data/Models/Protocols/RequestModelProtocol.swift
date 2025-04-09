//
//  RequestModelProtocol.swift
//  MELIStoreCore
//
//  Created by Andres Duque on 5/04/25.
//

/// `RequestModelProtocol` define un contrato para modelos que serán utilizados
/// como cuerpos (`body`) de solicitudes HTTP en el cliente de red.
///
/// Al conformar a este protocolo, el modelo se asegura de ser compatible con
/// codificación/decodificación (a través de `Decodable`) y seguro para concurrencia (`Sendable`).
///
/// Este protocolo es útil para tipar de forma explícita todos los modelos
/// que se utilizarán al construir una solicitud de red.
///
/// ### Conformidad:
/// Generalmente, los modelos que representen el cuerpo de un `POST`, `PUT`, `PATCH`, etc.,
/// deberían conformar a este protocolo.
public protocol RequestModelProtocol: Decodable, Sendable {}
