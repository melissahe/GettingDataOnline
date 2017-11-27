//
//  ArticleViewController.swift
//  GettingDataFromOnline
//
//  Created by C4Q on 11/27/17.
//  Copyright © 2017 Melissa He @ C4Q. All rights reserved.
//

import UIKit

class ArticleViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    var stock: Stock!
    
    var articles = [Article]() {
        didSet {
            tableView.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        loadData()
    }

    func loadData() {
        let urlStr = "https://api.iextrading.com/1.0/stock/\(stock.symbol)/news/last/20"
        
        let completion = {(onlineArticles: [Article]) -> Void in
            self.articles = onlineArticles
        }
        
        ArticleAPIClient.manager.getArticles(from: urlStr, completionHandler: completion, errorHandler: {print($0)})
    }
    
}

//MARK: - Table View Data Source Methods
extension ArticleViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return articles.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "articleCell", for: indexPath)
        let currentArticle = articles[indexPath.row]
        
        cell.textLabel?.text = currentArticle.headline
        cell.detailTextLabel?.text = currentArticle.source
        
        return cell
    }
}
