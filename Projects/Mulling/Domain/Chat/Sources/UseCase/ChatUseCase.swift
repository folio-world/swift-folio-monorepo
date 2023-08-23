//
//  ChatUseCase.swift
//  MullingDomainChat
//
//  Created by 송영모 on 2023/08/23.
//

import Foundation

import MullingCore
import MullingShared

protocol ChatUseCaseInterface {
    func askToGPT(type: ChatType, chats: [ChatEntity]) async -> Result<[ChatEntity], RequestError>
}

public enum ChatError: Error {
    case fail
}

public extension RequestError {
    func toDomain() -> ChatError {
        return .fail
    }
}

final class ChatUseCase {
    private let openAIRepository: OPENAIRepositoryInterface
    
    public init(openAIRepository: OPENAIRepositoryInterface) {
        self.openAIRepository = openAIRepository
    }
    
    func askToGPT(type: ChatType, chats: [ChatEntity]) async -> Result<[ChatEntity], ChatError> {
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
