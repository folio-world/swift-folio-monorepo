//
//  TickerSummaryDataEntity.swift
//  ToolinderDomainTradeInterface
//
//  Created by 송영모 on 2023/09/26.
//

import Foundation

public struct TickerSummaryDataEntity: Equatable {
    public let avgPrice: Double
    public let currentVolume: Double
    public let buyVolume: Double
    public let sellVolume: Double
    public let yield: Double
    public let profit: Double
}

public extension Ticker {
    func toTickerSummaryDataEntity() -> TickerSummaryDataEntity {
        let trades = (self.trades ?? []).sorted(by: { $0.date < $1.date })
        
        var totalAmount = 0.0
        var buyVolume = 0.0
        var sellVoume = 0.0
        var totalVolume = 0.0
        var avgPrice = 0.0
        var profit = 0.0
        var yield = 0.0
        
        for trade in trades {
            switch trade.side {
            case .buy:
                totalAmount += trade.price * trade.volume
                buyVolume += trade.volume
                
            case .sell:
                totalAmount -= (totalAmount / trade.volume) * trade.price * trade.volume
                sellVoume += trade.volume
                
            }
//            // 평단가 계산
//            if trade.side == .buy {
//                
//            } else {
//                sellVoume += trade.volume
//            }
            totalVolume = buyVolume - sellVoume
            
            if !totalVolume.isZero {
                avgPrice = totalAmount / totalVolume
            }
            
            // 수익 계산
            if trade.side == .sell {
                profit += (trade.price - avgPrice) * trade.volume
            }
        }
        // 수익률 계산
        if !totalAmount.isZero {
            yield = (profit / totalAmount) * 100
        }
//        
//        var totalCost = 0.0
//        var totalQuantity = 0.0
//        
//        for transaction in transactions {
//            switch transaction.type {
//            case .buy:
//
//            case .sell:
//                let sellQuantity = transaction.quantity
//                if totalQuantity >= sellQuantity {
//                    
//                } else {
//                    // 판매량이 보유량을 초과할 경우 예외 처리
//                    print("오류: 보유량 부족")
//                    return 0.0
//                }
//            }
//        }
//        
//        guard totalQuantity > 0 else {
//            // 보유량이 0이면 평단가를 계산할 수 없으므로 예외 처리
//            print("오류: 보유량이 0입니다.")
//            return 0.0
//        }
//        
//        // 평단가 계산
//        let averageCost = totalCost / totalQuantity
//        
//        return averageCost
        
        let result = TickerSummaryDataEntity(
            avgPrice: avgPrice,
            currentVolume: totalVolume,
            buyVolume: buyVolume,
            sellVolume: sellVoume,
            yield: yield,
            profit: profit
        )
        
        return result
    }
}
