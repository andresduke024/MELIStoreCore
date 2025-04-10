//
//  CoreModule.swift
//  MELIStoreCore
//
//  Created by Andres Duque on 8/04/25.
//

/// Módulo principal del núcleo de la aplicación (`Core`).
///
/// `CoreModule` es la implementación concreta del protocolo `BasicModuleProtocol`
/// y se encarga de exponer las dependencias necesarias para el funcionamiento
/// del núcleo del sistema.
///
/// Este módulo debe registrarse primero, ya que contiene utilidades y servicios
/// comunes que otros módulos pueden necesitar (por ejemplo: manejo de errores,
/// configuración global, validadores, etc.).
public struct CoreModule: BasicModuleProtocol {
    
    /// Instancia compartida (singleton) del módulo Core.
    public static let shared = CoreModule()
    
    /// Inicializador privado para restringir la creación de instancias.
    private init() {}
    
    /// Contenedor de dependencias del módulo Core.
    public var dependenciesContainer: any DependenciesContainer {
        CoreDependenciesContainer()
    }
}
