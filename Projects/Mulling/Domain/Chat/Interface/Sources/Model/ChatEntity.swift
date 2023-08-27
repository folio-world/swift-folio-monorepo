//
//  ChatEntity.swift
//  MullingDomainChat
//
//  Created by 송영모 on 2023/08/23.
//

import Foundation

public struct ChatEntity: Hashable {
    public var id: UUID
    public var content: String
    public var isSelected: Bool
    public var updated: Int
    
    public init(
        id: UUID = .init(),
        content: String = "",
        isSelected: Bool = false,
        updated: Int = Date().timeIntervalSince1970.exponent
    ) {
        self.id = id
        self.content = content
        self.isSelected = isSelected
        self.updated = updated
    }
}
