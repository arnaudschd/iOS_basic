//
//  InvestmentV.swift
//  iOS_basics
//
//  Created by Arnaud SCHEID on 25/11/2020.
//

import UIKit

class InvestmentVC: UIViewController {
    
    @IBOutlet weak var buyButton: UIButton!
    @IBOutlet weak var sellButton: UIButton!
    @IBOutlet weak var currencyPriceLabel: UILabel!
    @IBOutlet weak var ammountTextField: UITextField!
    
    var currency: Currency!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "\(currency.name)"
        self.currencyPriceLabel.text = "$\(currency.price.truncate(places: 2).description)"
        self.ammountTextField.text = "0"
        setUpButtons()
    }
    
    func setUpButtons() {
        buyButton.tintColor = UIColor.white
        buyButton.backgroundColor = #colorLiteral(red: 0, green: 0.659442626, blue: 0.2802314791, alpha: 1)
        buyButton.layer.cornerRadius = 5
        
        sellButton.tintColor = UIColor.white
        sellButton.backgroundColor = #colorLiteral(red: 0.8078431487, green: 0.02745098062, blue: 0.3333333433, alpha: 1)
        sellButton.layer.cornerRadius = 5
    }
    
    @IBAction func sellCurrency() {
        let toDouble = Double(ammountTextField.text!)
        AppManager.userManager.user.ownedCurrencies[currency.assetID]! -= toDouble!
    }

    @IBAction func buyCurrency() {
        let toDouble = Double(ammountTextField.text!)
        AppManager.userManager.user.ownedCurrencies[currency.assetID]! += toDouble!
    }
}
