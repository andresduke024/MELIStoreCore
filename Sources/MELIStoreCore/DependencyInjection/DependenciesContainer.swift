//
//  DependenciesContainer.swift
//  MELIStore
//
//  Created by Andres Duque on 5/04/25.
//

/// Protocolo que define un contenedor de dependencias que se encarga
/// de registrar las instancias necesarias para el funcionamiento de un módulo o capa.
///
/// Las implementaciones de este protocolo deben encargarse de registrar
/// los servicios, casos de uso, mapeadores y cualquier otra clase necesaria
/// en el sistema de inyección de dependencias.
///
/// Este patrón permite mantener un acoplamiento bajo entre módulos,
/// facilitando el testeo, la escalabilidad y la modularidad de la arquitectura.
///
/// ### Ejemplo de uso:
/// ```swift
/// struct MyDependenciesContainer: DependenciesContainer {
///     func registerDependencies() {
///         Injector.shared.register(MyUseCaseProtocol.self) { MyUseCase() }
///     }
/// }
/// ```
///
/// Generalmente este contenedor es invocado automáticamente al inicializar un `ModuleProtocol`
/// para garantizar que todas las dependencias estén disponibles antes de usarse.
public protocol DependenciesContainer {
    
    /// Método que debe implementarse para registrar todas las dependencias necesarias del módulo.
    func registerDependencies()
}
