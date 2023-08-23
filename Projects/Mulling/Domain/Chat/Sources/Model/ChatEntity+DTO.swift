//
//  ChatEntity.swift
//  MullingDomainChat
//
//  Created by 송영모 on 2023/08/23.
//

import Foundation

import MullingDomainChatInterface
import MullingCore

public extension ChatCompletionResponseDTO {
    func toDomain() -> [ChatEntity] {
        self.choices.flatMap {
            $0.message.content.components(separatedBy: ", ")
        }.filter {
            !$0.isEmpty
        }.map {
            .init(content: $0)
        }
    }
    
    func toDomain() -> ChatEntity {
        let content = self.choices.compactMap {
            $0.message.content
        }.lazy.joined(separator: "\n")
        
        return .init(content: content)
    }
}
