//
//  ArticleAPIClient.swift
//  GettingDataFromOnline
//
//  Created by C4Q on 11/27/17.
//  Copyright © 2017 Melissa He @ C4Q. All rights reserved.
//

import Foundation

class ArticleAPIClient {
    private init() {}
    static let manager = ArticleAPIClient()
    func getArticles(from urlStr: String,
                     completionHandler: @escaping ([Article]) -> Void,
                     errorHandler: @escaping
        (Error) -> Void) {
        
        guard let url = URL(string: urlStr) else {
            print("Could not get url")
            return
        }
        
        let completion: (Data) -> Void = {(data: Data) in
            do {
                let articles = try JSONDecoder().decode([Article].self, from: data)
                completionHandler(articles)
            } catch let error {
                print(error)
                errorHandler(error)
            }
        }
        
        NetworkHelper.manager.performDataTask(with: url, completionHandler: completion, errorHandler: errorHandler)
        
    }
}
