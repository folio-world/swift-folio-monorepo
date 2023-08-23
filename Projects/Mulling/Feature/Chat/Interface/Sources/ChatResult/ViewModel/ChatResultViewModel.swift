//
//  ChatResultViewModel.swift
//  MullingFeatureChatDemo
//
//  Created by 송영모 on 2023/08/21.
//

import Foundation

import MullingDomain
import MullingCore

public class ChatResultViewModel: ObservableObject {
    public struct Dependencies: Hashable {
        public let chats: [ChatEntity]
        
        public init(chats: [ChatEntity]) {
            self.chats = chats
        }
    }
    
    enum Action {
        case gptButtonTapped
    }
    
    private let dependencies: Dependencies
    private let chatUseCase: ChatUseCaseInterface
    
    @Published public var chats: [ChatEntity]
    @Published public var job: String = ""
    @Published public var subject: String = ""
    
    public init(
        dependencies: Dependencies,
        chatUseCase: ChatUseCaseInterface
    ) {
        self.dependencies = dependencies
        self.chatUseCase = chatUseCase
        
        self.chats = dependencies.chats
    }
    
    func send(_ action: Action) {
        switch action {
        case .gptButtonTapped:
            break
        }
    }
}
