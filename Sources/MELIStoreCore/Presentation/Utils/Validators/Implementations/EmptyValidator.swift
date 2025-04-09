//
//  EmptyValidator.swift
//  MELIStoreCore
//
//  Created by Andres Duque on 9/04/25.
//

/// Validador que lanza un error si el texto está vacío.
///
/// `EmptyValidator` implementa el protocolo `ValidatorProtocol` y se utiliza
/// para asegurarse de que una cadena de texto no esté vacía. Si la cadena está vacía,
/// lanza un `ValidationError` con el mensaje proporcionado.
///
/// ### Ejemplo de uso:
/// ```swift
/// let validator = EmptyValidator(message: "El campo es obligatorio")
/// try validator.validate("Contenido") // No lanza error
/// try validator.validate("") // Lanza ValidationError
/// ```
public struct EmptyValidator: ValidatorProtocol {
    
    /// Mensaje que se usará en caso de que la validación falle.
    private let message: String
    
    /// Inicializa el validador con un mensaje de error personalizado.
    ///
    /// - Parameter message: Mensaje que se lanzará en caso de validación fallida.
    public init(message: String) {
        self.message = message
    }
    
    /// Valida que el texto no esté vacío.
    ///
    /// - Parameter text: Texto a validar.
    /// - Throws: `ValidationError` si el texto está vacío.
    public func validate(_ text: String) throws {
        guard text.isEmpty else { return }
        
        throw ValidationError(
            message: message
        )
    }
}
