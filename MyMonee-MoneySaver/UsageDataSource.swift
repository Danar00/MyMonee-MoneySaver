//
//  UsageDataSource.swift
//  MyMonee-MoneySaver
//
//  Created by MacBook on 20/05/21.
//

import Foundation
import UIKit

class UsageDataSource: NSObject, UITableViewDataSource {
    
    var usageHistoryList: [UsageHistory] = []
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return usageHistoryList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: HomeViewCell.self), for: indexPath) as! HomeViewCell
        cell.showData(usage: usageHistoryList[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
    
    
}
