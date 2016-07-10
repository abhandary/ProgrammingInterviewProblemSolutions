//
//  ViewController.swift
//  Constraints
//
//  Created by Akshay Bhandary on 6/27/16.
//  Copyright © 2016 Akshay Bhandary. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UIWebViewDelegate {

    @IBOutlet weak var greenButton: UIButton!
    @IBOutlet weak var webView: UIWebView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        greenButton?.titleLabel?.adjustsFontSizeToFitWidth = true
        greenButton?.titleLabel?.minimumScaleFactor = 0.5
        self.webView.delegate = self
        let request = NSURLRequest(URL: NSURL(string: "https://bit.ly/291uVEZ")!)
        self.webView .loadRequest(request)
        
    }
    
    func webView(webView: UIWebView, shouldStartLoadWithRequest request: NSURLRequest, navigationType: UIWebViewNavigationType) -> Bool {
        print(request)
        return true
    }
    
    func webViewDidFinishLoad(webView: UIWebView) {
        print("%s", __FUNCTION__)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func buttonPressed(sender: UIButton) {
        if sender.titleForState(.Normal) == "X" {
            sender.setTitle("A very long title for this button", forState:.Normal)
        } else {
            sender.setTitle("X", forState: .Normal)
        }
    }
}

