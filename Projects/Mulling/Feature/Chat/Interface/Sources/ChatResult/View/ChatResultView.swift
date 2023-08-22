//
//  ChatResultView.swift
//  MullingFeatureChatDemo
//
//  Created by 송영모 on 2023/08/21.
//

import SwiftUI

import MullingShared

public struct ChatResultView: View {
    @EnvironmentObject private var flowCoordinator: ChatFlowCoordinator
    
    @StateObject public var viewModel: ChatResultViewModel
    
    public init(viewModel: ChatResultViewModel) {
        self._viewModel = .init(wrappedValue: viewModel)
    }
    
    public var body: some View {
        VStack(spacing: .zero) {
            
        }
    }
}

struct ChatResultView_Previews: PreviewProvider {
    static var previews: some View {
        ChatView(viewModel: .init())
    }
}
