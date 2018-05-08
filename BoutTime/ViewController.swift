//
//  ViewController.swift
//  BoutTime
//
//  Created by thechemist on 5/1/18.
//  Copyright © 2018 mfukuoka. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    enum Direction: Int {
        case Down = 0
        case Up = 1
    }
    @IBAction func orderAnswer(_ sender: Any) {
        
        //check if it was an up or down button
        if let sender = sender as? UIButton {

            sender.isSelected = !sender.isSelected
            
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
    
}

