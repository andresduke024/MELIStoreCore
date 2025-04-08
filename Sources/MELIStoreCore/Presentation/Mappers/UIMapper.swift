//
//  UIMapper.swift
//  MELIStoreCore
//
//  Created by Andres Duque on 8/04/25.
//

public protocol UIMapper {
    associatedtype Entity
    associatedtype UIModel
    
    func map(_ entity: Entity) -> UIModel
}
