//
//  CacheManager.swift
//  iOS_basics
//
//  Created by Arnaud SCHEID on 25/11/2020.
//

import Foundation

struct CacheManager {
    let userDefault = UserDefaults.standard
    
    func set(_ key: String, value: String) {
        userDefault.setValue(value, forKey: key)
    }
    
    func get(_ key: String) {
        userDefault.value(forKey: key)
    }
}
