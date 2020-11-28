//
//  ViewController.swift
//  iOS_basics
//
//  Created by Arnaud SCHEID on 23/11/2020.
//

import UIKit
import SwiftyJSON

class PortfolioVC: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var currencyLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var ownedLabel: UILabel!
    @IBOutlet weak var table: UITableView!
        
    private var currencySorted = false
    private var priceSorted = false
    private var ownedSorted = false
    
    private var indexToReload: IndexPath?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        table.reloadData()
        
        table.delegate = self
        table.dataSource = self

        let sortByName = UITapGestureRecognizer(target: self, action: #selector(PortfolioVC.sortCurrency))
        let sortByPrice = UITapGestureRecognizer(target: self, action: #selector(PortfolioVC.sortPrice))
        let sortByOwned = UITapGestureRecognizer(target: self, action: #selector(PortfolioVC.sortOwned))
        
        currencyLabel.isUserInteractionEnabled = true
        priceLabel.isUserInteractionEnabled = true
        ownedLabel.isUserInteractionEnabled = true
        
        currencyLabel.addGestureRecognizer(sortByName)
        priceLabel.addGestureRecognizer(sortByPrice)
        ownedLabel.addGestureRecognizer(sortByOwned)
        
        if let data = MockHelpers.readLocalFile(forName: "CurrenciesMocks") {
            AppManager.investmentManager.currencies = try! JSONDecoder().decode([Currency].self, from: data)
            for item in AppManager.investmentManager.currencies {
                AppManager.userManager.user.ownedCurrencies[item.assetID] = 0.0
            }
            AppManager.userManager.user.ownedCurrencies["USDT"] = 100000
            print(AppManager.userManager.user.ownedCurrencies)
        }
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
       
        table.reloadData()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return AppManager.investmentManager.currencies.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "portfolioCell", for: indexPath) as! PortfolioCell;
        if AppManager.investmentManager.currencies[indexPath.row].assetID == "USDT" {
            cell.isUserInteractionEnabled = false
        }
        cell.currency?.text = AppManager.investmentManager.currencies[indexPath.row].assetID
        cell.price?.text = "$\(AppManager.investmentManager.currencies[indexPath.row].price.truncate(places: 2).description)"
        cell.owned?.text = AppManager.userManager.user.ownedCurrencies[AppManager.investmentManager.currencies[indexPath.row].assetID]?.truncate(places: 2).description
        return cell;
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        indexToReload = indexPath
        
        if let _ = tableView.cellForRow(at: indexPath), let destinationViewController = navigationController?.storyboard?.instantiateViewController(withIdentifier: "investmentVC") as? InvestmentVC {
            
            destinationViewController.currency = AppManager.investmentManager.currencies[indexPath.row]
            navigationController?.pushViewController(destinationViewController, animated: true)
        }
    }
    
    @IBAction func sortCurrency() {
        if currencySorted == true {
            AppManager.investmentManager.currencies.sort { $0.assetID < $1.assetID }
        } else {
            AppManager.investmentManager.currencies.sort { $0.assetID > $1.assetID }
        }
        currencySorted = !currencySorted
        self.table.reloadData()
    }
    
    @IBAction func sortPrice() {
        if priceSorted == true {
            AppManager.investmentManager.currencies.sort { $0.price < $1.price }
        } else {
            AppManager.investmentManager.currencies.sort { $0.price > $1.price }
        }
        priceSorted = !priceSorted
        self.table.reloadData()
    }
    
    @IBAction func sortOwned() {
        ownedSorted = !ownedSorted
        self.table.reloadData()
    }
}

