//
//  Tradecurrency.swift
//  ToolinderDomainTradeInterface
//
//  Created by 송영모 on 2023/09/04.
//

import Foundation

public enum Currency: String, Codable, CaseIterable, Equatable {
    case dollar = "USD"
    case yen = "JPY"
    case sterling = "GBP"
    case franc = "CHF"
    case florin = "AWG"
    case turkishlira = "TRY"
    case ruble = "RUB"
    case euro = "EUR"
    case dong = "VND"
    case indianrupee = "INR"
    case tenge = "KZT"
    case peseta = "ESP"
    case peso = "MXN"
    case kip = "LAK"
    case won = "KRW"
    case austral = "AUD"
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
    case bitcoin = "BTC"
    case brazilianreal = "BRL"
}
