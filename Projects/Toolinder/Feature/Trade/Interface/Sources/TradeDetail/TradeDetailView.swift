//
//  TradeDetailView.swift
//  ToolinderFeatureCalendarInterface
//
//  Created by 송영모 on 2023/09/11.
//

import SwiftUI
import SwiftData

import ComposableArchitecture

import ToolinderFeatureTradeInterface
import ToolinderDomain
import ToolinderShared

public struct TradeDetailView: View {
    @Environment(\.modelContext) private var context
    let store: StoreOf<TradeDetailStore>
    
    public init(store: StoreOf<TradeDetailStore>) {
        self.store = store
    }
    
    public var body: some View {
        WithViewStore(self.store, observe: { $0 }) { viewStore in
            ScrollView {
                VStack {
                    tradeView(viewStore: viewStore)
                    
                    Divider()
                    
                    noteView(viewStore: viewStore)
                    
                    photoView(viewStore: viewStore)
                    
                    HStack {
                        if let ticker = viewStore.state.trade.ticker {
                            TickerItem(ticker: ticker, isSelected: false)
                        }
                        
                        Spacer()
                    }
                    
                    tradeListView(viewStore: viewStore)
                }
                .padding()
            }
            .onAppear {
                viewStore.send(.onAppear)
            }
            .sheet(
                store: self.store.scope(
                    state: \.$tradeEdit,
                    action: { .tradeEdit($0) }
                )
            ) {
                TradeEditView(store: $0)
                    .presentationDetents([.large])
            }
            .navigationTitle(viewStore.state.trade.ticker?.name ?? "")
            .navigationBarTitleDisplayMode(.large)
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button("Edit") {
                        viewStore.send(.editButtonTapped)
                    }
                }
            }
        }
    }
    
    private func tradeView(viewStore: ViewStoreOf<TradeDetailStore>) -> some View {
        VStack(alignment: .trailing) {
            HStack(alignment: .bottom, spacing: .zero) {
                Spacer()
                
                Text(scaledString(valueOrNil: viewStore.state.trade.volume))
                    .font(.title)
                    .fontWeight(.semibold)
                
                Text("vol")
                    .fontWeight(.semibold)
            }
            
            HStack(alignment: .bottom, spacing: .zero) {
                Spacer()
                
                Text(scaledString(valueOrNil: viewStore.state.trade.price))
                    .font(.title)
                    .fontWeight(.semibold)
                
                Text("\(viewStore.state.trade.ticker?.currency?.rawValue.lowercased() ?? "")")
                    .fontWeight(.semibold)
            }
        }
    }
    
    private func tradeListView(viewStore: ViewStoreOf<TradeDetailStore>) -> some View {
        VStack {
            HStack {
                Label("History", systemImage: "clock")
                    .font(.headline)
                Spacer()
            }
            .padding(.bottom, 5)
            
            ForEachStore(self.store.scope(state: \.tradeItem, action: TradeDetailStore.Action.tradeItem(id:action:))) {
                TradeItemCellView(store: $0)
            }
            
            TradeNewItem()
        }
    }
    
    private func noteView(viewStore: ViewStoreOf<TradeDetailStore>) -> some View {
        VStack(spacing: 5) {
            HStack {
                Label("Note", systemImage: "note.text")
                    .font(.headline)
                
                Spacer()
            }
            
            HStack {
                Text(viewStore.state.trade.note ?? "")
                    .font(.caption)
                
                Spacer()
            }
        }
    }
    
    private func photoView(viewStore: ViewStoreOf<TradeDetailStore>) -> some View {
        VStack(spacing: 5) {
            HStack {
                Label("Photo", systemImage: "photo")
                    .font(.headline)
                
                Spacer()
            }
            
            HStack {
                ForEach(viewStore.state.trade.images, id: \.self) { imageData in
                    ImageItem(imageData: imageData)
                }
                
                Spacer()
            }
        }
    }
    
    private func scaledString(valueOrNil: Double?) -> String {
        if let value = valueOrNil {
            if value.isZero {
                return "0"
            } else {
                return String(describing: "\(value)")
            }
        } else {
            return "0"
        }
    }
}
