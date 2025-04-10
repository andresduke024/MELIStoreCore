//
//  UIMapper.swift
//  MELIStoreCore
//
//  Created by Andres Duque on 8/04/25.
//

/// Protocolo para mapear entidades del dominio a modelos de interfaz de usuario (UI).
///
/// El protocolo `UIMapper` define un contrato genérico para transformar
/// entidades del dominio en modelos utilizados por la capa de presentación,
/// ayudando a mantener la separación de responsabilidades entre capas.
///
/// ## Uso
/// Conforma a este protocolo especificando los tipos asociados `Entity` y `UIModel`,
/// e implementa el método `map(_:)` para realizar la conversión.
///
/// ```swift
/// struct SomeEntity {
///     let id: String
///     let name: String
/// }
///
/// struct SomeUIModel {
///     let nameToShow: String
/// }
///
/// struct ProductoUIMapper: UIMapper {
///     func map(_ entity: SomeEntity) -> SomeUIModel {
///         SomeUIModel(nameToShow: entity.name)
///     }
/// }
/// ```
public protocol UIMapper {
    /// Tipo de la entidad del dominio a convertir.
    associatedtype Entity
    
    /// Tipo del modelo de UI resultante de la conversión.
    associatedtype UIModel
    
    /// Mapea una entidad del dominio a un modelo de UI.
    ///
    /// - Parameter entity: La instancia de la entidad del dominio.
    /// - Returns: El modelo de UI correspondiente a la entidad dada.
    func map(_ entity: Entity) -> UIModel
}
