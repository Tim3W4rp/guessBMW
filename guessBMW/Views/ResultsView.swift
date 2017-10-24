//
//  ResultsView.swift
//  guessBMW
//
//  Created by Martin Jordán on 20.10.17.
//  Copyright © 2017 Martin Jordán. All rights reserved.
//

import Foundation
import UIKit

class ResultsView : UIViewController {

    @IBOutlet var resultLabel: UILabel!
    
    override func viewDidLoad() {
        resultLabel.text = "Your time is: \(GameStateSingleton.gameState.applicationData.getNewestTime())"
    }
    
}
