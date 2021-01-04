//
//  HomePresenter.swift
//  iOS_basics
//
//  Created by Arnaud SCHEID on 23/11/2020.
//

import Foundation

final class InvestmentPresenter {
      
    private var currencySorted = false
    private var priceSorted = false
    private var ownedSorted = false
    
    func getMarketDatas() {
        if let data = MockHelpers.readLocalFile(forName: "CurrenciesMocks") {
            AppManager.investment.currencies = try! JSONDecoder().decode([Currency].self, from: data)
            
            if UserDefaults.standard.object(forKey: "ownedCurr") == nil {
                for item in AppManager.investment.currencies {
                    AppManager.user.user.ownedCurrencies[item.assetID] = 0.0
                }
                AppManager.user.user.ownedCurrencies["USDT"] = 100000
                AppManager.user.user.ownedCurrencies["BTC"] = 1.952
            }
        }
    }
    
    func sortCurrency() {
        if currencySorted == true {
            AppManager.investment.currencies.sort { $0.assetID < $1.assetID }
        } else {
            AppManager.investment.currencies.sort { $0.assetID > $1.assetID }
        }
        currencySorted = !currencySorted
    }
    
    func sortPrice() {
        if priceSorted == true {
            AppManager.investment.currencies.sort { $0.price < $1.price }
        } else {
            AppManager.investment.currencies.sort { $0.price > $1.price }
        }
        priceSorted = !priceSorted
    }
}
