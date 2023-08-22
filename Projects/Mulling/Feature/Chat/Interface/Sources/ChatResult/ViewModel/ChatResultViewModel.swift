//
//  ChatResultViewModel.swift
//  MullingFeatureChatDemo
//
//  Created by 송영모 on 2023/08/21.
//

import Foundation

import MullingDomain

public class ChatResultViewModel: ObservableObject {
    public struct Dependencies {
        public let chats: [String]
        
        public init(chats: [String]) {
            self.chats = chats
        }
    }
    
    enum Action {
        case gptButtonTapped
    }
    
    private let dependencies: Dependencies
    private let chatGPTRepository: ChatGPTRepositoryInterface
    
    let chats: [String]
    
    @Published public var job: String = ""
    @Published public var subject: String = ""
    
    public init(
        dependencies: Dependencies,
        chatGPTRepository: ChatGPTRepositoryInterface
    ) {
        self.dependencies = dependencies
        self.chatGPTRepository = chatGPTRepository
        self.chats = dependencies.chats
    }
    
    func send(_ action: Action) {
        switch action {
        case .gptButtonTapped:
            Task {
                let tt = await chatGPTRepository
                    .postChatCompletion(
                        request: .init(
                            model: .gpt_3_5_turbo,
                            messages: [
                                .init(role: .system, content: "너는 프로덕트 디자이너야"),
                                .init(role: .user, content: "환경이라는 키워드를 가진 IT 서비스 아이디어를 제안해줘")
                            ]
                        )
                    )
                switch tt {
                case .success(let success):
                    print(success)
                case .failure(let failure):
                    print(failure)
                }
            }
            break
        }
    }
}
