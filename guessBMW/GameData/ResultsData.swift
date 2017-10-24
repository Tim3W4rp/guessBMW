//
//  ResultsData.swift
//  guessBMW
//
//  Created by Martin Jordán on 21.10.17.
//  Copyright © 2017 Martin Jordán. All rights reserved.
//

import Foundation

struct ResultsData {
    var results: [String] = []
    var newestTime: String
   
    mutating func appendResult(newestResult: String){
        results.append(newestResult)
    }
    
    mutating func sortResults(){
        results = results.sorted(by: <)
    }
    
    func  getBestResult() -> String {
        if let bestResult = results.min() {
            return bestResult
        }
        return "0.000"
    }
    
    func getResults() -> [String] {
        return results
    }
    
    mutating func setResults(results: [String]) {
        self.results = results
    }
    
    func getSize() -> Int {
        return results.count
    }
    
    func getNewestTime() -> String {
        return newestTime
    }
    
    mutating func setNewestTime(time: String) {
        self.newestTime = time
    }
}
