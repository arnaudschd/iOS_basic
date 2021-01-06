//
//  Double.swift
//  iOS_basics
//
//  Created by Arnaud SCHEID on 25/11/2020.
//

import Foundation

extension Double {
    func truncate(places : Int) -> Double {
        return Double(floor(pow(10.0, Double(places)) * self) / pow(10.0, Double(places)))
    }
}
