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
import MullingShared

public class ChatViewModel: ObservableObject {
    private var subscribers: Set<AnyCancellable> = []
    
    public struct Dependencies {
        public init() { }
    }
    
    enum Action {
        case onAppear
        case sendButtonTapped
        case gptButtonTapped
        case chatCellTapped(id: UUID)
    }
    
    private let dependencies: Dependencies
    private let chatUseCase: ChatUseCaseInterface
    private let pointUseCase: PointUseCaseInterface
    
    private let rewardAd: Rewarded = .init(id: Environment.rewardedId)
    
    @Published var point: PointEntity = .init(current: 0)
    @Published var keyword: String = ""
    @Published var chats: [ChatEntity] = []
    @Published var status: ChatStatus = .inactive
    
    @Published var chatResultDependencies: ChatResultViewModel.Dependencies?
    
    public init(
        dependencies: Dependencies,
        chatUseCase: ChatUseCaseInterface,
        pointUseCase: PointUseCaseInterface
    ) {
        self.dependencies = dependencies
        self.chatUseCase = chatUseCase
        self.pointUseCase = pointUseCase
        
        bind()
    }
    
    @MainActor
    func send(_ action: Action) {
        switch action {
        case .onAppear:
            switch pointUseCase.fetch() {
            case let .success(point):
                self.point = point
            default:
                break
            }
        case .sendButtonTapped:
            if !keyword.isEmpty {
                chats.append(.init(content: keyword, isSelected: true))
                keyword = ""
            } else if status == .active {
                let filterdChats = chats.filter { $0.isSelected }
                chatResultDependencies = .init(chats: filterdChats)
            }
            
        case .gptButtonTapped:
            switch status {
            case .needPoint:
                rewardAd.show { reward in
                    if case let .success(point) = self.pointUseCase.earn(point: Int(truncating: reward.amount)) {
                        self.point = point
                    }
                }
                
            case .active:
                Task {
                    status = .isLoading
                    let filteredChats = chats.filter({ $0.isSelected })
                    let response = await chatUseCase.askKeywordsToGPT(chats: filteredChats)
                    switch response {
                    case let .success(chatGPT):
                        chats.removeAll(where: { !$0.isSelected })
                        chats.append(contentsOf: chatGPT.chats)
                        if case let .success(point) =  self.pointUseCase.use(point: chatGPT.usedPoint) {
                            self.point = point
                        }
                    case let .failure(failure):
                        print(failure)
                    }
                    status = .active
                }
            case .inactive, .isLoading:
                break
            }
            
        case let .chatCellTapped(id):
            if let index = chats.firstIndex(where: { $0.id == id }) {
                chats[index].isSelected.toggle()
            }
        }
    }
    
    func bind() {
        $chats
            .removeDuplicates()
            .receive(on: DispatchQueue.main)
            .sink { [weak self] chats in
                self?.status = self?.currentStatus() ?? .active
            }.store(in: &subscribers)
        
        $status
            .removeDuplicates()
            .receive(on: DispatchQueue.main)
            .sink { [weak self] status in
                self?.status = self?.currentStatus() ?? .active
            }.store(in: &subscribers)

        $point
            .removeDuplicates(by: { $0.current == $1.current })
            .receive(on: DispatchQueue.main)
            .sink { [weak self] _ in
                self?.status = self?.currentStatus() ?? .active
            }
            .store(in: &subscribers)
    }
    
    private func currentStatus() -> ChatStatus {
        if status == .isLoading {
            return .isLoading
        } else if point.current < 0 {
            return .needPoint
        } else if chats.contains(where: { $0.isSelected }) {
            return .active
        } else {
            return .inactive
        }
    }
}
