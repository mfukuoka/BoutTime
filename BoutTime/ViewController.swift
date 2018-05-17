//
//  ViewController.swift
//  BoutTime
//
//  Created by mfukuoka on 5/1/18.
//  Copyright © 2018 mfukuoka. All rights reserved.
//

import UIKit

class ViewController: UIViewController {


    @IBOutlet weak var nextRoundButton: UIButton!
    @IBOutlet weak var notificationLabel: UILabel!
    
    @IBOutlet weak var eventLabelOne: UILabel!
    @IBOutlet weak var eventLabelTwo: UILabel!
    @IBOutlet weak var eventLabelThree: UILabel!
    @IBOutlet weak var eventLabelFour: UILabel!
    
    var updateLabelTimer: Timer!
    var timeLimit = 60
    var timerLabel: UILabel!
    let game = Game()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //get shake gesture
        self.becomeFirstResponder()
        
        //let the games begin!
        game.newRound()
        
       //set screen for start of the round
        defaultRoundScreen()
        
       

     
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    //become first responder for shake motion
    override var canBecomeFirstResponder: Bool {
        get {
            return true
        }
    }
    
    //shake motion
    override func motionEnded(_ motion: UIEventSubtype, with event: UIEvent?) {
        print("AC/DC: You shook me all night long.")
    }
    
    //updates the events text labels
    func refreshEventsOnScreen(){
        if let round = game.round {
            eventLabelOne.text = round.events[0].description
            eventLabelTwo.text = round.events[1].description
            eventLabelThree.text = round.events[2].description
            eventLabelFour.text = round.events[3].description
        }
        
    }
    
    //set up the display so the round can start
    func defaultRoundScreen(){
        
        //hide the next round button and update notification label
        nextRoundButton.isHidden = true
        notificationLabel.text = "Shake to complete"
        
        //make a label to display the timer
        timerLabel = UILabel(frame: CGRect(x: 0, y: 0, width: 100, height: 30))
        timerLabel.text = "0:\(timeLimit)"
        timerLabel.font = timerLabel.font.withSize(35)
        timerLabel.textColor = UIColor(red: 1, green: 1, blue: 1, alpha: 1)
        timerLabel.translatesAutoresizingMaskIntoConstraints = false
        
        //add it to the same view as the nextRoundButton
        if let subview = nextRoundButton.superview {
            subview.addSubview(timerLabel)
        }
        
        //add layout constraints
        super.view.addConstraint(NSLayoutConstraint(item: timerLabel, attribute: .centerX, relatedBy: .equal, toItem: self.view, attribute: .centerX, multiplier: 1, constant: 0))
        super.view.addConstraint(NSLayoutConstraint(item: timerLabel, attribute: .top, relatedBy: .equal, toItem: nextRoundButton, attribute: .top, multiplier: 1, constant: 0))
        
        //setup countdown timer
        timeLimit = 10
        updateLabelTimer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(updateTimerText), userInfo: nil, repeats: true)
        refreshEventsOnScreen()
    }
    
    //responsible for decreasing the time and updating the label
    @objc func updateTimerText(){
        timeLimit -= 1
        timerLabel.text = "0:\(timeLimit)"
        if timeLimit == 0 {
            timerLabel.isHidden = true
            nextRoundButton.isHidden = false
            notificationLabel.text = "Tap events to learn more"
            updateLabelTimer.invalidate()
        }
    }


    enum Button: Int {
        case One = 0
        case Two
        case Three
        case Four
        case Five
        case Six
    }
    
    //event for when an answer is moved up or down
    @IBAction func orderEvent(_ sender: Any) {
        
        if let sender = sender as? UIButton {
            if let round = game.round {
                let event1 = round.events[0]
                let event2 = round.events[1]
                let event3 = round.events[2]
                let event4 = round.events[3]
                
                switch sender.tag {
                case Button.One.rawValue, Button.Two.rawValue:
                    round.events[1] = event1
                    round.events[0] = event2
                case Button.Three.rawValue, Button.Four.rawValue:
                    round.events[1] = event3
                    round.events[2] = event2
                case Button.Five.rawValue, Button.Six.rawValue:
                    round.events[2] = event4
                    round.events[3] = event3
                default:
                    fatalError()
                }
                
              refreshEventsOnScreen()
            }
        }
        
    }
    @IBAction func nextRound() {
        game.newRound()
        defaultRoundScreen()
    }
    
    
    //MARK: Helper Methods
    func timeLimit(seconds: Int) {
        
        let delay = Int64(NSEC_PER_SEC * UInt64(seconds))
        
        let dispatchTime = DispatchTime.now() + Double(delay) / Double(NSEC_PER_SEC)
        
        DispatchQueue.main.asyncAfter(deadline: dispatchTime) {
            //do something
        }
    }
}

