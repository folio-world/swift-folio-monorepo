////
////  TradeItem.swift
////  ToolinderFeatureCalendarInterface
////
////  Created by 송영모 on 2023/09/02.
////
//
//import SwiftUI
//
//import ToolinderShared
//import ToolinderDomain
//
//public struct TradeItem: View {
//    private let trade: Trade
//    private let isSelected: Bool
//    
//    private let isShowOnlyTime: Bool
//    private let isShowEdit: Bool
//    
//    public var action: () -> Void
//    public var trailingAction: () -> Void
//    
//    public init(
//        trade: Trade,
//        isSelected: Bool = false,
//        isShowOnlyTime: Bool = true,
//        isShowEdit: Bool = true,
//        action: @escaping () -> Void = {},
//        trailingAction: @escaping () -> Void = {}
//    ) {
//        self.trade = trade
//        self.isSelected = isSelected
//        self.isShowOnlyTime = isShowOnlyTime
//        self.isShowEdit = isShowEdit
//        
//        self.action = action
//        self.trailingAction = trailingAction
//    }
//    
//    public var body: some View {
//        HStack {
//            tradeView()
//            
//            if isShowEdit {
//                editButtonView()
//            }
//        }
//    }
//    
//    private func tradeView() -> some View {
//        HStack(spacing: 10) {
//            if isShowOnlyTime {
//                Text(trade.date.localizedString(dateStyle: .none, timeStyle: .short))
//                    .font(.headline)
//                    .fontWeight(.semibold)
//            } else {
//                Text(trade.date.localizedString(dateStyle: .short, timeStyle: .short))
//                    .font(.headline)
//                    .fontWeight(.semibold)
//            }
//            
//            trade.ticker?.type?.image
//                .font(.title3)
//                .foregroundStyle(trade.side == .buy ? .pink : .mint)
//            
//            Text(trade.ticker?.name ?? "")
//                .font(.body)
//                .fontWeight(.semibold)
//            
//            Spacer()
//        }
//        .frame(height: 35)
//        .padding(10)
//        .background(isSelected ? Color(uiColor: .systemGray5) : Color(uiColor: .systemGray6))
//        .clipShape(
//            RoundedRectangle(
//                cornerRadius: 8
//            )
//        )
//        .onTapGesture {
//            self.action()
//        }
//    }
//    
//    private func editButtonView() -> some View {
//        Button(action: {}, label: {
//            Image(systemName: "square.and.pencil")
//        })
//        .frame(height: 35)
//        .padding(10)
//        .background(isSelected ? Color(uiColor: .systemGray5) : Color(uiColor: .systemGray6))
//        .clipShape(
//            RoundedRectangle(
//                cornerRadius: 8
//            )
//        )
//        .onTapGesture {
//            self.trailingAction()
//        }
//    }
//}