//
//  EnvironmentValuesKeys.swift
//  MELIStore
//
//  Created by Andres Duque on 5/04/25.
//

import Foundation

/// Enumeración que define las claves utilizadas para acceder a valores del entorno
/// dentro del archivo `Info.plist` de la aplicación.
///
/// Estas claves se utilizan en conjunto con implementaciones de `EnvironmentValuesProtocol`
/// para acceder de manera segura y tipada a configuraciones globales como URLs base,
/// tokens de autenticación, etc.
///
/// ### Ejemplo de uso:
/// ```swift
/// let reader: EnvironmentValuesProtocol = EnvironmentValuesReader()
/// let token: String = reader.get(.accessToken)
/// ```
///
/// Las claves deben existir bajo la estructura `Environment` en el archivo `Info.plist`.
///
/// ### Ejemplo de estructura en el Info.plist:
/// ```xml
/// <key>Environment</key>
/// <dict>
///     <key>ACCESS_TOKEN</key>
///     <string>abc123</string>
///     <key>BASE_URL</key>
///     <string>https://api.mystore.com</string>
/// </dict>
/// ```
public enum EnvironmentValueType: String, Sendable {
    
    /// Token de acceso usado para autenticación en llamadas de red.
    case accessToken = "ACCESS_TOKEN"
    
    /// URL base del backend de la aplicación.
    case baseURL = "BASE_URL"
}
