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
    case bypassAdd
    case edit
    
    public enum Action {
        case dismiss
        case delete
    }
}

public struct EditHeaderView: View {
    public let mode: EditMode
    public let title: LocalizedStringKey
    
    public var action: (EditMode.Action) -> ()
    
    public init(
        mode: EditMode,
        title: LocalizedStringKey,
        action: @escaping (EditMode.Action) -> Void
    ) {
        self.mode = mode
        self.title = title
        self.action = action
    }
    
    public var body: some View {
        HStack {
            if mode == .add {
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
            
            if mode == .edit {
                Button(action: {
                    action(.delete)
                }, label: {
                    Image(systemName: "trash.circle.fill")
                        .foregroundStyle(.foreground)
                        .font(.title)
                })
            }
        }
    }
}
