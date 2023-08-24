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
    
    private var rewardAd: Rewarded = .init()
    
    public init(viewModel: ChatResultViewModel) {
        self._viewModel = .init(wrappedValue: viewModel)
    }
    
    public var body: some View {
        VStack {
            ScrollView(showsIndicators: false) {
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
            
            HStack {
                Button(action: {
                    viewModel.send(.gptButtonTapped)
                    
                    rewardAd.show {
                        print($0)
                    }
                }, label: {
                    Label(viewModel.mode == .isLoading ?
                          ""
                          : "Ask GPT",
                        systemImage: viewModel.mode == .isLoading ?
                          ""
                          : "volleyball"
                    )
                    .foregroundColor(.white)
                })
                .padding(10)
                .background(
                    VStack {
                        switch viewModel.mode {
                        case .isLoading:
                            ProgressView()
                        case .active:
                            RoundedRectangle(cornerRadius: 20)
                                .foregroundColor(.black)
                        case .inactive:
                            RoundedRectangle(cornerRadius: 20)
                                .foregroundColor(.gray)
                        }
                    }
                )
                
                if !viewModel.idea.isEmpty {
                    Button(action: {
                        viewModel.send(.shareButtonTapped)
                    }, label: {
                        Label("Share After AD", systemImage: "square.and.arrow.up")
                        .foregroundColor(.white)
                    })
                    .padding(10)
                    .background(
                        RoundedRectangle(cornerRadius: 20)
                            .foregroundColor(.black)
                    )
                }
            }
            .padding(.vertical)
            .padding(.horizontal)
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
