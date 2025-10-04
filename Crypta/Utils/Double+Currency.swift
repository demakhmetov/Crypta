//
//  Double+Currency.swift
//  Crypta
//
//  Created by Dias on 02.10.2025.
//

import Foundation

extension Double {
    func formattedCurrency() -> String {
        let absValue = abs(self)
        let sign = self < 0 ? "-" : ""
        
        switch absValue {
        case 1_000_000_000_000...:
            return String(format: "\(sign)$%.2fT", absValue / 1_000_000_000_000)
        case 1_000_000_000...:
            return String(format: "\(sign)$%.2fB", absValue / 1_000_000_000)
        case 1_000_000...:
            return String(format: "\(sign)$%.2fM", absValue / 1_000_000)
        case 1_000...:
            return String(format: "\(sign)$%.2fK", absValue / 1_000)
        default:
            return String(format: "\(sign)$%.2f", absValue)
        }
    }
}
