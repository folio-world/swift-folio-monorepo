//
//  EditTradeView.swift
//  ToolinderFeatureCalendarInterface
//
//  Created by 송영모 on 2023/09/02.
//

import SwiftUI

import ComposableArchitecture

public struct EditTradeView: View {
    let store: StoreOf<EditTradeStore>
    
    public init(store: StoreOf<EditTradeStore>) {
        self.store = store
    }
    
    public var body: some View {
        WithViewStore(self.store, observe: { $0 }) { viewStore in
            
        }
    }
}

