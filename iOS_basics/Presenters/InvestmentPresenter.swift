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
            AppManager.investmentManager.currencies = try! JSONDecoder().decode([Currency].self, from: data)
            for item in AppManager.investmentManager.currencies {
                AppManager.userManager.user.ownedCurrencies[item.assetID] = 0.0
            }
            AppManager.userManager.user.ownedCurrencies["USDT"] = 100000
            AppManager.userManager.user.ownedCurrencies["BTC"] = 1.952
        }
    }
    
    func sortCurrency() {
        if currencySorted == true {
            AppManager.investmentManager.currencies.sort { $0.assetID < $1.assetID }
        } else {
            AppManager.investmentManager.currencies.sort { $0.assetID > $1.assetID }
        }
        currencySorted = !currencySorted
    }
    
    func sortPrice() {
        if priceSorted == true {
            AppManager.investmentManager.currencies.sort { $0.price < $1.price }
        } else {
            AppManager.investmentManager.currencies.sort { $0.price > $1.price }
        }
        priceSorted = !priceSorted
    }
}
