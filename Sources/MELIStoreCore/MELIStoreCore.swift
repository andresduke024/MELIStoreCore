public struct CoreModule: ModuleProtocol {
    
    public static let shared = CoreModule()
    
    private init() {}
    
    public var dependenciesContainer: any DependenciesContainer {
        CoreDependenciesContainer()
    }
}
