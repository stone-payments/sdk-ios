//
//  ScreenDisplayViewController.swift
//  Demo Swift
//
//  Created by Eduardo Mello de Macedo | Stone on 21/03/17.
//  Copyright © 2017 Eduardo Mello de Macedo | Stone. All rights reserved.
//

import UIKit
import StoneSDK

class ScreenDisplayViewController: UIViewController {

    @IBOutlet weak var messageTextField: UITextField!
    @IBOutlet weak var feedbackLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "Exibe mensagem no display"
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    @IBAction func performDisplayMessage(_ sender: Any) {
        let message = self.messageTextField.text
        STNDisplayProvider.displayMessage(message) { (succeeded, error) in
            if succeeded {
                NSLog("Mensagem enviada para o PinPad")
                self.feedbackLabel.text = "Mensagem enviada ao Pinpad"
            } else {
                NSLog(error.debugDescription)
                self.feedbackLabel.text = error.debugDescription
            }
        }
    }
}
