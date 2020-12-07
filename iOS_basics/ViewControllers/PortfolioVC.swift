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
    
    override func viewDidLoad() {
        presenter = PortfolioPresenter()

        self.view.backgroundColor = UIColor(named: "backgroundColor")

        table.delegate = self
        table.dataSource = self

        table.reloadData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        presenter.loadPortfolioCurrency()
        
        table.reloadData()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter.getOwnedCurrencies()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "portfolioCell", for: indexPath) as! PortfolioCell;
        cell.currency?.text = Array(presenter.portfolioCurrencies.keys)[indexPath.row].description
        cell.value?.text = (Array(presenter.portfolioCurrencies.values)[indexPath.row] *
                                (MockHelpers.findCurrencyByID(value: Array(presenter.portfolioCurrencies.keys)[indexPath.row]
                                                                .description)?.price.truncate(places: 2))!).truncate(places: 2).description
        cell.owned?.text = Array(presenter.portfolioCurrencies.values)[indexPath.row].truncate(places: 2).description
        cell.contentView.backgroundColor = UIColor(named: "backgroundColor")

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
