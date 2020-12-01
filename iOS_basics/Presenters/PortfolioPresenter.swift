//
//  PortfolioPresenter.swift
//  iOS_basics
//
//  Created by Arnaud SCHEID on 01/12/2020.
//

import Foundation

final class PortfolioPresenter {
    var ownedCurrencies: [String: Double] = [:]
    
    func loadPortfolioCurrency() -> [String : Double] {
        var portfolioCurrencies: [String: Double] = [:]
        
        for (curr, qty) in AppManager.userManager.user.ownedCurrencies {
            if qty != 0 {
                portfolioCurrencies[curr] = qty
            }
        }
        return portfolioCurrencies
    }
}
