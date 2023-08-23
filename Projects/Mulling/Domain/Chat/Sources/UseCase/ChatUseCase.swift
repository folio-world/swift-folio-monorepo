//
//  ChatUseCase.swift
//  MullingDomainChat
//
//  Created by 송영모 on 2023/08/23.
//

import Foundation

import MullingDomainChatInterface
import MullingCore
import MullingShared

public protocol ChatUseCaseInterface {
    func askToGPT(type: ChatType, chats: [ChatEntity]) async -> Result<[ChatEntity], ChatError>
}

public enum ChatError: Error {
    case fail
}

public extension RequestError {
    func toDomain() -> ChatError {
        return .fail
    }
}

public final class ChatUseCase: ChatUseCaseInterface {
    private let openAIRepository: OPENAIRepositoryInterface
    
    public init(openAIRepository: OPENAIRepositoryInterface) {
        self.openAIRepository = openAIRepository
    }
    
    public func askToGPT(type: ChatType, chats: [ChatEntity]) async -> Result<[ChatEntity], ChatError> {
        let messages = type.chatCompletionMessages(chats: chats)
        let request = ChatCompletionRequestDTO(
            model: .gpt_3_5_turbo,
            messages: messages
        )
        let resposne = await openAIRepository.postChatCompletion(request: request)
        let result = resposne.map {
            $0.toDomain()
        }.mapError {
            $0.toDomain()
        }
        
        return result
    }
}
