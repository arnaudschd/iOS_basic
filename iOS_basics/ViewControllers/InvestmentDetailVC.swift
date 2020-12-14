//
//  InvestmentV.swift
//  iOS_basics
//
//  Created by Arnaud SCHEID on 25/11/2020.
//

import UIKit
import Toast

class InvestmentDetailVC: UIViewController {
    
    @IBOutlet weak var buyButton: UIButton!
    @IBOutlet weak var sellButton: UIButton!
    @IBOutlet weak var currencyPriceLabel: UILabel!
    @IBOutlet weak var ammountTextField: UILabel!
    @IBOutlet weak var ownedQuantityLabel: UILabel!
    @IBOutlet weak var ownedValueLabel: UILabel!
    
    var currency: Currency!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "\(currency.name)"
        self.currencyPriceLabel.text = "$\(currency.price.truncate(places: 2).description)"
        self.ammountTextField.text = "0"
        self.view.backgroundColor = UIColor(named: "backgroundColor")
        updateLabels()
        setUpButtons()
    }
    
    func updateLabels() {
        self.ownedValueLabel.text = String((AppManager.userManager.user.ownedCurrencies[currency.assetID]! * currency.price).truncate(places: 2))
        self.ownedQuantityLabel.text = AppManager.userManager.user.ownedCurrencies[currency.assetID]!.truncate(places: 2).description
    }
    
    func setUpButtons() {
        buyButton.tintColor = UIColor.white
        buyButton.backgroundColor = UIColor(named: "buyButtonColor")
        buyButton.layer.cornerRadius = 5
        
        sellButton.tintColor = UIColor.white
        sellButton.backgroundColor = UIColor(named: "sellButtonColor")
        sellButton.layer.cornerRadius = 5
    }
    
    @IBAction func sellCurrency() {
        let toDouble = Double(ammountTextField.text!)!
        if AppManager.userManager.user.ownedCurrencies[currency.assetID]! < toDouble {
            self.view.makeToast(insufficientCurrency)
        } else {
            AppManager.userManager.user.ownedCurrencies[currency.assetID]! -= toDouble
            AppManager.userManager.user.ownedCurrencies["USDT"]! += currency.price * toDouble
            updateLabels()
        }
    }
    
    @IBAction func buyCurrency() {
        let toDouble = Double(ammountTextField.text!)!
        if AppManager.userManager.user.ownedCurrencies["USDT"]! < (toDouble * currency.price) {
            self.view.makeToast(insufficientFunds)
        } else {
            AppManager.userManager.user.ownedCurrencies[currency.assetID]! += toDouble
            AppManager.userManager.user.ownedCurrencies["USDT"]! -= currency.price * toDouble
            updateLabels()
        }
    }
}
