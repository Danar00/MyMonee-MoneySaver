//
//  NetworkService.swift
//  MyMonee-MoneySaver
//
//  Created by MacBook on 20/05/21.
//

import Foundation
class NetworkService {
    let url: String = "https://60a5fb0ac0c1fd00175f4d86.mockapi.io/api/v1/transaction"

    func loadTransactionList(completion: @escaping (_ usage: [UsageHistory]) -> ()) {
        let components = URLComponents(string: self.url)!

//        components.queryItems = [
//            URLQueryItem(name: <#T##String#>, value: <#T##String?#>)
//        ]

        let request = URLRequest(url: components.url!)
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            if let data = data {
                let decoder = JSONDecoder()
                let history = try! decoder.decode([UsageHistory].self, from: data) as [UsageHistory]
                completion(history)
                
            }
//            if let httpResponse =  response as? HTTPURLResponse {
//                httpResponse.statusCode
//            }
        }
        task.resume()
    }
}

