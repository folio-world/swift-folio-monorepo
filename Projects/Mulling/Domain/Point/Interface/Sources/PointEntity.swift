//
//  PointEntity.swift
//  MullingDomainPointInterface
//
//  Created by 송영모 on 2023/08/24.
//

import Foundation

public struct PointEntity {
    public let id: UUID
    public var current: Int
    
    public init(id: UUID = .init(), current: Int) {
        self.id = id
        self.current = current
    }
}
