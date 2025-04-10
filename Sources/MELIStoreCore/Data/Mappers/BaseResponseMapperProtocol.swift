//
//  BaseResponseMapperProtocol.swift
//  MELIStoreCore
//
//  Created by Andres Duque on 5/04/25.
//

/// `BaseResponseMapperProtocol` define un protocolo base para transformar
/// modelos de red (`InputModel`) en entidades de dominio (`OutputEntity`).
///
/// Este protocolo es útil para desacoplar la capa de red de la lógica de negocio,
/// asegurando que los modelos recibidos desde el backend puedan ser convertidos
/// en estructuras más adecuadas para el dominio de la aplicación.
///
/// ### Asociados:
/// - `InputModel`: El tipo del modelo recibido desde el backend (normalmente `Decodable`).
/// - `OutputEntity`: El tipo al que se desea transformar el modelo para uso interno.
///
/// ### Métodos:
/// - `mapResponse`: Transforma un modelo recibido desde la red en una entidad de dominio.
/// - `mapOptionalList`: Método utilitario (definido por extensión) para transformar una lista opcional
///   de elementos en otra lista, ignorando valores `nil` resultantes del mapeo.
public protocol BaseResponseMapperProtocol: Sendable {
    associatedtype InputModel
    associatedtype OutputEntity
    
    /// Transforma un modelo de red en una entidad de dominio.
    /// - Parameter input: El modelo recibido desde el backend.
    /// - Returns: La entidad de dominio transformada.
    func mapResponse(_ input: InputModel) throws -> OutputEntity
    
    /// Transforma una lista opcional usando un closure, ignorando elementos `nil`.
   /// - Parameters:
   ///   - list: Lista opcional de entrada.
   ///   - transform: Función que transforma cada elemento.
   /// - Returns: Lista resultante sin valores `nil`.
    func mapOptionalList<Input, Output>(
        _ list: [Input]?,
        _ transform: (Input) throws -> Output?
    ) rethrows -> [Output]
}


public extension BaseResponseMapperProtocol {
    
    /// Implementación por defecto del método `mapOptionalList`.
    func mapOptionalList<Input, Output>(
        _ list: [Input]?,
        _ transform: (Input) throws -> Output?
    ) rethrows -> [Output] {
        let result = try list?.compactMap(transform)
        
        return result ?? []
    }
}
