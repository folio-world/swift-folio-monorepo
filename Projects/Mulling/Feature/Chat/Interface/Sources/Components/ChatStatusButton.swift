//
//  ChatStatusButton.swift
//  MullingFeatureChatDemo
//
//  Created by 송영모 on 2023/08/25.
//

import SwiftUI

public struct ChatStatusButton: View {
    let status: ChatStatus
    let action : () -> Void
    
    private let size = 35.0
    
    public init(status: ChatStatus, action: @escaping () -> Void) {
        self.status = status
        self.action = action
    }
    
    public var body: some View {
        Button {
            action()
        } label: {
            switch status {
            case .needPoint: needPointLabel()
            case .inactive: inactiveLabel()
            case .active: activeLabel()
            case .isLoading: isLoadingLabel()
            }
        }
    }
    
    private func inactiveLabel() -> some View {
        Image(systemName: "volleyball.circle.fill")
            .font(.system(size: size))
            .foregroundColor(.gray)
    }
    
    private func activeLabel() -> some View {
        Image(systemName: "volleyball.circle.fill")
            .font(.system(size: size))
            .foregroundColor(.green)
    }
    
    private func needPointLabel() -> some View {
        Image(systemName: "volleyball.circle.fill")
            .font(.system(size: size))
            .foregroundColor(.pink)
    }
    
    private func isLoadingLabel() -> some View {
        Image(systemName: "circle.fill")
            .font(.system(size: size))
            .foregroundColor(.green)
            .overlay(
                ProgressView()
                    .progressViewStyle(
                        CircularProgressViewStyle(tint: .white)
                    )
                    .controlSize(.mini)
            )
    }
}

struct ChatStatusButton_Previews: PreviewProvider {
    static var previews: some View {
        ChatStatusButton(status: .needPoint) {
            print("action")
        }
    }
}
