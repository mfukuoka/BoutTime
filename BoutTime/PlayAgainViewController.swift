//
//  PlayAgainViewController.swift
//  BoutTime
//
//  Created by thechemist on 5/19/18.
//  Copyright © 2018 mfukuoka. All rights reserved.
//

import UIKit

class PlayAgainViewController: UIViewController {
    @IBOutlet weak var scoreLabel: UILabel!
    
    var score: String?
    var viewController: ViewController?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if let score = self.score {
            scoreLabel.text = score
        }
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    @IBAction func dismiss(_ sender: Any) {
        if let viewController = self.viewController {
            viewController.game.newGame()
            viewController.game.newRound()
            viewController.defaultRoundScreen()
        }
        self.dismiss(animated: true, completion: nil)
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
