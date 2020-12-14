//
//  AppManager.swift
//  iOS_basics
//
//  Created by Arnaud SCHEID on 23/11/2020.
//

import Foundation

struct AppManager {
    static let shared = AppManager()
    static var investmentManager = InvestmentManager()
    static var cacheManager = CacheManager()
    static var userManager = UserManager()
}
