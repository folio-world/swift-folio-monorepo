//
//  ChatGPTRepository.swift
//  MullingDomainGPT
//
//  Created by 송영모 on 2023/08/22.
//

import Foundation

import MullingCore

public protocol ChatGPTRepositoryInterface {
    func postChatCompletion(request: ChatCompletionRequestDTO) async -> Result<ChatCompletionResponseDTO, RequestError>
}

public struct ChatGPTRepository: HTTPClient, ChatGPTRepositoryInterface {
    public init() {}
    
    public func postChatCompletion(request: ChatCompletionRequestDTO) async -> Result<ChatCompletionResponseDTO, RequestError> {
        return await sendRequest(endpoint: ChatGPTEndpoint.completion(request: request), responseModel: ChatCompletionResponseDTO.self)
    }
}
