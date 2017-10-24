//
//  GameStateSingleton.swift
//  guessBMW
//
//  Created by Martin Jordán on 21.10.17.
//  Copyright © 2017 Martin Jordán. All rights reserved.
//

import Foundation

class GameStateSingleton {
    static let gameState = GameStateSingleton(results: [], newestTime: "")
    
    var applicationData: ResultsData
    var counter: Int
    
    init (results: [String], newestTime: String) {
        self.applicationData = ResultsData(results: results, newestTime: newestTime)
        self.counter = Int()
    }
    
    func retrieveResults() -> ResultsData {
        return applicationData
    }
    
    func setResultsCollection(applicationData: ResultsData) {
        self.applicationData = applicationData
    }
    
}
