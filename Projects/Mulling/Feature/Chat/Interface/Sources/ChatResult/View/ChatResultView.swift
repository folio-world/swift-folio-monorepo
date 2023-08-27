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
        ZStack {
            VStack {
                ScrollView(showsIndicators: false) {
                    HStack {
                        PointView(point: viewModel.point)
                        
                        Spacer()
                    }
                    
                    HStack {
                        Text("Keyword")
                            .fontWeight(.semibold)
                            .font(.caption)
                            .foregroundColor(.white)
                            .padding(.horizontal, 7)
                            .padding(.vertical, 4)
                            .background(
                                RoundedRectangle(cornerRadius: 30)
                                    .foregroundColor(.black)
                            )
                        
                        Spacer()
                    }
                    
                    chatListView()
                    
                    inputView()
                        .padding(.bottom, 5)
                    if !viewModel.idea.isEmpty {
                        VStack(spacing: 5) {
                            HStack {
                                Text("GPT")
                                    .fontWeight(.semibold)
                                    .font(.caption)
                                    .foregroundColor(.white)
                                    .padding(.horizontal, 7)
                                    .padding(.vertical, 4)
                                    .background(
                                        RoundedRectangle(cornerRadius: 30)
                                            .foregroundColor(.black)
                                    )
                                
                                Spacer()
                            }
                            
                            Text(viewModel.idea)
                        }
                    }
                }
                
                Spacer()
            }
            
            VStack {
                Spacer()
                
                HStack {
                    ChatStatusButton(status: viewModel.status) {
                        viewModel.send(.gptButtonTapped)
                    }
                    
                    ShareButton(isActive: !viewModel.idea.isEmpty) {
                        viewModel.send(.shareButtonTapped)
                    }
                }
            }
            .padding(.vertical)
        }
        .onAppear {
            viewModel.send(.onAppear)
        }
        .padding(.horizontal)
        .sheet(isPresented: $viewModel.isShare) {
            SharingView(content: viewModel.shareContent)
        }
    }
    
    private func chatListView() -> some View {
        HStack {
            FlexibleView(
                availableWidth: UIScreen.screenWidth,
                data: viewModel.chats,
                spacing: 5,
                alignment: .leading,
                content: { item in
                    Text(verbatim: item.content)
                        .padding(.horizontal, 12)
                        .padding(.vertical, 7)
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
            
            Spacer()
        }
    }
    
    private func inputView() -> some View {
        VStack {
            HStack {
                Text("Variable")
                    .fontWeight(.semibold)
                    .font(.caption)
                    .foregroundColor(.white)
                    .padding(.horizontal, 7)
                    .padding(.vertical, 4)
                    .background(
                        RoundedRectangle(cornerRadius: 30)
                            .foregroundColor(.black)
                    )
                
                Spacer()
            }
            
            HStack(spacing: 5) {
                Text("Jobs:")
                    .font(.callout)
                
                TextField("ex) Product Manager", text: $viewModel.job)
                    .textFieldStyle(.plain)
            }
            
            HStack(spacing: 5) {
                Text("Subject:")
                    .font(.callout)
                
                TextField("ex) IT Project", text: $viewModel.subject)
                    .textFieldStyle(.plain)
            }
        }
    }
}

struct ChatResultView_Previews: PreviewProvider {
    static var previews: some View {
        ChatView(viewModel: ChatSceneDIContainer().makeChatViewModel(dependencies: .init()))
    }
}
