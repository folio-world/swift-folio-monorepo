//
//  ChatView.swift
//  MullingFeatureChatDemo
//
//  Created by 송영모 on 2023/08/21.
//

import SwiftUI

import MullingShared

public struct ChatView: View {
    @StateObject public var viewModel: ChatViewModel
    
    public init(viewModel: StateObject<ChatViewModel>) {
        self._viewModel = viewModel
    }
    
    public var body: some View {
        VStack(spacing: .zero) {
            Spacer()
            
            FlexibleView(
                availableWidth: UIScreen.screenWidth - 10,
                data: [
                    "Here’s", "to", "the", "crazy", "ones", "the", "misfits", "the", "rebels", "the", "troublemakers", "the", "round", "pegs", "in", "the", "square", "holes", "the", "ones", "who", "see", "things", "differently", "they’re", "not", "fond", "of", "rules"
                ],
                spacing: 5,
                alignment: .leading,
                content: { item in
                    Text(verbatim: item)
                        .padding(8)
                        .background(
                            RoundedRectangle(cornerRadius: 8)
                                .fill(Color.gray.opacity(0.2))
                        )
                },
                elementsSize: [:]
            )
            .padding(.vertical, 10)
            
            HStack(spacing: .zero) {
                TextField("keyword", text: $viewModel.chat)
                    .padding(.leading, 10)
                
                Button(action: {
                    
                }, label: {
                    Image(systemName: "arrow.up.circle.fill")
                        .font(.title)
                })
                .padding(.trailing, 5)
                .padding(.vertical, 5)
            }
            .overlay(
                RoundedRectangle(cornerRadius: 20)
                    .strokeBorder(.gray, style: StrokeStyle(lineWidth: 1))
            )
            .padding(.horizontal)
        }
    }
}

struct ChatView_Previews: PreviewProvider {
    static var previews: some View {
        ChatView(viewModel: .init(wrappedValue: .init()))
    }
}
