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
        self.ownedValueLabel.text = String((AppManager.user.user.ownedCurrencies[currency.assetID]! * currency.price).truncate(places: 2))
        self.ownedQuantityLabel.text = AppManager.user.user.ownedCurrencies[currency.assetID]!.truncate(places: 2).description
    }
    
    func setUpButtons() {
        buyButton.tintColor = UIColor.white
        buyButton.backgroundColor = Colors.green
        buyButton.layer.cornerRadius = 5
        
        sellButton.tintColor = UIColor.white
        sellButton.backgroundColor = Colors.red
        sellButton.layer.cornerRadius = 5
    }
    
    @IBAction func sellCurrency() {
        let toDouble = Double(ammountTextField.text!)!
        if AppManager.user.user.ownedCurrencies[currency.assetID]! < toDouble {
            self.view.makeToast(insufficientCurrency)
        } else {
            AppManager.user.user.ownedCurrencies[currency.assetID]! -= toDouble
            AppManager.user.user.ownedCurrencies["USDT"]! += currency.price * toDouble
            updateLabels()
        }
    }
    
    @IBAction func buyCurrency() {
        let toDouble = Double(ammountTextField.text!)!
        if AppManager.user.user.ownedCurrencies["USDT"]! < (toDouble * currency.price) {
            self.view.makeToast(insufficientFunds)
        } else {
            AppManager.user.user.ownedCurrencies[currency.assetID]! += toDouble
            AppManager.user.user.ownedCurrencies["USDT"]! -= currency.price * toDouble
            updateLabels()
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
