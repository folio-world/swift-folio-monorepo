//
//  ChatViewModel.swift
//  MullingFeatureChatDemo
//
//  Created by 송영모 on 2023/08/21.
//

import Foundation

import MullingDomain
import MullingCore

public class ChatViewModel: ObservableObject {
    public struct Dependencies {
        public init() { }
    }
    
    enum Action {
        case sendButtonTapped
    }
    
    private let dependencies: Dependencies
    private let chatUseCase: ChatUseCaseInterface
    
    @Published var keyword: String = ""
    @Published var chats: [ChatEntity] = []
    
    @Published var chatResultDependencies: ChatResultViewModel.Dependencies?
    
    public init(
        dependencies: Dependencies,
        chatUseCase: ChatUseCaseInterface
    ) {
        self.dependencies = dependencies
        self.chatUseCase = chatUseCase
    }
    
    func send(_ action: Action) {
        switch action {
        case .sendButtonTapped:
            if !self.keyword.isEmpty {
                self.chats.append(.init(content: self.keyword, isSelected: true))
                self.keyword = ""
            }
        }
    }
}
