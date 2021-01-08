//
//  InvestmentPresenterTests.swift
//  iOS_basicsTests
//
//  Created by Arnaud SCHEID on 06/01/2021.
//

import XCTest

@testable import iOS_basics

final class InvestmentPresenterTests: XCTestCase {
    let sut = InvestmentPresenter()
    
    override func setUp() {
        super.setUp()
    }
    
    func testGetMarketDatas_success() {
        AppManager.investment.currencies = []
        
        sut.getMarketDatas()
        
        XCTAssertNotEqual(AppManager.investment.currencies, [])
        XCTAssertEqual(AppManager.user.user.ownedCurrencies["USDT"], 100000)
        XCTAssertEqual(AppManager.user.user.ownedCurrencies["BTC"] , 1.952)
    }
}
