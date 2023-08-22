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
        ScrollView {
            VStack(spacing: .zero) {
                chatListView()
                
                inputView()
                
                Spacer()
                
                HStack {
                    Button(action: {}, label: {
                        Label("Ask GPT", systemImage: "volleyball")
                            .foregroundColor(.white)
                    })
                    .padding(10)
                    .background(
                        RoundedRectangle(cornerRadius: 20)
                            .foregroundColor(.black)
                    )
                    
//                    Spacer()
//                    
//                    Button(action: {}, label: {
//                        Label("Share After Watching Ads", systemImage: "square.and.arrow.up")
//                            .foregroundColor(.white)
//                    })
//                    .padding(10)
//                    .background(
//                        RoundedRectangle(cornerRadius: 20)
//                            .foregroundColor(.black)
//                    )
                }
            }
        }
        .padding(.horizontal)
    }
    
    private func chatListView() -> some View {
        VStack(alignment: .leading) {
            FlexibleView(
                availableWidth: UIScreen.screenWidth,
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
    
    private func inputView() -> some View {
        VStack {
            HStack(spacing: 5) {
                Text("Jobs:")
                    .font(.callout)
                    .fontWeight(.semibold)
                
                TextField("", text: $viewModel.job)
            }
            .padding()
            .overlay(
                RoundedRectangle(cornerRadius: 20)
                    .strokeBorder(.gray, style: StrokeStyle(lineWidth: 1))
            )
            
            HStack(spacing: 5) {
                Text("Subject:")
                    .font(.callout)
                    .fontWeight(.semibold)
                
                TextField("", text: $viewModel.subject)
            }
            .padding()
            .overlay(
                RoundedRectangle(cornerRadius: 20)
                    .strokeBorder(.gray, style: StrokeStyle(lineWidth: 1))
            )
        }
    }
}

struct ChatResultView_Previews: PreviewProvider {
    static var previews: some View {
        ChatView(viewModel: .init(dependencies: .init()))
    }
}
