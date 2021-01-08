//
//  PortfolioPresenterTests.swift
//  iOS_basicsTests
//
//  Created by Arnaud SCHEID on 06/01/2021.
//

import XCTest

@testable import iOS_basics

final class PortfolioPresenterTests: XCTestCase {
    let investPres = InvestmentPresenter()
    let sut = PortfolioPresenter()
    
    override func setUp() {
        investPres.getMarketDatas()
    }

    
    func testGetOwnedCurrencies_success() {
        let res = sut.getOwnedCurrencies()
        
        XCTAssertEqual(res, 2)
    }
}
