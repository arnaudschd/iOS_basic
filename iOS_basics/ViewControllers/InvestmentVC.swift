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
    
    private var indexToReload: IndexPath?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        presenter = InvestmentPresenter()
        
        table.reloadData()
        
        table.delegate = self
        table.dataSource = self

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
        return AppManager.investmentManager.currencies.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "investmentCell", for: indexPath) as! InvestmentCell;
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
        
        if let _ = tableView.cellForRow(at: indexPath), let destinationViewController = navigationController?.storyboard?.instantiateViewController(withIdentifier: "investmentVC") as? InvestmentDetailVC {
            
            destinationViewController.currency = AppManager.investmentManager.currencies[indexPath.row]
            navigationController?.pushViewController(destinationViewController, animated: true)
        }
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

