//
//  FieldValidator.swift
//  MELIStoreCore
//
//  Created by Andres Duque on 9/04/25.
//

/// Protocolo que define la interfaz para validadores de texto.
///
/// Los tipos que conformen este protocolo deben implementar una función de validación
/// que reciba un texto como entrada y lance un error si no cumple con ciertas reglas.
///
/// - Note: Los errores lanzados deben estar relacionados con la validación (por ejemplo, `ValidationError`).
public protocol ValidatorProtocol {
    
    /// Valida una cadena de texto según una o más reglas definidas.
    ///
    /// - Parameter text: El texto a validar.
    /// - Throws: Un error si el texto no cumple con las reglas de validación.
    func validate(_ text: String) throws
}
