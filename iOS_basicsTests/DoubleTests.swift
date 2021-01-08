//
//  DoubleTests.swift
//  iOS_basicsTests
//
//  Created by Arnaud SCHEID on 06/01/2021.
//

import XCTest

@testable import iOS_basics

final class DoubleTests: XCTestCase {
    func testTruncate_success() {
        let float = 3.14159265359
        
        let res = float.truncate(places: 2)
        
        XCTAssertEqual(res, 3.14)
    }
}
