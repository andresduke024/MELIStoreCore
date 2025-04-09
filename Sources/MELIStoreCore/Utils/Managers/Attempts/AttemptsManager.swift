//
//  AttemptsManager.swift
//  MELIStoreProducts
//
//  Created by Andres Duque on 5/04/25.
//

/// Implementación del protocolo `AttemptsManagerProtocol` utilizando un `actor` para manejo seguro de concurrencia.
///
/// `AttemptsManager` permite ejecutar una operación asíncrona con una lógica de reintentos
/// configurable. Utiliza recursividad para intentar nuevamente en caso de fallo, y asegura
/// el estado interno usando `actor`, garantizando que las operaciones sobre el contador de intentos
/// sean thread-safe.
///
/// ### Uso típico:
/// Ideal para operaciones que pueden fallar intermitentemente, como llamadas a APIs o servicios remotos.
///
/// - Note: El número de intentos se reinicia tras una ejecución exitosa o al lanzar el error final.
/// - Warning: Usa recursión. Aunque controlada, evita valores extremadamente altos para `maxAttempts`.
actor AttemptsManager: AttemptsManagerProtocol {
    
    /// Contador de intentos realizados.
    private var attempts: Int = 0
    
    /// Ejecuta un bloque de código asíncrono con una cantidad máxima de reintentos.
    ///
    /// - Parameters:
    ///   - maxAttempts: Número máximo de intentos permitidos.
    ///   - block: Bloque asíncrono que se desea ejecutar.
    /// - Returns: Resultado exitoso del bloque, si se completa dentro del límite de intentos.
    /// - Throws: El error lanzado por el bloque si todos los intentos fallan.
    func execute<T: Sendable>(
        maxAttempts: Int,
        _ block: @Sendable @escaping () async throws -> T,
    ) async rethrows -> T {
        do {
            let result = try await block()
            
            restore()
            return result
        } catch {
            increment()
            
            guard attempts < maxAttempts else {
                restore()
                throw error
            }
            
            return try await execute(
                maxAttempts: maxAttempts,
                block
            )
        }
    }
    
    /// Incrementa el contador de intentos.
    private func increment() { attempts += 1 }
    
    /// Restaura el contador de intentos a 0.
    private func restore() { attempts = 0 }
}
