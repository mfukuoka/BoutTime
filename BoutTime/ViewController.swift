//
//  ViewController.swift
//  BoutTime
//
//  Created by mfukuoka on 5/1/18.
//  Copyright © 2018 mfukuoka. All rights reserved.
//

import UIKit
import WebKit
class ViewController: UIViewController {

    let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
    @IBOutlet weak var nextRoundButton: UIButton!
    @IBOutlet weak var notificationLabel: UILabel!
    
    @IBOutlet weak var eventButtonOne: UIButton!
    @IBOutlet weak var eventButtonTwo: UIButton!
    @IBOutlet weak var eventButtonThree: UIButton!
    @IBOutlet weak var eventButtonFour: UIButton!

    
    var updateLabelTimer: Timer!
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
    
    //don't allow to rotate the screen
    override open var shouldAutorotate: Bool {
        return false
    }
    //become first responder for shake motion
    override var canBecomeFirstResponder: Bool {
        get {
            return true
        }
    }
    
    //shake motion. check answers
    override func motionEnded(_ motion: UIEventSubtype, with event: UIEvent?) {
        if game.timeLimit > 0 {
        game.timeLimit = 0
        timesUp()
        }
    }
    
    //updates the events text labels
    func refreshEventsOnScreen(){
        if let round = game.round {
            eventButtonOne.setTitle(round.events[0].description, for: .normal)
            eventButtonTwo.setTitle(round.events[1].description, for: .normal)
            eventButtonThree.setTitle(round.events[2].description, for: .normal)
            eventButtonFour.setTitle(round.events[3].description, for: .normal)
        }
        
    }
    
    //set up the display so the round can start
    func defaultRoundScreen(){
        
        //hide the next round button and update notification label
        nextRoundButton.isHidden = true
        notificationLabel.text = "Shake to complete"
        
        //reset time limit and setup countdown timer
        game.timeLimit = game.timeAtLimit
        updateLabelTimer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(updateTimerText), userInfo: nil, repeats: true)
        
        //make a label to display the timer
        timerLabel = UILabel(frame: CGRect(x: 0, y: 0, width: 100, height: 30))
        timerLabel.text = "0:\(game.timeLimit)"
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
        
        //update the event labels
        refreshEventsOnScreen()
    }
    
    //responsible for decreasing the time and updating the label
    @objc func updateTimerText(){
        game.timeLimit -= 1
        if game.timeLimit >= 10 {
            timerLabel.text = "0:\(game.timeLimit)"
        }
        else {
            timerLabel.text = "0:0\(game.timeLimit)"
        }
        
        //times up. show the next round button.
        if game.timeLimit == 0 {
            timesUp()
        }
    }

    //show results and if game is over play again screen
    func timesUp() {
        timerLabel.isHidden = true
        nextRoundButton.isHidden = false
        notificationLabel.text = "Tap events to learn more"
        updateLabelTimer.invalidate()
        
        //change nextround button if events are ordered correctly
        if game.isOrderedCorrectly() {
            nextRoundButton.setImage(#imageLiteral(resourceName: "next_round_success"), for: .normal)
            game.playCorrectSound()
        }
        else{
            nextRoundButton.setImage(#imageLiteral(resourceName: "next_round_fail"), for: .normal)
            game.playIncorrectSound()
        }
        
        //if the game is over then show the play again screen
        if game.isGameOver() {
            if let playAgainViewContorller = storyBoard.instantiateViewController(withIdentifier: "PlayAgainViewController") as? PlayAgainViewController
            {
                playAgainViewContorller.score = "\(game.correctAnswers)/\(game.totalRounds)"
                playAgainViewContorller.viewController = self
                self.present(playAgainViewContorller, animated: true, completion: nil)
            }
            
        }
    }
    
    //enum event buttons
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
        if game.timeLimit > 0 {
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
    }
    
    //open a web view when an event is clicked if the round is over
    @IBAction func urlView(_ sender: Any) {
        if game.timeLimit < 1 {
            if let sender = sender as? UIButton {
                if let round = game.round {
                    
                    
                    if let  newViewController = storyBoard.instantiateViewController(withIdentifier: "WebViewController") as? WebViewController
                    {
                        let event1 = round.events[0]
                        let event2 = round.events[1]
                        let event3 = round.events[2]
                        let event4 = round.events[3]
                        
                        switch sender.tag {
                        case Button.One.rawValue:
                            newViewController.url = event1.url
                        case Button.Two.rawValue:
                            newViewController.url = event2.url
                        case Button.Three.rawValue:
                            newViewController.url = event3.url
                        case Button.Four.rawValue:
                            newViewController.url = event4.url
                        default:
                            fatalError()
                        }
                        
                        self.present(newViewController, animated: true, completion: nil)
                    }
                    
                }
            }
        }
    }
    
    //go to the next round
    @IBAction func nextRound() {
        if !game.isGameOver() {
        game.newRound()
        defaultRoundScreen()
        }
    }
    
}

