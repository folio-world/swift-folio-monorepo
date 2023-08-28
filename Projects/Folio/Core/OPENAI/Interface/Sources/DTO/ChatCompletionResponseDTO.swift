//
//  ChatCompletionResponseDTO.swift
//  MullingDomainGPTInterface
//
//  Created by 송영모 on 2023/08/22.
//

import Foundation

public struct ChatCompletionResponseDTO: Codable {
    public let id, object: String
    public let created: Int
    public let model: ChatCompletionModelType
    public let choices: [ChatCompletionChoice]
    public let usage: Usage
}

public struct ChatCompletionChoice: Codable {
    public let index: Int
    public let message: ChatCompletionMessage
    public let finishReason: String

    enum CodingKeys: String, CodingKey {
        case index, message
        case finishReason = "finish_reason"
    }
}

public struct Usage: Codable {
    public let promptTokens, completionTokens, totalTokens: Int

    enum CodingKeys: String, CodingKey {
        case promptTokens = "prompt_tokens"
        case completionTokens = "completion_tokens"
        case totalTokens = "total_tokens"
    }
}
