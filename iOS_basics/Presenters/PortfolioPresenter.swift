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
    
    private var currencySorted: Bool = false
    private var valueSorted: Bool = false
    private var ownedSorted: Bool = false
    
    init() {
        loadPortfolioCurrency()
        
        for (key, value) in AppManager.user.user.ownedCurrencies {
            if value > 0 {
                portfolioCurrencies[key] = value
            }
        }
    }
    
    func loadPortfolioCurrency(){
        var portfolioCurrencies: [String: Double] = [:]
        
        for (curr, qty) in AppManager.user.user.ownedCurrencies {
            if qty != 0 {
                portfolioCurrencies[curr] = qty
            }
        }
        self.portfolioCurrencies = portfolioCurrencies
    }
    
    func getOwnedCurrencies() -> Int {
        var i = 0
        
        for (_, value) in AppManager.user.user.ownedCurrencies {
           if value > 0 {
              i += 1
           }
        }
        return i
    }
//    
//    func sortCurrency() {
//        let keysArraySorted = Array(ownedCurrencies.map({ $0.key }))
//        
//        ownedCurrencies = keysArraySorted
//        for
//    }
//    
//    func sortValue() {
//        var sorted: [String: Double] = [:]
//        
//        if currencySorted == true {
//            sorted = portfolioCurrencies.sorted { return $0.key < $1.key }
//        } else {
//            sorted = portfolioCurrencies.sorted { return $0.key > $1.key }
//        }
//        valueSorted = !valueSorted
//    }

}
