//
//  ChatEntity.swift
//  MullingDomainChat
//
//  Created by 송영모 on 2023/08/23.
//

import Foundation

import MullingCore

public extension ChatCompletionResponseDTO {
    func toDomain() -> [ChatEntity] {
        self.choices.flatMap { choice in
            choice.message.content.components(separatedBy: ",")
        }.map { content in
            ChatEntity(content: content)
        }
    }
}
