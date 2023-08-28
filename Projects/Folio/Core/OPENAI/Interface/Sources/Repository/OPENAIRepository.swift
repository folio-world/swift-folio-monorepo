//
//  ChatGPTRepository.swift
//  MullingDomainGPT
//
//  Created by 송영모 on 2023/08/22.
//

import Foundation

import MullingShared

public protocol OPENAIRepositoryInterface {
    func postChatCompletion(request: ChatCompletionRequestDTO) async -> Result<ChatCompletionResponseDTO, RequestError>
}

public struct OPENAIRepository: HTTPClient, OPENAIRepositoryInterface {
    public init() {}
    
    public func postChatCompletion(request: ChatCompletionRequestDTO) async -> Result<ChatCompletionResponseDTO, RequestError> {
        return await sendRequest(endpoint: OPENAIEndpoint.completion(request: request), responseModel: ChatCompletionResponseDTO.self)
    }
}
