//
//  Tradecurrency.swift
//  ToolinderDomainTradeInterface
//
//  Created by 송영모 on 2023/09/04.
//

import Foundation

public enum Currency: String, Codable, CaseIterable, Equatable {
    case dollar = "USD"             // 미국: 달러
    case euro = "EUR"               // 유럽: 유로
    case yen = "JPY"                // 일본: 옌
    case sterling = "GBP"           // 영국: 스털링
    case australianDollar = "AUD"   // 오스트레일리아: 오스트레일리아 달러
    case canadianDollar = "CAD"     // 캐나다: 캐나다 달러
    case franc = "CHF"              // 스위스: 프랑
    case krona = "SEK"              // 스웨덴: 크로나
    case peso = "MXN"               // 멕시코: 페소
    case newZealandDollar = "NZD"   // 뉴질랜드: 뉴질랜드 달러
    case singaporeDollar = "SGD"    // 싱가포르: 싱가포르 달러
    case hongKongDollar = "HKD"     // 홍콩: 홍콩 달러
    case krone = "NOK"              // 노르웨이: 크로네
    case won = "KRW"                // 대한민국: 원
    
    case bitcoin = "BTC"            // 비트코인
    /*
    case florin = "AWG"
    case turkishlira = "TRY"
    case ruble = "RUB"
    case dong = "VND"
    case indianrupee = "INR"
    case tenge = "KZT"
    case peseta = "ESP"
    case kip = "LAK"
    case hryvnia = "UAH"
    case naira = "NGN"
    case guarani = "PYG"
    case coloncurrency = "CRC"
    case cedi = "GHS"
    case tugrik = "MNT"
    case shekel = "ILS"
    case manat = "AZN"
    case baht = "THB"
    case lari = "GEL"
    case brazilianreal = "BRL"
     */
}
