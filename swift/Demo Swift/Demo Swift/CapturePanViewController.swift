//
//  CapturePanViewController.swift
//  Demo Swift
//
//  Created by Eduardo Mello de Macedo | Stone on 21/03/17.
//  Copyright © 2017 Eduardo Mello de Macedo | Stone. All rights reserved.
//

import UIKit
import StoneSDK

class CapturePanViewController: UIViewController {

    @IBOutlet weak var feedbackLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "Captura de PAN"
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @IBAction func performCapture(_ sender: Any) {
        STNCardProvider.getCardPan { (succeeded, pan, error) in
            if (succeeded) {
                NSLog("**** **** **** \(pan)")
                self.feedbackLabel.text = "Os 4 ultimos digitos são:\(pan)"
            } else {
                NSLog(error.debugDescription)
                self.feedbackLabel.text = error.debugDescription
            }
        }
    }
}
