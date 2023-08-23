//
//  ChatView.swift
//  MullingFeatureChatDemo
//
//  Created by 송영모 on 2023/08/21.
//

import SwiftUI

import MullingShared

public struct ChatView: View {
    @EnvironmentObject public var chatFlowCoordinator: ChatFlowCoordinator
    
    @StateObject public var viewModel: ChatViewModel
    
    public init(viewModel: ChatViewModel) {
        self._viewModel = .init(wrappedValue: viewModel)
    }
    
    public var body: some View {
        VStack(spacing: .zero) {
            chatListView()
                .padding(.horizontal)
            
            chatTextFieldView()
                .padding()
        }
        .onReceive(viewModel.$chatResultDependencies) { dependenciesOrNil in
            if let dependencies = dependenciesOrNil {
                chatFlowCoordinator.navigate(.chatResult(dependencies))
            }
        }
    }
    
    private func chatListView() -> some View {
        GeometryReader { reader in
            ScrollView {
                VStack {
                    Spacer()
                    
                    FlexibleView(
                        availableWidth: UIScreen.screenWidth - 10,
                        data: viewModel.chats,
                        spacing: 5,
                        alignment: .leading,
                        content: { item in
                            Button(item.content, action: {
                                
                            })
                            .fontWeight(.light)
                            .foregroundColor(.black)
                            .padding(.horizontal, 12)
                            .padding(.vertical, 7)
                            .background(
                                RoundedRectangle(cornerRadius: 20)
                                    .strokeBorder(.gray, style: StrokeStyle(lineWidth: 1))
                            )
                        },
                        elementsSize: [:]
                    )
                    .padding(.vertical, 5)
                }
                .frame(minHeight: reader.size.height)
            }
        }
    }
    
    private func chatTextFieldView() -> some View {
        HStack(spacing: .zero) {
            Button(action: {
            }, label: {
                Image(systemName: "arrow.counterclockwise.circle.fill")
                    .font(.title)
                    .foregroundColor(viewModel.keyword.isEmpty ? .green : .gray)
            })
            .padding(.trailing, 10)
            
            HStack(spacing: .zero) {
                TextField("keyword", text: $viewModel.keyword)
                    .fontWeight(.light)
                    .padding(.leading, 10)
                    .onSubmit {
                        viewModel.send(.sendButtonTapped)
                    }
                
                Button(action: {
                    if viewModel.keyword.isEmpty {
                    } else {
                        viewModel.send(.sendButtonTapped)
                    }
                }, label: {
                    Image(systemName: viewModel.keyword.isEmpty ? "arrow.right.circle.fill" : "arrow.up.circle.fill")
                        .foregroundColor(viewModel.keyword.isEmpty ? .gray : .green)
                        .font(.title)
                })
                .padding(.trailing, 5)
                .padding(.vertical, 5)
            }
            .overlay(
                RoundedRectangle(cornerRadius: 20)
                    .strokeBorder(.gray, style: StrokeStyle(lineWidth: 1))
            )
        }
    }
}

struct ChatView_Previews: PreviewProvider {
    static var previews: some View {
        ChatView(viewModel: ChatSceneDIContainer().makeChatViewModel(dependencies: .init()))
    }
}
