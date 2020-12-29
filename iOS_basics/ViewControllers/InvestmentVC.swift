//
//  ViewController.swift
//  iOS_basics
//
//  Created by Arnaud SCHEID on 23/11/2020.
//

import UIKit
import SwiftyJSON

class InvestmentVC: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var currencyLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var ownedLabel: UILabel!
    @IBOutlet weak var table: UITableView!
        
    private var presenter: InvestmentPresenter!
    private var refreshControl = UIRefreshControl()
    
    private var indexToReload: IndexPath?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        presenter = InvestmentPresenter()

        self.view.backgroundColor = Colors.background
        
        table.reloadData()
        table.delegate = self
        table.dataSource = self
        
        refreshControl.attributedTitle = NSAttributedString(string: "Pull to refresh")
        refreshControl.addTarget(self, action: #selector(self.refresh(_:)), for: .valueChanged)
        table.refreshControl = refreshControl // not required when using UITableViewController
        
        let sortByName = UITapGestureRecognizer(target: self, action: #selector(InvestmentVC.sortCurrency))
        let sortByPrice = UITapGestureRecognizer(target: self, action: #selector(InvestmentVC.sortPrice))
        let sortByOwned = UITapGestureRecognizer(target: self, action: #selector(InvestmentVC.sortOwned))
        
        currencyLabel.isUserInteractionEnabled = true
        priceLabel.isUserInteractionEnabled = true
        ownedLabel.isUserInteractionEnabled = true
        
        currencyLabel.addGestureRecognizer(sortByName)
        priceLabel.addGestureRecognizer(sortByPrice)
        ownedLabel.addGestureRecognizer(sortByOwned)
        
        presenter.getMarketDatas()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
       
        table.reloadData()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return AppManager.investment.currencies.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "investmentCell", for: indexPath) as! InvestmentCell;
        if AppManager.investment.currencies[indexPath.row].assetID == "USDT" {
            cell.isUserInteractionEnabled = false
        }
        cell.currency?.text = AppManager.investment.currencies[indexPath.row].assetID
        cell.price?.text = String(format: "$%.02f", AppManager.investment.currencies[indexPath.row].price)
        cell.owned?.text = String(format: "%.02f", AppManager
                                    .user
                                    .user
                                    .ownedCurrencies[AppManager.investment.currencies[indexPath.row]
                                                        .assetID] as! CVarArg)
        cell.contentView.backgroundColor = Colors.background
        
        cell.price.textColor = (AppManager.investment.currencies[indexPath.row].change1Hour > 0) ? Colors.green : Colors.red
        return cell;
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        indexToReload = indexPath
        
        if let _ = tableView.cellForRow(at: indexPath), let destinationViewController = navigationController?.storyboard?.instantiateViewController(withIdentifier: "investmentVC") as? InvestmentDetailVC {
            
            destinationViewController.currency = AppManager.investment.currencies[indexPath.row]
            navigationController?.pushViewController(destinationViewController, animated: true)
        }
    }
    
    @objc func refresh(_ sender: AnyObject) {
        refreshControl.endRefreshing()
        print("PTR")
    }
    
    @IBAction func sortCurrency() {
        presenter.sortCurrency()
        self.table.reloadData()
    }
    
    @IBAction func sortPrice() {
        presenter.sortPrice()
        self.table.reloadData()
    }
    
    @IBAction func sortOwned() {
        self.table.reloadData()
    }
}

