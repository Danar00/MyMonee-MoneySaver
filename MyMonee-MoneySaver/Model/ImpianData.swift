//
//  ImpianData.swift
//  MyMonee-MoneySaver
//
//  Created by MacBook on 14/05/21.
//

import Foundation

struct ImpianData {
    var id: String
    var impianName: String
    var impianProgress: Float
    var impianPrice: String
    var impianPriceTarget: Int
    
    init(impianName: String, impianProgress: Float, impianPrice: String, impianPriceTarget: Int) {
        self.id = String(UUID.init().uuidString.prefix(6)).uppercased()
        self.impianName = impianName
        self.impianProgress = impianProgress
        self.impianPrice = impianPrice
        self.impianPriceTarget = impianPriceTarget
    }
}

var impianData: [ImpianData] = [
//    ImpianData(impianName: "Membeli Mobil", impianProgress: 0.2, impianPrice: "IDR 999.0000 / IDR 200.000.000", impianPriceTarget: 200000000),
//    ImpianData(impianName: "Membeli Airpods Baru", impianProgress: 0.6, impianPrice: "IDR 999.0000 / IDR 1.500.000", impianPriceTarget: 1500000),
//    ImpianData(impianName: "Membeli Sepatu Adidas", impianProgress: 1.0, impianPrice: "IDR 999.0000 / IDR 500.000", impianPriceTarget: 500000)
]
