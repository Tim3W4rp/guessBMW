//
//  GameView.swift
//  guessBMW
//
//  Created by Martin Jordán on 20.10.17.
//  Copyright © 2017 Martin Jordán. All rights reserved.
//

import Foundation
import UIKit

class GameView : UIViewController {
    @IBOutlet var timerLabel: UILabel!
    @IBOutlet weak var leftImageView: UIImageView!
    @IBOutlet weak var middleImageView: UIImageView!
    @IBOutlet weak var rightImageView: UIImageView!
    @IBOutlet var gameScoreCounterLabel: UILabel!
    @IBOutlet var modelNameLabel: UILabel!
    
    @IBAction func leftImageClicked(_ sender: UITapGestureRecognizer) {
        validateLeftImage()
    }
    
    @IBAction func middleImageClicked(_ sender: UITapGestureRecognizer) {
        validateMiddleImage()
    }
    
    @IBAction func rightImageClicked(_ sender: UITapGestureRecognizer) {
        validateRightImage()
    }
    
    var miliseconds = 0
    weak var timer: Timer?
    var startTime: Double = 0
    var time: Double = 0
    var timePenalty: Double = 0
    
    var currentModelName: String = ""
    var model1: Model = Model(modelName: "",imageName: "")
    var model2: Model = Model(modelName: "",imageName: "")
    var model3: Model = Model(modelName: "",imageName: "")
    var pastImages: [String] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        startTimer()
        randomImages()
        GameStateSingleton.gameState.counter = 0
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        timer!.invalidate()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        GameStateSingleton.gameState.applicationData.setNewestTime(time: timeString(time: time))
    }
    
    @objc func advanceTimer(timer: Timer) {
        time = Date().timeIntervalSinceReferenceDate - startTime + timePenalty
        timerLabel.text = timeString(time: time)
        if GameStateSingleton.gameState.counter == 10 {
            performSegue(withIdentifier: "goToResults", sender: Any?.self)
        }
    }
    
    func startTimer() {
        startTime = Date().timeIntervalSinceReferenceDate
        timer = Timer.scheduledTimer(timeInterval: 0.02,
                                     target: self,
                                     selector: #selector(advanceTimer(timer: )),
                                     userInfo: nil,
                                     repeats: true)
    }
    
    func selectionWasCorrect () {
        GameStateSingleton.gameState.counter += 1
        gameScoreCounterLabel.text = "\(GameStateSingleton.gameState.counter) / 10"
        appendModelToPastImages(modelToBeIgnored: currentModelName)
    }
    
    func randomImages () {
        var rand1: Int = Int(arc4random_uniform(UInt32(ModelsCollection.modelCollection.count)))
        var rand2: Int = Int(arc4random_uniform(UInt32(ModelsCollection.modelCollection.count)))
        var rand3: Int = Int(arc4random_uniform(UInt32(ModelsCollection.modelCollection.count)))
        
        while (rand1 == rand2) || (rand2 == rand3) || (rand3 == rand1) {
            rand1 = Int(arc4random_uniform(UInt32(ModelsCollection.modelCollection.count)))
            rand2 = Int(arc4random_uniform(UInt32(ModelsCollection.modelCollection.count)))
            rand3 = Int(arc4random_uniform(UInt32(ModelsCollection.modelCollection.count)))
        }
        
        var key = Array(ModelsCollection.modelCollection.keys)[rand1]
        var value = ModelsCollection.modelCollection[key]
        model1.modelName = value!
        model1.imageName = key
        
        key = Array(ModelsCollection.modelCollection.keys)[rand2]
        value = ModelsCollection.modelCollection[key]
        model2 = Model(modelName: value!, imageName: key)
        model2.modelName = value!
        model2.imageName = key
        
        key = Array(ModelsCollection.modelCollection.keys)[rand3]
        value = ModelsCollection.modelCollection[key]
        model3 = Model(modelName: value!, imageName: key)
        model3.modelName = value!
        model3.imageName = key
    
        loadSelectedModelImages(model1: model1, model2: model2, model3: model3)
        randomCorrectCar()
    }
    
    func validateLeftImage() {
        if model1.modelName == currentModelName {
            selectionWasCorrect()
        } else {
            timePenalty += 3
        }
        uniqueRandomImages()
    }
    
    func validateMiddleImage() {
        if model2.modelName == currentModelName {
            selectionWasCorrect()
        } else {
            timePenalty += 3
        }
        uniqueRandomImages()
    }
    
    func validateRightImage() {
        if model3.modelName == currentModelName {
            selectionWasCorrect()
        } else {
            timePenalty += 3
        }
        uniqueRandomImages()
    }
    
    func uniqueRandomImages() {
        while (pastImages.contains(currentModelName)) {
            randomImages()
        }
    }
    
    func randomCorrectCar () {
        let threeCars: [String] = [model1.modelName, model2.modelName, model3.modelName]
        let randomCar = Int(arc4random_uniform(UInt32(threeCars.count)))
        currentModelName = threeCars[randomCar]
        modelNameLabel.text = currentModelName
    }
    
    func appendModelToPastImages(modelToBeIgnored: String?) {
        if let val = modelToBeIgnored {
            pastImages.append(val)
        }
    }
    
    func loadSelectedModelImages (model1: Model, model2: Model, model3: Model) {
        leftImageView.image = UIImage(named: model1.imageName)
        middleImageView.image = UIImage(named: model2.imageName)
        rightImageView.image = UIImage(named: model3.imageName)
    }
    
    
    func timeString(time:Double) -> String {
        return String(format:"%.3f",time)
    }
    
}
