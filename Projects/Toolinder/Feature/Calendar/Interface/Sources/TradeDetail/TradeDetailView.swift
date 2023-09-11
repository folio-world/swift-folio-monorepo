//
//  TradeDetailView.swift
//  ToolinderFeatureCalendarInterface
//
//  Created by 송영모 on 2023/09/11.
//

import SwiftUI
import SwiftData

import ComposableArchitecture

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
                    
                    HStack {
                        if let ticker = viewStore.state.trade.ticker {
                            TickerItem(ticker: ticker, isSelected: false)
                        }
                        
                        Spacer()
                    }
                    .padding(.horizontal)
                    
                    tradeListView(viewStore: viewStore)
                }
            }
            .navigationTitle(viewStore.state.trade.ticker?.name ?? "Back")
        }
    }
    
    private func tradeView(viewStore: ViewStoreOf<TradeDetailStore>) -> some View {
        VStack {
            HStack {
                Text("Trade")
                    .font(.title3)
                    .fontWeight(.semibold)
                Spacer()
            }
            .padding(.horizontal)
            
            HStack {
                Text(scaledString(valueOrNil: viewStore.state.trade.volume))
                    .font(.title)
                    .fontWeight(.semibold)
                
                Text("vol")
                    .fontWeight(.semibold)
                
                Spacer()
            }
            .padding(.horizontal)
            
            HStack {
                Text(scaledString(valueOrNil: viewStore.state.trade.price))
                    .font(.title)
                    .fontWeight(.semibold)
                
                Text("\(viewStore.state.trade.ticker?.currency?.rawValue.lowercased() ?? "")")
                    .fontWeight(.semibold)
                
                Spacer()
            }
            .padding(.horizontal)
        }
    }
    
    private func tradeListView(viewStore: ViewStoreOf<TradeDetailStore>) -> some View {
        VStack {
            HStack {
                Text("History")
                    .font(.title3)
                    .fontWeight(.semibold)
                Spacer()
            }
            
            ForEach(viewStore.state.trade.ticker?.trades ?? []) { trade in
                TradeItem(trade: trade, isShowOnlyTime: false, isShowEdit: true)
            }
            
            TradeNewItem()
        }
        .padding(.horizontal)
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

