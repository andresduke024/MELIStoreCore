//
//  FieldValidationError.swift
//  MELIStoreCore
//
//  Created by Andres Duque on 9/04/25.
//

/// Representa un error de validación con un mensaje personalizado.
///
/// Esta estructura se utiliza para proporcionar retroalimentación específica
/// cuando una validación de texto u otro dato falla. Conforma el protocolo `Error`,
/// por lo que puede ser utilizada dentro de flujos de manejo de errores (`do-catch`).
///
/// ### Ejemplo de uso:
/// ```swift
/// throw ValidationError(message: "El campo no puede estar vacío.")
/// ```
///
/// Puedes utilizar esta estructura junto con validadores personalizados para
/// mostrar mensajes específicos en la UI o para depuración.
public struct ValidationError: Error {
    
    /// Mensaje descriptivo del error de validación.
    public let message: String
    
    /// Inicializa un nuevo `ValidationError` con un mensaje específico.
    ///
    /// - Parameter message: Mensaje asociado al error de validación.
    public init(message: String) {
        self.message = message
    }
}
