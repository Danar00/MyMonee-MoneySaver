//
//  Format.swift
//  MyMonee-MoneySaver
//
//  Created by MacBook on 19/05/21.
//

import Foundation
import UIKit

protocol ConvertDate {
    func currentDate() -> String
}

protocol ConvertCurrency {
    func currentCurrency() -> String
}
