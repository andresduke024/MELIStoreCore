//
//  CoreConstants.swift
//  MELIStoreCore
//
//  Created by Andres Duque on 5/04/25.
//

/// Contenedor de constantes reutilizables dentro del núcleo (`Core`) de la aplicación.
///
/// Esta estructura agrupa valores constantes que pueden ser utilizados en diferentes
/// capas del sistema, como en lógica de red, lógica de reintentos, entre otros.
public struct CoreConstants {
    /// Número máximo de intentos permitidos al ejecutar una operación.
    public static let maxExecutionAttempts = 3
    
    /// Separador de rutas utilizado para construir endpoints (ej: `/some-endpoint`).
    public static let pathSeparator = "/"
}

