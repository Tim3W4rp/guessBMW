//
//  MainView.swift
//  guessBMW
//
//  Created by Martin Jordán on 20.10.17.
//  Copyright © 2017 Martin Jordán. All rights reserved.
//

import UIKit

class MainView: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet var newestTimeLabel: UILabel!
    @IBOutlet var bestResultsTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if GameStateSingleton.gameState.applicationData.getNewestTime() != "" {
            GameStateSingleton.gameState.applicationData.appendResult(newestResult: GameStateSingleton.gameState.applicationData.getNewestTime())
        }
        
        
        newestTimeLabel.text = GameStateSingleton.gameState.applicationData.getNewestTime()
        GameStateSingleton.gameState.applicationData.sortResults()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

extension MainView {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return GameStateSingleton.gameState.applicationData.getSize()
    }
    
 func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = bestResultsTableView.dequeueReusableCell(withIdentifier: "cellReuseIdentifier")
        cell?.textLabel?.text = GameStateSingleton.gameState.applicationData.results[indexPath.row]
        return cell!
    }
    
}

