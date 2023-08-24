//
//  ChatResultViewModel.swift
//  MullingFeatureChatDemo
//
//  Created by 송영모 on 2023/08/21.
//

import Foundation
import Combine

import MullingDomain
import MullingCore
import MullingShared

public class ChatResultViewModel: ObservableObject {
    private var subscribers: Set<AnyCancellable> = []
    
    public struct Dependencies: Hashable {
        public let chats: [ChatEntity]
        
        public init(chats: [ChatEntity]) {
            self.chats = chats
        }
    }
    
    enum Action {
        case onAppear
        case gptButtonTapped
        case shareButtonTapped
    }
    
    private let dependencies: Dependencies
    private let chatUseCase: ChatUseCaseInterface
    private let pointUseCase: PointUseCaseInterface
    private var rewardAd: Rewarded = .init()
    
    @Published var point: PointEntity = .init(current: 0)
    @Published var chats: [ChatEntity]
    @Published var job: String = ""
    @Published var subject: String = ""
    @Published var status: ChatStatus = .inactive
    @Published var idea: String = ""
    @Published var isShare: Bool = false
    @Published var shareContent: String = ""
    
    public init(
        dependencies: Dependencies,
        chatUseCase: ChatUseCaseInterface,
        pointUseCase: PointUseCaseInterface
    ) {
        self.dependencies = dependencies
        self.chatUseCase = chatUseCase
        self.pointUseCase = pointUseCase
        
        self.chats = dependencies.chats
        
        bind()
    }
    
    @MainActor
    func send(_ action: Action) {
        switch action {
        case .onAppear:
            if case let .success(point) = pointUseCase.fetch() {
                self.point = point
            }
        case .gptButtonTapped:
            switch status {
            case .needPoint:
                rewardAd.show { _ in
                    if case let .success(point) = self.pointUseCase.earn(point: 1000) {
                        self.point = point
                    }
                }
            case .active:
                Task {
                    status = .isLoading
                    switch await chatUseCase.askIdeaToGPT(job: job, subject: subject, chats: chats) {
                    case let .success(chatGPT):
                        self.idea = chatGPT.toIdea()
                        if case let .success(point) = self.pointUseCase.use(point: chatGPT.usedPoint) {
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
        case .shareButtonTapped:
            shareContent = "Summary\n\nKeywords: \(chats.map { $0.content }.joined(separator: ","))\n\nJob: \(job)\nSubject: \(subject)\n\nGPT: \n\(idea)"
            isShare = true
            return
        }
    }
    
    func bind() {
        $job.combineLatest($subject)
            .sink { [weak self] _ in
                self?.status = self?.currentStatus() ?? .active
            }
            .store(in: &subscribers)
        
        $point
            .receive(on: DispatchQueue.main)
            .removeDuplicates(by: { $0.current == $1.current })
            .sink { [weak self] _ in
                self?.status = self?.currentStatus() ?? .active
            }
            .store(in: &subscribers)
        
        $status
            .removeDuplicates()
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
        } else if !job.isEmpty && !subject.isEmpty {
            return .active
        } else {
            return .inactive
        }
    }
}

public extension ChatGPTEntity {
    func toIdea() -> String {
        return self.chats.first?.content ?? ""
    }
}
