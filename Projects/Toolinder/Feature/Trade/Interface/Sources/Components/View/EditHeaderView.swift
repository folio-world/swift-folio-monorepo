//
//  EditHeaderView.swift
//  ToolinderFeatureTradeInterface
//
//  Created by 송영모 on 2023/10/02.
//

import Foundation
import SwiftUI

public enum EditMode {
    case add
    case edit
    case select
    
    public enum Action {
        case dismiss
        case new
        case delete
    }
}

public struct EditHeaderView: View {
    public let mode: EditMode
    public let title: LocalizedStringKey
    public let isShowDismissButton: Bool
    public let isShowNewButton: Bool
    public let isShowDeleteButton: Bool
    
    public var action: (EditMode.Action) -> ()
    
    public init(
        mode: EditMode,
        title: LocalizedStringKey,
        isShowDismissButton: Bool = false,
        isShowNewButton: Bool = false,
        isShowDeleteButton: Bool = false,
        action: @escaping (EditMode.Action) -> Void
    ) {
        self.mode = mode
        self.title = title
        self.isShowDismissButton = isShowDismissButton
        self.isShowNewButton = isShowNewButton
        self.isShowDeleteButton = isShowDeleteButton
        
        self.action = action
    }
    
    public var body: some View {
        HStack {
            if isShowDismissButton {
                Button(action: {
                    action(.dismiss)
                }, label: {
                    Image(systemName: "chevron.left")
                        .font(.title)
                        .foregroundStyle(.foreground)
                })
            }
            
            Text(title)
                .font(.title)
            
            Spacer()
            
            if isShowDeleteButton {
                Button(action: {
                    action(.delete)
                }, label: {
                    Image(systemName: "trash.circle.fill")
                        .foregroundStyle(.foreground)
                        .font(.title)
                })
            }
            
            if isShowNewButton {
                Button(action: {
                    action(.new)
                }, label: {
                    Image(systemName: "plus.circle.fill")
                        .foregroundStyle(.foreground)
                        .font(.title)
                })
            }
        }
    }
}
