//
//  CurrencyFormatter.swift
//  StarlingTestApp
//
//  Created by Vadim Chistiakov on 20.09.2023.
//

import Foundation

protocol CurrencyFormatter {
    func formatCurrency(amount: FeedItem.Amount) -> String
    func formatCurrency(minorUnits: Int64) -> String
    func roundedAmount(for amounts: [FeedItem.Amount]) -> Int64
}

final class CurrencyFormatterImpl: CurrencyFormatter {
    
    private let formatter: NumberFormatter
    
    init(formatter: NumberFormatter) {
        self.formatter = formatter
    }
    
    func formatCurrency(minorUnits: Int64) -> String {
        formatCurrency(amount: FeedItem.Amount(currency: "GBP", minorUnits: minorUnits))
    }
    
    func formatCurrency(amount: FeedItem.Amount) -> String {
        formatter.numberStyle = .currency
        formatter.currencyCode = amount.currency
        
        let pounds = amount.minorUnits / 100
        let pence = amount.minorUnits % 100
        
        let totalValue = NSNumber(value: Double(pounds) + Double(pence) / 100)
        
        if let formattedString = formatter.string(from: totalValue) {
            return formattedString
        } else {
            return "Undefined"
        }
    }
    
    func roundedAmount(for amounts: [FeedItem.Amount]) -> Int64 {
        amounts.reduce(into: 0) { partialResult, amount in
            partialResult += roundUpToNearest(minorUnits: amount.minorUnits)
        }
    }
    
    // MARK: - Private method
    
    private func roundUpToNearest(minorUnits: Int64) -> Int64 {
        let remainder = minorUnits % 100
            
        if remainder == 0 {
            // If the value is already a multiple of 100, no rounding is needed.
            return 0
        } else {
            // How much is missing to a whole hundred
            return 100 - remainder
        }
    }
    
}
