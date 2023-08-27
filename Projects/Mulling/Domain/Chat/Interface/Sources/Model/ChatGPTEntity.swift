//
//  ChatGPTEntity.swift
//  MullingDomainChatInterface
//
//  Created by 송영모 on 2023/08/25.
//

import Foundation

public struct ChatGPTEntity: Hashable {
    public let id: UUID
    public let chats: [ChatEntity]
    public let usedPoint: Int
    
    public init(
        id: UUID = .init(),
        chats: [ChatEntity],
        usedPoint: Int) {
        self.id = id
        self.chats = chats
        self.usedPoint = usedPoint
    }
}

