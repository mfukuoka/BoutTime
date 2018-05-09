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
    
    var updateLabelTimer: Timer!
    var timeLimit = 60
    var timerLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //let the games begin!
        startRound()

    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //set up the display so the round can start
    func startRound(){
        
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
    }
    
    //responsible for decreasing the time and updating the label
    @objc func updateTimerText(){
        timeLimit -= 1
        timerLabel.text = "0:\(timeLimit)"
        if timeLimit == 0 {
            timerLabel.isHidden = true
            nextRoundButton.isHidden = false
            notificationLabel.text = "Tap events to learn more"
        }
    }


    enum Direction: Int {
        case Down = 0
        case Up = 1
    }
    
    //event for when an answer is moved up or down
    @IBAction func orderEvent(_ sender: Any) {
        
        if let sender = sender as? UIButton {
            
            if sender.tag == Direction.Up.rawValue {
                print("Up")
            }
            else if sender.tag == Direction.Down.rawValue {
                print("Down")
            }
            else{
                fatalError()
            }
        }
        
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

