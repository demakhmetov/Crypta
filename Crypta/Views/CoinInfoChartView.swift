//
//  CoinInfoChartView.swift
//  Crypta
//
//  Created by Dias on 02.10.2025.
//

// CoinLineChartView.swift
import SwiftUI
import SwiftUICharts

struct CoinInfoChartView: View {
    let data: [CoinPricePointModel]

    var body: some View {
        let prices: [Double] = data.map { $0.price }
        
        let firstPrice = prices.first ?? 1
        let lastPrice = prices.last ?? 1
        let rateChange = ((lastPrice - firstPrice) / firstPrice) * 100
        
        return LineChartView(
            data: prices,
            title: "",
            legend: "",
            style: ChartStyle(
                backgroundColor: Color.black,
                accentColor: .green,
                gradientColor: GradientColors.green,
                textColor: .white,
                legendTextColor: .white,
                dropShadowColor: .clear
            ),
            form: ChartForm.large,
            rateValue: Int(rateChange)
        )
        .padding()
    }
}
