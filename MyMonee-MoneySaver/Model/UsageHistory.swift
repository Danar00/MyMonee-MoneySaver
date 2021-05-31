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

struct UsageHistory: Codable {
    var id: String
    var usageName: String
    var usageDate: String
    var price: Int
    var status: Bool
    
    enum CodingKeys: String, CodingKey  {
        case id
        case usageName = "usage_name"
        case usageDate = "usage_date"
        case price
        case status
    }
    
    
    init(usageName: String, usageDate: String, price: Int, status: Bool) {
        self.id = String(UUID.init().uuidString.prefix(6)).uppercased()
        self.usageName = usageName
        self.usageDate = usageDate
        self.price = price
        self.status = status
    }
}

extension UsageHistory {
    func formatRupiah() -> String {
        let formatter = NumberFormatter()
        formatter.locale = Locale(identifier: "Id_ID")
        formatter.groupingSeparator = "."
        formatter.numberStyle = .decimal
        var result: String = ""
        
        if let formatterTipAmount = formatter.string(from: self.price as NSNumber) {
            result = "Rp \(formatterTipAmount)"
        }
        return result
    }
    
    func formatDate() -> String {
        let date = Date()
        let formatter = DateFormatter()
        formatter.dateFormat = "dd MMMM yyyy - HH.mm"
        let result = formatter.string(from: date)
        return result
    }
}




var usageHistory: [UsageHistory] = [
//    UsageHistory(usageName: "Bayar Listrik", usageDate: "1 Mei 2021 - 19.30", price: 256000, status: true),
//    UsageHistory(usageName: "Gaji Febuari", usageDate: "1 Mei 2021 - 19.30", price: 1250000, status: false)
]




