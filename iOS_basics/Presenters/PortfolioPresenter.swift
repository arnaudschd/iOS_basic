//
//  PortfolioPresenter.swift
//  iOS_basics
//
//  Created by Arnaud SCHEID on 01/12/2020.
//

import Foundation

final class PortfolioPresenter {
    var ownedCurrencies: [String: Double] = [:]
    
    var portfolioCurrencies: [String: Double]!
    
    init() {
        loadPortfolioCurrency()
        
        for (key, value) in AppManager.userManager.user.ownedCurrencies {
            if value > 0 {
                portfolioCurrencies[key] = value
            }
        }
    }
    
    func loadPortfolioCurrency(){
        var portfolioCurrencies: [String: Double] = [:]
        
        for (curr, qty) in AppManager.userManager.user.ownedCurrencies {
            if qty != 0 {
                portfolioCurrencies[curr] = qty
            }
        }
        self.portfolioCurrencies = portfolioCurrencies
    }
    
    func getOwnedCurrencies() -> Int {
        var i = 0
        
        for (_, value) in AppManager.userManager.user.ownedCurrencies {
           if value > 0 {
              i += 1
           }
        }
        return i
    }

}
