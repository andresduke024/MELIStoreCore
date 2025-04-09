//
//  EnvironmentValues.swift
//  MELIStore
//
//  Created by Andres Duque on 5/04/25.
//

import Foundation
import SwiftDependencyInjector

/// Implementación concreta del protocolo `EnvironmentValuesProtocol`
/// encargada de leer valores definidos en el archivo `Info.plist` bajo la clave `"Environment"`.
///
/// Esta utilidad permite centralizar el acceso a variables de entorno configuradas
/// para diferentes targets o esquemas de la aplicación, como `API_URL`, `APP_VERSION`, etc.
///
/// Si la propiedad solicitada no existe o no puede ser casteada al tipo esperado, se lanzará un `fatalError`.
///
/// > Nota: Asegúrate de que el archivo `Info.plist` contenga un diccionario con la clave `"Environment"`
/// > y que todas las claves dentro de él coincidan con los casos definidos en `EnvironmentValueType`.
struct EnvironmentValuesReader: EnvironmentValuesProtocol {
    
    /// Obtiene un valor del entorno a partir de una clave proporcionada.
    ///
    /// - Parameter key: Clave del valor que se desea obtener (caso de `EnvironmentValueType`).
    /// - Returns: El valor asociado a la clave casteado al tipo `T`.
    /// - Throws: `fatalError` si la clave no se encuentra o el valor no puede ser casteado al tipo esperado.
    func get<T>(_ key: EnvironmentValueType) -> T {
        let environment = readEnvironment()
        
        guard let data = environment[key.rawValue], let value = data as? T else {
            fatalError("Environment value with key \(key.rawValue) not founded")
        }
        
        return value
    }
    
    /// Lee el diccionario de entorno desde el archivo `Info.plist`.
    ///
    /// - Returns: Diccionario con las variables de entorno definidas.
    /// - Throws: `fatalError` si el archivo `plist` no existe o no contiene la clave `"Environment"`.
    private func readEnvironment() -> [String : Any] {
        guard let plist = Bundle.main.infoDictionary else {
            fatalError("Plist file not found")
        }
        
        guard let global = plist["Environment"] as? [String : Any] else {
            fatalError("GlobalVariables not set in plist")
        }

        return global
    }
}
