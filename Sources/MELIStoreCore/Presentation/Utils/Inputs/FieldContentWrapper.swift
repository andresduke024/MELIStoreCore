//
//  FieldContentWrapper.swift
//  MELIStoreCore
//
//  Created by Andres Duque on 9/04/25.
//

import Foundation

/// Wrapper para campos de texto con validación integrada.
///
/// `FieldContentWrapper` permite manejar el contenido de un campo de texto
/// junto con su validación y posibles errores. Se puede utilizar en formularios
/// o entradas de usuario donde se necesiten aplicar validaciones personalizadas.
///
/// ### Ejemplo de uso:
/// ```swift
/// var field = FieldContentWrapper.build(
///     initialValue: "",
///     rules: [EmptyValidator(message: "Este campo es obligatorio")]
/// )
///
/// let isValid = field.validate()
/// print(field.error) // "Este campo es obligatorio"
/// ```
public struct FieldContentWrapper {
    
    /// Contenido del campo de texto.
    public var content: String
    
    /// Mensaje de error actual del campo, si existe.
    public var error: String?
    
    /// Marca si la validación ya ha sido ejecutada al menos una vez.
    public var isFirstValidationDone: Bool = false
    
    /// Lista de validadores asociados al campo.
    private let validators: [ValidatorProtocol]
    
    /// Indica si hay un error de validación presente.
    public var hasError: Bool { error != nil }
    
    /// Inicializa una instancia de `FieldContentWrapper`.
    ///
    /// - Parameters:
    ///   - content: Valor inicial del campo.
    ///   - validators: Lista de reglas de validación a aplicar.
    private init(
        initial content: String,
        validators: [ValidatorProtocol] = []
    ) {
        self.content = content
        self.error = nil
        self.validators = validators
    }
    
    /// Ejecuta la validación del campo.
    ///
    /// - Parameter always: Si es `false`, sólo se valida si ya se validó antes.
    /// - Returns: `true` si no hay errores, `false` en caso contrario.
    @MainActor
    @discardableResult
    mutating public func validate(
        always: Bool = true
    ) -> Bool {
        if !always && !isFirstValidationDone {
            return !hasError
        }
        
        executeValidators()
        isFirstValidationDone = true
        
        return !hasError
    }
    
    /// Ejecuta todos los validadores y asigna el mensaje de error si aplica.
    @MainActor
    mutating private func executeValidators() {
        do {
            for item in validators {
                try item.validate(content)
            }
            
            self.error = nil
        } catch let validationError as ValidationError {
            self.error = validationError.message
        } catch let validationError {
            self.error = validationError.localizedDescription
        }
    }
}

public extension FieldContentWrapper {
    /// Construye una instancia de `FieldContentWrapper` con valores iniciales.
    ///
    /// - Parameters:
    ///   - initialValue: Valor inicial del campo.
    ///   - validators: Lista de validadores a aplicar.
    /// - Returns: Una nueva instancia de `FieldContentWrapper`.
    static func build(
        initialValue: String = "",
        rules validators: [ValidatorProtocol] = []
    ) -> FieldContentWrapper {
        return FieldContentWrapper(
            initial: initialValue,
            validators: validators
        )
    }
}
