//
//  ChatViewModel.swift
//  MullingFeatureChatDemo
//
//  Created by 송영모 on 2023/08/21.
//

import SwiftUI
import Combine

import MullingDomain
import MullingCore

public class ChatViewModel: ObservableObject {
    private var subscribers: Set<AnyCancellable> = []
    
    public struct Dependencies {
        public init() { }
    }
    
    enum GPTMode {
        case inactive
        case active
        case isLoading
    }
    
    enum Action {
        case sendButtonTapped
        case gptButtonTapped
        case chatCellTapped(id: UUID)
    }
    
    private let dependencies: Dependencies
    private let chatUseCase: ChatUseCaseInterface
    
    @Published var keyword: String = ""
    @Published var chats: [ChatEntity] = []
    @Published var mode: GPTMode = .inactive
    
    @Published var chatResultDependencies: ChatResultViewModel.Dependencies?
    
    public init(
        dependencies: Dependencies,
        chatUseCase: ChatUseCaseInterface
    ) {
        self.dependencies = dependencies
        self.chatUseCase = chatUseCase
        
        bind()
    }
    
    @MainActor
    func send(_ action: Action) {
        switch action {
        case .sendButtonTapped:
            if !keyword.isEmpty {
                chats.append(.init(content: keyword, isSelected: true))
                keyword = ""
            }
            
        case .gptButtonTapped:
            if self.mode == .active {
                Task {
                    mode = .isLoading
                    let filteredChats = chats.filter({ $0.isSelected })
                    let response = await chatUseCase.askToGPT(type: .keyword, chats: filteredChats)
                    switch response {
                    case let .success(newChats):
                        chats.removeAll(where: { !$0.isSelected })
                        chats.append(contentsOf: newChats)
                    case let .failure(failure):
                        print(failure)
                    }
                    mode = .active
                }
            }
            
        case let .chatCellTapped(id):
            if let index = chats.firstIndex(where: { $0.id == id }) {
                chats[index].isSelected.toggle()
            }
        }
    }
    
    func bind() {
        $chats.receive(on: DispatchQueue.main).sink { [weak self] chats in
            if chats.contains(where: { $0.isSelected }) && self?.mode != .isLoading {
                self?.mode = .active
                self?.chats.sort{ $0.isSelected && !$1.isSelected }
            }
        }.store(in: &subscribers)
    }
}
