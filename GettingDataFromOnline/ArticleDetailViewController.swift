//
//  ArticleDetailViewController.swift
//  GettingDataFromOnline
//
//  Created by C4Q on 11/27/17.
//  Copyright © 2017 Melissa He @ C4Q. All rights reserved.
//

import UIKit

class ArticleDetailViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var headlineLabel: UILabel!
    @IBOutlet weak var sourceLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var summaryTextView: UITextView!
    @IBOutlet weak var relatedStocksTableView: UITableView!
    
    
    var article: Article!
    var relatedStocks: [String] = [] {
        didSet {
            relatedStocksTableView.reloadData()
        }
    }
    
    var selectedText = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadData()
        relatedStocksTableView.dataSource = self
        relatedStocksTableView.delegate = self
    }

    func loadData() {
        relatedStocks = article.related.components(separatedBy: ",")
        headlineLabel.text = article.headline
        sourceLabel.text = article.source
        dateLabel.text = article.datetime
        summaryTextView.text = article.summary
    }
    
    //Data Source Methods
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return relatedStocks.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "relatedCell", for: indexPath)
        let currentRelatedStock = relatedStocks[indexPath.row]
        
        cell.textLabel?.text = currentRelatedStock
        
        return cell
    }
    
    @IBAction func unwindToStockViewController(segue: UIStoryboardSegue) {
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        let selectedIndexPath = relatedStocksTableView.indexPathForSelectedRow
//
//        let selectedCell = relatedStocksTableView.cellForRow(at: selectedIndexPath!)
        
        performSegue(withIdentifier: "unwindSegue", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if
            let currentVC = segue.source as? ArticleDetailViewController,
            let destinationVC = segue.destination as? ViewController {
            destinationVC.searchTerm = currentVC.selectedText
        }
    }
    
//    //Navigation
//    override func unwind(for unwindSegue: UIStoryboardSegue, towardsViewController subsequentVC: UIViewController) {
//        if let destinationVC = unwindSegue.destination as? ViewController {
//            destinationVC.stock
//        }
//    }
    
}
