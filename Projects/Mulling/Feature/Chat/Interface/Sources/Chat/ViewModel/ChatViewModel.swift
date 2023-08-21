//
//  ChatViewModel.swift
//  MullingFeatureChatDemo
//
//  Created by 송영모 on 2023/08/21.
//

import Foundation
import Combine

public class ChatViewModel: ObservableObject {
    @Published var chats: [String] = []
    
    public init() {
        
    }
}
