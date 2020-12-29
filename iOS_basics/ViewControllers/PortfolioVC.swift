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
    
    @IBOutlet weak var currencyLabel: UILabel!
    @IBOutlet weak var valueLabel: UILabel!
    @IBOutlet weak var ownedLabel: UILabel!
    
    private var presenter: PortfolioPresenter!
    
    private var currencySorted = false
    private var priceSorted = false
    private var ownedSorted = false
    
    
    override func viewDidLoad() {
        presenter = PortfolioPresenter()

        self.view.backgroundColor = Colors.background

        let sortByName = UITapGestureRecognizer(target: self, action: #selector(PortflolioVC.sortCurrency))
        let sortByValue = UITapGestureRecognizer(target: self, action: #selector(PortflolioVC.sortValue))
        let sortByOwned = UITapGestureRecognizer(target: self, action: #selector(PortflolioVC.sortOwned))
        
        currencyLabel.isUserInteractionEnabled = true
        valueLabel.isUserInteractionEnabled = true
        ownedLabel.isUserInteractionEnabled = true
        
        currencyLabel.addGestureRecognizer(sortByName)
        valueLabel.addGestureRecognizer(sortByValue)
        ownedLabel.addGestureRecognizer(sortByOwned)
        
        
        table.delegate = self
        table.dataSource = self

        table.reloadData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        presenter.loadPortfolioCurrency()
        
        print(AppManager.news.news?.results)
        
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
        cell.contentView.backgroundColor = Colors.background

        return cell;
    }
    
    @IBAction func sortCurrency() {
//        presenter.sortCurrency()
        self.table.reloadData()
    }

    @IBAction func sortValue() {
//        presenter.sortValue()
        self.table.reloadData()
    }

    @IBAction func sortOwned() {
        self.table.reloadData()
    }
}
