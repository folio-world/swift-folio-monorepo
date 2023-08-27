//
//  ShareButton.swift
//  MullingFeatureChatInterface
//
//  Created by 송영모 on 2023/08/25.
//

import SwiftUI

public struct ShareButton: View {
    let isActive: Bool
    let action : () -> Void
    
    public init(isActive: Bool, action: @escaping () -> Void) {
        self.isActive = isActive
        self.action = action
    }
    
    public var body: some View {
        Button {
            action()
        } label: {
            if isActive {
                Image(systemName: "square.and.arrow.up.circle.fill")
                    .font(.system(size: 35))
                    .foregroundColor(.green)
            } else {
                Image(systemName: "square.and.arrow.up.circle.fill")
                    .font(.system(size: 35))
                    .foregroundColor(.gray)
            }
        }
    }
}

struct ShareButton_Previews: PreviewProvider {
    static var previews: some View {
        ShareButton(isActive: true) {
            print("action")
        }
    }
}
