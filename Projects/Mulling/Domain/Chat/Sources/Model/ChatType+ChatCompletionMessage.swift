//
//  ChatType+GPTSystemMessage.swift
//  MullingDomainChat
//
//  Created by 송영모 on 2023/08/23.
//

import Foundation

import MullingCore

public extension ChatType {
    func chatCompletionMessages(chats: [ChatEntity]) -> [ChatCompletionMessage] {
        switch self {
        case .keyword:
            let system = chatCompletionMessages(role: .system, chats: chats)
            let user = chatCompletionMessages(role: .user, chats: chats)
            return system + user
        }
    }
    
    private func chatCompletionMessages(
        role: MessageRole,
        chats: [ChatEntity]
    ) -> [ChatCompletionMessage] {
        switch role {
        case .system:
            return systemChatCompletionMessages(chats: chats)
        case .user:
            return userChatCompletionMessages(chats: chats)
        case .assistant:
            return []
        case .function:
            return []
        }
    }
    
    private func userChatCompletionMessages(chats: [ChatEntity]) -> [ChatCompletionMessage] {
        switch self {
        case .keyword:
            let keywords = chats.map { $0.content }.joined(separator: ",")
            return [
                .init(role: .user, content: "Suggest keywords related to \(keywords)")
            ]
        }
    }
    
    private func systemChatCompletionMessages(chats: [ChatEntity]) -> [ChatCompletionMessage] {
        switch self {
        case .keyword:
            return [
                .init(role: .system, content: "You are an AI bot that suggests keywords that help with ideas"),
                .init(role: .system, content: "You have to answer all the questions with a comma separated by keywords")
            ]
        }
    }
}
