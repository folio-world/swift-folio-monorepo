//
//  ChatView.swift
//  MullingFeatureChatDemo
//
//  Created by 송영모 on 2023/08/21.
//

import SwiftUI

public struct ChatView: View {
    @StateObject public var viewModel: ChatViewModel
    
    public init(viewModel: StateObject<ChatViewModel>) {
        self._viewModel = viewModel
    }
    
    public var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
    }
}

struct ChatView_Previews: PreviewProvider {
    static var previews: some View {
        ChatView(viewModel: .init(wrappedValue: .init()))
    }
}
