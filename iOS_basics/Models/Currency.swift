//
//  Curencies.swift
//  iOS_basics
//
//  Created by Arnaud SCHEID on 24/11/2020.
//

import Foundation
import SwiftyJSON

struct Currency: Codable {
    let assetID, originalSymbol, name, slug: String
    let cryptoType: Bool
    let supply, marketCap, price, volume: Double
    let change, change1Hour, change1Week, earliestKnownPrice: Double
    let earliestTradeDate, lastUpdate, maxSupply: Int
    let id: String

    enum CodingKeys: String, CodingKey {
        case assetID = "assetId"
        case originalSymbol, name, slug, cryptoType, supply, marketCap, price, volume, change, change1Hour, change1Week, earliestKnownPrice, earliestTradeDate, lastUpdate, maxSupply
        case id = "_id"
    }
}
