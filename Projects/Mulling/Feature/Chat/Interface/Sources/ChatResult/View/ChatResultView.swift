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
        VStack(alignment: .leading, spacing: .zero) {
            chatListView()
                .padding(.horizontal)
            
            HStack {
                Spacer()
            }
            Spacer()
        }
    }
    
    private func chatListView() -> some View {
        VStack(alignment: .leading) {
            FlexibleView(
                availableWidth: UIScreen.screenWidth - 10,
                data: viewModel.chats,
                spacing: 5,
                alignment: .leading,
                content: { item in
                    Text(verbatim: item)
                        .fontWeight(.light)
                        .padding(10)
                        .background(
                            RoundedRectangle(cornerRadius: 20)
                                .strokeBorder(.gray, style: StrokeStyle(lineWidth: 1))
                        )
                        .onTapGesture {
                            print(item)
                        }
                },
                elementsSize: [:]
            )
            .padding(.vertical, 5)
        }
    }
}

struct ChatResultView_Previews: PreviewProvider {
    static var previews: some View {
        ChatView(viewModel: .init(dependencies: .init()))
    }
}
