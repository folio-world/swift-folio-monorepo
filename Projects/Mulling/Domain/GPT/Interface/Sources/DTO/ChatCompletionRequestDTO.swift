//
//  ChatCompletionRequestDTO.swift
//  MullingDomainGPT
//
//  Created by 송영모 on 2023/08/22.
//

import Foundation

public struct ChatCompletionRequestDTO: Codable {
    public let model: ChatCompletionModelType
    public let messages: [ChatCompletionMessage]
    
    public init(model: ChatCompletionModelType, messages: [ChatCompletionMessage]) {
        self.model = model
        self.messages = messages
    }
}

public struct ChatCompletionMessage: Codable {
    public let role: MessageRole
    public let content: String
    
    public init(role: MessageRole, content: String) {
        self.role = role
        self.content = content
    }
}

public enum MessageRole: String, Codable {
    case system
    case user
    case assistant
    case function
}
