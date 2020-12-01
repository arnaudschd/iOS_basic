//
//  MockHelpers.swift
//  iOS_basics
//
//  Created by Arnaud SCHEID on 24/11/2020.
//

import Foundation

class MockHelpers {
    static func readLocalFile(forName name: String) -> Data? {
        do {
            if let bundlePath = Bundle.main.path(forResource: name,
                                                 ofType: "json"),
                let jsonData = try String(contentsOfFile: bundlePath).data(using: .utf8) {
                return jsonData
            }
        } catch {
            print(error)
        }
        return nil
    }
    
    static func findCurrencyByID(value searchValue: String) -> Currency?
    {
        for (_, value) in AppManager.investmentManager.currencies.enumerated()
        {
            if value.assetID == searchValue {
                return value
            }
        }
        return nil
    }
}
