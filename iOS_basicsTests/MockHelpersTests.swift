//
//  MockHelpersTests.swift
//  iOS_basicsTests
//
//  Created by Arnaud SCHEID on 05/01/2021.
//

import XCTest

@testable import iOS_basics

final class MockHelpersTests: XCTestCase {
    let sut = MockHelpers()
    
    override func setUp() {
        super.setUp()
    }
    
    func testReadLocalFile_success() {
        let file = "CurrenciesMocks"
                
        let res = sut.readLocalFile(forName: file)
        
        XCTAssertNotNil(res)
    }

    func testReadLocalFile_failed() {
        let file = "WrongFile"
                
        let res = sut.readLocalFile(forName: file)
        
        XCTAssertNil(res)
    }
    
    func testFindCurrencyById_success() {
        let res = sut.findCurrencyByID(value: "BTC")
        
        XCTAssertEqual(res!.assetID, "BTC")
    }
    
    func testFindCurrencyById_failed() {
        let res = sut.findCurrencyByID(value: "test")
        
        XCTAssertNil(res)
    }
}
