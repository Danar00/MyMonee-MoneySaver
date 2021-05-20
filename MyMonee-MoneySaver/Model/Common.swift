//
//  Common.swift
//  MyMonee-MoneySaver
//
//  Created by MacBook on 16/05/21.
//

import Foundation
import UIKit

struct LastTransaction {
    var lastDeposit: String = "0"
    var lastWithdraw: String = "0"
}

protocol noticed {
    func alert()
}

func getBalance() -> Double {
    var result:Double = balance.balanceAmount
    for value in usageHistory {
        switch value.status{
        case true:
            result -= Double(value.price)
        case false:
            result += Double(value.price)
        }
    }
    return result
}

//func getLastDepoAndWithdraw() -> LastTransaction{
//    var result:LastTransaction = LastTransaction()
//
//    usageHistory.forEach { (value: UsageHistory) in
//        switch value.status{
//        case false:
//            result.lastDeposit = convertIntToFormatMoney(money: value.price, isDepoOrWithdraw: nil)
//        case true:
//            result.lastWithdraw = convertIntToFormatMoney(money: value.price, isDepoOrWithdraw: nil)
//        }
//    }
//    return result
//}

func getLastTransactionDeposit() -> String {
    var result: Double = 0
    for value in usageHistory {
        if value.status == false {
            result = Double(value.price)
        }
    }
    return convertIntToFormatMoney(money: Int(result), isDepoOrWithdraw: nil)
    
}

func getLastTransactionWithdraw() -> String {
    var result: Double = 0
    for value in usageHistory {
        if value.status == true {
            result = Double(value.price)
        }
    }
    return convertIntToFormatMoney(money: Int(result), isDepoOrWithdraw: nil)
}

func convertIntToFormatMoney(money:Int,isDepoOrWithdraw:TypeHistory?) -> String{
    let formatter = NumberFormatter()
    formatter.locale = Locale(identifier: "id_ID")
    formatter.groupingSeparator = "."
    formatter.numberStyle = .decimal
    var result: String = "", symbol: String = ""

    if isDepoOrWithdraw != nil{
        symbol = isDepoOrWithdraw == .deposit  ? "+" : "-"
    }

    if let formattedTipAmount = formatter.string(from: money as NSNumber) {
       result = "\(symbol)Rp " + formattedTipAmount
    }
    return result
}

func convertIntToFormatMoneyRaw(money:Int) -> String{
    let formatter = NumberFormatter()
    formatter.locale = Locale(identifier: "id_ID")
    formatter.groupingSeparator = "."
    formatter.numberStyle = .decimal
    var result: String = ""
    if let formattedTipAmount = formatter.string(from: money as NSNumber) {
       result = formattedTipAmount
    }
    return result
}



func convertToMoney(money: Double) -> String {
    let formatter = NumberFormatter()
    formatter.locale = Locale(identifier: "id_ID")
    formatter.groupingSeparator = "."
    formatter.numberStyle = .decimal
    var result: String = ""
    if let formattedAmount = formatter.string(from: money as NSNumber) {
        result = formattedAmount
    }
    return result
}


func moneyToDecimal(money: String) -> Double {
    let formatter = NumberFormatter()
    formatter.locale = Locale(identifier: "id_ID") // USA: Locale(identifier: "en_US")
    formatter.numberStyle = .decimal
    var number: Double = 0
    if let formattedAmount = formatter.number(from: money){
        number = Double(truncating: formattedAmount)
    }
    return number
}

//func getCurrentDate() -> String {
//    let date = Date()
//    let formatter = DateFormatter()
//    formatter.dateFormat = "dd MMMM yyyy - HH.mm"
//    let result = formatter.string(from: date)
//    return result
//}

struct Balance {
    var balanceAmount: Double
    
    init(balanceAmount: Double) {
        self.balanceAmount = balanceAmount
    }
    
}

var balance = Balance(balanceAmount: 0)
