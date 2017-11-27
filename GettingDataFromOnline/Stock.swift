//
//  Stock.swift
//  GettingDataFromOnline
//
//  Created by C4Q on 11/27/17.
//  Copyright © 2017 Melissa He @ C4Q. All rights reserved.
//

import Foundation

struct Stock: Codable {
    let symbol: String
    let companyName: String
    let exchange: String
    let industry: String
    let description: String
    let CEO: String
    
    static let defaultStock = Stock(symbol: "Default symbol", companyName: "Default company", exchange: "Default exchange", industry: "Default industry", description: "Default description", CEO: "Default CEO")
}
