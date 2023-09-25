//
//  PortfolioMainView.swift
//  ToolinderFeaturePortfolioInterface
//
//  Created by 송영모 on 2023/09/11.
//

import SwiftUI
import Charts

import ComposableArchitecture

public struct PortfolioMainView: View {
    public let store: StoreOf<PortfolioMainStore>
    
    public init(store: StoreOf<PortfolioMainStore>) {
        self.store = store
    }
    
    public var body: some View {
        WithViewStore(self.store, observe: { $0 }) { viewStore in
            GeometryReader { proxy in
                ScrollView {
                    VStack {
                        headerView(viewStore: viewStore)
                        
                        summaryChartTabView(viewStore: viewStore, proxy: proxy)
                    }
                }
            }
            .onAppear {
                viewStore.send(.onAppear)
            }
            .navigationTitle("Portfolio")
        }
    }
    
    private func headerView(viewStore: ViewStoreOf<PortfolioMainStore>) -> some View {
        HStack {
            Spacer()
            
            Picker("", selection: viewStore.binding(get: \.selectedPeriod, send: PortfolioMainStore.Action.selectPeriod)) {
                ForEach(PortfolioMainStore.Period.allCases, id: \.self) {
                    Text($0.rawValue).tag($0)
                }
            }
        }
    }
    
    private func summaryChartTabView(
        viewStore: ViewStoreOf<PortfolioMainStore>,
        proxy: GeometryProxy
    ) -> some View {
        VStack {
            TabView {
                TickerTypeChartView(
                    tickerTypeChartDataEntity: viewStore.state.tickerTypeChartDataEntity
                )
                .padding()
                .frame(width: proxy.size.width)
                
                TickerTypeChartView(
                    tickerTypeChartDataEntity: viewStore.state.tickerTypeChartDataEntity
                )
                .padding()
                .frame(width: proxy.size.width)
            }
            .frame(width: proxy.size.width, height: 200)
            .tabViewStyle(.page(indexDisplayMode: .never))
        }
    }
    
    private func tradeChartTabView(viewStore: ViewStoreOf<PortfolioMainStore>) -> some View {
        VStack {
            
        }
    }
    
    private func tickerListView(viewStore: ViewStoreOf<PortfolioMainStore>) -> some View {
        VStack {
            
        }
    }
}
