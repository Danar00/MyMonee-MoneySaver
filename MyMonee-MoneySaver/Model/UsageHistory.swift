//
//  UsageHistory.swift
//  MyMonee-MoneySaver
//
//  Created by MacBook on 14/05/21.
//

import Foundation

enum TypeHistory: String {
    case deposit
    case withdraw
}

struct UsageHistory {
    var id: String
    var usageName: String
    var usageDate: String
    var price: Int
    var status: Bool
    
    init(usageName: String, usageDate: String, price: Int, status: Bool) {
        self.id = String(UUID.init().uuidString.prefix(6)).uppercased()
        self.usageName = usageName
        self.usageDate = usageDate
        self.price = price
        self.status = status
    }
}

var usageHistory: [UsageHistory] = [
//    UsageHistory(usageName: "Bayar Listrik", usageDate: "1 Mei 2021 - 19.30", price: 256000, status: true),
//    UsageHistory(usageName: "Gaji Febuari", usageDate: "1 Mei 2021 - 19.30", price: 1250000, status: false)
]
