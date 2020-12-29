//
//  AppManager.swift
//  iOS_basics
//
//  Created by Arnaud SCHEID on 23/11/2020.
//

import Foundation

struct AppManager {
    static let shared = AppManager()
    static var investment = InvestmentManager()
    static var cache = CacheManager()
    static var user = UserManager()
    static var news = NewsManager()
    static var network = NetworkManager()
}
