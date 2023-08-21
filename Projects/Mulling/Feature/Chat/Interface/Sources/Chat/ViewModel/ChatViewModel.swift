//
//  ChatViewModel.swift
//  MullingFeatureChatDemo
//
//  Created by 송영모 on 2023/08/21.
//

import Foundation

public class ChatViewModel: ObservableObject {
    
    enum Action {
        case sendButtonTapped(String)
    }
    
    @Published var chat: String = ""
    @Published var chats: [String] = []
    
    public init() {
        
    }
    
    func send(_ action: Action) {
        switch action {
        case let .sendButtonTapped(chat):
            if chat.isEmpty {
                
            } else {
                self.chats.append(chat)
                self.chat = ""
            }
        }
    }
}
