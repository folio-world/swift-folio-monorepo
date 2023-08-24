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

public class ChatResultViewModel: ObservableObject {
    private var subscribers: Set<AnyCancellable> = []
    
    public struct Dependencies: Hashable {
        public let chats: [ChatEntity]
        
        public init(chats: [ChatEntity]) {
            self.chats = chats
        }
    }
    
    enum GPTMode {
        case inactive
        case active
        case isLoading
    }
    
    enum Action {
        case gptButtonTapped
        case shareButtonTapped
    }
    
    private let dependencies: Dependencies
    private let chatUseCase: ChatUseCaseInterface
    private let pointUseCase: PointUseCaseInterface
    
    @Published var point: PointEntity = .init(current: 0)
    @Published var chats: [ChatEntity]
    @Published var job: String = ""
    @Published var subject: String = ""
    @Published var mode: GPTMode = .inactive
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
        case .gptButtonTapped:
            if mode == .active {
                Task {
                    mode = .isLoading
                    let result = await chatUseCase.askIdeaToGPT(job: job, subject: subject, chats: chats)
                    
                    switch result {
                    case let .success(chatGPT):
                        self.idea = chatGPT.toIdea()
                        if case let .success(point) =  self.pointUseCase.use(point: chatGPT.usedPoint) {
                            self.point = point
                        }
                    case let .failure(failure):
                        print(failure)
                    }
                    self.idea = idea
                    mode = .active
                }
            }
        case .shareButtonTapped:
            shareContent = "Summary\n\nKeywords: \(chats.map { $0.content }.joined(separator: ","))\n\nJob: \(job)\nSubject: \(subject)\n\nGPT: \n\(idea)"
            isShare = true
            return
        }
    }
    
    func bind() {
        $job.combineLatest($subject)
            .sink { [weak self] (job, subject) in
                if !job.isEmpty && !subject.isEmpty && self?.mode != .isLoading {
                    self?.mode = .active
                } else {
                    self?.mode = .inactive
                }
            }
            .store(in: &subscribers)
    }
}

public extension ChatGPTEntity {
    func toIdea() -> String {
        return self.chats.first?.content ?? ""
    }
}
