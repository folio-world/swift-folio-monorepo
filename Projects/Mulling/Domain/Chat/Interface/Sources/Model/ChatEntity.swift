//
//  ChatEntity.swift
//  MullingDomainChat
//
//  Created by 송영모 on 2023/08/23.
//

import Foundation

public struct ChatEntity {
    public var content: String
    public var isSelected: Bool
    public var updated: Int
    
    public init(
        content: String = "",
        isSelected: Bool = false,
        updated: Int = Date().timeIntervalSince1970.exponent
    ) {
        self.content = content
        self.isSelected = isSelected
        self.updated = updated
    }
}
