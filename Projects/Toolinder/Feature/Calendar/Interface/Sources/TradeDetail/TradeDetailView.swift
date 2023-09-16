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
                    
                    Divider()
                        .padding(.horizontal)
                    
                    
                    
                    HStack {
                        Label("Note", systemImage: "note.text")
                            .font(.title3)
                        
                        Spacer()
                    }
                    .padding(.horizontal)
                    
                    HStack {
                        Text("월터 테비스[1]의 1983년 소설 《The Queen's Gambit》을 원작으로 넷플릭스에서 제작해 2020년 10월 23일에 공개된 7부작 미니시리즈이다. 제목인 퀸즈 갬빗이 체스 용어이듯 체스를 소재로 한 드라마로, 시청 등급은 청소년 관람불가. 스콧 프랭크[2]가 감독을 맡고 안야 테일러조이가 주인공 엘리자베스 하먼을 연기한다.체스판을 묘사한 대다수의 영화나 텔레비전 쇼와는 달리, 체스판이 정확하게 세팅되어 있고 체스 게임과 포지션 역시 꽤나 현실적인 것이 이 시리즈의 특징이다. 내셔널 마스터 브루스 판돌피니와 전직 세계 챔피언이자 역사상 최고의 체스 플레이어 중 하나로 평가받는 그랜드마스터 가리 카스파로프가 이 시리즈의 컨설턴트 역할을 했다.")
                            .font(.caption)
                        
                        Spacer()
                    }
                    .padding(.horizontal)
                    
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
            .navigationTitle(viewStore.state.trade.ticker?.name ?? "")
            .navigationBarTitleDisplayMode(.large)
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button("Edit") {
                        viewStore.send(.editButtonTapped)
                    }
                }
            }
            .sheet(
                store: self.store.scope(
                    state: \.$addTrade,
                    action: { .addTrade($0) }
                )
            ) {
                AddTradeView(store: $0)
                    .presentationDetents([.medium, .large])
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
            .padding(.horizontal)
            
            HStack(alignment: .bottom, spacing: .zero) {
                Spacer()
                
                Text(scaledString(valueOrNil: viewStore.state.trade.price))
                    .font(.title)
                    .fontWeight(.semibold)
                
                Text("\(viewStore.state.trade.ticker?.currency?.rawValue.lowercased() ?? "")")
                    .fontWeight(.semibold)
            }
            .padding(.horizontal)
        }
    }
    
    private func tradeListView(viewStore: ViewStoreOf<TradeDetailStore>) -> some View {
        VStack {
            HStack {
                Label("History", systemImage: "clock")
                    .font(.title3)
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

