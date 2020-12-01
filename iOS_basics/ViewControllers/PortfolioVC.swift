//
//  PortfolioVC.swift
//  iOS_basics
//
//  Created by Arnaud SCHEID on 01/12/2020.
//

import Foundation
import UIKit

final class PortflolioVC: UIViewController, UITableViewDelegate, UITableViewDataSource{
    @IBOutlet weak var table: UITableView!

    private var presenter: PortfolioPresenter!
    var portfolioCurrencies: [String: Double]!
    
    override func viewDidLoad() {
        presenter = PortfolioPresenter()
        portfolioCurrencies = presenter.loadPortfolioCurrency()
        
        table.delegate = self
        table.dataSource = self
        
        for (key, value) in AppManager.userManager.user.ownedCurrencies {
           if value > 0 {
              portfolioCurrencies[key] = value
           }
        }
        
        table.reloadData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        portfolioCurrencies = presenter.loadPortfolioCurrency()
        
        table.reloadData()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        var i = 0
        for (_, value) in AppManager.userManager.user.ownedCurrencies {
           if value > 0 {
              i += 1
           }
        }
        return i
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "portfolioCell", for: indexPath) as! PortfolioCell;
        
        cell.currency?.text = Array(portfolioCurrencies.keys)[indexPath.row].description
//        cell.currency?.text = Array(portfolioCurrencies.values)[indexPath.row]
        cell.owned?.text = Array(portfolioCurrencies.values)[indexPath.row].truncate(places: 2).description
        print(Array(portfolioCurrencies.keys)[indexPath.row])
        
        return cell;
    }
    
    //    @IBAction func sortCurrency() {
//        presenter.sortCurrency()
//        self.table.reloadData()
//    }
//
//    @IBAction func sortPrice() {
//        presenter.sortPrice()
//        self.table.reloadData()
//    }
//
//    @IBAction func sortOwned() {
//        self.table.reloadData()
//    }
}
