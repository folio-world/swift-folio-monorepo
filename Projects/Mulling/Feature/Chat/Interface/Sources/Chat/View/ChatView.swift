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
        ZStack {
            VStack {
                chatListView()
                    .padding(.horizontal)
                
                chatTextFieldView()
                    .padding()
            }
            
            VStack {
                HStack {
                    Text("\(viewModel.point.current) P")
                        .font(.caption)
                        .foregroundColor(.white)
                        .padding(.horizontal, 7)
                        .padding(.vertical, 4)
                        .background(
                            RoundedRectangle(cornerRadius: 30)
                                .foregroundColor(viewModel.point.current >= 0 ? .black : .pink)
                        )
                    
                    Spacer()
                }
                
                Spacer()
            }
            .padding(.horizontal)
        }
        .onAppear {
            viewModel.send(.onAppear)
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
                            VStack {
                                if item.isSelected {
                                    Button(item.content, action: {
                                        viewModel.send(.chatCellTapped(id: item.id))
                                    })
                                    .fontWeight(.light)
                                    .foregroundColor(.white)
                                    .padding(.horizontal, 12)
                                    .padding(.vertical, 7)
                                    .background(
                                        RoundedRectangle(cornerRadius: 20)
                                            .foregroundColor(.black)
                                    )
                                } else {
                                    Button(item.content, action: {
                                        viewModel.send(.chatCellTapped(id: item.id))
                                    })
                                    .fontWeight(.light)
                                    .foregroundColor(.black)
                                    .padding(.horizontal, 12)
                                    .padding(.vertical, 7)
                                    .background(
                                        RoundedRectangle(cornerRadius: 20)
                                            .strokeBorder(.gray, style: StrokeStyle(lineWidth: 1))
                                    )
                                }
                            }
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
            ChatStatusButton(status: viewModel.status) {
                viewModel.send(.gptButtonTapped)
            }
            .padding(.trailing, 10)
            
            HStack(spacing: .zero) {
                TextField("keyword", text: $viewModel.keyword)
                    .fontWeight(.light)
                    .padding(.leading, 10)
                    .onSubmit {
                        viewModel.send(.sendButtonTapped)
                    }
                
                Button(action: {
                    viewModel.send(.sendButtonTapped)
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
