//
//  TimeManager.swift
//  guessBMW
//
//  Created by Martin Jordán on 24.10.17.
//  Copyright © 2017 Martin Jordán. All rights reserved.
//

import Foundation
import UIKit

class TimeManager: UIViewController {
    static let timer = TimeManager ()
    
    var miliseconds = 0
    weak var timer: Timer?
    var startTime: Double = 0
    var time: Double = 0
    var timePenalty: Double = 0

    func startTimer() {
        startTime = Date().timeIntervalSinceReferenceDate
        timer = Timer.scheduledTimer(timeInterval: 0.02,
                                     target: self,
                                     selector: #selector(advanceTimer(timer: )),
                                     userInfo: nil,
                                     repeats: true)
    }
    
    @objc func advanceTimer(timer: Timer) -> String{
        self.time = Date().timeIntervalSinceReferenceDate - startTime + timePenalty
        if GameStateSingleton.gameState.counter == 10 {
            performSegue(withIdentifier: "goToResults", sender: Any?.self)
        }
        return timeString(time: time)
    }
    
    func timeString(time:Double) -> String {
        return String(format:"%.3f",time)
    }
    
}
