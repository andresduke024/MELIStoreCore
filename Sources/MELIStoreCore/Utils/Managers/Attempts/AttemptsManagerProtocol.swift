//
//  AttemptsManagerProtocol.swift
//  MELIStoreProducts
//
//  Created by Andres Duque on 5/04/25.
//

/// Protocolo que define la lógica para ejecutar una operación con múltiples intentos.
///
/// `AttemptsManagerProtocol` permite implementar una estrategia de reintentos para
/// ejecutar bloques de código asíncronos que puedan fallar, como llamadas de red o
/// procesos críticos. Es especialmente útil para mejorar la resiliencia del sistema.
/// 
/// - Note: El bloque se ejecutará nuevamente si lanza un error, hasta alcanzar el máximo de intentos.
///
/// - Warning: Si se superan los `maxAttempts`, el error final será lanzado.
public protocol AttemptsManagerProtocol: Sendable {
    
    /// Ejecuta un bloque asíncrono con una cantidad máxima de reintentos.
    ///
    /// - Parameters:
    ///   - maxAttempts: El número máximo de veces que se intentará ejecutar el bloque.
    ///   - block: El bloque de código asíncrono que se desea ejecutar.
    /// - Returns: El resultado exitoso del bloque ejecutado.
    /// - Throws: El error del último intento si todos fallan.
    func execute<T: Sendable>(
        maxAttempts: Int,
        _ block: @Sendable @escaping () async throws -> T
    ) async rethrows -> T
}
