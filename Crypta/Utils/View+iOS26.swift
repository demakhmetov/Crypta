//
//  View+iOS26.swift
//  Crypta
//
//  Created by Dias on 01.10.2025.
//

import SwiftUI

extension View {
    @ViewBuilder
    func iOS26Only<T: View>(_ modifier: (Self) -> T) -> some View {
        if #available(iOS 26, *) {
            modifier(self)
        } else {
            self
        }
    }
}
