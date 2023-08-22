//
//  ChatViewModel.swift
//  MullingFeatureChatDemo
//
//  Created by 송영모 on 2023/08/21.
//

import Foundation

import MullingDomain

public class ChatViewModel: ObservableObject {
    public struct Dependencies {
        public init() { }
    }
    
    enum Action {
        case sendButtonTapped(String)
    }
    
    private let dependencies: Dependencies
    private let chatGPTRepository: ChatGPTRepositoryInterface
    
    @Published var chat: String = ""
    @Published var chats: [String] = []
    
    public init(
        dependencies: Dependencies,
        chatGPTRepository: ChatGPTRepositoryInterface
    ) {
        self.dependencies = dependencies
        self.chatGPTRepository = chatGPTRepository
    }
    
    func send(_ action: Action) {
        switch action {
        case let .sendButtonTapped(chat):
            if !chat.isEmpty {
                self.chats.append(chat)
                self.chat = ""
            }
        }
    }
}
