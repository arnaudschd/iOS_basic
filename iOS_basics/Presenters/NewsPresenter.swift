//
//  NewsPresenter.swift
//  iOS_basics
//
//  Created by Arnaud SCHEID on 09/12/2020.
//

import Foundation

final class NewsPresenter {
    
    var currencySorted: Bool = false
    var valueSorted: Bool = false
    var ownedSorted: Bool = false
    
    func getNews(completion: () -> ()) {
        completion()
    }
    
    func sortCurrency() {
        if currencySorted == true {
            AppManager.investment.currencies.sort { $0.assetID < $1.assetID }
        } else {
            AppManager.investment.currencies.sort { $0.assetID > $1.assetID }
        }
        currencySorted = !currencySorted
    }
    
    func sortValue() {
        if valueSorted == true {
            AppManager.investment.currencies.sort { $0.assetID < $1.assetID }
        } else {
            AppManager.investment.currencies.sort { $0.assetID > $1.assetID }
        }
        valueSorted = !valueSorted
    }
//    
//    func sortOwned() {
//        if ownedSorted == true {
//            AppManager.investment.currencies.sort { $0.price < $1.price }
//        } else {
//            AppManager.investment.currencies.sort { $0.price > $1.price }
//        }
//        ownedSorted = !ownedSorted
//    }
}
