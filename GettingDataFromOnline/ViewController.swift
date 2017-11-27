//
//  ViewController.swift
//  GettingDataFromOnline
//
//  Created by C4Q on 11/27/17.
//  Copyright © 2017 Melissa He @ C4Q. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UISearchBarDelegate {

    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var CEOLabel: UILabel!
    @IBOutlet weak var exchangeLabel: UILabel!
    @IBOutlet weak var descriptionTextView: UITextView!
    @IBOutlet weak var errorMessageLabel: UILabel!
    
    var searchTerm: String = "" {
        didSet {
            loadData()
        }
    }
    
    var stock = Stock.defaultStock {
        didSet {
            //we want it so that things update whenever your stock changes
            setLabelsFromStock()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        searchBar.delegate = self
        errorMessageLabel.text = ""
    }
    
    func loadData() {
        let urlStr = "https://api.iextrading.com/1.0/stock/\(searchTerm)/company"
        let setStockToOnlineStock: (Stock) -> Void = { (onlineStock: Stock) in
            //what should we do if we have a stock
            self.stock = onlineStock
            self.errorMessageLabel.text = ""
        }
        
        StockAPIClient.manager.getStock(from: urlStr, completionHandler: setStockToOnlineStock, errorHandler: {_ in
            self.errorMessageLabel.text = "Error: Could not get \"\(self.searchTerm)\" as a company symbol"
        })
        
    }
    
    func setLabelsFromStock() {
        nameLabel.text = stock.companyName
        CEOLabel.text = stock.CEO
        exchangeLabel.text = stock.exchange
        descriptionTextView.text = stock.description
    }
    
    //Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destinationVC = segue.destination as? ArticleViewController {
            destinationVC.stock = stock
        }
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let searchText = searchBar.text else {
            return
        }
        
        searchTerm = searchText
        searchBar.resignFirstResponder()
    }
    
}

