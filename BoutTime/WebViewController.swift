//
//  WebViewController.swift
//  BoutTime
//
//  Created by thechemist on 5/19/18.
//  Copyright © 2018 mfukuoka. All rights reserved.
//

import UIKit
import WebKit

class WebViewController: UIViewController {
  

    @IBOutlet weak var contentView: UIView!
    var wkWebView:WKWebView!
    var url: String = "https://www.google.com"
    override func viewDidLoad() {
        super.viewDidLoad()
        wkWebView = WKWebView(frame:contentView.frame)
        contentView.addSubview(wkWebView)

        if let url = URL(string: self.url) {
            let request = URLRequest(url: url)
                wkWebView.load(request)
            }
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


    @IBAction func dismiss(_ sender: Any) {
       
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
