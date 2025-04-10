//
//  EndpointProtocol.swift
//  MELIStore
//
//  Created by Andres Duque on 5/04/25.
//

/// Protocolo que define la estructura base para representar un endpoint
/// dentro de una capa de red o consumo de APIs.
///
/// Cualquier tipo que implemente este protocolo podrá ser usado para
/// construir rutas completas a servicios web, separando la lógica del dominio
/// de la configuración específica de cada API.
public protocol EndpointProtocol: Sendable {
    
    /// Ruta específica del endpoint (por ejemplo: `/items/ML123`)
    var path: String { get }
    
    /// Nombre o ruta base de la API (por ejemplo: `api/v1` o `catalog`)
    var api: String { get }
}
