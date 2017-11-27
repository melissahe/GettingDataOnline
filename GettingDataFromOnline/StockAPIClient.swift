//
//  StockAPIClient.swift
//  GettingDataFromOnline
//
//  Created by C4Q on 11/27/17.
//  Copyright © 2017 Melissa He @ C4Q. All rights reserved.
//

import Foundation

//singleton model
class StockAPIClient {
    private init() {}
    static let manager = StockAPIClient()
    func getStock(from urlStr: String,
                  completionHandler: @escaping (Stock) -> Void,
                  errorHandler: @escaping (Error) -> Void) {
        
        //1. we give it a string - takes a string
        guard let url = URL(string: urlStr) else {
            print("\(urlStr)")
            print("Could not get url")
            return
        }
        
        //2. completion handler - what should it do with this data; it somehow gets a stock
        //how do we get stock? we need to get data from network
        let completion: (Data) -> Void = {(data: Data) in
            //this expects a closure
            do {
                let stock = try JSONDecoder().decode(Stock.self, from: data)
                completionHandler(stock)
            } catch let error {
                //3. error handler - what happens if there's an error
                errorHandler(error)
            }
        }
        
        NetworkHelper.manager.performDataTask(with: url, completionHandler: completion, errorHandler: errorHandler)
        
        
    }
}
