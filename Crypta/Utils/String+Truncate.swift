//
//  String+Truncate.swift
//  Crypta
//
//  Created by Dias on 01.10.2025.
//

extension String {
    func truncated(to: Int) -> String {
        if self.count > to {
            let index = self.index(self.startIndex, offsetBy: to)
            return String(self[..<index]) + "…"
        } else {
            return self
        }
    }
}
