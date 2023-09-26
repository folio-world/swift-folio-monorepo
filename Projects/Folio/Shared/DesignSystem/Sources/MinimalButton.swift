//
//  MinimalButton.swift
//  FolioSharedDesignSystem
//
//  Created by 송영모 on 2023/09/26.
//

import SwiftUI


public struct MinimalButton: View {
    public let title: String
    public let isActive: Bool
    
    public var action: () -> ()
    
    public init(
        title: String = "",
        isActive: Bool = false,
        action: @escaping () -> Void
    ) {
        self.title = title
        self.isActive = isActive
        self.action = action
    }
    
    public var body: some View {
        Button(action: {
            action()
        }, label: {
            HStack {
                Spacer()
                
                Text(self.title)
                    .font(.title3)
                    .fontWeight(.semibold)
                    .foregroundStyle(.white)
                
                Spacer()
            }
            .padding(.vertical, 10)
        })
        .background(.black)
        .clipShape(
            RoundedRectangle(
                cornerRadius: 8,
                style: .continuous
            )
        )
    }
}
