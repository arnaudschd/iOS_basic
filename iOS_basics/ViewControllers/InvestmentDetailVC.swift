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
    @IBOutlet weak var marketCap: UILabel!
    @IBOutlet weak var supply: UILabel!
    @IBOutlet weak var volume: UILabel!
    
    var currency: Currency!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "\(currency.name)"
        self.currencyPriceLabel.text = String(format: "$%.02f", currency.price)
        self.ammountTextField.text = "0"
        self.marketCap.text = String(format: "$%.02f", currency.marketCap)
        self.supply.text = String(format: "%.02f \(currency.assetID)", currency.supply)
        self.volume.text = String(format: "$%.02f", currency.volume)
        self.view.backgroundColor = Colors.background
        updateLabels()
        setUpButtons()
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
        
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(
            target: self,
            action: #selector(dismissMyKeyboard))
        view.addGestureRecognizer(tap)
    }
    
    func updateLabels() {
        self.ownedValueLabel.text = String(format: "%.02f", AppManager.user.user.ownedCurrencies[currency.assetID]! * currency.price)
        self.ownedQuantityLabel.text = String(format: "%.02f", AppManager.user.user.ownedCurrencies[currency.assetID]!)
    }
    
    func setUpButtons() {
        buyButton.tintColor = UIColor.white
        buyButton.backgroundColor = Colors.green
        buyButton.layer.cornerRadius = 10
        
        sellButton.tintColor = UIColor.white
        sellButton.backgroundColor = Colors.red
        sellButton.layer.cornerRadius = 10
    }
    
    @IBAction func sellCurrency() {
        if let toDouble = Double(ammountTextField.text ?? "0") {
            if AppManager.user.user.ownedCurrencies[currency.assetID]! < toDouble {
                self.view.makeToast(insufficientCurrency)
            } else {
                AppManager.user.user.ownedCurrencies[currency.assetID]! -= toDouble
                AppManager.user.user.ownedCurrencies["USDT"]! += currency.price * toDouble
                UserDefaults.standard.setValue(AppManager.user.user.ownedCurrencies, forKey: "ownedCurr")
                updateLabels()
            }
        }
    }
    
    
    @IBAction func buyCurrency() {
        if let toDouble = Double(ammountTextField.text ?? "0") {
            if AppManager.user.user.ownedCurrencies["USDT"]! < (toDouble * currency.price) {
                self.view.makeToast(insufficientFunds)
            } else {
                AppManager.user.user.ownedCurrencies[currency.assetID]! += toDouble
                AppManager.user.user.ownedCurrencies["USDT"]! -= currency.price * toDouble
                UserDefaults.standard.set(AppManager.user.user.ownedCurrencies, forKey: "ownedCurr")
                updateLabels()
            }
        }
    }
    
    @objc func keyboardWillShow(notification: NSNotification) {
        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
            if self.view.frame.origin.y == 0 {
                self.view.frame.origin.y -= keyboardSize.height
            }
        }
    }
    
    @objc func keyboardWillHide(notification: NSNotification) {
        if self.view.frame.origin.y != 0 {
            self.view.frame.origin.y = 0
        }
    }
    
    @objc func dismissMyKeyboard(){
        view.endEditing(true)
    }
}
