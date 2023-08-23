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
    func askKeywordsToGPT(chats: [ChatEntity]) async -> Result<[ChatEntity], ChatError>
    func askIdeaToGPT(job: String, subject: String, chats: [ChatEntity]) async -> Result<ChatEntity, ChatError>
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
    
    public func askKeywordsToGPT(chats: [ChatEntity]) async -> Result<[ChatEntity], ChatError> {
        let keywords = chats.map { $0.content }.joined(separator: ",")
        let messages: [ChatCompletionMessage] = [
            .init(role: .system, content: "You are an AI bot that suggests keywords that help with ideas"),
            .init(role: .system, content: "You must answer all the questions with a comma separated by keywords"),
            .init(role: .system, content: "You must answer in the language that corresponds to the keyword asked by the user"),
            .init(role: .user, content: "Suggest keywords related to \(keywords)")
        ]
        let request = ChatCompletionRequestDTO(
            model: .gpt_3_5_turbo,
            messages: messages,
            maxTokens: 150
        )
        let resposne = await openAIRepository.postChatCompletion(request: request)
        let result: Result<[ChatEntity], ChatError> = resposne.map {
            $0.toDomain()
        }.mapError {
            $0.toDomain()
        }
        
        return result
    }
    
    public func askIdeaToGPT(job: String, subject: String, chats: [ChatEntity]) async -> Result<ChatEntity, ChatError> {
        let keywords = chats.map { $0.content }.joined(separator: ",")
        let messages: [ChatCompletionMessage] = [
            .init(role: .system, content: "You're an AI bot that uses keywords to suggest ideas"),
            .init(role: .system, content: "Your job is \(job)"),
            .init(role: .system, content: "You must answer in the language that corresponds to the keyword asked by the user"),
            .init(role: .user, content: "Use the keywords \(keywords) to suggest 3 ideas for \(subject)")
        ]
        let request = ChatCompletionRequestDTO(
            model: .gpt_3_5_turbo,
            messages: messages
        )
        let resposne = await openAIRepository.postChatCompletion(request: request)
        let result: Result<ChatEntity, ChatError> = resposne.map {
            $0.toDomain()
        }.mapError {
            $0.toDomain()
        }
        
        return result
    }
}
