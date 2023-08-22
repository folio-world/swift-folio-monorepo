//
//  ChatResultViewModel.swift
//  MullingFeatureChatDemo
//
//  Created by 송영모 on 2023/08/21.
//

import Foundation

public class ChatResultViewModel: ObservableObject {
    public struct Dependencies {
        public let chats: [String]
        
        public init(chats: [String]) {
            self.chats = chats
        }
    }
    
    enum Action {
        
    }
    
    private let dependencies: Dependencies
    
    let chats: [String]
    
    @Published public var job: String = ""
    @Published public var subject: String = ""
    
    public init(dependencies: Dependencies) {
        self.dependencies = dependencies
        self.chats = dependencies.chats
    }
    
    func send(_ action: Action) {
        
    }
}
